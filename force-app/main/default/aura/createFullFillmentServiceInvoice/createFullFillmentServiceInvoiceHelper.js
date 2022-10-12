({
	 getData : function(c, e) {
         var h = this;
         console.log('enter getRecordName : ' );
         h.request(c, 'getRecordName', {recordId : c.get("v.recordId")}, function (r) {
             console.log('getRecordName : ' ,r)
             c.set('v.recordName',r.recordName);
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
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);*/
    }
})