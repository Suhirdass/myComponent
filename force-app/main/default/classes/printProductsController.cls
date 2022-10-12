public class printProductsController {
	public Object filters{get;set;}
    public List<Product2> record{get;set;}
    
    public printProductsController(){
      callgetServiceTicketsData();  
    }
    public void callgetServiceTicketsData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        AuraResponse wrapperData = ProductsCtlr.getNewProductRequestIds(mapOfFilters);
        System.debug('wrapperData='+wrapperData);
        List<String> ids = (List<String>)wrapperData.data.get('ids');
        AuraResponse recordsData = ProductsCtlr.getNewProductRequests(ids,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('records'));
        record = (List<Product2>)recordsData.Data.get('records');
        System.debug('rec='+record);
    }
}