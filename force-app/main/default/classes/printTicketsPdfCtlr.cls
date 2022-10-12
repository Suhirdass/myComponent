public without sharing class printTicketsPdfCtlr {
    
    public Object filters{get;set;}
    public List<ServiceTicketsCtlr.ServiceTicket> rec{get;set;}
    
    public printTicketsPdfCtlr(){
      callgetServiceTicketsData();  
    }
    
    public void callgetServiceTicketsData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        String fromService = ApexPages.currentPage().getParameters().get('fromService');
        fromService = fromService != null && fromService != '' ? fromService : 'true';
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        AuraResponse wrapperData = ServiceTicketsCtlr.getIdsForFile(mapOfFilters,fromService);
        System.debug('wrapperData='+wrapperData);
        Set<Id> ids = (Set<Id>)wrapperData.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idValue : ids){
           idsList.add(idValue); 
        }
        AuraResponse recordsData = ServiceTicketsCtlr.getServiceTicketsFile(idsList,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('records'));
        rec = (List<ServiceTicketsCtlr.ServiceTicket>)recordsData.Data.get('records');
        System.debug('rec='+rec);
    }
}