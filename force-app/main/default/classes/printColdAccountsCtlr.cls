public class printColdAccountsCtlr {
    public List<List<Order__c>> rec{get;set;}
    public printColdAccountsCtlr(){
        rec = New List<List<Order__c>>(); 
    	String filters = ApexPages.currentPage().getParameters().get('filters');
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        AuraResponse wrapperData = HomeController.getAllColdAccountIds(mapOfFilters);
        Set<Id> ids = (Set<Id>)wrapperData.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idValue : ids){
           idsList.add(idValue); 
        }
        AuraResponse recordsData = HomeController.getAllColdAccounts(idsList,mapOfFilters);
        List<Order__c>tempList = new List<Order__c>();
        for(Order__c coldAcc : (List<Order__c>)recordsData.Data.get('coldAccountsList')){
        	tempList.add(coldAcc);
            if(tempList.size() == 1000){
            	rec.add(tempList);
                tempList = new List<Order__c>();
            }
        }
        if(tempList.size() > 0)
            rec.add(tempList);
    }
}