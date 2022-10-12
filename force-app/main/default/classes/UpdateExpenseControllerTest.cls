@isTest
public class UpdateExpenseControllerTest {
    private static testmethod void runTest(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        Expense_Number__c  en = new Expense_Number__c (Expense_Approver__c = UserInfo.getUserId(), Project__c = objAccount.Id,ExpenseStatus__c = 'Approved', Reimbursed__c =true,Reimbursed_Date__c = System.today());
        insert en;
        
        Expense_Line__c el = new Expense_Line__c (ExpenseNumber__c = en.Id, ExpenseDate__c = System.today().addDays(2),Related_Account__c = objAccount.Id, Qty__c =1, ExpenseAmount__c =100, ExpenseType__c = 'Event', ExpenseDescription__c = 'Test');
        insert el;
        Test.startTest();
        Approval.lock(en);
        Expense_Number__c  en1 = UpdateExpenseController.getExpenseRecord(en.Id);
        Map<String,Object> detaisl = UpdateExpenseController.updateExpenseRecord(JSON.serialize(en1));
    }
}