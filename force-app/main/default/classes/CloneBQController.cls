/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CloneBQController
 */
public class CloneBQController{

    private ApexPages.StandardController stdController;
    private Brand_Quote__c brandQuoteObj = null;
    private Id clonedBQId;
    
    @testVisible
    private static final String BQ_STATUS_DRAFT = 'Draft'; 
    
    // Constructor
    public CloneBQController(ApexPages.StandardController controller) {
        this.stdController = controller;
        brandQuoteObj = (Brand_Quote__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    /**
     * Clone BQ with line items
     *
     * @return PageReference of newly crated BQ detail page
     */
    public PageReference cloneBQAction() {
        PageReference pageRef = null;
        Id brandQuoteId = brandQuoteObj.Id;
        Brand_Quote__c cloneBQSO = new Brand_Quote__c();
        List<Brand_Quote_Line__c> cloneBQLines = new List<Brand_Quote_Line__c>(); 
        
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            // Get all fields of Brand Quote
            DescribeSObjectResult describeBQResult = Brand_Quote__c.getSObjectType().getDescribe(); 
            List<String> bqFieldNames = new List<String>( describeBQResult.fields.getMap().keySet() );  
            String brandQuoteQuery = ' SELECT ' +
                                     String.join( bqFieldNames, ',' ) +
                                    ' FROM ' +
                                    describeBQResult.getName() +
                                    ' Where Id =: brandQuoteId LIMIT 1';
            brandQuoteObj = Database.query( brandQuoteQuery );
            
            // Get all fields of Brand Quote Lines
            DescribeSObjectResult describeBQLineResult = Brand_Quote_Line__c.getSObjectType().getDescribe();    
            List<String> bqLineFieldNames = new List<String>( describeBQLineResult.fields.getMap().keySet() );  
            String brandQuoteLineQuery = ' SELECT ' +
                                        String.join( bqLineFieldNames, ',' ) +
                                        ' FROM ' +
                                        describeBQLineResult.getName() +
                                        ' Where Brand_Quote_Number__c =: brandQuoteId';
            List<Brand_Quote_Line__c> brandQuoteLines = Database.query( brandQuoteLineQuery );
            
            // clone BQ
            cloneBQSO = brandQuoteObj.clone(false, true);
            cloneBQSO.BQ_Status__c = BQ_STATUS_DRAFT;
            insert cloneBQSO;
            clonedBQId = cloneBQSO.Id;
            
            if(brandQuoteLines == null || brandQuoteLines.size() == 0){
                return redirectToBQ();
            }
            
            // clone BQ lines
            for(Brand_Quote_Line__c bqLine : brandQuoteLines){
                Brand_Quote_Line__c cloneBQLineSO  = bqLine.clone(false, true);
                cloneBQLineSO.Brand_Quote_Number__c = clonedBQId;
                cloneBQLines.add(cloneBQLineSO);
            }
            insert cloneBQLines;
            
        
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('CloneBQController:cloneBQAction()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToBQ();
    }

    /**
     * Redirect to cloned BQ detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToBQ() {
        PageReference pageRef;
        if(clonedBQId != null){
            pageRef = new PageReference('/'+clonedBQId);
            pageRef.setRedirect(true);
        }
        return pageRef;
    }
}