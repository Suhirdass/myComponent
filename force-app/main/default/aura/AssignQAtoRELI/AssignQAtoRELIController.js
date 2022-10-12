({
	doInit : function(c, e, h) {
        console.log('Record Id:',c.get('v.recordId'));
        h.getRecords(c,h);
        
    },
    onCancel : function(c, e, h) {
        try{
            window.location.href = '/' + c.get('v.recordId'); 
        } catch(ex){
            console.log('Exception '+ex);
        }
	},
    handleNewQAClick : function(c, e, h) 
    {  
        var recId = e.currentTarget.dataset.id;
        console.log('selectedRELI '+recId);
        c.set('v.selectedRELI',recId);
        c.set('v.isNewQA',true);
      //c.find('NewAssignQA').createRecord();   
    },
    getValueFromLwc : function(component, event, helper) {
		component.set("v.isNewQA",event.getParam('isNewQA'));
	},
    closeModel: function(c, e, h) {
        c.set('v.isNewQA', false);
    },
    handleSuccess : function(cmp, event, helper) {
        console.log('##enter handleSuccess');
        cmp.set('v.isNewQA', false);
		helper.getRecords(cmp,helper);        
    },
    onSubmit :function(cmp,event,h){
        console.log('##enter onSubmit');
        event.preventDefault();       // stop the form from submitting
        /*const fields = event.getParam('fields');
        console.log('##',cmp.get('v.selectedRELI'));*/
        //fields.Receiving_Line__c = cmp.get('v.selectedRELI');// modify a field
        cmp.find('myRecordForm').submit();
    }
})