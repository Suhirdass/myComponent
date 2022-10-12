/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CreateInvoiceControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CreateInvoiceControllerTest{
    
    static Sales_Order__c salesOrderSO;
    static List<Sales_Order_Line__c> soLines;
    static List<Invoice__c> invoices;
	 
    // Test loading sales order lines
    static testMethod void testLoadSOLines(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO status as Approved and Allocated as true
        salesOrderSO.SO_Status__c = SalesOrderSupport.SO_STATUS_APPROVED;
        salesOrderSO.Allocated__c = true;
        update salesOrderSO;
        
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        
        controllerObj.pageSize = '2';
        
        // load page size picklist
        controllerObj.getPageSizeOptions();
        controllerObj.retrieveSalesOrderAndLines();
        
        AuraResponse r = new AuraResponse('CreateInvoiceController.createInvoice()');    
        CreateInvoiceController assign = new CreateInvoiceController();
        /*
        Sales_Order_Line__c soLine = new Sales_Order_Line__c();
        Brand_Quote_Line__c brand = [select id,MOQ__c from Brand_Quote_Line__c limit 1];
        Account acc = [select id from Account limit 1];
        Product2 prd = [select id from Product2 limit 1];
        RecordType rT = [select id, Description, name from RecordType where Description like '%Used for Retail Shipments%' limit 1];
        soLine.Brand_Quote_Line__c = brand.id;
        soLine.Product_Name__c = prd.id;
        soLine.Ownership_Code__c = acc.id;
        soLine.Product_Title__c = 'Supplier';
        soLine.RecordTypeId = rT.id;
        //soLine.MOQ__c = brand.MOQ__c;
        soLine.Retail_Wholesale_Price__c = 200;
        
        soLine.Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        //update soLine;
        */
        List<CreateInvoiceController.SalesOrderLineWrapper> soliWrapprList = new List<CreateInvoiceController.SalesOrderLineWrapper>();    
       
        CreateInvoiceController.SalesOrderLineWrapper soliWrappr1  = new  CreateInvoiceController.SalesOrderLineWrapper();
        CreateInvoiceController.SalesOrderLineWrapper soliWrappr2  = new  CreateInvoiceController.SalesOrderLineWrapper();
        CreateInvoiceController.SalesOrderLineWrapper soliWrappr3  = new  CreateInvoiceController.SalesOrderLineWrapper();
		
        soliWrappr1.isSelected = true;
        soliWrappr1.isDisabled = false;
        soliWrappr1.qtyToBill = 1;
        soliWrappr1.salesOrderLineSO = soLines[0];
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soliWrapprList.add(soliWrappr1);

        soliWrappr2.isSelected = true;
        soliWrappr2.isDisabled = false;
        soliWrappr2.qtyToBill = 1;
        soliWrappr2.salesOrderLineSO = soLines[1];
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_CANCELLED;
        soliWrapprList.add(soliWrappr2);

        soliWrappr3.isSelected = true;
        soliWrappr3.isDisabled = false;
        soliWrappr3.qtyToBill = 1;
        soliWrappr3.salesOrderLineSO = soLines[2];
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_REJECTED;
        soliWrapprList.add(soliWrappr3);
        test.startTest();
        CreateInvoiceController.createInvoice(salesOrderSO.Id);
        AuraResponse ar = CreateInvoiceController.createInvoiceAndLinesLight(salesOrderSO, soliWrapprList);
        
        salesOrderSO.Allocated__c = false;
        update salesOrderSO;
        CreateInvoiceController.createInvoice(salesOrderSO.Id);
        
        salesOrderSO.SO_Status__c = 'Cancelled';
        update salesOrderSO;
        CreateInvoiceController.createInvoice(salesOrderSO.Id);
        
        salesOrderSO.SO_Status__c = 'Draft';
        update salesOrderSO;
        CreateInvoiceController.createInvoice(salesOrderSO.Id);
        
        // get total SO lines
        System.assertEquals(3, controllerObj.salesOrderLines.size(), 'Total sales order lines mis-match');
        
        // get sales order lines displayed per page based on page size
        // first page of pagination
        System.assertEquals(2, controllerObj.setSalesOrderLines.size(),  'Sales order lines per page mis-match');
        System.assertEquals(true, controllerObj.hasSalesOrderLines, 'SO lines flag mis-match');
        
        // get So lines displayed per page based on page size
        // first page of pagination
        System.assertEquals(2, controllerObj.setSalesOrderLines.size(),  'Sales order lines per page mis-match');
        System.assertEquals(true, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.salesOrderLinesIterable.currentPage, 'Current page number mis-match');
        controllerObj.updateQtyToBillForAllSOLines();
        
        // next action of pagination
        controllerObj.nextSalesOrderLines();
        System.assertEquals(1, controllerObj.setSalesOrderLines.size(),  'Sales Order Linesper page mis-match');
        System.assertEquals(false, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(true, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        System.assertEquals(2, controllerObj.salesOrderLinesIterable.currentPage, 'Current page number mis-match');
        
        // previous action of pagination
        controllerObj.previousSalesOrderLines();
        System.assertEquals(2, controllerObj.setSalesOrderLines.size(),  'Sales Order Linesper page mis-match');
        System.assertEquals(true, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.salesOrderLinesIterable.currentPage, 'Current page number mis-match');
        
        // last action of pagination
        controllerObj.lastSalesOrderLines();
        System.assertEquals(1, controllerObj.setSalesOrderLines.size(),  'Sales Order Linesper page mis-match');
        System.assertEquals(false, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(true, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        System.assertEquals(2, controllerObj.salesOrderLinesIterable.currentPage, 'Current page number mis-match');
        
        // first action of pagination
        controllerObj.firstSalesOrderLines();
        System.assertEquals(2, controllerObj.setSalesOrderLines.size(),  'Sales Order Linesper page mis-match');
        System.assertEquals(true, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.salesOrderLinesIterable.currentPage, 'Current page number mis-match');
        
        // reset page size
        controllerObj.pageSize = '10';
        controllerObj.doResetSalesOrderLinesPageSize();
        System.assertEquals(1, controllerObj.salesOrderLinesIterable.totalPages, 'Total pages mis-match');
        System.assertEquals(3, controllerObj.setSalesOrderLines.size(),  'Sales Order Linesper page mis-match');
        System.assertEquals(false, controllerObj.hasNextSalesOrderLines, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousSalesOrderLines, 'Previous link visible flag mis-match');
        
        test.stopTest();
    }
    
    
    // Test cancel button action
    static testMethod void testCancelAction(){
        
        // Get data created from setup
        retrieveData();
        
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        
        controllerObj.retrieveSalesOrderAndLines();
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+salesOrderSO.Id, pageRef.getURL(), 'Page referece mis-match');
    }
    
    // Test validation 1 - No sales order lines selected and user selected Create Invoice button
    static testMethod void testSOLinesValidation1(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO status as Approved and Allocated as true
        salesOrderSO.SO_Status__c = SalesOrderSupport.SO_STATUS_APPROVED;
        salesOrderSO.Allocated__c = true;
        update salesOrderSO;
        
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        
        controllerObj.retrieveSalesOrderAndLines();
        pageRef = controllerObj.createInvoiceAndLines();
        System.assertEquals(null, pageRef, 'Page referece mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Sales_Order_Line_Selected), 'Validation message mis-match');
    }
    
    // Test validation 2
    // Qty to Bill must be positive value and cannot be greater than qty to invoiced
    static testMethod void testSOLinesValidation2(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO status as Approved and Allocated as true
        salesOrderSO.SO_Status__c = SalesOrderSupport.SO_STATUS_APPROVED;
        salesOrderSO.Allocated__c = true;
        update salesOrderSO;
        
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        
        controllerObj.retrieveSalesOrderAndLines();
        
        // Select sales order line and provide qty to bill values
        controllerObj.setSalesOrderLines[0].isSelected = true;
        controllerObj.setSalesOrderLines[0].qtyToBill = -5; // negative value
        controllerObj.setSalesOrderLines[1].isSelected = true;
        controllerObj.setSalesOrderLines[1].qtyToBill = 100; // greater than qty to invoiced
        controllerObj.setSalesOrderLines[2].isSelected = true;
        controllerObj.setSalesOrderLines[2].qtyToBill = null; // not specified
        
        pageRef = controllerObj.createInvoiceAndLines();
        System.assertEquals(null, pageRef, 'Page referece mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(2, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage1 = String.format(Label.Qty_To_Bill_Positive_Value, 
                        new List<String>{controllerObj.setSalesOrderLines[0].salesOrderLineSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage1), 'Validation message mis-match');
        
        String errorMessage2 = String.format(Label.Qty_To_Bill_Cannot_Be_Greater_Than_Qty_To_Invoiced, 
                         new List<String>{controllerObj.setSalesOrderLines[1].salesOrderLineSO.Product_Name__r.Name});
        System.assert(msgList[1].getDetail().contains(errorMessage2), 'Validation message mis-match');
    }
    
    // Create Invoice and Lines 
    // Update SO lines with Qty invoiced value
    static testMethod void testCreateInvoiceAndRelatedLines_UpdateSOLineWithQtyInvoiced(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO status as Approved and Allocated as true
        salesOrderSO.SO_Status__c = SalesOrderSupport.SO_STATUS_APPROVED;
        salesOrderSO.Allocated__c = true;
        update salesOrderSO;
        
        // Update planned ship date of Sales order
        salesOrderSO.Planned_Ship_Date__c = System.Today();
        salesOrderSO.Payment_Terms__c = 'NET 5'; 
        update salesOrderSO;
        
        // Existing invoice size
        System.assertEquals(1, invoices.size(), 'Invoice size mis-match');
        
        // SO lines Qty invoiced
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        System.assertEquals(5.0,
                            soLines[0].Qty_Invoiced__c, 
                            'Qty Invoiced mis-match');
                            
        System.assertEquals(15.0,
                            soLines[1].Qty_Invoiced__c, 
                            'Qty Invoiced mis-match');
                            
        System.assertEquals(25.0,
                            soLines[2].Qty_Invoiced__c, 
                            'Qty Invoiced mis-match');
                            
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        
        controllerObj.retrieveSalesOrderAndLines();
        
        // get total SO lines
        System.assertEquals(3, controllerObj.salesOrderLines.size(), 'Total sales order lines mis-match');
        
        // Select sales order line and provide qty to bill values
        controllerObj.setSalesOrderLines[0].isSelected = true;
        controllerObj.setSalesOrderLines[0].qtyToBill = 5; 
        controllerObj.setSalesOrderLines[1].isSelected = true;
        controllerObj.setSalesOrderLines[1].qtyToBill = 5;
        controllerObj.setSalesOrderLines[2].isSelected = true;
        controllerObj.setSalesOrderLines[2].qtyToBill = 5; 
        
        pageRef = controllerObj.createInvoiceAndLines();
        //System.assertEquals('/'+salesOrderSO.Id, pageRef.getURL(), 'Page referece mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        // Verify created invoice & line items and updated SO lines
        /*retrieveData();
        
        System.assertEquals(2, invoices.size(), 'Invoice size mis-match');
        System.assertEquals(salesOrderSO.Id, invoices[1].Sales_Order__c, 'Sales Order of Invoice mis-match');
        System.assertEquals(System.Today().addDays(5), invoices[1].Invoice_Due_Date__c, 'Invoice Due date mis-match');
        
        // SO lines Qty invoiced
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        System.assertEquals(10.0,
                            soLines[0].Qty_Invoiced__c, 
                            'Invoiced qty mis-match');
                            
        System.assertEquals(20.0,
                            soLines[1].Qty_Invoiced__c, 
                            'Invoiced qty mis-match');
                            
        System.assertEquals(30.0,
                            soLines[2].Qty_Invoiced__c, 
                            'Invoiced qty mis-match');
        
        // Get invoice lines
        List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
        invoiceLines = [Select Invoice_Qty__c, Sales_Order_Line__c From Invoice_Line__c Where Invoice__c =: invoices[1].Id];
        System.assertEquals(3, invoiceLines.size(), 'SO lines mis-match');
        
        System.assertEquals(5.0,
                            invoiceLines[0].Invoice_Qty__c, 
                            'Invoice qty mis-match');
        System.assertEquals(soLines[0].Id,
                            invoiceLines[0].Sales_Order_Line__c, 
                            'Sales Order Line of Invoice Line mis-match');
                            
        System.assertEquals(5.0,
                            invoiceLines[1].Invoice_Qty__c, 
                            'Invoice qty mis-match');
        System.assertEquals(soLines[1].Id,
                            invoiceLines[1].Sales_Order_Line__c, 
                            'Sales Order Line of Invoice Line mis-match');
                            
        System.assertEquals(5.0,
                            invoiceLines[2].Invoice_Qty__c, 
                            'Invoice qty mis-match');
        System.assertEquals(soLines[2].Id,
                            invoiceLines[2].Sales_Order_Line__c, 
                            'Sales Order Line of Invoice Line mis-match');*/
    }
    
  
    
    // Test load create invoice page for cancelled SO
    static testMethod void testCreateInvoiceForCancelledSO(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO status as Cancelled
        salesOrderSO.SO_Status__c = SalesOrderSupport.SO_STATUS_CANCELLED;
        update salesOrderSO;
        
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        pageRef = controllerObj.retrieveSalesOrderAndLines();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Create_Invoice_For_Cancelled_SO), 'Validation message mis-match');
    }
    
    // Test load create invoice page for non approved or non allocated
    static testMethod void testCreateInvoiceForNonApprovedOrNonAllocatedSO(){
        
        // Get data created from setup
        retrieveData();
        
        // SO status is not approved
        PageReference pageRef = Page.CreateInvoice;
        pageRef.getParameters().put('id', salesOrderSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderSO);
        CreateInvoiceController controllerObj = new CreateInvoiceController(stdController);
        pageRef = controllerObj.retrieveSalesOrderAndLines();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO), 'Validation message mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        salesOrderSO = new Sales_Order__c();
        salesOrderSO = [Select Id, Allocated__c, SO_Status__c, Planned_Ship_Date__c from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Qty_Invoiced__c From Sales_Order_Line__c];
        
        invoices = new List<Invoice__c>();
        invoices = [Select Id, Sales_Order__c, Shipped_Date__c, Invoice_Due_Date__c from Invoice__c];
        
        // Create payment term custom settings record
        TestUtilData.createPaymentTermSettigs('NET 5', 5, true);
        TestUtilData.createPaymentTermSettigs('NET 10', 10, true);
    }
}