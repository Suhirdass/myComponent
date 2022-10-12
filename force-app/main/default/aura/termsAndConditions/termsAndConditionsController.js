({
	handleClick : function(c, event, helper) {
		helper.request(c, 'hasAccepted', {}, function (r) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": '',
                "message": 'Accepted terms and conditions!',
                "type": 'success'
            });
            toastEvent.fire();
			$A.get("e.force:closeQuickAction").fire();  
            $A.get('e.c:newsAndAnnouncementEvent').fire();
        }); 	
        
	}
})