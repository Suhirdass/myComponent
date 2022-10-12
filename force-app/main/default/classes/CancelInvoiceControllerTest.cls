/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelInvoiceControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CancelInvoiceControllerTest{
    
    static Invoice__c invoiceSO;
    static List<Sales_Order_Line__c> soLines;
    
    // Test loading VF page
    static testMethod void testUpdateInvoiceAndSOLines(){
        retrieveData();
        
        // verify invoice status
        System.assertEquals('Draft', 
                            invoiceSO.AR_Status__c,
                            'Invoice status mis-match');
        
        // verify SO lines Qty invoiced
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        System.assertEquals(5.0,
                            soLines[0].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
                            
        System.assertEquals(15.0,
                            soLines[1].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
                            
        System.assertEquals(25.0,
                            soLines[2].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
        
        PageReference pageRef = Page.CancelInvoice;
        pageRef.getParameters().put('id', invoiceSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(invoiceSO);
        CancelInvoiceController controllerObj = new CancelInvoiceController(stdController);
        controllerObj.updateInevoiceAndLines();
        
        // verify invoice status
        invoiceSO = [Select Id, AR_Status__c from Invoice__c where Id =: invoiceSO.Id];
        System.assertEquals(InvoiceSupport.INVOICE_STATUS_CANCELLED,
                            invoiceSO.AR_Status__c, 
                            'Invoice status mis-match');
                            
        // verify SO lines Qty invoiced
        soLines = [Select Qty_Invoiced__c From Sales_Order_Line__c];
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        System.assertEquals(0.0,
                            soLines[0].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
                            
        System.assertEquals(0.0,
                            soLines[1].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
                            
        System.assertEquals(0.0,
                            soLines[2].Qty_Invoiced__c, 
                            'SO Line Qty Invoiced mis-match');
                    
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invoiceSO = new Invoice__c();
        invoiceSO = [Select Id, AR_Status__c from Invoice__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Qty_Invoiced__c From Sales_Order_Line__c];
    }
}