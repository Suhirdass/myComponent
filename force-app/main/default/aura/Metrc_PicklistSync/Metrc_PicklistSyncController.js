({
    doInit : function(component, event, helper){
        helper.checkUserMetrcAcsess(component, event, helper);
    },
     syncDataToMetrc : function(component, event, helper) {
        helper.syncDataToMetrcHelper(component, event, helper);  
     },
     cancelModal : function(component, event, helper) {
        helper.cancelModal(component, event, helper);  
     }

})