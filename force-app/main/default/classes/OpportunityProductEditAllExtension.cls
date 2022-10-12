/**************************************************************************************
Apex Class Name    : OpportunityProductEditAllExtension 
Test Class Name    : OpportunityProductEditAllExtensionTest
Version            : 1.0
Created Date       : Aug 24 2018
Function           : Used for opportunityProductEditAll VF page and used in "Edit ALL" button.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  08/24/2018              Original Version
*******************************************************************************/
public with sharing class OpportunityProductEditAllExtension{
    
    public opportunityLineItem[] shoppingCart {get;set;}
    public OpportunityProductEditAllExtension(ApexPages.StandardController controller) {
        shoppingCart = [select Id,Name, Quantity, TotalPrice, UnitPrice, Description,Product_Title__c,MOQ__c,MOQ_TF__c, PriceBookEntryId,Product2.Available_Inventory__c,Product2.Available_Qty__c, PriceBookEntry.Name, PriceBookEntry.IsActive, PriceBookEntry.Product2Id, PriceBookEntry.Product2.Name, PriceBookEntry.PriceBook2Id 
                        from opportunityLineItem where OpportunityId =:controller.getRecord().Id order by PriceBookEntry.Name ASC ];
    }
    
    public OpportunityProductEditAllExtension(){
    }
    
    public PageReference onSave(){
        Boolean validationCheck =false;
        for(opportunityLineItem var:shoppingCart){
            if(var.UnitPrice <= 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter valid Sales Price'));
                validationCheck =true;
            }
            if(var.Quantity < 1){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter valid Quantity'));
                validationCheck =true;
            }
            if(validationCheck ==true){ return null;}
        }
        
        if(shoppingCart.size()>0){
            upsert(shoppingCart);    
        }
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    }
    
    @AuraEnabled
    public static AuraResponse onSaveCart(List<opportunityLineItem> shoppingCart){
        AuraResponse r = new AuraResponse('OpportunityProductEditAllLightController.onSaveCart()');
        if(shoppingCart.size()  > 0){
            upsert(shoppingCart);        
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse opportunityProductEdit(String recordId){
        AuraResponse r = new AuraResponse('OpportunityProductEditAllExtension.opportunityProductEdit()');
        
        OpportunityProductEditAllExtension opps = new OpportunityProductEditAllExtension();
        
        opps.shoppingCart = [select Id,Name, Quantity, TotalPrice, UnitPrice, Description,Product_Title__c,MOQ__c,MOQ_TF__c, PriceBookEntryId,Product2.Available_Inventory__c,Product2.Available_Qty__c, PriceBookEntry.Name, PriceBookEntry.IsActive, PriceBookEntry.Product2Id, PriceBookEntry.Product2.Name, PriceBookEntry.PriceBook2Id, Is_Sample__c  
                             from opportunityLineItem where OpportunityId =: recordId order by PriceBookEntry.Name ASC ];
        
        List<String> lstStr = new List<String>();
        Schema.DescribeFieldResult fieldResult = opportunityLineItem.Product_Title__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            lstStr.add(f.getLabel());
        }
        
        r.data.put('shoppingCart', opps.shoppingCart);
        r.data.put('pickListVal', lstStr);
        return r;
    }
    
    public PageReference onCancel(){
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    }
    public PageReference getTotalQty() {
        //TotalQty =Quantity  * MOQ;
        return null;
    }
}