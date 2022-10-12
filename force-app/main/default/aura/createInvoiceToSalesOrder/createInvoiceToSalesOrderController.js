({
    doInit :function(c, e, h) {
        h.request(c, 'getRecordName', { recordId: c.get('v.recordId') }, function (r) {
            console.log('brandAccountType:',r.brandAccountType);
            c.set('v.recordName',r.recordName);
            c.set('v.RecordType',r.RecordType);
            c.set('v.orderType',r.orderType);
            c.set('v.brandAccountType',r.brandAccountType);
            c.set('v.ServiceTypeErr',r.ServiceTypeErr);
            c.set('v.ServiceType',r.ServiceType);
            
        });
    },
    onCreateRetailerInvoice :function(c, e, h) {
        if(c.get('v.ServiceType') == 'Buy/Sell'){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error',
                message:c.get('v.ServiceTypeErr'),
                duration:' 5000',
                key: 'info_alt',
                type: 'Error',
                mode: 'pester'
            });
            toastEvent.fire(); 
            $A.get("e.force:closeQuickAction").fire();
        }else{
             h.navigateToComponent("c:createInvoice",{recordId : c.get("v.recordId")},true);
        }
        
       
    },
    onCreateFulfillmentInvoice :function(c, e, h) {
        if(c.get('v.ServiceType') == 'Buy/Sell'){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error',
                message:c.get('v.ServiceTypeErr'),
                duration:' 5000',
                key: 'info_alt',
                type: 'Error',
                mode: 'pester'
            });
            toastEvent.fire(); 
            $A.get("e.force:closeQuickAction").fire();
        }else{
            c.set('v.showCreateFullFillMent',true);
        }
        //h.navigateToComponent("c:createFullFillmentServiceInvoice",{recordId : c.get("v.recordId")},true);
    },
    onCreateServiceInvoice :function(c, e, h) {
        c.set('v.showServiceInvoice',true);
        //h.navigateToComponent("c:SalesOrderCreateInvoice",{recordId : c.get("v.recordId")},true);
    },
    onCreateReceivingInvoice :function(c, e, h) {
    	h.navigateToComponent("c:receivingServiceInvoice",{recordId : c.get("v.recordId")},true);
    },
    closeDialog :function(c, e, h) {
        c.set('v.showCreateFullFillMent',false);
        c.set('v.showServiceInvoice',false);
    },
    showCreateFullFillMentYes :function(c, e, h) {
        h.navigateToComponent("c:createFullFillmentServiceInvoice",{recordId : c.get("v.recordId")},true);
    },
    showServiceInvoiceYes :function(c, e, h) {
        //h.navigateToComponent("c:SalesOrderCreateInvoice",{recordId : c.get("v.recordId")},true);
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/CreateInvFromSO?id=" + component.get("v.recordId"),
            redirect:true
            
        });
        urlEvent.fire();
    },
    navigate : function(c, e, h) {
        /*var evt = $A.get("e.force:navigateToComponent");
        var recId = c.get("v.recordId");
        //debugger;
        //console.log("Record ID -- >"+recId);
        evt.setParams({
            componentDef : "c:createInvoice",
            componentAttributes: {
                
                recordId : recId
            }
        });
        evt.fire();*/
    },
    createCTI2 : function(c, e, h) {
 h.navigateToComponent("c:createCTIInvoice",{recordId : c.get("v.recordId")},true);      
      
    },
      createCTI : function(c, e, h) {
 h.navigateToComponent("c:createCTIInvoice",{recordId : c.get("v.recordId")},true);       
 /*h.request(c, 'createCultivationTaxInvoice', {recordId: c.get("v.recordId")}, function(r){
             h.navigateToComponent("c:createCTIInvoice",{recordId : c.get("v.recordId")},true);
            var statusSOerror = r.statusSOerror;    
            if(statusSOerror == 'Error1'){ 
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgSubmitSOForApprovalToCreateCTI);       
            }else if(statusSOerror == 'Error2'){    
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgCan_tCreateCTIForCancelledSO);     
            }else if(statusSOerror == 'Error3'){    
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgCan_tCreateCTIForRejectedSO);     
            }else if(statusSOerror == 'Error4'){    
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgCan_tCreateCTIForNonApproved);     
            }else if(statusSOerror == 'Error5'){    
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgCTIAlreadyCreated);   
            }else if(statusSOerror == 'Error6'){    
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showError('Warning', 'Warning', r.ErrMsgBillableCultivationTaxIP);   
            }else{ 
                h.navigateToRecord(c, r.setInvoice);
                h.showError('Success!', 'success', r.Success_Msg_CTI_Created);
            } 
        });*/
    },
})