({
	doInit : function(component, event, helper) {
        console.log("doInit...");
		var action = component.get("c.getSocialAccounts");
        action.setCallback(this,function(response){
            var state = response.getState();
            console.log("state::",state);
            if (component.isValid() && state === "SUCCESS"){
                var res = response.getReturnValue();
                if(res){
                    console.log("res::",res);
                    if(res.Facebook__c){
                        component.set('v.facebook',res.Facebook__c);
                    }
                    if(res.LinkedIn__c){
                        component.set('v.linkedin',res.LinkedIn__c);
                    }
                    if(res.Twitter__c){
                        component.set('v.twitter',res.Twitter__c);
                    }
                    if(res.Instagram__c){
                        component.set('v.instagram',res.Instagram__c);
                    }
                    
                }
                 
            }
        });
        $A.enqueueAction(action);
	}
})