({
	doInit : function(c, e, h) {
      
    },
    
    closeModel: function(component, event, helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    },
    
    runIps: function(c, e, h) {
        h.request(c,'runSupplierBillSnapshot', {recordId: c.get("v.recordId")}, function(r){
        	h.navigateToRecord(c, c.get('v.recordId'));    
        })
	},
})