({
	closePopup : function(component, event, helper) {
        var checkCmp = component.find("checkbox");
        if(checkCmp.get("v.value")){
            try {
            	helper.request(component,'dontShowAgain',{ },function (r) {
                    $A.get("e.force:closeQuickAction").fire();    
                });
			} catch (err) {
				console.log('Error:', err);		
			}
        }else{
        	$A.get("e.force:closeQuickAction").fire();        
        }
	}
})