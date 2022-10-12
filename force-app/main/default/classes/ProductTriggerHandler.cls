/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ProductTriggerHandler
 */
public class ProductTriggerHandler{
    
    private static String PRODUCT_STATUS_ACTIVE{
        get{
            return String.isNotBlank(PRODUCT_STATUS_ACTIVE) ? PRODUCT_STATUS_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Status_Active');
        }set;
    }
    private static String PRODUCT_STATUS_INACTIVE{
        get{
            return String.isNotBlank(PRODUCT_STATUS_INACTIVE) ? PRODUCT_STATUS_INACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Status_Inactive');
        }set;
    }
    private static String PRODUCT_STATUS_DRAFT{
        get{
            return String.isNotBlank(PRODUCT_STATUS_DRAFT) ? PRODUCT_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Status_Draft');
        }set;
    }
    /**
     * Prevent duplicate product names to be inserted or edited
     * @param newProductList - Trigger.New list of Product2 trigger
     * @param oldProductMap - Trigger.oldMap map of Product2 trigger
     */
    public static void updateStrainPercentage(List<Product2> newProductList, Map<Id, Product2> oldProductMap){
        system.debug('##enter updateStrainPercentage');
        Set<Id> strainIds = new Set<Id>();
        for(Product2 productSO : newProductList){
            if(productSO.Strain__c != null ){
                strainIds.add(productSO.Strain__c);
            }
        }
        system.debug('##strainIds : '+strainIds.size());
        if(strainIds.size() > 0){
            
            List<Strain__c> stList = [SELECT id,Strain_Type__c,SativaPercentage__c,IndicaPercentage__c FROM Strain__c WHERE id IN: strainIds];
            Map<String,Strain_Type_Config__mdt> StrainTypePercentageMap = new Map<String,Strain_Type_Config__mdt>();
            for(Strain_Type_Config__mdt stconfig : [SELECT Id, MasterLabel,Indica_Percentage__c,Sativa_Percentage__c,Strain_Type__c  FROM Strain_Type_Config__mdt ] ){
                for(String sType : stconfig.Strain_Type__c.split(',')){
                    if(!StrainTypePercentageMap.containsKey(sType)){
                        StrainTypePercentageMap.put(sType, stconfig);
                    }
                }  
            }
            system.debug('##stList : '+stList.size());
            List<Strain__c> stUpdateList = new List<Strain__c>();
            for(Strain__c st : stList){
                system.debug('##StrainTypePercentageMap : '+StrainTypePercentageMap.get(st.Strain_Type__c));
                if(StrainTypePercentageMap.containsKey(st.Strain_Type__c)){
                    st.SativaPercentage__c = StrainTypePercentageMap.get(st.Strain_Type__c).Sativa_Percentage__c;
                    st.IndicaPercentage__c = StrainTypePercentageMap.get(st.Strain_Type__c).Indica_Percentage__c;
                }else{
                    st.SativaPercentage__c = 0;
                    st.IndicaPercentage__c = 0;
                }
                stUpdateList.add(st);
            }
            if(stUpdateList.size() > 0 ){
                update stUpdateList;
            }
        }
    }
    public static void verifyUniqueProductName(List<Product2> newProductList, Map<Id, Product2> oldProductMap){
        
        List<Product2> candidateProducts = new List<Product2>();
        Set<Id> currentIds = new Set<Id>();
        
        for(Product2 productSO : newProductList){
            Product2 oldProductSO = oldProductMap != null ? (Product2)oldProductMap.get(productSO.Id) : null;
            if(trigger.isInsert){
                candidateProducts.add(productSO);
            }
            if(trigger.isInsert && productSO.Status__c == NULL){
                productSO.Status__c = PRODUCT_STATUS_DRAFT;
            }
            // Update Status Based on Active change
            if(trigger.isUpdate && productSO.IsActive != oldProductSO.IsActive){
                productSO.Status__c = productSO.IsActive ? PRODUCT_STATUS_ACTIVE : PRODUCT_STATUS_INACTIVE;
            }
            
            // Get candidate products where new value of product name is changed
            if(trigger.isUpdate && productSO.Name != oldProductSO.Name){
                candidateProducts.add(productSO);
                if(trigger.isUpdate){
                    currentIds.add(productSO.Id);
                }
            }
        }
        
        // Get existing products to verify with new product records
        if(candidateProducts.size() > 0){
            
            Map<String, Id> caseInsensitiveProductIdsByName = new Map<String, Id>();
            Map<Id, String> productNamesById = new Map<Id, String>();
            
            for(Product2 productSO : [Select Id, Name From Product2 WHERE Id Not IN: currentIds]){
                caseInsensitiveProductIdsByName.put(productSO.Name.toLowerCase(), productSO.Id);
                productNamesById.put(productSO.Id, productSO.Name);
            }
            
            for(Product2 productSO : candidateProducts){
                if(productSO != null && caseInsensitiveProductIdsByName.containsKey(productSO.Name.toLowerCase())){
                    String existingProductId = caseInsensitiveProductIdsByName.get(productSO.Name.toLowerCase()); 
                    String existingProductName = productNamesById.get(existingProductId); 
                    productSO.addError(String.format(Label.Product_name_duplicate_validation_error, 
                                        new List<String>{productSO.Name,
                                        existingProductId,
                                        existingProductName}), false);
                }
            }
        }
    }
    
    public static void notifyCustomerOnAvailableInventory(List<Product2> newProductList, Map<Id, Product2> oldProductMap){
        Set<Id> availableProductIds = new Set<Id>();
        for(Product2 prd: newProductList){
            if(prd.Available_Inventory__c != null && 
               prd.Available_Inventory__c != oldProductMap.get(prd.Id).Available_Inventory__c &&
               prd.Available_Inventory__c >= prd.MOQ__c && oldProductMap.get(prd.Id).Available_Inventory__c < prd.MOQ__c
              ){
                availableProductIds.add(prd.Id);
            }
        }
        if(!availableProductIds.isEmpty()){
            Product_Stock_Notification__c[] PSNs = [SELECT Id,Name, Product__c, Sent_Notification__c FROM Product_Stock_Notification__c WHERE Product__c IN: availableProductIds AND Sent_Notification__c = false];
            if(!PSNs.isEmpty()){
                for(Product_Stock_Notification__c p: PSNs){
                    p.Sent_Notification__c = true;
                }
                update PSNs;
            }
        }
    }
}