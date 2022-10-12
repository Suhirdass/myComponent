/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMTSMDriverDetailsControllerTest
 */

@isTest(OnInstall=false SeeAllData=false)
public class RSMTSMDriverDetailsControllerTest {
    
     
   static List<Shipping_Manifest__c> lstrsm;
   static List<Shipping_Manifest__c > lsttsm;
    
   static testMethod void testDriverNotFound(){
          
      RSMTSMDriverDetailsController controllerObj = new RSMTSMDriverDetailsController();
      
       
   }
   
    static testMethod void testretreiveTSMRSMMnullDate(){
        
        Drivers__c objDrive=[select id, Name, Expiration_Date__c from Drivers__c limit 1];
        objDrive.Name =  UserInfo.getName();
        update objDrive;
        
        RSMTSMDriverDetailsController controllerObj = new RSMTSMDriverDetailsController();
        controllerObj.dat = null;
        controllerObj.retreiveTSMRSM();
   } 
    
    
    static testMethod void testUpdateRSMTSM(){
        
        Drivers__c objDrive=[select id, Name, Expiration_Date__c from Drivers__c limit 1];
        objDrive.Name =  UserInfo.getName();
        update objDrive;
        
        RSMTSMDriverDetailsController controllerObj = new RSMTSMDriverDetailsController();
        controllerObj.pageSizeTSM = '2';
        controllerObj.pageSizeRSM = '2';
    
        controllerObj.getPageSizeOptionsTSM();
        controllerObj.getPageSizeOptionsRSM(); 
        
        controllerObj.retreiveTSMRSM();
        
        controllerObj.updateRSMTSM();
        
        controllerObj.setTSM[0].isSelectedTSM = true;
        controllerObj.setRSM[0].isSelectedRSM = true;
        
        controllerObj.updateRSMTSM();
        
        // next action of pagination
        controllerObj.nextTSM();
       
       // previous action of pagination
        controllerObj.previousTSM();
       
        // last action of pagination
        controllerObj.lastTSM();
       
        // first action of pagination
        controllerObj.firstTSM();
       
         // reset page size
        controllerObj.pageSizeTSM = '2';
        controllerObj.doResetTSMPageSize();
       
       
        // next action of pagination
        controllerObj.nextRSM();
       
       
       // previous action of pagination
        controllerObj.previousRSM();
       
       
         // last action of pagination
        controllerObj.lastRSM();
       
       
        // first action of pagination
        controllerObj.firstRSM();
       
        PageReference pageRef = controllerObj.doResetRSMPageSize();
       
       
       
       
       // reset page size
        controllerObj.pageSizeRSM = '10';
        controllerObj.doResetTSMPageSize();
   }
    
    static testMethod void testDriverLicenseExpiredErrorMsg(){
        
        Drivers__c objDrive=[select id, Name, Expiration_Date__c from Drivers__c limit 1];
        objDrive.Name =  UserInfo.getName();
        objDrive.Expiration_Date__c = objDrive.Expiration_Date__c.addDays(-365);
        update objDrive;
        
        RSMTSMDriverDetailsController controllerObj = new RSMTSMDriverDetailsController();
  
       
   }
    
     @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
        
        Sales_Order__c objSO =[select id,Site__c, Planned_Ship_Date__c from Sales_Order__c limit 1];
        system.debug('objSO.Planned_Ship_Date__c1'+objSO.Planned_Ship_Date__c);
        objSO.Planned_Ship_Date__c = date.today();
        
        update objSO;
        
        Drivers__c objDriver =TestUtilData.createDriver(true);
        
        system.debug('objSO.Planned_Ship_Date__c2'+objSO.Planned_Ship_Date__c);
        
        
        Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
        
        list<Shipping_Manifest__c> lstRSM = new list<Shipping_Manifest__c>();
        
        Shipping_Manifest__c objRSM1 = TestUtilData.createRSM(objPicklist, false);
        objRSM1.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM1.Driver__c = objDriver.id;
        objRSM1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM1);
        
        Shipping_Manifest__c objRSM2 = TestUtilData.createRSM(objPicklist, false);
        objRSM2.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM2.Driver__c = objDriver.id;
        objRSM2.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM2);
        
        Shipping_Manifest__c objRSM3 = TestUtilData.createRSM(objPicklist, false);
        objRSM3.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM3.Driver__c = objDriver.id;
        objRSM3.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM3);
        
        insert lstRSM;
        
        Purchase_Order__c objPO = [Select id, Brand_Quote__c, Opportunity_Name__c, Site__c, Ownership__c, 
                                   Distributor_Name__c, Distributor_Contact__c, Supplier_Name__c, Supplier_Contact__c,
                                   Receiver_Name__c, Receiver_Contact__c from Purchase_Order__c limit 1];
       
        Vehicles__c objVehicle=TestUtilData.createVehicle(true);
        
        
        list<Shipping_Manifest__c> lstTSM = new list<Shipping_Manifest__c>();
        
        
        Shipping_Manifest__c objTSM1 = createTSM(objPO, objDriver.id, objVehicle.id);
        objTSM1.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        lstTSM.add(objTSM1);
        
        Shipping_Manifest__c objTSM2 = createTSM(objPO, objDriver.id, objVehicle.id);
        objTSM2.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        lstTSM.add(objTSM2);        
        
        Shipping_Manifest__c objTSM3 = createTSM(objPO, objDriver.id, objVehicle.id);
        objTSM3.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        lstTSM.add(objTSM3);
        
        insert lstTSM;
        
    }
    
    public static Shipping_Manifest__c createTSM(Purchase_Order__c objPO, id driverID, id vehicleId){
        
        
        Shipping_Manifest__c objTSM = new Shipping_Manifest__c();
        objTSM.Purchase_Order__c = objPO.id;
        objTSM.Brand_Quote__c = objPO.Brand_Quote__c;
        objTSM.Opportunity_Name__c = objPO.Opportunity_Name__c;
        objTSM.Site__c = objPO.Site__c;
        objTSM.Ownership__c = objPO.Ownership__c;
        objTSM.Distributor_Name__c = objPO.Distributor_Name__c;
        objTSM.Distributor_Contact__c = objPO.Distributor_Contact__c;
        objTSM.Supplier_Name__c = objPO.Supplier_Name__c;
        objTSM.Supplier_Contact__c = objPO.Supplier_Contact__c;
        objTSM.Receiver_Name__c = objPO.Receiver_Name__c;
        objTSM.Receiver_Contact__c = objPO.Receiver_Contact__c;
        objTSM.Planned_Ship_Transfer_Date__c = date.today();
        objTSM.Shipping_Method__c = 'Distributor Pick-up';
        objTSM.Shipping_Terms__c ='CIP';
        objTSM.Payment_Terms__c ='COD';
        objTSM.Driver__c = driverID;
        objTSM.Vehicle__c = vehicleId;
 
        return objTSM;
        
    }
        
     
}