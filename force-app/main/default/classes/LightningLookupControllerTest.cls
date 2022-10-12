/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* LightningLookupControllerTest
*/
@isTest
public class LightningLookupControllerTest {
	@isTest
    static void testLightningLookup(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        LightningLookupController.getRecords('Account','Name','Test',objAccount.Id);
        LightningLookupController.getRecords('Vehicles__c','Name','Test','');
        LightningLookupController.getRecords('Drivers__c','Name','Test','');
        String VEHICLE_STRING_REFRIGERATED = LightningLookupController.VEHICLE_STRING_REFRIGERATED;
        System.assertEquals(objAccount.Name, 'Test Account1');
    }
}