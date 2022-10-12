/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceSupportTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class InvoiceSupportTest{

    static final Date PLANNED_SHIP_DATE = System.Today();
    
    // Blank payment term
    static testMethod void testCalculateInvoiceDueDate_BlankPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE, 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, null),
                            'Invoice Due Date mis-match');
        System.assertEquals(PLANNED_SHIP_DATE, 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE,PLANNED_SHIP_DATE, null),
                            'Invoice Due Date mis-match');
    }
    
    // COD + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_COD5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(5), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'COD + 5 RR'),
                            'Invoice Due Date mis-match');
    }

     // NET 5 payment term
    static testMethod void testCalculateInvoiceDueDate_NET5PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(5), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 5'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 5 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET5_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(10), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 5 + 5 RR'),
                            'Invoice Due Date mis-match');
    }

     // NET 7 payment term
    static testMethod void testCalculateInvoiceDueDate_NET7PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(7), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 7'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 7 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET7_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(12), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 7 + 5 RR'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 10 payment term
    static testMethod void testCalculateInvoiceDueDate_NET10PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(10), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 10'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 10 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET10_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(15), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 10 + 5 RR'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 14 payment term
    static testMethod void testCalculateInvoiceDueDate_NET14PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(14), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 14'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 14 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET14_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(19), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 14 + 5 RR'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 15 payment term
    static testMethod void testCalculateInvoiceDueDate_NET15PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(15), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 15'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 15 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET15_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(20), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 15 + 5 RR'),
                            'Invoice Due Date mis-match');
    }

    // NET 21 payment term
    static testMethod void testCalculateInvoiceDueDate_NET21PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(21), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 21'),
                            'Invoice Due Date mis-match');
    }
    // NET 21 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET21_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(26), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 21 + 5 RR'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 30 payment term
    static testMethod void testCalculateInvoiceDueDate_NET30PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(30), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 30'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 30 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET30_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(35), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 30 + 5 RR'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 45 payment term
    static testMethod void testCalculateInvoiceDueDate_NET45PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(45), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 45'),
                            'Invoice Due Date mis-match');
    }
    
    // NET 45 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET45_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(50), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 45 + 5 RR'),
                            'Invoice Due Date mis-match');
    }

    // NET 60 payment term
    static testMethod void testCalculateInvoiceDueDate_NET60PaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(60), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 60'),
                            'Invoice Due Date mis-match');
    }
    // NET 60 + 5 RR payment term
    static testMethod void testCalculateInvoiceDueDate_NET60_5RRPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE.addDays(65), 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'NET 60 + 5 RR'),
                            'Invoice Due Date mis-match');
    }   
    
    // Different payment term
    static testMethod void testCalculateInvoiceDueDate_DifferentPaymentTerm(){
        System.assertEquals(PLANNED_SHIP_DATE, 
                            InvoiceSupport.calculateInvoiceDueDate(PLANNED_SHIP_DATE, 'Test'),
                            'Invoice Due Date mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        // Create payment term custom settings records
        List<Payment_Terms_Settings__c> paymentTermSettingsList = new List<Payment_Terms_Settings__c>();
        
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('COD + 5 RR', 5, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 5', 5, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 5 + 5 RR', 10, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 7', 7, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 7 + 5 RR', 12, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 10', 10, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 10 + 5 RR', 15, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 14', 14, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 14 + 5 RR', 19, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 15', 15, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 15 + 5 RR', 20, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 21', 21, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 21 + 5 RR', 26, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 30', 30, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 30 + 5 RR', 35, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 45', 45, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 45 + 5 RR', 50, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 60', 60, false));
        paymentTermSettingsList.add(TestUtilData.createPaymentTermSettigs('NET 60 + 5 RR', 65, false));
        
        insert paymentTermSettingsList;
        TestUtilData.createTestData();
    }
}