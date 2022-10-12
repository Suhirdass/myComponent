/**************************************************************************************
Apex Class Name    : MiscReceiptControllerTest
Version            : 1.0
Created Date       : July 26 2018
Function           : Used for MiscReceipt VF page
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  07/26/2018              Original Version
*******************************************************************************/
@isTest
public class MiscReceiptControllerTest{
    static List<Inventory_Position__c> invPositions;
    static List<Product2> products;

  /*  @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    } */
    
        @TestSetUp
        static void testDataSetUp(){
            Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
            TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
            Site__c[] sites = [SELECT Id FROM Site__c];
            Site_User__c su = new Site_User__c(Site__c = sites[0].Id,User__c = UserInfo.getUserId(),Active__c = true);
            insert su;
    }
  
  // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Rack__c, 
                        Rack_Level__c, 
                        Bin_Location__c, 
                        Qty_On_Hand__c,
                        Inventory_Location__c,
                        Inventory_Location__r.Name
                        From Inventory_Position__c];
    }
    
    Public static testMethod void inventoryDetailsTest2(){
        Test.StartTest();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        System.debug('1..');
       /* Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Test product InvDetTest2';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        insert objProduct1; */
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 1';
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
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
                
        List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        insert inv;
        
        Inventory_Position__c inv2 = new Inventory_Position__c();
        inv2.Receiving_Line__c=receivingLines[0].ID;
        inv2.Product_Name__c=objProduct1.id;
        inv2.Qty_On_Hand__c=10;
        
        System.assertNOTEquals(objProduct1,null);
        //invPositions[0].Product_Name__c =objProduct1.ID;
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id',objProduct1.ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objProduct1);
        
        MiscReceiptController testObj = new MiscReceiptController(sc);
        testObj.recordID =objProduct1.ID;
        testObj.cancelRedirect();
        testObj.SaveRecord();        
        
        List<Product2> prodList = new List<Product2>();
        List<Inventory_Position__c> invPositionList;
        List<InventoryPositionWrapper> invPositionWrappList = new List<InventoryPositionWrapper>();
        prodList =[Select ID,name,Producer_Name__c,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,MOQ__c,
                   (Select id,Name,Site__c,Product_Name__c,Inventory_Location__c,Harvest_Batch_Code__c,UID_New__c,Rack__c,Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Rack_Level__c,Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c from Inventory_Positions__r) from Product2 where ID=:objProduct1.id];
        if(prodList.size()>0){
            //prod=prodList[0];
            invPositionList =prodList[0].Inventory_Positions__r;
            for(Inventory_Position__c invPosRec :invPositionList){
                InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
                invPositionWrappList.add(wrap);
            } 
        }
        Inventory_Perpetual_Adjustment__c invPerAdj = new Inventory_Perpetual_Adjustment__c();
        invPerAdj.Reason_for_Adjustments__c='Test adj';
        invPerAdj.Type__c='Miscellaneous Issue';
        
        MiscReceiptController.createInventoryPerpetualAdjustment(invPositionList[0],invPerAdj);
        
        MiscReceiptController.miscReceiptLightningLoad(objProduct1.ID);
        MiscReceiptController.saveRecordLightning(objProduct1.ID,inv2,invPerAdj);
        
        System.assertNOTEquals(testObj,null);
    }
}