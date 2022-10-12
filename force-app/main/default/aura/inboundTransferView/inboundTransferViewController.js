({
	onInit : function(c,e,h) {
		try{
            console.log("ST:",JSON.stringify(c.get('v.serviceTicket')));
            c.set('v.recordId', sessionStorage.getItem('serviceTicketId'));
        }catch(err){}
        
        h.request(c, 'getServiceTicket', {recordId: c.get('v.recordId')}, function(r){
            console.log("r:",r);
            let st = r.serviceTicket;
            if(st.transferMethod == 'Drop-off'){
                st.licenseNumber = st.licenseNumber + ' - '+ st.licenseType;
            } else {
                st.licenseNumber = st.licenseNumber + ' - '+ st.licensePremiseAddress;
            }
            c.set('v.serviceTicket', st);
            c.set('v.branddetails', r.branddetails);
            var totalCompleted = 0;
            r.serviceTicketLines.forEach((item) => {
                totalCompleted += item.PWOStatus == 'Completed'?1:0;
                var Total_Units = item.Total_Units || 0;
                var Qty_Per_Multi_Unit  = item.Qty_Per_Multi_Unit || 0;
                if(Qty_Per_Multi_Unit == 0){
                	item.totalCases = 0;
            	}else{
                     var totalCases = (Total_Units/Qty_Per_Multi_Unit);
                     item.totalCases = totalCases.toFixed(2);
        		}
            })
        	c.set('v.totalCompletedPercent',(totalCompleted/r.serviceTicketLines.length)*100);
        	c.set('v.totalCompleted',totalCompleted);
            c.set('v.serviceTicketLines', r.serviceTicketLines);
            //console.log("getServiceTicket:",JSON.stringify(c.get('v.serviceTicket')));
        });
        
        
	},
    onEdit: function(c, e, h){
        var recordId = e.getSource().get('v.value');
        sessionStorage.setItem('serviceTicketId', recordId);
        h.redirect('/inboundtransfer', true);
    },
    onCancel: function(c, e, h){
        h.redirect('/inboundtransfers', true);        
    },
    onExpendCollapse: function(c, e, h){
        var index = e.getSource().get("v.value");
        var serviceTicketLines = c.get('v.serviceTicketLines');
        serviceTicketLines[index].isAllCollapsed = !serviceTicketLines[index].isAllCollapsed;
        c.set('v.serviceTicketLines',serviceTicketLines);
        
    },
    showHideSLine: function(c, e, h){
        var index = e.currentTarget.dataset.index;
        console.log('index:',index);
        var serviceTicketLines = c.get('v.serviceTicketLines');
        serviceTicketLines[index].isCollapsed = !serviceTicketLines[index].isCollapsed;
        c.set('v.serviceTicketLines',serviceTicketLines);
    },
        printDetails: function (c, e, h) {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/inboundtransferview','/apex/printInboundTransfer?recordId='+c.get('v.recordId'));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');        
        } , 
        onViewCompliance:function(c,e,h){
            var complianceFileIds = [];
            complianceFileIds.push(e.currentTarget.dataset.id);
            console.log("recordId:", complianceFileIds);
            $A.get('e.lightning:openFiles').fire({
                recordIds: complianceFileIds
            });
        }
})