({
	showPopup : function(component) {
        var h = this;
        var isDataLoaded = component.get("v.isDataLoaded");
        if(isDataLoaded){
            window.setTimeout($A.getCallback(function(){
            Swal.fire({
              title: component.get('v.recordName'),
              text: ' Cancel PWO. Are you sure ?',
              type: '',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#6b6161',
              confirmButtonText: 'Yes',
                cancelButtonText: 'No',
                focusCancel:true
            }).then((result) => {
              	if (result.value) {
                	h.cancelPWO(component);
            	}else{
                    $A.get("e.force:closeQuickAction").fire();
                    }
            });
                              }),10);
        }else{
            window.setTimeout($A.getCallback(function(){
                h.showPopup(component);
            }),100);
        }
	},
    cancelPWO : function(component) {
        var action = component.get("c.updatePWO");
        action.setParams({ PWOId : component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("cancelPWO From server: " + response.getReturnValue());
				var r = response.getReturnValue();
                if(r.success){
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        "recordId": component.get("v.recordId")
                    });
                    navEvt.fire();
                    $A.get("e.force:closeQuickAction").fire();
                }else{
                    component.set("v.isSuccess",false);
                    component.set('v.message',(r.warning || r.error));
                }
            }
        });
        $A.enqueueAction(action);
    }
})