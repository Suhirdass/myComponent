@isTest(OnInstall=false SeeAllData=false)
public class CreateCreditMemoToInvoiceControllerTest {
    static Invoice__c invoices;
    static List<Invoice_Line__c> invoiceLines;
	 @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    static testMethod void test1(){
        retrieveData();
        
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(invoices);
        CreateCreditMemoToInvoiceController controllerObj = new CreateCreditMemoToInvoiceController(stdController);
        
        controllerObj.pageSize = '2';
        
        
        
        AuraResponse r = new AuraResponse('CreateCreditMemoToInvoiceController.createInvoice()');    
        CreateCreditMemoToInvoiceController assign = new CreateCreditMemoToInvoiceController();
        r = CreateCreditMemoToInvoiceController.createInvoice(invoices.id);
        List<CreateCreditMemoToInvoiceController.InvoiceLineWrapper> wrp = (List<CreateCreditMemoToInvoiceController.InvoiceLineWrapper>)r.data.get('setInvoiceLines');
        wrp[0].qtyToCredit = 1;
        wrp[0].isSelected = true;
        CreateCreditMemoToInvoiceController.createInvoiceAndLinesLight(invoices,wrp);
    }    
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        
        
        invoices = new Invoice__c();
        invoices = [Select Id,Name,Sales_Order__c,AR_Type__c,Distributor_Contact__c,Sample_Order__c, Sales_Order__r.Name,Receiver_Name__c,Receiver_Name__r.Name,Invoice_Due_Date__c,Collections_Status__c,
                       Brand_Quote__c,Brand_Quote__r.Name,Receiver_Contact__c,Receiver_License__c,Shipped_Date__c,Distributor_License__c,Distributor_Name__c,Distributor_Name__r.Name,Invoice_Memo__c,Opportunity_Name__c,Total_Product_Price__c,Excise_Tax_Balance__c,Customer_PO_or_Quote__c,
                       Payment_Terms__c,Shipping_Method__c,Shipping_Terms__c,Site__c,Supplier_Contact__c,Total_Excise_Tax_Amount__c,Invoice_Balance__c,Site__r.Name, Site__r.Warehouse_Name__c,
                       Ship_Confirmation_Date__c,Order_Booking_Fee__c,Pack_Out_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Mileage_Fee__c,Total_Weight_Fee__c,Retailer_PO__c,
                       Factoring_Assignee__c,Factoring_Contact__c,Factoring_Rate__c,Total_Invoice_Amount__c,Supplier_License__c,Supplier_Name__c,Invoice_Aged__c,RecordTypeId, Ownership__c,RecordType.Name from Invoice__c];
        invoiceLines = new List<Invoice_Line__c>();
        invoiceLines = [SELECT Id,Name,Invoice__c,Product_Title__c,Is_Sample__c,IsPromo__c,OwnershipCode__c,Pick_Pack_Fee__c,QA_Review_Fee__c,
                                            Total_Weight_lbs__c,Listing_Fee__c,ReCalc_Excise_Tax__c,InvoiceLine_Status__c,Retail_Wholesale_Price__c,Sales_Order_Line__c,Sales_Order_Line__r.Name,Product_Name__c,Product_Name__r.Family,Product_Name__r.Name,Product_Description__c,Unit_Excise_Tax__c,Invoice_Qty__c
                                            FROM Invoice_Line__c];
        // Create payment term custom settings record
        TestUtilData.createPaymentTermSettigs('NET 5', 5, true);
        TestUtilData.createPaymentTermSettigs('NET 10', 10, true);
    }
}