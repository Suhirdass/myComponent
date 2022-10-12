@isTest
public class InvoiceSnapshotControllerTest {
        static Invoice__c invoiceObj;
    static List<Invoice_Line__c> invLines;
    static State_Licenses__c receiverLicenseObj;
 static testMethod void runSnapshotTest(){
        Test.startTest();
        
       Invoice__c invoiceSO = new Invoice__c();
        invoiceSO.AR_Status__c = 'Approved';
        insert invoiceSO;
        
        InvoiceSnapshotController.runInvoiceSnapshot(invoiceSO.Id);
      	Database.executeBatch(new BatchToRunIPSnapshot());
        Test.stopTest();
    }
      @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        
        TestUtilData.createTestData();
    }
    
    public static void retrieveData(){
                       
       
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
        
      //  receiverLicenseObj.License_Name__c = objAccount.Id;
    //    update receiverLicenseObj;
        
        Id recordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        // Update pending invoice related to RSM
        invoiceObj.RecordTypeId =recordTypeId;
        invoiceObj.Posted_Date__c = System.today();
        invoiceObj.Invoice_Due_Date__c = System.Today() - 5;
        invoiceObj.AR_Status__c = 'Draft';
        //invoiceObj.Receiver_Name__c = objAccount.Id;
       // invoiceObj.Receiver_License__c = receiverLicenseObj.Id;
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
        InvoiceSnapshotController.runInvoiceSnapshot(invoiceObj.Id);
      	Database.executeBatch(new batchToRunInvoiceSnapshot());
        
        Test.stopTest();
    }
   static testMethod void runSnapshotTest2(){
       Test.startTest();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
     //   insert objProduct1;
        
        Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
        il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
        
        Decimal totalQty = 0.0;
        Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=90;
      //  iv.Product_Name__c = objProduct1.Id;
        totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        InvoiceSnapshotController.getSMdetails(iv.id);
        Test.stopTest();
     
      
   }
    
    
}