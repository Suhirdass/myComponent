({
	doInit : function(component, event, helper) {
        var error = {
            'Status':'Cannot create Sales Order for Cancelled Brand Quote!',
            'Distributor':'Distributor Name and Distributor License Name Mismatch',
            'Receiver':'Receiver Name and Receiver License Name Mismatch',
            'Supplier':'Supplier Name and Supplier License Name Mismatch',
            'BlankDistributorName':'Please select Distributor Name',
            'BlankReceiverName':'Please select Receiver Name',
            'BlankSupplierName':'Please select Supplier Name',
            'BlankDistributorLC':'Please select Distributor License',
            'BlankReceiverLC':'Please select Receiver License',
            'BlankSupplierLC':'Please select Supplier License',
            'DLInactive':'Distributor License is Inactive',
            'RLInactive':'Receiver License is Inactive',
            'SLInactive':'Supplier License is Inactive',
            'DCBlank':'Distributor Contact is Inactive',
            'RCBlank':'Receiver Contact is Inactive',
            'SCBlank':'Supplier Contact is Inactive'
        };
        var action = component.get("c.getBQStatus");
        action.setParams({ 'recordId': component.get("v.recordId") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let recordStatus = response.getReturnValue(); 
                component.set('v.recordName',recordStatus.recordName);
                component.set('v.recordStatus',recordStatus.status);
                if(recordStatus.misMatchData != ''){
                    component.set('v.isCancelled',true);
                    component.set('v.error', error[recordStatus.misMatchData]);
                }
            }
        })
        $A.enqueueAction(action);
        helper.getData(component, event);
	},
    createSO : function(component, event, helper) {
		helper.createSalesOrder(component, event);
	},
    cancel : function(component, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
})