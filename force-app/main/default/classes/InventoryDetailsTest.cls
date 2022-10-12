/**************************************************************************************
Apex Class Name    : InventoryDetailsTest 
Version            : 1.0
Created Date       : July 01 2018
Function           : Used for InventoryDetails VF page and used in "InventoryDetails" VF page.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  07/01/2018              Original Version
* Suresh                  07/26/2018             MiscIssue test class added.
*******************************************************************************/
@isTest
public class InventoryDetailsTest {
    static List<Inventory_Position__c> invPositions;
    static List<Product2> products;
    static List<Rack__c> racks;
    static List<Site__c> sites;
    static List<Rack_Level__c> rackLevels;
    static List<Bin_Location__c> binLocations;
    static List<Inventory_Location__c> invLocations;
    
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
    public static void retrieveData(Boolean updateInventoryPositions){
        
        products = [Select Id from Product2];
        products[0].Cannabis_Weight__c = 10.0;
        update products[0];
        invPositions = [Select Rack__c, 
                        Rack_Level__c, 
                        Bin_Location__c, 
                        Qty_On_Hand__c,
                        Site__c,
                        Inventory_Location__c,
                        Product_Name__c,
                        Inventory_Location__r.Name
                        From Inventory_Position__c];
        invLocations = [Select Id, Include_in_Inventory__c From Inventory_Location__c];
        sites = [SELECT Id FROM Site__c];
        // Update inventory location of inventory position as non receiving inspection
        if(updateInventoryPositions){
            for(Inventory_Position__c invPositionSO : invPositions){
                invPositionSO.Inventory_Location__c = invLocations[1].Id;
            }
            update invPositions;
        }
        
        for(Inventory_Location__c invLocationSO : invLocations){
            invLocationSO.Include_in_Inventory__c = true;
        }
        update invLocations;
        
        racks = [Select Name, Inventory_Location__c, Inventory_Location__r.Name From Rack__c ORDER BY NAME];
        rackLevels = [Select Name, Rack__c From Rack_Level__c ORDER BY NAME];
        binLocations = [Select Name, Bin_Volume_Capacity__c, Rack_Level__c, 
                        Ignore_Storage_Limit__c From Bin_Location__c ORDER BY NAME];
        sites = [SELECT Id FROM Site__c];
    }
    
    static testMethod void inventoryDetailsTest(){
        
        Test.startTest();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
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
        
        
        System.assertNOTEquals(objProduct1,null);
        //invPositions[0].Product_Name__c =objProduct1.ID;
        
        List<Inventory_Position__c> invPositions = [Select Inventory_Location__c,Supplier_Name__c,License_Premise__c,Rack_Level__r.Name,
                                                    Supplier_License_Number__c,Product_Name__r.Name,Product_Description__c,Rack__r.Name,
                                                    Purchase_Order__c,Date_Received__c,Harvest_Batch_Code__r.Name,Stocking_UOM__c,Bin_Location__r.Name ,
                                                    UID_New__r.Name,Ownership__r.Name,Qty_Allocated__c,Quantity_Type__c,
                                                    Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c];
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id',objProduct1.ID);
        pageRef.getParameters().put('selectedIds',invPositions[0].Id+','+invPositions[1].Id+','+invPositions[2].Id);
        pageRef.getParameters().put('holdType','Hold');
        pageRef.getParameters().put('selectedIps',invPositions[0].Id+','+invPositions[1].Id+','+invPositions[2].Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objProduct1);
        InventoryDetails testObj = new InventoryDetails(sc);
        testObj.recordID =objProduct1.ID;
        testObj.redirectItemDetail();
        testObj.recordID ='';
        testObj.selectedRecordId=objProduct1.ID;
        testObj.refreshInventoryDetails();
        testObj.recordID =objProduct1.ID;
        testObj.selectedRecordId='';
        testObj.refreshInventoryDetails();
        
        
        List<String> lstStr = new List<String>();
        List<InventoryPositionWrapper> lstInv = new List<InventoryPositionWrapper>();
        
        for(Inventory_Position__c inv1 : invPositions){
            lstInv.add(new InventoryPositionWrapper(true,inv1));
            lstStr.add(inv1.Id);
        }
        lstInv.add(new InventoryPositionWrapper(false,invPositions[0]));
        String str = JSON.serialize(lstInv);
        
        List<InventoryDetails.InventoryPositionWrapperPut> lstInvPut = new List<InventoryDetails.InventoryPositionWrapperPut>();
        
        InventoryDetails.InventoryPositionWrapperPut newPut = new InventoryDetails.InventoryPositionWrapperPut(invPositions[0]);
        newPut.qtyToPutAway = -10;
        lstInvPut.add(newPut);
        //lstInvPut.add(new InventoryDetails.InventoryPositionWrapperPut(invPositions[0]));
        String strPut = JSON.serialize(lstInvPut);
        String posIds = JSON.serialize(lstStr);
        
        List<Bin_Location__c> lstBin = [Select Name,Id, Bin_Volume_Capacity__c, Rack_Level__c,Ignore_Storage_Limit__c From Bin_Location__c ORDER BY NAME];
        rackLevels = [Select Name, Rack__c From Rack_Level__c ORDER BY NAME];
        racks = [Select Name, Inventory_Location__c, Inventory_Location__r.Name From Rack__c ORDER BY NAME];
        invLocations = [Select Id, Include_in_Inventory__c From Inventory_Location__c];
        sites = [SELECT Id FROM Site__c];
        
        Map<Id, List<Bin_Location__c>> binLocationsByRackLevelId = new Map<Id, List<Bin_Location__c>>();
        binLocationsByRackLevelId.put(rackLevels[0].Id,lstBin);
        
        Map<Id, List<Rack_Level__c>> rackLevelsByRackId = new Map<Id, List<Rack_Level__c>>();
        rackLevelsByRackId.put(racks[0].Id,rackLevels);
        
        Map<Id, List<Rack__c>> rackByLocationId = new Map<Id, List<Rack__c>>();
        rackByLocationId.put(invLocations[0].Id,racks);
        
        Map<Id, List<Inventory_Location__c>> rackBySiteId = new Map<Id, List<Inventory_Location__c>>();
        rackBySiteId.put(sites[0].Id,invLocations);
        
        Map<Id, Decimal> binConsumedCapacityById = new Map<Id,Decimal>();
        for(Bin_Location__c bin : lstBin){
            binConsumedCapacityById.put(bin.Id,bin.Bin_Volume_Capacity__c);    
        }
        
        String binStr = JSON.serialize(binConsumedCapacityById);
        String rackLevel = JSON.serialize(binLocationsByRackLevelId);
        String rack = JSON.serialize(rackLevelsByRackId);
        String loc = JSON.serialize(rackByLocationId);
        String site = JSON.serialize(rackBySiteId);
        
        InventoryDetails.inventoryDetails(objProduct1.ID,'Test');
        InventoryDetails.redirectToMiscIssue(str,objProduct1.ID);
        InventoryDetails.massTransferAction(str,objProduct1.ID);
        InventoryDetails.updateInventoryLocations(strPut,str,objProduct1.ID);
        InventoryDetails.mergeIPs(posIds,objProduct1.ID);
        InventoryDetails.loadBalanceQtyToPutAwayLight(invPositions[0].Id,strPut,binStr,lstBin[0].Id);
        InventoryDetails.loadBinLocationsLight(invPositions[0].Id,strPut,rackLevel,rackLevels[0].Id,binStr,lstBin[0].Id);
        InventoryDetails.loadRackLevelsLight(invPositions[0].Id,strPut,rack,rackLevel,racks[0].Id,binStr,lstBin[0].Id);
        InventoryDetails.loadIPLocationRec(invPositions[0].Id,strPut,invLocations[0].Id,loc,rack,rackLevel,binStr,lstBin[0].Id);
        InventoryDetails.loadIPSitesRec(invPositions[0].Id,strPut,sites[0].Id,site,loc,rack,rackLevel,binStr,lstBin[0].Id);
        
        product2 product = [select id,Name from Product2 limit 1];
        
        testObj.mergeIPs();
        testObj.holdUnHoldIps();
      
        System.assertNOTEquals(testObj,null);
        Test.stopTest();
    }
    static testMethod void inventoryDetailsTest2(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 2';
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
        
        System.assertNOTEquals(objProduct1,null);
        //invPositions[0].Product_Name__c =objProduct1.ID;
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id',objProduct1.ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objProduct1);
        InventoryDetails testObj = new InventoryDetails(sc);
        testObj.recordID =objProduct1.ID;
        testObj.redirectItemDetail();
        testObj.recordID ='';
        testObj.selectedRecordId=objProduct1.ID;
        testObj.refreshInventoryDetails();
        testObj.recordID =objProduct1.ID;
        testObj.selectedRecordId='';
        testObj.redirectToMiscReceipt();
        testObj.redirectToMiscIssue();
        testObj.cancelRedirect();
        
        
        // testObj.SaveRecord();
        List<Product2> prodList = new List<Product2>();
        List<Inventory_Position__c> invPositionList;
        List<InventoryPositionWrapper> invPositionWrappList = new List<InventoryPositionWrapper>();
        List<InventoryPositionWrapper> invPositionWrappList2 = new List<InventoryPositionWrapper>();
        List<InventoryPositionWrapper> invPositionWrappList3 = new List<InventoryPositionWrapper>();
        prodList =[Select ID,name,Producer_Name__c,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,MOQ__c,
                   (Select id,Name,Site__c,Product_Name__c,Inventory_Location__c,Rack__c,Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Rack_Level__c,
                    Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c 
                    from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true) from Product2  ];
        if(prodList.size()>0){
         
            invPositionList =prodList[0].Inventory_Positions__r;
            for(Inventory_Position__c invPosRec :invPositionList){
                InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
                InventoryPositionWrapper wrap2= new InventoryPositionWrapper(false,invPosRec);
                invPositionWrappList.add(wrap);
                wrap2.qtyToAdjust =5;
                invPositionWrappList2.add(wrap2);
                //invPositionWrappList3.add(wrap3);
            } 
        }
        Inventory_Perpetual_Adjustment__c invPerAdj = new Inventory_Perpetual_Adjustment__c();
        invPerAdj.Reason_for_Adjustments__c='Test adj';
        invPerAdj.Type__c='Miscellaneous Issue';
        
        testObj.invPositionWrappList =invPositionWrappList ;
        testObj.SaveRecord();
        testObj.invPositionWrappList =invPositionWrappList2 ;
        testObj.SaveRecord();
        InventoryDetails.createInventoryPerpetualAdjustment(invPositionWrappList,invPerAdj);
        System.assertNOTEquals(testObj,null);
        
        InventoryDetails.fetchFilterProducts('',JSON.serialize(invPositionWrappList),'');
    }
    
    static testMethod void inventoryDetailsTest3(){
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 3';
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
        
        
        System.assertNOTEquals(objProduct1,null);
        //invPositions[0].Product_Name__c =objProduct1.ID;
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id',objProduct1.ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objProduct1);
        InventoryDetails testObj = new InventoryDetails(sc);
        testObj.recordID ='';
        testObj.redirectItemDetail();
        testObj.refreshInventoryDetails();
        System.assertNOTEquals(testObj,null);
    }
    
    static testMethod void inventoryDetailsTest4(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 4';
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
        
        System.assertNOTEquals(objProduct1,null);
        //invPositions[0].Product_Name__c =objProduct1.ID;
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id',objProduct1.ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objProduct1);
        test.startTest();
        InventoryDetails testObj = new InventoryDetails(sc);
        testObj.recordID =objProduct1.ID;
        testObj.redirectItemDetail();
        testObj.recordID ='';
        testObj.selectedRecordId=objProduct1.ID;
        testObj.refreshInventoryDetails();
        testObj.recordID =objProduct1.ID;
        testObj.selectedRecordId='';
        testObj.redirectToMiscReceipt();
        testObj.redirectToMiscIssue();
        testObj.cancelRedirect();
        
        
        // testObj.SaveRecord();
        List<Product2> prodList = new List<Product2>();
        List<Inventory_Position__c> invPositionList;
        List<InventoryPositionWrapper> invPositionWrappList = new List<InventoryPositionWrapper>();
        List<InventoryPositionWrapper> invPositionWrappList2 = new List<InventoryPositionWrapper>();
        List<InventoryPositionWrapper> invPositionWrappList3 = new List<InventoryPositionWrapper>();
        List<Brand_Quote__c> bq= [select id from Brand_Quote__c];
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq[0].id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        insert objbqline1 ;
        List<Sales_Order__c> objSO= [select id from Sales_Order__c];
        
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO[0].id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Status__c = 'Allocated';
        
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        insert objSOline1;
        
        prodList =[Select ID,name,Producer_Name__c,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,MOQ__c,
                   (Select id,Name,Site__c,Product_Name__c,Inventory_Location__c,Rack__c,Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Rack_Level__c,Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c from Inventory_Positions__r ) from Product2  ];
        if(prodList.size()>0){
            //prod=prodList[0];
            invPositionList =prodList[0].Inventory_Positions__r;
            for(Inventory_Position__c invPosRec :invPositionList){
                invPosRec.Qty_On_Hand__c =0;
                invPosRec.Sales_Order_Line__c =objSOline1.ID;
                
                InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
                
                invPositionWrappList.add(wrap);
            } 
        }
        Inventory_Perpetual_Adjustment__c invPerAdj = new Inventory_Perpetual_Adjustment__c();
        invPerAdj.Reason_for_Adjustments__c='Test adj';
        invPerAdj.Type__c='Miscellaneous Issue';
        
        testObj.invPositionWrappList =invPositionWrappList ;
        testObj.SaveRecord();
        test.stopTest();
        for(Inventory_Position__c invPosRec :invPositionList){
            invPosRec.Qty_On_Hand__c =10;
            invPosRec.Sales_Order_Line__c =objSOline1.ID;
            
            InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
            
            invPositionWrappList.add(wrap);
            wrap.qtyToAdjust =5;
            wrap.isSelected = true;
        }
        testObj.invPositionWrappList =invPositionWrappList ;
        testObj.redirectToMiscIssue();
        testObj.SaveRecord();
        
        System.assertNOTEquals(testObj,null);
    }
    
    // Test validation 1
    // At least one inventory should be selected to transfer
    static testMethod void testInventoryMassTransferValidation1(){
        
        retrieveData(true);
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Inventory_Selected_To_Transfer), 'Validation message mis-match');
    }
    
    // Test validation 2
    // Qty to transfer must be positive value
    static testMethod void testInventoryMassTransferValidation2(){
        
        retrieveData(true);
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = -5; // negative value
        test.stopTest();
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage = String.format(Label.Qty_To_Put_Away_Positive_Value, 
                                            new List<String>{testObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage), 'Validation message mis-match');
    }
    
    // Test validation 3
    // Qty to transfer cannot be greater than qty on hand
    static testMethod void testInventoryMassTransferValidation3(){
        
        retrieveData(true);
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 100; // greater than qty on hand
        
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        test.stopTest();
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage = String.format(Label.Qty_To_Put_Away_Cannot_Be_Greater_Than_Qty_On_Hand, 
                                            new List<String>{testObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage), 'Validation message mis-match');
    }
    
    // Test validation 4
    // Rack, Rack Level, Bin Location cannot be null
    static testMethod void testInventoryMassTransferValidation4(){
        
        retrieveData(true);
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 5; // no rack selected
        test.stopTest();
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage = String.format(Label.Rack_Rack_Level_Bin_Location_Cannot_Be_Null, 
                                            new List<String>{testObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage), 'Validation message mis-match');
    }
    
    // Test validation 5
    // Qty to put away is greater than balance qty to put away
    static testMethod void testInventoryMassTransferValidation5(){
        
        retrieveData(true);
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        test.startTest();
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 5; 
        testObj.inventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        
        System.assertEquals(5, testObj.inventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin location and qty to put away
        testObj.selectedInvPositionId = testObj.inventoryPositions[0].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        test.stopTest();
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage = String.format(Label.Bin_Location_Capacity_Validation, 
                                            new List<String>{binLocations[0].Name,
                                                String.valueOf(testObj.inventoryPositions[0].qtyToPutAway),
                                                testObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage), 'Validation message mis-match');
    }
    
    // Test validation 6
    // Total specified qty to put away vs available capacity of selected bin location
    /*static testMethod void testInventoryMassTransferValidation6(){
        
        retrieveData(true);
        
        // Create another inventory position for first product record
        Inventory_Position__c cloneInvPositionSO = invPositions[0].clone(false, true);
        insert cloneInvPositionSO;
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(2, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.invPositionWrappList[1].isSelected = true;
        testObj.massTransferAction();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(2, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 4; 
        testObj.inventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        
        System.assertEquals(5, testObj.inventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin location and qty to put away
        testObj.selectedInvPositionId = testObj.inventoryPositions[0].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        test.stopTest();
        // select second inventory position
        testObj.inventoryPositions[1].qtyToPutAway = 2; 
        testObj.inventoryPositions[1].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for second inventory position
        System.assertEquals(5, testObj.inventoryPositions[1].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin location and qty to put away
        testObj.selectedInvPositionId = testObj.inventoryPositions[1].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[1].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[1].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[1].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assert(msgList[0].getDetail().contains('exceeds available capacity'), 'Validation message mis-match');
    }*/
    
    // Update inventory position with new rack/rack level/bin location - Total qty on hand  put away
    /*static testMethod void testUpdateInventoryPositionWithTotalQtyOnHand(){
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
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
        objProduct1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get('Product').getRecordTypeId();
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Cannabis_Weight__c = 10.0;
        insert objProduct1;
        
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c = true;
        insert receivingInventoryLocation;
        
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = receivingInventoryLocation.Id;
        insert rackSO;
        
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = racks[0].Id;
        insert rackLevelSO;
        
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevels[0].Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        insert binLocationSO;
        
        invPositions = [Select Rack__c, Rack_Level__c, Bin_Location__c, Qty_On_Hand__c,Site__c,Inventory_Location__c,
                        Product_Name__c, Inventory_Location__r.Name From Inventory_Position__c];
        
        for(Inventory_Position__c invPositionSO : invPositions){
            invPositionSO.Inventory_Location__c = invLocations[1].Id;
            invPositionSO.Qty_On_Hand__c = 4.0;
        }
        update invPositions;
        
        // verify existing values of first inventory position
        System.assertEquals(4, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);

        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        test.startTest();
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        System.assertEquals(true, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(false, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 4; 
        
        // Specify rack, rack level and bin location for first inventory position
        testObj.inventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        testObj.selectedInvPositionId = testObj.inventoryPositions[0].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        test.stopTest();
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals('/apex/InventoryDetails?id='+products[0].Id, pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Retrieve updated inventory positions
        retrieveData(false);
        System.assertEquals(racks[0].Id, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(rackLevels[0].Id, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(binLocations[0].Id, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals('Test Location', invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
    }*/
    
    // Update inventory position with new rack/rack level/bin location - Partial qty on hand  put away
    /*static testMethod void testUpdateInventoryPositionWithPartialQtyOnHand(){
        
        retrieveData(true);
        
        // verify existing values of first inventory position
        System.assertEquals(5, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        System.assertEquals(true, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(false, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 3; 
        
        // Specify rack, rack level and bin location for first inventory position
        testObj.inventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        testObj.selectedInvPositionId = testObj.inventoryPositions[0].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
		test.stopTest();        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals('/apex/InventoryDetails?id='+products[0].Id, pageRef.getURL(), 'Page reference mis-match');
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Retrieve updated inventory positions
        retrieveData(false);
        
        // verify existing inventory position - update qty on hand
        System.assertEquals(2, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals('Test Location', invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        // verify cloned inventory position
        System.assertEquals(3, invPositions[3].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(racks[0].Id, invPositions[3].Rack__c, 'Rack mis-match');
        System.assertEquals(rackLevels[0].Id, invPositions[3].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(binLocations[0].Id, invPositions[3].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals('Test Location', invPositions[3].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
    }*/
    
    // Bypass validation of total specified qty to put away vs available capacity of selected bin location
    // If Ignore Storage limit is true for selected bin location
    static testMethod void testInventoryPoistions_BypassAvailableCapacityValidationForIgnoreStorageLimit(){
        
        retrieveData(true);
        
        // Update Ignore storage limit as true for bin location
        binLocations[0].Ignore_Storage_Limit__c = true;
        update binLocations[0];
        
        // verify existing values of first inventory position
        System.assertEquals(5, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        PageReference pageRef = Page.InventoryDetails;
        pageRef.getParameters().put('Id', products[0].ID);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(products[0]);
        test.startTest();
        // Test available inventory positions for selected product
        InventoryDetails testObj = new InventoryDetails(sc);
        System.assertEquals(1, testObj.invPositionWrappList.size(), 'Inventory position size mis-match');
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Select available inventory to transfer
        testObj.invPositionWrappList[0].isSelected = true;
        testObj.massTransferAction();
        
        System.assertEquals(true, testObj.showMassTransferBlock,  'Mass transfer block flag should be false');
        System.assertEquals(false, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals(1, testObj.inventoryPositions.size(), 'Inventory position to transfer size mis-match');
        
        // Select inventory position and provide qty to put away values
        testObj.inventoryPositions[0].qtyToPutAway = 5; 
        
        // Specify rack, rack level and bin location for first inventory position
        System.assertEquals(5, testObj.inventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        // Specify rack, rack level and bin location for first inventory position
        testObj.inventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        testObj.selectedInvPositionId = testObj.inventoryPositions[0].invPositionSO.Id;
        testObj.selectedRackId = racks[0].Id;
        
        testObj.loadRackLevels();
        
        testObj.inventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        testObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        testObj.loadBinLocations();
        testObj.selectedBinLocationId = binLocations[0].Id;
        testObj.inventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, testObj.inventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, testObj.inventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        pageRef = testObj.updateInventoryLocations();
        System.assertEquals('/apex/InventoryDetails?id='+products[0].Id, pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assertEquals(false, testObj.showMassTransferBlock, 'Mass transfer block flag should be false');
        System.assertEquals(true, testObj.invPosSectionRender, ' Available Inventory block flag should be true');
        
        // Retrieve updated inventory positions
        retrieveData(false);
        
        // verify existing inventory position - update qty on hand
        System.assertEquals(racks[0].Id, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(rackLevels[0].Id, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(binLocations[0].Id, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(5, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals('Test Location', invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        test.stopTest();
    }
    static testMethod void dymolabelTest(){
        retrieveData();
        PageReference pageRef = Page.InventoryDetails;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController stdController = new ApexPages.StandardController(products[0]);
        InventoryDetails controllerObj = new InventoryDetails(stdController);
        controllerObj.redirectItemDetail();
        controllerObj.getDymoLabelLayouts();
        
        
        List<InventoryPositionWrapper> lstInv = new List<InventoryPositionWrapper>();
        invPositions = [Select Inventory_Location__c,Supplier_Name__c,License_Premise__c,Rack_Level__r.Name,
                        Supplier_License_Number__c,Product_Name__r.Name,Product_Description__c,Rack__r.Name,
                        Purchase_Order__c,Date_Received__c,Harvest_Batch_Code__r.Name,Stocking_UOM__c,Bin_Location__r.Name ,
                        UID_New__r.Name,Ownership__r.Name,Qty_Allocated__c,Quantity_Type__c, Inventory_Position__c.Lab_Test_Status__c,
                        Rack__c, Rack_Level__c, Bin_Location__c,Qty_On_Hand__c,Site__r.Name,Inventory_Location__r.Name From Inventory_Position__c];
        for(Inventory_Position__c inv : invPositions){
            lstInv.add(new InventoryPositionWrapper(true,inv));    
        }
        lstInv.add(new InventoryPositionWrapper(false,invPositions[0]));
        String str = JSON.serialize(lstInv);
        InventoryDetails.generateImageXml(products[0].Id,str,InventoryDetails.TWOBYFOUR,'test',true);
        InventoryDetails.generateImageXml(products[0].Id,str,InventoryDetails.FOURBYSIX,'test',true);
        System.assertNotEquals(products[0].Id, str);
        IPPrintLabels.getImage4X6Xml(invPositions[0]); 
        IPPrintLabels.getImage2X4Xml(invPositions[0]);
        IPPrintLabels.getImage1X3Xml(invPositions[0]);
        IPPrintLabels.getImage2X4XmlQR(invPositions[0]);

    }
    
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        products = [Select Id from Product2];
        
        products[0].Cannabis_Weight__c = 10.0;
        update products[0];
        
        invLocations = [Select Id, Include_in_Inventory__c From Inventory_Location__c];
        for(Inventory_Location__c invLocationSO : invLocations){
            invLocationSO.Include_in_Inventory__c = true;
        }
        update invLocations;
    }
    static void createTestData(){
        // Create Accounts
        
        // supplier Account
        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount3);
        
        insert accounts;
        
        // Create Contacts
        // supplier contact
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.LastName = 'Test Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.LastName = 'Test Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts;
        
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='test1';
        insert objSite;
        
        // Create State License
        
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_State__c = 'California';
        objStateLicenses2.License_City__c = 'San Francisco';
        objStateLicenses2.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses2.License_Zip__c = '94124';
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_State__c = 'California';
        objStateLicenses3.License_City__c = 'San Francisco';
        objStateLicenses3.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses3.License_Zip__c = '94124';
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        
        
        
        // Receiving Inspection inventory location
        List<Inventory_Location__c> inventoryLocations = new List<Inventory_Location__c>();
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        inventoryLocations.add(receivingInventoryLocation);
        
        // New Test inventory location
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = objSite.id;
        inventoryLocations.add(newInventoryLocation);
        
        insert inventoryLocations;
        
        // Create opportunity
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c = 'COD';
        insert opp;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
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
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        products.add(objProduct3);
        
        insert products;
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        // Create Opportunity line item
        OpportunityLineItem opLineItem=new OpportunityLineItem ();
        opLineItem.Quantity=1;
        opLineItem.OpportunityId =opp.id;
        opLineItem.TotalPrice =100;
        opLineItem.PricebookEntryId = pbe.id;
        insert opLineItem;
        
        // Create brand quote
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Supplier_Name__c = objAccount.id;
        bq.Receiver_Name__c = objAccount3.id;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        insert bq;
        
        // Create brand quote lines
        List<Brand_Quote_Line__c> brandQuoteLines = new List<Brand_Quote_Line__c>();
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        brandQuoteLines.add(objbqline1);
        
        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c= objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;
        brandQuoteLines.add(objbqline2);
        
        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c= objProduct3.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;
        brandQuoteLines.add(objbqline3);
        
        insert brandQuoteLines;
        
        // Create purchase order
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objPO.recordTypeId = recordTypeId;
        objPO.Site__c = bq.Site__c;
        objpO.PO_Status__c = 'Draft';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = bq.Supplier_License__c;
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = bq.Receiver_License__c;
        objPO.Ownership__c = bq.Ownership__c;
        insert objPO;
        
        // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Product_Name__c= objbqline1.Product_Name__c;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c= objbqline2.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c= objbqline3.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
        
        list<Purchase_Order_Line__c> purchaseOrderLines = new list<Purchase_Order_Line__c>();
        purchaseOrderLines.add(objPOline1);
        purchaseOrderLines.add(objPOline2);
        purchaseOrderLines.add(objPOline3);
        insert purchaseOrderLines;
        
        // Create Receiving
        Receiving__c objReceiving = new Receiving__c(Purchase_Order__c= objPO.id, Site__c= objPO.Site__c, Ownership__c = objPO.Ownership__c );
        insert objReceiving;
        
        // Create 3 receiving lines which will create inventory positions automatically
        List<Receiving_Line__c> receivingLines = new List<Receiving_Line__c>();
        for(Integer i=0; i<purchaseOrderLines.size(); i++){
            Receiving_Line__c objReceivingLine = new Receiving_Line__c();
            objReceivingLine.Inventory_Location__c = receivingInventoryLocation.Id;
            objReceivingLine.Product_Name__c = products[i].Id;
            objReceivingLine.Purchase_Order_Line__c = purchaseOrderLines[i].Id;
            objReceivingLine.Qty_to_Receive__c = 5.0;
            objReceivingLine.Receiving_ID__c = objReceiving.Id;
            objReceivingLine.Site__c = objSite.Id;
            objReceivingLine.UID__c = 'TEST' + i;
            objReceivingLine.Ownership__c = objAccount.Id;
            receivingLines.add(objReceivingLine);
        }
        insert receivingLines;
        
        // Create Racks
        List<Rack__c> racks = new List<Rack__c>();
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = newInventoryLocation.Id;
        racks.add(rackSO);
        insert racks;
        
        // Create Rack Levels
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = racks[0].Id;
        rackLevels.add(rackLevelSO);
        insert rackLevels;
        
        // Create Bin Locations
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevels[0].Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocations.add(binLocationSO);
        insert binLocations;
        
        Sales_Order__c objSO = new Sales_Order__c();
        objSO.Site__c = bq.Site__c;
        objSO.SO_Status__c = 'Draft';
        objSO.SO_Type__c = 'Sell Quote';
        objSO.Brand_Quote__c = bq.id;
        objSO.Supplier_Contact__c = objContact.Id;
        objSO.Supplier_Name__c = bq.Supplier_Name__c;
        objSO.Supplier_License__c = bq.Supplier_License__c;
        objSO.Distributor_Contact__c = objContact2.Id;
        objSO.Distributor_Name__c = bq.Distributor_Name__c;
        objSO.Distributor_License__c = bq.Distributor_License__c;
        objSO.Receiver_Name__c = bq.Receiver_Name__c;
        objSO.Receiver_Contact__c = objContact3.Id;
        objSO.Receiver_License__c = bq.Receiver_License__c;
        objSO.Payment_Terms__c = bq.Payment_Terms__c;
        objSO.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO.Shipping_Method__c = bq.Shipping_Method__c;
        objSO.Ownership__c = accounts[0].Id;
        objSO.Customer_PO_or_Quote__c = 'Test Quote';
        objSO.Opportunity_Name__c = opp.Id;
        
        insert objSO;    
        
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO.id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        
        Sales_Order_Line__c objSOline2 = new Sales_Order_Line__c();
        objSOline2.Sales_Order__c = objSO.id;
        objSOline2.Product_Name__c= objbqline2.Product_Name__c;
        objSOline2.Product_Title__c = 'Distributor';
        objSOline2.Qty_Ordered__c = 20;
        objSOline2.Qty_Invoiced__c = 15.0;
        objSOline2.Retail_Wholesale_Price__c = 20;
        
        Sales_Order_Line__c objSOline3 = new Sales_Order_Line__c();
        objSOline3.Sales_Order__c = objSO.id;
        objSOline3.Product_Name__c= objbqline3.Product_Name__c;
        objSOline3.Product_Title__c = 'Distributor';
        objSOline3.Qty_Ordered__c = 30;
        objSOline3.Qty_Invoiced__c = 25.0;
        objSOline3.Retail_Wholesale_Price__c = 30;
        
        list<Sales_Order_Line__c> lstSalesOrderLine = new list<Sales_Order_Line__c>();
        lstSalesOrderLine.add(objSOline1);
        lstSalesOrderLine.add(objSOline2);
        lstSalesOrderLine.add(objSOline3);
        
        insert lstSalesOrderLine;
        
        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = objSO.id;
        inv.AR_Status__c = 'Draft';
        insert inv;
        
        Invoice_Line__c invLine1 = new Invoice_Line__c();
        invline1.Invoice__c = inv.id;
        invLine1.Sales_Order_Line__c = lstSalesOrderLine[0].Id;
        invLine1.Invoice_Qty__c = 5.0;
        invLine1.Retail_Wholesale_Price__c = 100.0;
        invLine1.Excise_Tax_Amount__c = 10.0;
        invLine1.Product_Name__c = objProduct1.Id;
        
        Invoice_Line__c invLine2 = new Invoice_Line__c();
        invLine2.Invoice__c = inv.id;
        invLine2.Sales_Order_Line__c = lstSalesOrderLine[1].Id;
        invLine2.Invoice_Qty__c = 15.0;
        invLine2.Retail_Wholesale_Price__c = 100.0;
        invLine2.Excise_Tax_Amount__c = 15.0;
        invLine2.Product_Name__c = objProduct2.Id;
        
        Invoice_Line__c invLine3 = new Invoice_Line__c();
        invLine3.Invoice__c = inv.id;
        invLine3.Sales_Order_Line__c = lstSalesOrderLine[2].Id;
        invLine3.Invoice_Qty__c = 25.0;
        invLine3.Retail_Wholesale_Price__c = 100.0;
        invLine3.Excise_Tax_Amount__c = 20.0;
        invLine3.Product_Name__c = objProduct3.Id;
        
        list<Invoice_Line__c> ivoiceLines = new list<Invoice_Line__c>();
        ivoiceLines.add(invLine1);
        ivoiceLines.add(invLine2);
        ivoiceLines.add(invLine3);
        
        insert ivoiceLines;
    }
}