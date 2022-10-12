@isTest
public class QualityAssuranceTriggerTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        TestUtilData.createTestData();
        Test.startTest();
        
        try{
            Sales_Order__c objSO =[select id,Site__c, Planned_Ship_Date__c from Sales_Order__c limit 1];
            objSO.Planned_Ship_Date__c = date.today();
            
            List<Inventory_Position__c>  invPositions = [Select Site__c, 
                                                         Inventory_Location__r.Name,
                                                         Rack__r.Name,Sales_Order_Line__c,Sales_Order_Line__r.Product_Name__c, 
                                                         Rack_Level__r.Name, 
                                                         Bin_Location__r.Name
                                                         From Inventory_Position__c];
            
            Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
            List<PickList_Line__c> pickListLines = TestUtilData.createPicklistLines(invPositions, objPicklist.Id, true);
            
            List<Picklist_Line__c> lstPickLine = new List<Picklist_Line__c>();
            lstPickLine = [SELECT Id,Name from Picklist_Line__c Limit 10];
            
            List<Receiving_Line__c> lstReceiveLine = new List<Receiving_Line__c>();
            lstReceiveLine = [SELECT Id,Name from Receiving_Line__c Limit 10];
            
            Quality_Assurance__c qa = new Quality_Assurance__c();
            qa.Picklist_Line__c = lstPickLine[0].Id;
            qa.Receiving_Line__c = lstReceiveLine[0].Id;
            qa.Batch_ID__c = 'Pass';
            qa.Product_Verification__c = 'Pass';
            qa.UID__c = 'Pass';
            qa.Qty_Verification__c = 'Pass';
            insert qa;
            
            qa.Picklist_Line__c = lstPickLine[1].Id;
            update qa;
            
            delete qa;
        } catch(Exception ex){}
        
        Test.stopTest();
    }
}