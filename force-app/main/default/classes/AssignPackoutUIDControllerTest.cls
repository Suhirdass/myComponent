@isTest
public class AssignPackoutUIDControllerTest {
	private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
                TestUtilData.skipTrigger = true;

        TestUtilData.createTestData();
        Test.startTest();
        
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
        
        AssignPackoutUIDController.getStatus(objPicklist.Id);
        AssignPackoutUIDController.getPicklist(objPicklist.Id);
        
        List<Picklist_Line__c> lstPickLine = new List<Picklist_Line__c>();
        lstPickLine = [SELECT Id,Name from Picklist_Line__c Limit 10];
        if(lstPickLine.size() > 0){
            String piskLineJson = JSON.serialize(lstPickLine); 
            AssignPackoutUIDController.assignPackout(piskLineJson);
        }
                
        Quality_Assurance__c qa = new Quality_Assurance__c();
        qa.Picklist_Line__c = lstPickLine[0].Id;
        qa.Batch_ID__c = 'Pass';
        qa.Product_Verification__c = 'Pass';
        qa.UID__c = 'Pass';
        qa.Qty_Verification__c = 'Pass';
        
        String qaJson = JSON.serialize(qa); 
        AssignPackoutUIDController.createQARec(qaJson,lstPickLine[0].Id);
        
        String status;
        status=AssignPackoutUIDController.ERR_MSG_REQUIRED_QR_CODE;
         status=AssignPackoutUIDController.ERR_MSG_REQUIRED_BAR_CODE;
        
        Brand_Quote__c bq = new Brand_Quote__c ();
        
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        insert bq;
        
        Sales_Order__c so = new Sales_Order__c();
        so.Brand_Quote__c = bq.Id;
        insert so;
        
        Picklist__c p = new Picklist__c();
        p.Sales_Order__c = so.Id;
        insert p;
        
        List<String> plList = new List<String>();
        for(Picklist_Line__c pl : lstPickLine){
            plList.add(pl.Id);
        }
        
        AssignPackoutUIDController.createNewMassQARecord(plList);
        AssignPackoutUIDController.createQARecord(p.Id);
        Test.stopTest();
    }
}