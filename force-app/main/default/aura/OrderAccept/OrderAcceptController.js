({
    doInit : function(component, event, helper) {
        //helper.acceptOrder(component, event);
        helper.getData(component, event);
    },
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    holdBrandQuote : function(component, event, helper) {
        helper.acceptOrder(component, event);
    },
    yess : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/" + component.get("v.recordId")
            
        });
        urlEvent.fire();
    },
    onSubmit : function(c,e,h){
        const selectedSite = c.get('v.selectedSite');
        const order = c.get('v.order');   
        let sites = c.get('v.sites');
        for(let i = 0;i<sites.length;i++){
            //console.log(sites[i].Id,' : ',order.Site__c)
            if(sites[i].Id == selectedSite){
                //console.log(sites[i].License_ID__c,' : ',order.State_License__c)
                if(sites[i].License_ID__c == order.State_License__c){
                     h.error({message:c.get('v.Err_Msg_of_Ship_To_and_Origin_Site')});   
            		return;
                }
            }
        }
        var siteId;
        if(selectedSite !== order.Site__c)
            siteId = selectedSite;
        else
            siteId = '';
		h.request(c, 'acceptAndUpdateSiteOrder', { 'recordId': c.get("v.recordId"),'siteId': siteId }, function (r) {
            console.log('acceptOrder::',r);
            c.set("v.alreadyApproved", r.alreadyApproved);
            c.set("v.isStatusApproved", r.isStatusApproved);
            if(!r.alreadyApproved){
                $A.get("e.force:closeQuickAction").fire();
                // Option 1
                $A.get('e.force:refreshView').fire();
                // Option 2
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/" + c.get("v.recordId")                        
                });
                urlEvent.fire();                    
            }
        });            
    },
    acceptOrder2 : function(component, event) {
        var action = component.get("c.acceptOrder");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.alreadyApproved", response.getReturnValue().data.alreadyApproved);
                component.set("v.isStatusApproved", response.getReturnValue().data.isStatusApproved);
                if(!response.getReturnValue().data.alreadyApproved){
                    //   component.set("v.draft", true);
                    $A.get("e.force:closeQuickAction").fire();
                    // Option 1
                    $A.get('e.force:refreshView').fire();
                    // Option 2
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/" + component.get("v.recordId")                        
                    });
                    urlEvent.fire();                    
                }                
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
})