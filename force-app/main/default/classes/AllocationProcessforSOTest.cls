/**************************************************************************************

*******************************************************************************/
@isTest
public class AllocationProcessforSOTest {
    static Sales_Order__c objSO;
      static Sales_Order_Line__c objSO2;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
     private static String SO_RecordType;

    @TestSetUp
        static void testDataSetUp(){
            TestUtilData.skipTrigger = True;
        TestUtilData.createTestData();
            Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    }
  
    static testMethod void AllocationProcessforSOTest(){
        Test.startTest();
           TestUtilData.skipTrigger = True;
        retrieveData();
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        AllocationProcessforSO controllerObj = new AllocationProcessforSO(stdController);
        AllocationProcessforSO.AllocationProcess(objSO.Id);
        controllerObj.AllocationProcess();
       // controllerObj.AllocationProcessforSO();
        AuraResponse r = new AuraResponse('AllocationProcessforSO.AllocationProcessLight()');
       
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
      
        controllerObj.goBack();
        
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c]; 
        system.debug('lstSO 0 status'+lstSO[0].Status__c);
        system.debug('lstSO 1 status'+lstSO[1].Status__c);
        system.debug('lstSO 2 status'+lstSO[2].Status__c);
        
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[0].Qty_Allocated__c = 40;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[1].Qty_Allocated__c = 20;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_BACK_ORDERED;
        soLines[2].Qty_Allocated__c = 0;
       // soLines[2].Ownership_Code__c = 'Test 1'
        update soLines;
        
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
      Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
		il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
 
        Decimal totalQty = 0.0;
       	Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=0.2;
        totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        list <Inventory_Position__c> ivlst = new list <Inventory_Position__c>();
        ivlst.add(iv);
        
        
         AllocationProcessforSO.calTotalQtyinHand(ivlst);
		AllocationProcessforSO.checkValidation(objSO);
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
 		 AllocationProcessforSO.calTotalQtyAllocated(ivlst, objSO.Id); 
       
        decimal tempQtyOrderd=9;
        decimal balanceQty=9;
       
     AllocationProcessforSO.getIPsNeededtoUpdate(ivlst, tempQtyOrderd, balanceQty, null, ivlst);   
      
Test.stopTest();
    }
     static testMethod void inventoryDetailsTestopen(){
Test.startTest();
            TestUtilData.skipTrigger = True;
        retrieveData();
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        AllocationProcessforSO controllerObj = new AllocationProcessforSO(stdController);
        AllocationProcessforSO.AllocationProcess(objSO.Id);
        controllerObj.AllocationProcess();
        AuraResponse r = new AuraResponse('AllocationProcessforSO.AllocationProcessLight()');
       
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
        controllerObj.goBack();
       
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c]; 
        system.debug('lstSO 0 status'+lstSO[0].Status__c);
        system.debug('lstSO 1 status'+lstSO[1].Status__c);
        system.debug('lstSO 2 status'+lstSO[2].Status__c);
        
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[0].Qty_Allocated__c = 40;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[1].Qty_Allocated__c = 20;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[2].Qty_Allocated__c = 0;
        update soLines;
        
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
      Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
		il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
 
        Decimal totalQty = 0.0;
       	Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=0.2;
        totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        list <Inventory_Position__c> ivlst = new list <Inventory_Position__c>();
        ivlst.add(iv);
       
        
         AllocationProcessforSO.calTotalQtyinHand(ivlst);
		AllocationProcessforSO.checkValidation(objSO);
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
 		 AllocationProcessforSO.calTotalQtyAllocated(ivlst, objSO.Id); 
        decimal tempQtyOrderd=9;
        decimal balanceQty=9;
       
     AllocationProcessforSO.getIPsNeededtoUpdate(ivlst, tempQtyOrderd, balanceQty, null, ivlst);   
       Test.stopTest();

    }
    
     static testMethod void inventoryDetailsTestopen2(){
            TestUtilData.skipTrigger = True;
        retrieveData();
       
        Test.startTest();
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c]; 
        system.debug('lstSO 0 status'+lstSO[0].Status__c);
        system.debug('lstSO 1 status'+lstSO[1].Status__c);
        system.debug('lstSO 2 status'+lstSO[2].Status__c);
        
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[0].Qty_Allocated__c = 40;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[1].Qty_Allocated__c = 20;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_OPEN;
        soLines[2].Qty_Allocated__c = 0;
        update soLines;
        
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
      Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
		il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
 
        Decimal totalQty = 0.0;
       	Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=0.2;
        totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        list <Inventory_Position__c> ivlst = new list <Inventory_Position__c>();
        ivlst.add(iv);
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        AllocationProcessforSO controllerObj = new AllocationProcessforSO(stdController);
        AllocationProcessforSO.AllocationProcess(objSO.Id);
        controllerObj.AllocationProcess();
        controllerObj.goBack();
       Test.stopTest();

    }
    
    static testMethod void inventoryDetailsTest2(){
        Test.startTest();
           TestUtilData.skipTrigger = True;
       retrieveData();
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        AllocationProcessforSO controllerObj = new AllocationProcessforSO(stdController);
         AuraResponse r = new AuraResponse('AllocationProcessforSO.AllocationProcessLight()');
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
        controllerObj.AllocationProcess();
        controllerObj.goBack();
        
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c]; 
        system.debug('lstSO 0 status'+lstSO[0].Status__c);
        system.debug('lstSO 1 status'+lstSO[1].Status__c);
        system.debug('lstSO 2 status'+lstSO[2].Status__c);
        
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 90;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[0].Qty_Allocated__c = 90;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[1].Qty_Allocated__c = 20;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_BACK_ORDERED;
        soLines[2].Qty_Allocated__c = 0;
        //soLines[2].Balance_Qty_to_Allocate__c = 9;
        update soLines;
        
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
      Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
		il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
 
         Decimal totalQty = 0.0;
       Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=90;
         totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        list <Inventory_Position__c> ivlst = new list <Inventory_Position__c>();
        ivlst.add(iv);
        
        
        
        
         Id productId = soLines[2].Product_Name__c;
            // if(soli.Balance_Qty_to_Allocate__c == sumofQtyinHand){
         map<Id,List<Inventory_Position__c>> mapofIPsbyProducId = new map<Id,List<Inventory_Position__c>> ();
         Map<Id,Decimal> availableForAllocation = new Map<Id,Decimal>();
          Decimal sumofQtyinHand = availableForAllocation.get(productId); 

         AllocationProcessforSO.calTotalQtyinHand(ivlst);
		AllocationProcessforSO.checkValidation(objSO);
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
        AllocationProcessforSO.checkValidationLight(objSO);
  		AllocationProcessforSO.calTotalQtyAllocated(ivlst, objSO.Id); 
        decimal tempQtyOrderd=9;
        decimal balanceQty=90;
      
       
         Map<Id,Sales_Order_Line__c> tempSOlinesMap = new Map<Id,Sales_Order_Line__c>();
         Id productId2 = soLines[0].Product_Name__c;
          map<ID,Sales_Order_Line__c> mapofSOlinebyProductID = new map<ID,Sales_Order_Line__c>();
			//set<Id> keyId= mapofSOlinebyProductID.Keyset();
                    Sales_Order_Line__c soli = mapofSOlinebyProductID.get(productId);
                     tempSOlinesMap.put(soLines[0].id,new Sales_Order_Line__c(id = soLines[0].id, 
                                                                              Status__c = 'Back Ordered', 
                                                                              Qty_Allocated__c = 0));
                update tempSOlinesMap.values();
     AllocationProcessforSO.getIPsNeededtoUpdate(ivlst, tempQtyOrderd, balanceQty, null, ivlst);   
          Decimal totalQtyAllocated =  AllocationProcessforSO.calTotalQtyAllocated(ivlst, objSO.Id); 
        Test.stopTest();

    }
    // Test allocation process for confirmed picklist
    static testMethod void testAllocationProcess_ForConfirmedPicklist(){
           TestUtilData.skipTrigger = True;
        // Get data created from setup
        retrieveData();
        
        // Create confirmed Picklist
        Picklist__c picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = objSO.Id;
        picklistObj.Site__c = objSO.Site__c;
        picklistObj.Status__c = 'Confirmed';
        insert picklistObj;
        
        List<Account> lstAcc = [SELECT Id,Hold__c from Account LIMIT 10];
        for(Account acc : lstAcc){
        	acc.Hold__c = true;  
        }
        update lstAcc;
        
        List<Sales_Order__c> sOrder = [SELECT Id,Account_Hold_Exception__c from Sales_Order__c LIMIT 10];
        for(Sales_Order__c so : sOrder){
        	so.Account_Hold_Exception__c = false;
            //so.Allocated__c = true;
        }
        update sOrder;
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        List<Inventory_Location__c> inventoryLocations1 = new List<Inventory_Location__c>();
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        inventoryLocations1.add(receivingInventoryLocation);
        
        // New Test inventory location
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = objSite.id;
        inventoryLocations1.add(newInventoryLocation);

        insert inventoryLocations1;
        
        //System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        
        // One SO line is related with two inventory position 
        // last SO line is not related with any inventory position
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[0].Qty_Allocated__c = 40;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[1].Qty_Allocated__c = 20;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_BACK_ORDERED;
        soLines[2].Qty_Allocated__c = 0;
        update soLines;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        AllocationProcessforSO controllerObj = new AllocationProcessforSO(stdController);
        PageReference pageRef = controllerObj.AllocationProcess();
         AuraResponse r = new AuraResponse('AllocationProcessforSO.AllocationProcessLight()');
        AllocationProcessforSO.AllocationProcessLight(objSO.Id);
        System.assertEquals(null, pageRef, 'Page reference mis-match');
      //  AllocationProcessforSO.AllocationProcess(soid)
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        //System.assert(msgList[0].getDetail().contains(Label.No_Allocation_For_Cancelled_SO), 'Validation message mis-match');
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        // TestUtilData.createTestData();
        objSO = new Sales_Order__c();
        objSO = [Select Id, SO_Status__c, Site__c from Sales_Order__c];
       // objSO.Site__c =
        system.debug('objSO'+objSO);
        
        List<Inventory_Location__c> inventoryLocations = [select Available_for_Allocation__c, Default_for_Site__c from Inventory_Location__c];
        
        for(Inventory_Location__c invLocationObj : inventoryLocations){
            invLocationObj.Default_for_Site__c =false;
            invLocationObj.Available_for_Allocation__c = true;
           invLocationObj.Available_for_Lab_Allocation__c = true;
            
        }
        update inventoryLocations;
        
        List<Inventory_Position__c> inventorypossitions = [select id, Qty_On_Hand__c from Inventory_Position__c];
        inventorypossitions[1].Qty_On_Hand__c = 90;
        inventorypossitions[2].Qty_On_Hand__c = 90;
        
        update inventorypossitions;
        
        
        invPositions = [Select Qty_On_Hand__c,
                               Qty_Allocated__c,
                               Sales_Order_Line__c
                               From Inventory_Position__c];
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Status__c,Product_Name__c, Qty_Allocated__c From Sales_Order_Line__c];
     
       
    }

}