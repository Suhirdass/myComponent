({
    doInit : function(c,e,h) {
        var licenses = {
            'Standard' : 'Customer Community User Custom',
            'Standard with PLUS':'Customer Community Plus User Custom'
        }
        var action = c.get('c.getInit'); 
        action.setParams({
            "recordId" : c.get('v.recordId')
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                debugger;
                console.log('fefe',a.getReturnValue());
                var result = a.getReturnValue();
                if(result.Status__c == 'Activated'){
                    c.set('v.isActivated',true);
                }
                if(result.License_Type__c != undefined){
                    c.find("profileVal").set("v.value",licenses[result.License_Type__c]);
                }
                if(result.Account__c != undefined){
                    var acc = {label: result.Account__r.Name, value: result.Account__r.Id};
                    c.set('v.selectedRecord',acc);
                }
            }
        });
        $A.enqueueAction(action);
    },
    closeModal: function(c,e,h){
        $A.get("e.force:closeQuickAction").fire();
    },
    createUser: function(c,e,h){
        var profileName = c.find("profileVal").get("v.value");
        console.log('profileName',profileName);
        var recordId = c.get('v.recordId');
        var accountId = c.get('v.selectedRecord').value || '';
        console.log(c.get('v.selectedRecord'));
        if(profileName == '' || profileName == 'none' || profileName == undefined){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error!",
                "message": "Please select a Profile for the User.",
                "type": "error"
            });
            toastEvent.fire();
        }else{
            var action = c.get('c.approveUser'); 
            action.setParams({
                "recordId" : recordId,
                "profileName" : profileName,
                "accountId":accountId
            });
            action.setCallback(this, function(a){
                console.log('a.getReturnValue()',JSON.parse(JSON.stringify(a.getReturnValue())));
                var state = a.getState(); 
                if(state == 'SUCCESS') {
                    if(a.getReturnValue().length == 18){
                        var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url": "/"+a.getReturnValue()
                        });
                        urlEvent.fire();    
                    }else if(a.getReturnValue() == 'Email already exists.'){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error!",
                            "message": a.getReturnValue(),
                            "type": "error",
                            "duration" : '10000'
                        });
                        toastEvent.fire();
                        $A.get("e.force:closeQuickAction").fire();
                    }else{
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error!",
                            "message": a.getReturnValue(),
                            "type": "error",
                            "duration" : '10000'
                        });
                        toastEvent.fire();
                        $A.get("e.force:closeQuickAction").fire();
                    }
                    
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": a.getReturnValue(),
                        "type": "error",
                        "duration" : '10000'
                    });
                    toastEvent.fire();
                    $A.get("e.force:closeQuickAction").fire();
                }
            });
            $A.enqueueAction(action);
        }
        
    }
})