public class checkActiveSiteList {

    
    public static void checkActiveSiteListMethod(){
        

set<id>strainids = new set<id>();
List<id>sites = new List<id>();

List<TTGS_Strain__c> ttgssList = [SELECT Id,Name, Active__c,Site__c,Strain__c FROM TTGS_Strain__c WHERE Active__c = true];

 for(TTGS_Strain__c TTGSObj : ttgssList)  {
            if(TTGSObj.Active__c == true)
            {
                strainids.add(TTGSObj.Strain__c);
                system.debug('strainids>>> ' + strainids);
            }
        } 


List<TTGS_Strain__c> ttgsStrain = [SELECT Id,Name, Active__c,Site__c FROM TTGS_Strain__c WHERE Strain__c =: strainids];
for(TTGS_Strain__c a : ttgsStrain){
    if(a.Active__c == true && String.isNotBlank(a.Site__c)){
        sites.add(a.Site__c);
        system.debug('sites>>> ' + sites);
    }
}
    }
}