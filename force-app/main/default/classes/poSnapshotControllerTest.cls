@isTest
public class poSnapshotControllerTest {
    
  static testMethod void testShipConfirmRSM() {
       test.startTest();
        TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
         TestUtilData.createTestData();
        Site__c s =[SELECT Id From Site__c Limit 1];
        Account acc =[SELECT Id From Account WHERE Name=:'Test Account1' Limit 1];
        
       /* State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = s.Id;
        sl.Total_Miles__c=1;
        insert sl; */
        
        //Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = sl.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        //insert ccs;
        Purchase_Order__c  po = [Select Id,PO_Status__c,Site__c,Ownership__c,Supplier_Name__c,Supplier_License__c,Distributor_Name__c
                                 ,Distributor_License__c,Receiver_Name__c,Receiver_License__c from Purchase_Order__c LIMIT 1];
        po.PO_Status__c='Closed';
        po.Total_Weight_Fee__c =1;
        po.Goods_Receipt_Date__c=system.today();
        update po;
        poSnapshotController.runPOSnapshot(po.Id);
      	Database.executeBatch(new batchToRunPoSnapshot());
        
        Test.stopTest();
    }
}