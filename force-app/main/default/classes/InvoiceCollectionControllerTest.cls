@isTest(OnInstall=false SeeAllData=false)
public class InvoiceCollectionControllerTest {
    
    static Invoice__c invoiceObj;
    static List<Invoice_Line__c> invLines;
    static State_Licenses__c receiverLicenseObj;
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        
        TestUtilData.createTestData();
    }
    
    public static void retrieveData(){
                       
        // Retrieve License records
        receiverLicenseObj = new State_Licenses__c();
        receiverLicenseObj = [Select License_Name__c, License_Number__c, License_Status__c, License_Type__c, License_Expiration_Date__c, License_Class__c From State_Licenses__c LIMIT 1];
        
        // Retrieve invoice and lines
        invoiceObj = new Invoice__c();
        invoiceObj = [Select Name,Brand_Quote__c, Invoice_Balance__c, Receiver_License__c,Product_Balance__c, Invoice_Due_Date__c, AR_Status__c from Invoice__c];
        
        invLines = new List<Invoice_Line__c>();
        invLines = [Select InvoiceLine_Status__c, Retail_Wholesale_Price__c From Invoice_Line__c];
        
        for(Invoice_Line__c invoiceLineObj : invLines){
            invoiceLineObj.Retail_Wholesale_Price__c = 100.0;
            invoiceLineObj.InvoiceLine_Status__c = RSMSupport.STATUS_DRAFT;
        }
        update invLines;
    }
    
    static testMethod void testShipConfirmRSM() {
        Test.startTest();
        retrieveData();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        
        receiverLicenseObj.License_Name__c = objAccount.Id;
        update receiverLicenseObj;
        
        Id recordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        // Update pending invoice related to RSM
        invoiceObj.RecordTypeId =recordTypeId;
        invoiceObj.Posted_Date__c = System.today();
        invoiceObj.Invoice_Due_Date__c = System.Today() - 5;
        invoiceObj.AR_Status__c = 'Draft';
        invoiceObj.Receiver_Name__c = objAccount.Id;
        invoiceObj.Receiver_License__c = receiverLicenseObj.Id;
        invoiceObj.Collections_Status__c = 'Pending';
        invoiceObj.Total_Payments_Received__c = 1;
        
        update invoiceObj;
        
        System.debug('Product_Balance__c '+invoiceObj.Product_Balance__c);
        
        Receive_Payment__c rec = new Receive_Payment__c(Payment_Received_Date__c=Date.today(),Payment_Memo__c = 'test',
                                                       Payment_Amount__c = 10,Payment_Form__c = 'cash',Invoice__c = invoiceObj.Id);
        insert rec;
        
        List<InvoiceCollectionController.PendingInvoice> lstPending = InvoiceCollectionController.fatchInvoice('Test');
        for(InvoiceCollectionController.PendingInvoice inv : lstPending){
        	inv.taxAmount = '0';
            inv.productAmount = '0';
            inv.receivePaymentSO = rec;
        }
        String jsonStr = JSON.serialize(lstPending);
        InvoiceCollectionController.updateInvoices(jsonStr,'Test');
        
        for(InvoiceCollectionController.PendingInvoice inv : lstPending){
        	inv.taxAmount = '45005';
        }
        InvoiceCollectionController.checkValidation(lstPending);
        for(InvoiceCollectionController.PendingInvoice inv : lstPending){
        	inv.productAmount = '45005';
        }
        InvoiceCollectionController.checkValidation(lstPending);
        
        System.assertEquals(lstPending[0].productAmount, '45005', 'product Amount Equals');
        System.assertNotEquals(lstPending[0].taxAmount, '4500');
        Test.stopTest();
    }
}