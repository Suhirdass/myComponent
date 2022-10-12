@isTest
public class ReceivePaymentsCtlrTest {
    private static testmethod void runTest(){
        Account acc = new Account();
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        insert acc;
        Invoice__c invoiceSO = new Invoice__c();
        invoiceSO.AR_Status__c = 'Approved';
        
        insert invoiceSO;
        invoiceSO = [SELECT Id,Name FROM Invoice__c WHERE Id = :invoiceSO.Id];
        Bank_Register__c br = new Bank_Register__c(Bank_Name__c='Safe',Account__c = acc.Id);
        insert br;
        String paymentsData = '[{"InvoiceNumber":"'+invoiceSO.Name+'","RecordType":"Service","PaymentForm":"Check","Amount":"3217.86","Reference":"Test","PaymentMemo":"PaymentMemo","PaymentReceivedDate":"3/15/19","ReconciliationDate":"3/15/19","ReconciliationNotes":"ReconciliationNotes","CreditToAccount":"Safe"}]';
        Supplier_Bill__c PO = new Supplier_Bill__c();
        PO.Status__c = 'Approved';
        insert PO;
        PO = [SELECT Id,Name FROM Supplier_Bill__c WHERE Id = :PO.Id];
        
        
        String paymentsDataPO = '[{"Billpaysupplier":"'+PO.Name+'","PaymentForm":"Check","Amount":"-1","PaymentMemo":"PaymentMemo","PaymentReceivedDate":"3/15/19","ReconciliationDate":"3/15/19","ReconciliationNotes":"ReconciliationNotes","DebitToAccount":"Safe"}]';
        ReceivePaymentsCtlr.savePayments(paymentsDataPO, true);
        ReceivePaymentsCtlr.savePayments(paymentsData,false);
        
        Chart_of_Account__c accR = new Chart_of_Account__c();
        accR.Name='1000 IRR Business Checking Acct';
        accR.Account_Type__c	='other Assets';
        insert accR;
        
        // TestUtilData.createTestData();
        
        Receive_Payment__c[] rps = [Select Reconciliation_Notes__c,
                                    Posted_Date__c,
                                    Payment_Amount__c,
                                    Invoice__r.Receiver_Name__c,
                                    Bill_Pay__r.Supplier_Name__c,
                                    Name
                                    From Receive_Payment__c  limit 1];
        
        Receive_Payment__c  st1 = [SELECT Id,Reconciliation_Notes__c,Name,Bill_Pay__r.Supplier_Name__c,Posted_Date__c,Payment_Amount__c,Invoice__r.Receiver_Name__c FROM Receive_Payment__c WHERE Id =:rps[0].Id];
        
        Receive_Payment__c rp = new Receive_Payment__c();
        rp.Bank_Name__c ='citi Bank';
        rp.Chart_of_Account__c=accR.id ;
        rp.Payment_Amount__c=1;
        rp.Payment_Form__c='cash';
        rp.Invoice__c=invoiceSO.id;
        rp.Credit_to_Account__c='safe';
        insert rp;
        Map<String,Receive_Payment__c[]> creditToAccountMap = new Map<String,Receive_Payment__c[]>();
        creditToAccountMap.put(rp.Credit_to_Account__c, new Receive_Payment__c[]{rp});
        Bank_Register__c brs = new Bank_Register__c();
        brs.Bank_Balance__c =10;
        brs.Account__c=acc.id;
        brs.Bank_Name__c=rp.Credit_to_Account__c;
        insert brs;
        String INVOICE_OBJECT = 'Invoice__c';
        string entityToPay = INVOICE_OBJECT;
        ReceivePaymentsCtlr.createRegisterEntryLines(brs, rps, entityToPay) ;    
        Decimal oldBalance = 0;
        Register_Entry_Line__c registerEntrySO = new Register_Entry_Line__c();
        registerEntrySO.Entry_Memo__c=rp.Reconciliation_Notes__c;
        registerEntrySO.Bank_Register__c = brs.Id;
        registerEntrySO.Reconciled__c = false;
        registerEntrySO.Chart_of_Account__c=accR.id ;
        registerEntrySO.Old_Balance__c= oldBalance;
        registerEntrySO.Credit_Amount__c = rp.Payment_Amount__c;
        List< Register_Entry_Line__c>   reLines = new  List <Register_Entry_Line__c> ();
        reLines.add(registerEntrySO);
        insert reLines;
        ReceivePaymentsCtlr.getOldBalanceOfRegisterEntry(brs);  
        ReceivePaymentsCtlr.createBankRegisterEntry(creditToAccountMap, entityToPay);   
    }
}