@isTest
public class runSupplierBillSnapshotTest {
static testMethod void testShipConfirmRSM() {
    test.startTest();
    TestUtilData.skipTrigger = true;
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
    TestUtilData.createTestData();
    Site__c s =[SELECT Id From Site__c Limit 1];
    Account acc =[SELECT Id From Account WHERE Name=:'Test Account1' Limit 1];
    Supplier_Bill__c PO = new Supplier_Bill__c();
    PO.Status__c = 'Approved';
    insert PO;
    Supplier_Bill__c  SB = [SELECT Bill_Amount__c,Bill_Closing_Date__c,Bill_Due_Date__c,Bill_Opening_Date__c,Bill_Settled_Date__c,Brand_Quote__c,
                            Chart_of_Account__c FROM Supplier_Bill__c where id =:PO.Id];
    SB.Bill_Closing_Date__c=system.today();
    //  SB.Ship_Confirmation_Date__c =system.today();
    SB.Bill_Amount__c=200;
    update SB;
    runSupplierBillSnapshot.runSupplierBillSnapshot(SB.Id);
    Database.executeBatch(new batchToRunSupplierBillSnapshot());
    
    Test.stopTest();
}
}