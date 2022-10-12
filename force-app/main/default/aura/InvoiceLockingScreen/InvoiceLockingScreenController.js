({
	onInit: function (c, e, h) {
        console.log('id : ',c.get('v.recordId'));
        h.request(c, 'init', {}, function (r) {
               c.set('v.Year',r.currentYear);
               c.set('v.monthMap',r.Months);
            c.set('v.monthOptions',r.Months[1]);
            c.set('v.next',true);
        });
	},
    Next:function(cmp,event,helper){
        var lastMonths =cmp.get("v.monthMap");
        cmp.set('v.monthOptions',lastMonths[1]);
        var next = true;
        var prev = false;
        var Year = cmp.get("v.Year");
        cmp.set('v.Year',Year+1);
        cmp.set('v.next',next);
        cmp.set('v.prev',prev);
        cmp.set('v.Month',-1);
        cmp.set('v.isLocBtn',true);
    },
    Previous:function(cmp,event,helper){
        var lastMonths =cmp.get("v.monthMap");
        cmp.set('v.monthOptions',lastMonths[0]);
        var next = false;
        var prev = true;
        var Year = cmp.get("v.Year");
        cmp.set('v.Year',Year-1);
        cmp.set('v.next',next);
        cmp.set('v.prev',prev);
        cmp.set('v.Month',-1);
        cmp.set('v.isLocBtn',true);
    },
    onClickMonth : function(c, e, h) {
        var months = c.get("v.monthOptions");
        var monthOfNumber =parseInt(e.target.dataset.index);
        c.set('v.Month',monthOfNumber+1);
        c.set('v.isLocBtn',false);
        console.log('Month :',months[monthOfNumber]);
        h.request(c, 'checkMonthInvoices', {'year':c.get('v.Year'),'month':c.get('v.Month')}, function (r) {
            if(r.isUserNotAllowed != null || r.isUserNotAllowed != undefined){
                h.error({message:r.isUserNotAllowed});
                return ;
            }
            if(r.Error != null || r.Error != undefined){
                
                if(r.isPendingInvoices == true){
                    var pageNumber = 1;  
                    let pageSize = 25;//c.find("pageSize").get("v.value"); 
                   	c.set('v.pageSize',pageSize);
                    h.getInvoiceList(c, pageNumber, pageSize);
                    c.set('v.isPendingInvoices',true)
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message:r.Error,
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Warning',
                        mode: 'pester'
                    });
                    toastEvent.fire(); 
                }else{
                    c.set('v.Message',r.Error );
                    var cmpTarget = c.find('Modalbox1');
                    var cmpBack = c.find('Modalbackdrop');
                    $A.util.addClass(cmpTarget, 'slds-fade-in-open');
                    $A.util.addClass(cmpBack, 'slds-backdrop');
                }
                
            }
            
            if(r.isNoInvoices != null || r.isNoInvoices != undefined ){
                c.set('v.isNoInvoices',r.isNoInvoices );
            }
        }); 
       
    },
    onLocked : function(c, e, h){
        var cmpTarget = c.find('Modalbox1');
        var cmpBack = c.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop');
    },
    onClickOK : function(c, e, h){
        /*if(c.get('v.isPendingInvoices') == false){
            var pageNumber = c.get('v.PageNumber');  
            var pageSize = 10;//c.find("pageSize").get("v.value"); 
            h.getInvoiceList(c, pageNumber, pageSize);
            c.set('v.isNoInvoices',false );
            c.set('v.isPendingInvoices',true)
            var cmpTarget = c.find('Modalbox1');
            var cmpBack = c.find('Modalbackdrop');
            $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
            $A.util.removeClass(cmpBack, 'slds-backdrop');
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning',
                message:'Unable to lock month due to invoices that are not Revenue Recognized.',
                duration:' 5000',
                key: 'info_alt',
                type: 'Warning',
                mode: 'pester'
            });
            toastEvent.fire(); 
        }else{*/
            h.request(c, 'LockedInvoices', {'year':c.get('v.Year'),'month':c.get('v.Month')}, function (r) {
            if(r.Error != null || r.Error != undefined){
                var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        title : 'Error',
                                        message:r.Error,
                                        duration:' 5000',
                                        key: 'info_alt',
                                        type: 'Error',
                                        mode: 'pester'
                                    });
                                    toastEvent.fire(); 
            }
        });
        $A.get("e.force:closeQuickAction").fire();
        window.setTimeout(
                        $A.getCallback(function() {
                           window.location.reload();
                        }), 100
                    );
        

    },
    handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        //var pageSize = component.find("pageSize").get("v.value");
        let pageSize = component.get('v.pageSize');
        pageNumber++;
        helper.getInvoiceList(component, pageNumber, pageSize);
    },
     
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        //var pageSize = component.find("pageSize").get("v.value");
        let pageSize = component.get('v.pageSize');
        pageNumber--;
        helper.getInvoiceList(component, pageNumber, pageSize);
    },
     onFirst: function(component, event, helper) {
        var pageNumber = 1;  
        //var pageSize = component.find("pageSize").get("v.value");
        let pageSize = component.get('v.pageSize');
        helper.getInvoiceList(component, pageNumber, pageSize);
    },
    onLast: function(component, event, helper) {
         
        var TotalRecords = component.get('v.TotalRecords');
        //var pageSize = component.find("pageSize").get("v.value");
        let pageSize = component.get('v.pageSize');
        var pageNumber = Math.ceil(TotalRecords / pageSize);
        helper.getInvoiceList(component, pageNumber, pageSize);
    },
    onSelectChange: function(component, event, helper) {
        var page = 1;
        let pageSize = component.get('v.pageSize');
        pageSize = component.find("selectPageSize").get("v.value");
        component.set('v.pageSize',pageSize);
        helper.getInvoiceList(component, page, pageSize);
    },
    onBack : function(c, e, h) {
        c.set('v.isPendingInvoices',false );
    },
    cancel : function(c, e, h) {
        c.set('v.isNoInvoices',false );
        var cmpTarget = c.find('Modalbox1');
        var cmpBack = c.find('Modalbackdrop');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
        $A.util.removeClass(cmpBack, 'slds-backdrop');
        //$A.get("e.force:closeQuickAction").fire();
    },
})