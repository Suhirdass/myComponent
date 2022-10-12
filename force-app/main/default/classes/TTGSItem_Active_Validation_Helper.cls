public class TTGSItem_Active_Validation_Helper {
    
    public static void beforeInsert(List<TTGS_Item__c> lstTTGSItem){
        
        set<id> productId = new set<id>();
        set<id> siteId = new set<id>();
        
        
        for(TTGS_Item__c itemObj : lstTTGSItem){
            if(String.isNotBlank(itemObj.Site__c)){
                productId.add(itemObj.Product_Name__c);
                siteId.add(itemObj.Site__c);
            }
        }
        
        List<TTGS_Item__c> ttgsItem = [SELECT id,Name,Site__c FROM TTGS_Item__c WHERE Product_Name__c =:productId];
        
        set<id> multipleSiteId = new set<id>();
        
        for(TTGS_Item__c ttgsItemObj : ttgsItem){
            if(siteId.contains(ttgsItemObj.Site__c)){  
                multipleSiteId.add(ttgsItemObj.Site__c);
            }
            
        }
        
        for(TTGS_Item__c itemObj :lstTTGSItem)
        {
            if(multipleSiteId.size()>0){
                itemObj.adderror('Site name is already exist in product');
            }
        }  
    }
    
    
    public static void beforeUpdate(List<TTGS_Item__c> lstTTGSItem,Map<Id,TTGS_Item__c> oldMap){
            
      
        
        set<id>duplicatesites = new set<id>(); 
        set<id>strainids = new set<id>(); 
        set<id>sites = new set<id>();
        
        
        
        for(TTGS_Item__c TTGSObj :lstTTGSItem )  {
            if(TTGSObj.Site__c != oldMap.get(TTGSObj.Id).Site__c){
                strainids.add(TTGSObj.Strain__c);    
                sites.add(TTGSObj.Site__c);
              }
        }
        
        
        List<TTGS_Item__c> ttgslist =[select id,name,Site__c from TTGS_Item__c where Strain__c =:strainids];   
        
        for(TTGS_Item__c TTGSObj :ttgslist )  {
            if(sites.contains(TTGSObj.Site__c))  { 
                duplicatesites.add(TTGSObj.Site__c); 
            }
        }
      

        for(TTGS_Item__c TTGSObj :lstTTGSItem)
        {
            if(duplicatesites.size()>0){  
                TTGSObj.adderror('Can not Updating Record');  
            } 
        }
        
    }

}