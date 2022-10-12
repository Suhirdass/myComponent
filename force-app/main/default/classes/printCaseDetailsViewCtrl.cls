public class printCaseDetailsViewCtrl {
     public List<Case> record{get;set;}
    
    public printCaseDetailsViewCtrl(){
      callgetCaseDataView();  
    }
    public void callgetCaseDataView(){
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        AuraResponse recordsData = ProductsCtlr.printCaseDetails(recordId);
      	//record = (Case)recordsData.Data.get('caseDetails');
      	record = (List<Case>)recordsData.Data.get('caseDetails');
    }
}