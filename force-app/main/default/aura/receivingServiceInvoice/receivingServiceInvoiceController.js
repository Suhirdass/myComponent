({
	doInit : function(c, e, h) {
        h.request(c, 'getSalesOrderDetails', {recordId: c.get("v.recordId")}, function(r){
            if(r.Error != null || r.Error != undefined){
                h.error({ message: r.Error });
            } else {
               
                console.log('##SO : ',r.salesOrder);
                console.log('##SO : ',r.producerSOLines);
                c.set('v.salesOrderSO',r.salesOrder);
                c.set('v.producerSOLines', r.producerSOLines);
            }	
        });
	},
    noOB : function(c, e, h) {
        c.set('v.isOBCreated',false);
        $A.get("e.force:closeQuickAction").fire();
        //h.navigateToRecord(c,c.get("v.recordId"),'detail');
    },
    yesOB :function(c, e, h) {
        c.set('v.isOBCreated',false);
        h.request(c, 'createInvoices', {
            recordId: c.get("v.recordId"),
            salesOrderLineData: JSON.stringify(c.get("v.producerSOLines")),
            isOBCreated: true
        }, function(r){
            
                if(r.Error){
                    h.error({message:r.Error});
                }else{
                    h.navigateToRecord(c,c.get("v.recordId"),'detail');
                }
        });
       
    },
    cancelBtn : function(c, e, h) {
        h.navigateToRecord(c,c.get("v.recordId"),'detail');
    },
    createInvoice : function(c, e, h) {
        h.request(c, 'createInvoices', {
            recordId: c.get("v.recordId"),
            salesOrderLineData: JSON.stringify(c.get("v.producerSOLines")),
            isOBCreated: c.get('v.isOBCreated')
        }, function(r){
            if(r.isOBCreated){
                c.set('v.ErrorMsg',r.ErrorMsg);
                c.set('v.isOBCreated',r.isOBCreated);
            }else{
                if(r.Error){
                    h.error({message:r.Error});
                }else{
                    h.navigateToRecord(c,r.recordId,'detail');
                }
            }
        });
	},
    checkProducts : function(c, e, h) {
        var dataset = e.currentTarget.dataset;
        var isSelected = dataset.info;
        var productId = e.currentTarget.dataset.id;
        var solChild = c.find("checkProduct"); 
        if(solChild.length){
            for(var i=0; i<solChild.length; i++){
                if(solChild[i].get('v.name') === productId){
                    if(isSelected == 'true')
                    	solChild[i].set("v.value",true);
                	else
                        solChild[i].set("v.value",false);
                }
            } 
        }else {
            if(isSelected == 'true')
                solChild[i].set("v.value",true);
            else
                solChild[i].set("v.value",false);
        }
    },
    selectAllCheckboxes : function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.value");
        console.log('##',checkvalue);
        var salesOrder = c.find("checkContact");
        if(salesOrder != undefined){
            
            if(salesOrder.length > 0){
                for(var i=0; i<salesOrder.length; i++){
                    salesOrder[i].set("v.value",checkvalue);
                } 
            }else {
                salesOrder.set("v.value",checkvalue);
            }
        }
        
        
        /*var solChild = c.find("checkProduct"); 
        if(solChild.length){
            for(var i=0; i<solChild.length; i++){
                solChild[i].set("v.value",checkvalue);
            } 
        }else {
            solChild.set("v.value",checkvalue);
        }*/
    }
    
})