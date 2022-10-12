@isTest
public class InvoiceLockingScreenControllerTest {
    static testMethod void runtest(){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        TestUtilData.createTestData();
        
        Invoice__c inv =[SELECT id,Invoice_Date__c,IsLocked__c,Revenue_Recognition_Date__c FROM Invoice__c LIMIT 1];
        inv.Invoice_Date__c  = system.today();
        inv.IsLocked__c = true;
        inv.Revenue_Recognition_Date__c = system.today();
        update inv;
        
        Revenue_Recognition__c rr =new  Revenue_Recognition__c();
        rr.Revenue_Recognition_Date__c = system.today();
        rr.IsLocked__c = true;
        insert rr;
        
        InvoiceLockingScreenController.init();
        InvoiceLockingScreenController.LockedInvoices(system.today().year(),system.today().month());
        InvoiceLockingScreenController.lockAndUnlockToInvoice(inv.Id,true);
        InvoiceLockingScreenController.lockAndUnlockToInvoice(inv.Id,false);
        InvoiceLockingScreenController.getInvoiceData(1,10,system.today().year(),system.today().month());
        InvoiceLockingScreenController.checkMonthInvoices(system.today().year(),system.today().month());
        
        
    }
}