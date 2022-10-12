public without sharing class UpdateExpenseController {
    @AuraEnabled
    public static Expense_Number__c getExpenseRecord(String recordId){
        Expense_Number__c expense;
        if(String.isNotBlank(recordId)){
            Expense_Number__c[] expesnes = [SELECT Id, Name, OwnerId,Owner.Name,ExpenseName__c, Reimbursed__c, Reimbursed_Date__c, Approver__c, Project__c , Project__r.Name, TotalExpenseAmount__c      FROM Expense_Number__c WHERE Id =:recordId];
            
            if(!expesnes.isEmpty()){
                expense =  expesnes[0];
            }
        }
        return expense;
    }
    @AuraEnabled
    public static Map<String,Object> updateExpenseRecord(String expenseJSON){
        Map<String,Object> r = new Map<String,Object>();
        Expense_Number__c expense = (Expense_Number__c) JSON.deserialize(expenseJSON, Expense_Number__c.class);
        if(expense.Id != null ){
            UserRecordAccess URA = [SELECT RecordId, HasEditAccess FROM UserRecordAccess WHERE UserId = :UserInfo.getUserId() AND RecordId = :expense.Id];
            if(URA.HasEditAccess){
                Boolean isLocked = Approval.isLocked(expense);
                System.debug('##isLocked::'+isLocked);
                if(isLocked){
                    Approval.UnlockResult unlockedRersult = Approval.unlock(expense);
                    // Iterate through each returned result
                    if (unlockedRersult.isSuccess()) {
                        update expense;
                        r.put('success','Expense '+expense.Name+' updated successfully');
                       Approval.lock(expense);
                    }
                    else {
                        String error = '';
                        // Operation failed, so get all errors                
                        for(Database.Error err : unlockedRersult.getErrors()) {                  
                            error += err.getMessage();
                        }
                        r.put('error',error);
                    }
                }
            }else{
                r.put('error','User don\'t have edit access on the record');
            }
            
        }
        return r;
    }
    
}