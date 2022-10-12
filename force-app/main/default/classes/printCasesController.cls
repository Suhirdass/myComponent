public class printCasesController {
	public Object filters{get;set;}
    public List<Case> record{get;set;}
    
    public printCasesController(){
      callgetCaseTicketsData();  
    }
    public void callgetCaseTicketsData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        AuraResponse wrapperData = ProductsCtlr.getCases(mapOfFilters);
        List<String> ids = (List<String>)wrapperData.data.get('ids');
        AuraResponse recordsData = ProductsCtlr.getCaseDetails(ids,mapOfFilters);
        record = (List<Case>)recordsData.Data.get('records');
    }
}