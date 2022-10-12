public without sharing class PrintOrdersPdfCtlr {
    
    public Object filters{get;set;}
    public String HeaderTxt{get;set;}
    public String retailHeaderTxt{get;set;}
    public List<List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>> rec{get;set;}
    public List<ProductsCtlr.Order> retailOrder{get;set;}
    
    
    public PrintOrdersPdfCtlr(){
    	//callgetServiceTicketsData();  
    }
    
    public void callgetServiceTicketsData(){
        rec = new List<List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>>();
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        Boolean showTransferOrders = Boolean.valueOf(ApexPages.currentPage().getParameters().get('showTransferOrders'));
        HeaderTxt = showTransferOrders ? 'Outbound Transfers' : 'Orders';
        AuraResponse wrapperData = RetailDeliveryTicketsCtlr.getIds(mapOfFilters,showTransferOrders);
        System.debug('wrapperData='+wrapperData);
        Set<Id> ids = (Set<Id>)wrapperData.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idValue : ids){
           idsList.add(idValue); 
        }
        AuraResponse recordsData = RetailDeliveryTicketsCtlr.getRetailDeliveryTickets(idsList,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('retailDeliveryTickets'));
        List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>tempList = new List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>();
        for(RetailDeliveryTicketsCtlr.RetailDeliveryTicket rtc : (List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>)recordsData.Data.get('retailDeliveryTickets')){
        	tempList.add(rtc);
            if(tempList.size() == 1000){
            	rec.add(tempList);
                tempList = new List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>();
            }
        }
        if(tempList.size() > 0)
            rec.add(tempList);
        System.debug('rec='+rec);
    }
    
    public void callGetRetailOrderData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        retailHeaderTxt = 'Orders';
        AuraResponse wrapperData = ProductsCtlr.getOrdersIds(mapOfFilters);
        System.debug('wrapperData='+wrapperData);
        Set<Id> ids = (Set<Id>)wrapperData.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idValue : ids){
           idsList.add(idValue); 
        }
        AuraResponse recordsData = ProductsCtlr.getOrders(idsList,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('records'));
        retailOrder = (List<ProductsCtlr.Order>)recordsData.Data.get('records');
        //System.debug('rec='+retailOrder);*/
    }
}