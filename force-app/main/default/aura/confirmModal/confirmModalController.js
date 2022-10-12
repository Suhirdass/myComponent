({
	onCancel : function(component, event, helper) {
        const modal = document.getElementById('confirm-modal');
        if (modal) modal.classList.remove('is-active');
    },
    handleClick: function(component, event, helper) {
        // call the event   
        var compEvent = component.getEvent("confirmModalEvent");
        compEvent.setParams({"isConfirm" : true });  
        compEvent.fire();
    }
})