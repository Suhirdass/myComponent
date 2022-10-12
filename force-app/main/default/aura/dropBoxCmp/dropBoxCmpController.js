/*
 * Source : sfdcmonkey.com 
 * Date : 25/9/2017
 * Locker Service Ready code.
 */
({
    
    doInit: function(c, e, h) {
        let recId = c.get("v.recordId").substring(0, 3);
        console.log('RECID = '+recId);
        if(recId != '001'){
            h.request(c,'getProduct', {recordId: c.get("v.recordId")}, function(r){
                console.log(r.product);
                c.set('v.product',r.product);   
                console.log(c.get('v.product'));
            }); 
        } else {
            h.request(c,'getAccount', {recordId: c.get("v.recordId")}, function(r){
                c.set('v.account',r.accountRec);
                c.set('v.isAccount',true);
            });
        }
    },
    
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files") != null && component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event,helper);
        } else {
            helper.error({ message: 'Please Upload or Drop Image file'});
        }
    },
 
    closeModel : function(component, event, helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },
    
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
    
    handleConfirmDialogYes : function(c, event, helper) {
        c.set('v.showConfirmDialog', false);
        let isAccount = c.get('v.isAccount');
        if(c.get('v.isAccount')){
            helper.uploadFile(c,c.get('v.fName'),c.get('v.file'),'','Account Logo updated successfully',helper,isAccount); 
        } else {
        	helper.uploadFile(c,c.get('v.fName'),c.get('v.file'),'','Product Image updated successfully',helper,isAccount);     
        } 
    },
    
    handleConfirmDialogNo : function(component, event, helper) {
        component.set('v.showConfirmDialog', false);
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },
})