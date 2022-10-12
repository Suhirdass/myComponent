({
	doInit : function(c, e, h) {
        console.log('doInit::',c.get('v.recordId'));
        c.set("v.loaded",true);
        var action = c.get("c.getExpenseRecord");
        action.setParams({ 
            "recordId" : c.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            c.set("v.loaded",false);
            var state = response.getState();
            console.log('getExpenseRecord',response.getReturnValue());
            c.set("v.expense",response.getReturnValue());  
            
        });
        $A.enqueueAction(action);
	},
    updateExpense : function(c, e, h) {
        c.set("v.loaded",true);
        var expense = c.get('v.expense');
        console.log('expense:',JSON.stringify(expense));
        var action = c.get("c.updateExpenseRecord");
        action.setParams({ 
            "expenseJSON" : JSON.stringify(expense)
        });
        action.setCallback(this, function(response) {
            c.set("v.loaded",false);
            var state = response.getState();
            console.log('updateExpenseRecord:',response.getReturnValue());
            var r = response.getReturnValue();
            if(r.error){
                h.error({message:r.error});
            }else{
                h.success({message:r.success});
                $A.get("e.force:closeQuickAction").fire();
            }
            
        });
        $A.enqueueAction(action);
    },
    onCancel : function(c, e, h) {
        $A.get("e.force:closeQuickAction").fire(); 
    }
})