public class TTGS_DuplicateSIte_Validation_Helper {
    

    public static void beforeUpdate(List<TTGS_Strain__c> lstTTGSStrain,Map<Id,TTGS_Strain__c> oldMap){
            
      
        
        set<id>duplicatesites = new set<id>(); 
        set<id>strainids = new set<id>(); 
        set<id>sites = new set<id>();
        
        
        
        for(TTGS_Strain__c TTGSObj :lstTTGSStrain )  { if(TTGSObj.Active__c != oldMap.get(TTGSObj.Id).Active__c){
            if(TTGSObj.Active__c == true)
            {
                strainids.add(TTGSObj.Strain__c);    
                sites.add(TTGSObj.Site__c);   
            }
              }
        }
        
        
        List<TTGS_Strain__c> ttgslist =[select id,name,Active__c,Site__c from TTGS_Strain__c where Strain__c =:strainids];   
        
        for(TTGS_Strain__c TTGSObj :ttgslist )  {
            if(sites.contains(TTGSObj.Site__c) && TTGSObj.Active__c == true )  { duplicatesites.add(TTGSObj.Site__c); 
            }
        }
        system.debug('duplicatesites>>'+duplicatesites);
                system.debug('duplicatesites>>'+duplicatesites.size());

        for(TTGS_Strain__c TTGSObj :lstTTGSStrain)
        {
            if(duplicatesites.size()>0){  TTGSObj.adderror('Please deactivate existing active Strains and try creating/updating active Strain.');  
            }
        }
        
    }
    public static void beforeInsert(List<TTGS_Strain__c> lstTTGSStrain){
            
      
        
        set<id>duplicatesites = new set<id>(); 
        set<id>strainids = new set<id>(); 
        set<id>sites = new set<id>();
        
        
        
        for(TTGS_Strain__c TTGSObj :lstTTGSStrain )  {
            
                
            
            if(TTGSObj.Active__c == true)
            {
                strainids.add(TTGSObj.Strain__c);    
                sites.add(TTGSObj.Site__c);   
            }
             
        }
        
        
        List<TTGS_Strain__c> ttgslist =[select id,name,Active__c,Site__c from TTGS_Strain__c where Strain__c =:strainids];   
        
        for(TTGS_Strain__c TTGSObj :ttgslist )  { if(sites.contains(TTGSObj.Site__c) && TTGSObj.Active__c == true )
            {
                duplicatesites.add(TTGSObj.Site__c); 
            }
        }
        system.debug('duplicatesites>>'+duplicatesites);
                system.debug('duplicatesites>>'+duplicatesites.size());

        for(TTGS_Strain__c TTGSObj :lstTTGSStrain)
        {
            if(duplicatesites.size()>0){   TTGSObj.adderror('Please deactivate existing active Strains and try creating/updating active Strain.');  
            }
        }
        
    } 
    
     public static void GetVlaueFromParentInsert(List<TTGS_Strain__c> lstTTGSStrain){
       List<TTGS_Strain__c> ttgslist = new  List<TTGS_Strain__c> ();
       set<id>strainid = new set<id>(); 
       for(TTGS_Strain__c TTGSObj :lstTTGSStrain )  {
           
           strainid.add(TTGSObj.Strain__c);    
           
       }
       
       Strain__c strainobj =[select id,SativaPercentage__c,IndicaPercentage__c,CbdLevel__c,ThcLevel__c,name from Strain__c where Id =:strainid];   
       for(TTGS_Strain__c TTGSObj :lstTTGSStrain )  {
           if(TTGSObj.Sativa_Percentage__c == null){
               TTGS_Strain__c ttgs = new TTGS_Strain__c();  
               ttgs.Id = TTGSObj.Id;
               ttgs.Sativa_Percentage__c = strainobj.SativaPercentage__c;
               ttgs.Indica_Percentage__c = strainobj.IndicaPercentage__c;
               ttgs.CBD_Level__c = strainobj.CbdLevel__c;
               ttgs.THC_Level__c = strainobj.ThcLevel__c;
               
               ttgslist.add(ttgs);   
               
           } 
       }
       system.debug('t+tgslist'+ttgslist);
       upsert  ttgslist;
       
       
       
       
   }
    
}