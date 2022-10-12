@IsTest
private class ManageExternalProductCtrlTest {
	@TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    private static testmethod void manageProfileCtrl(){
    	Test.StartTest();
        
        List<Product2> lstProduct = [SELECT Id,Name,Available_Inventory__c,Product_Short_Description__c,Total_Inventory__c FROM Product2 WHERE Name='product 1'];
        lstProduct[0].Available_Inventory__c = 10;
        
        ManageExternalProductCtrl.getProductList();
        ManageExternalProductCtrl.saveProducts(lstProduct);
        System.assertEquals(lstProduct.size(), 1);
        System.assertNotEquals(lstProduct.size(), 3);
        Test.stopTest();
    }
}