/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMTSMMultiSelectComponentControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
private class RSMTSMMultiSelectComponentControllerTest {
    
    static Sales_Order__c salesOrderObj;
    static Picklist__c picklistObj;
    
    // Test move date from available list to selected list and vice versa
    static testMethod void testTransferDataBetweenAvailableAndSelectedPicklist() {
      
        // Get data created from setup
        retrieveData();
        
        // Create RSM data
        List<Shipping_Manifest__c> rsmList = new List<Shipping_Manifest__c>();
        Shipping_Manifest__c rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        Shipping_Manifest__c rsmObj1 = TestUtilData.createRSM(pickListObj, false);
        rsmObj1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        rsmList.add(rsmObj);
        rsmList.add(rsmObj1);
        insert rsmList;
        
        rsmList = [Select Name, Planned_Ship_Transfer_Date__c, Receiver_License__r.License_City__c From Shipping_Manifest__c Where RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        
        // Create TSM data
        List<Shipping_Manifest__c> tsmList = new List<Shipping_Manifest__c>();
        Shipping_Manifest__c tsmObj = TestUtilData.createTSM(salesOrderObj, false);
        tsmObj.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        Shipping_Manifest__c tsmObj1 = TestUtilData.createTSM(salesOrderObj, false);
        tsmObj1.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        tsmList.add(tsmObj);
        tsmList.add(tsmObj1);
        insert tsmList;
        
        tsmList = [Select Name, Planned_Ship_Transfer_Date__c, Receiver_License__r.License_City__c From Shipping_Manifest__c Where RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        
        RSMTSMMultiSelectComponentController controllerObj = new RSMTSMMultiSelectComponentController();
        controllerObj.initialList = new List<RSMTSMWrapper>();
        controllerObj.selectedList = new List<RSMTSMWrapper>();
        
        // Load RSMs
        for(Integer i=0; i<rsmList.size(); i++){
            RSMTSMWrapper rsmtsmObj = new RSMTSMWrapper();
            rsmtsmObj.Id = rsmList[i].Id;
            rsmtsmObj.Name = rsmList[i].Name;
            rsmtsmObj.deliveryCity = rsmList[i].Receiver_License__r.License_City__c;
            rsmtsmObj.plannedShipTransferDate = rsmList[i].Planned_Ship_Transfer_Date__c;
            controllerObj.initialList.add(rsmtsmObj);
        }
        
        // Load TSMs
        for(Integer i=0; i<tsmList.size(); i++){
            RSMTSMWrapper rsmtsmObj = new RSMTSMWrapper();
            rsmtsmObj.Id = tsmList[i].Id;
            rsmtsmObj.Name = tsmList[i].Name;
            rsmtsmObj.deliveryCity = tsmList[i].Receiver_License__r.License_City__c;
            rsmtsmObj.plannedShipTransferDate = tsmList[i].Planned_Ship_Transfer_Date__c;
            controllerObj.initialList.add(rsmtsmObj);
        }
        
        List<SelectOption> availableOptions  = controllerObj.getAvailableOptionList();
        List<SelectOption> selectedOptions  = controllerObj.getSelectedOptionList();
        System.assertEquals(4, availableOptions.size(), 'Available option size mis-match');
        System.assertEquals(0, selectedOptions.size(), 'Selected option size mis-match');
        
        // Select record to be moved from available to selected picklist
        controllerObj.availableRSMTSMOptions.add(rsmList[1].Id);
        controllerObj.availableRSMTSMOptions.add(tsmList[0].Id);
        controllerObj.clickRight();
        
        // Verify selected and available picklist size
        availableOptions  = controllerObj.getAvailableOptionList();
        selectedOptions  = controllerObj.getSelectedOptionList();
        System.assertEquals(2, availableOptions.size(), 'Available option size mis-match');
        System.assertEquals(2, selectedOptions.size(), 'Selected option size mis-match');
        
        // Select record to be moved from selected to available picklist
        controllerObj.selectedRSMTSMOptions.add(rsmList[1].Id);
        controllerObj.clickLeft();
        
        // Verify selected and available picklist size
        availableOptions  = controllerObj.getAvailableOptionList();
        selectedOptions  = controllerObj.getSelectedOptionList();
        System.assertEquals(3, availableOptions.size(), 'Available option size mis-match');
        System.assertEquals(1, selectedOptions.size(), 'Selected option size mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                                Brand_Quote__c, 
                                Distributor_Contact__c, 
                                Distributor_License__c,
                                Distributor_Name__c,
                                Opportunity_Name__c,
                                Payment_Terms__c,
                                Planned_Ship_Date__c,
                                Receiver_Contact__c,
                                Receiver_License__c,
                                Receiver_Name__c,
                                Sample_Order__c,
                                Shipping_Method__c,
                                Shipping_Terms__c,
                                Supplier_Contact__c,
                                Supplier_License__c,
                                Supplier_Name__c
                        from Sales_Order__c];
        
        // Update planned ship date of SO
        salesOrderObj.Planned_Ship_Date__c = System.Today();
        update salesOrderObj;
        
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListObj = [Select Site__c,
                              Sales_Order__r.Brand_Quote__c, 
                              Sales_Order__r.Customer_PO_or_Quote__c,
                              Sales_Order__r.Distributor_Contact__c, 
                              Sales_Order__r.Distributor_License__c,
                              Sales_Order__r.Distributor_Name__c,
                              Sales_Order__r.Opportunity_Name__c,
                              Sales_Order__r.Payment_Terms__c,
                              Sales_Order__r.Planned_Ship_Date__c,
                              Sales_Order__r.Receiver_Contact__c,
                              Sales_Order__r.Receiver_License__c,
                              Sales_Order__r.Receiver_Name__c,
                              Sales_Order__r.Sample_Order__c,
                              Sales_Order__r.Shipping_Method__c,
                              Sales_Order__r.Shipping_Terms__c,
                              Sales_Order__r.Supplier_Contact__c,
                              Sales_Order__r.Supplier_License__c,
                              Sales_Order__r.Supplier_Name__c
                       from Picklist__c];
    }
}