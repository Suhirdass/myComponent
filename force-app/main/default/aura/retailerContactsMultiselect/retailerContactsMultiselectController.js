({
    doInit :  function (component, event, helper) {
        console.log('InChils',component.get('v.selectedContactids'));
        var selectedContactids = component.get('v.selectedContactids');
        if(selectedContactids != ''){
            component.set('v.selectedContactList',selectedContactids.split(';'));
        }
    },
	handleContactsChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.selectedContactList", selectedValues);
        component.set("v.selectedContactids", selectedValues.join(';'));
        var cmpEvent = component.getEvent("retailerContactsMultiselectEvt"); 
        
        cmpEvent.fire();
    }
})