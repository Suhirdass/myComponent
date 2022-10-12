/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CloneBQControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CloneBQControllerTest{
    
    static List<Brand_Quote__c> bqs;
    static List<Brand_Quote_Line__c> bqLines;
    
    // Test clone BQ and Lines
    static testMethod void testCloneBQAndLines(){
        
        // Get data created from setup
        retrieveData();
        
        // Get current count of BQ and Lines
        System.assertEquals(1, bqs.size(), 'BQ count mis-match');
        System.assertEquals(3, bqLines.size(), 'BQ Lines count mis-match');
        
        PageReference pageRef = Page.CloneBQ;
        pageRef.getParameters().put('id', bqs[0].Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bqs[0]);
        CloneBQController controllerObj = new CloneBQController(stdController);
        pageRef = controllerObj.cloneBQAction();
        
        // Get updated data after clone
        retrieveData();
        
        // Get current count of BQ and Lines
        System.assertEquals(2, bqs.size(), 'BQ count mis-match');
        System.assertEquals(6, bqLines.size(), 'BQ Lines count mis-match');
        System.assertEquals(CloneBQController.BQ_STATUS_DRAFT, bqs[1].BQ_Status__c, 'Clone BQ status mis-match');
        
        // Verify clone and source BQ lines
        for(Integer i=0; i<bqLines.size(); i++){
            if(i < 3){
                System.assertEquals(bqLines[i].Brand_Quote_Number__c, bqs[0].Id, 'BQ Id mis-match');
            }else{
                System.assertEquals(bqLines[i].Brand_Quote_Number__c, bqs[1].Id, 'BQ Id mis-match');
            }
        }
        System.assertEquals('/'+String.valueOf(bqs[1].Id), pageRef.getURL(), 'Page reference mis-match');
    }
    
    // Test clone BQ - No BQ lines in source BQ
    static testMethod void testCloneBQ_NoBQLinesOnSourceBQ(){
        
        // Get data created from setup
        retrieveData();
        
        delete bqLines;
        
        // Get data created from setup
        retrieveData();
        
        // Get current count of BQ and Lines
        System.assertEquals(1, bqs.size(), 'BQ count mis-match');
        System.assertEquals(0, bqLines.size(), 'BQ Lines count mis-match');
        
        PageReference pageRef = Page.CloneBQ;
        pageRef.getParameters().put('id', bqs[0].Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bqs[0]);
        CloneBQController controllerObj = new CloneBQController(stdController);
        pageRef = controllerObj.cloneBQAction();
        
        // Get updated data after clone
        retrieveData();
        
        // Get current count of BQ and Lines
        System.assertEquals(2, bqs.size(), 'BQ count mis-match');
        System.assertEquals(0, bqLines.size(), 'BQ Lines count mis-match');
        System.assertEquals(CloneBQController.BQ_STATUS_DRAFT, bqs[1].BQ_Status__c, 'Clone BQ status mis-match');
        System.assertEquals('/'+String.valueOf(bqs[1].Id), pageRef.getURL(), 'Page reference mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        bqs = [Select Id, BQ_Status__c From Brand_Quote__c];
        bqLines = [Select Id, Brand_Quote_Number__c from Brand_Quote_Line__c];
    }
}