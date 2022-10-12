public class opportunityHelper {
    
    public static String OPP_STAGENAME_CLOSED_LOST{
        get{
            return String.isNotBlank(OPP_STAGENAME_CLOSED_LOST) ? OPP_STAGENAME_CLOSED_LOST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Opp_Stage_Name_Closed_Lost');
        }set;
    }
      public static String BRANDQUOTE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(BRANDQUOTE_STATUS_CANCELLED) ? BRANDQUOTE_STATUS_CANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Cancelled');
        }set;
    }
    
     public static String BRANDQUOTE_GENERATED_ERROR_MESSAGE{
        get{
            return String.isNotBlank(BRANDQUOTE_GENERATED_ERROR_MESSAGE) ? BRANDQUOTE_GENERATED_ERROR_MESSAGE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Generated_Error');
        }set;
    }
    
        
    public static void checkBrandquoteExists(list<Opportunity> newList){
        String oppStageName = newList[0].StageName;
           Id oppId = newList[0].Id;
             Set<Id> bqIds = new Set<Id>();
        if(oppStageName == OPP_STAGENAME_CLOSED_LOST )  {
          
             List<Brand_Quote__c> bqres = [SELECT Id, Name, BQ_Status__c FROM Brand_Quote__c WHERE Opportunity_Name__c =:oppId  AND BQ_Status__c!=:BRANDQUOTE_STATUS_CANCELLED];
             for(Brand_Quote__c ord: bqres){ bqIds.add(ord.Id);
             }
            
            if(bqIds.size() > 0){newList[0].addError(BRANDQUOTE_GENERATED_ERROR_MESSAGE);
            }
            
        }
        
    }

}