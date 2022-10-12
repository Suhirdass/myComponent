({
    acceptOrder : function(component, event) {
        var action = component.get("c.acceptOrder");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
                if(response.getReturnValue()){
                    component.set("v.draft", true);
                    /*  $A.get("e.force:closeQuickAction").fire();
                    // Option 1
                    $A.get('e.force:refreshView').fire();
                    // Option 2
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/" + component.get("v.recordId")                        
                    });
                    urlEvent.fire();*/                    
                }else{                    
                    component.set("v.alreadyApproved", true);
                }                
            }
            else if (state === "ERROR") {
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
    getData : function(c, event) {
        console.log('getData....getData');
        const h = this;
        h.request(c, 'getOrderDetails', { 'recordId': c.get("v.recordId") }, function (r) {
            console.log('getOrderDetails::',r);
            c.set('v.order',r.order);
            c.set('v.recordName',r.order.Name);
            c.set('v.selectedSite',r.order.Site__c);
            c.set('v.Err_Msg_of_Ship_To_and_Origin_Site',r.Err_Msg_of_Ship_To_and_Origin_Site);
            let sitesOptions = [];
            if(r.sites){
                [].concat(r.sites).forEach(site=>{
                    sitesOptions = [...sitesOptions,{label:site.Warehouse_Name__c,value:site.Id}];
				})
            }
            c.set('v.sites',r.sites);
            c.set('v.sitesOptions',sitesOptions);
        });
        /*var action = component.get("c.getRecordName");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: " + response.getReturnValue());
				component.set("v.recordName", response.getReturnValue());                
            }
            else if (state === "ERROR") {
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
        $A.enqueueAction(action);*/
    }
})