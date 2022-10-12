({
    doInit : function(component, event, helper){
        helper.checkUserMetrcAcsess(component, event, helper);
    },
     syncDataToMetrc : function(component, event, helper) {
          component.set("v.Spinner", true); 
        helper.syncDataToMetrcHelper(component, event, helper);  
     },
     syncDataToSfdc : function(component, event, helper) {
        helper.syncDataToSFDCHelper(component, event, helper);  
     },
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        //component.set("v.Spinner", true); 
   },
    
 // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
      // component.set("v.Spinner", false);
    }

})