public without sharing class printReportPdfCtrl {
        public Object filters{get;set;}
    public List<ReportsAndDashBoardController.Record> rec{get;set;}
    
    public printReportPdfCtrl(){
      callgetServiceTicketsData();  
    }
    
    public void callgetServiceTicketsData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        String checkRecentReports = ApexPages.currentPage().getParameters().get('recentReport');
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        AuraResponse wrapperData;
        if(checkRecentReports == 'true')
             wrapperData = ReportsAndDashBoardController.getRecentReportsIds(mapOfFilters);
        else
        	 wrapperData = ReportsAndDashBoardController.getReportsIds(mapOfFilters);
        System.debug('wrapperData='+wrapperData);
        list<Id> idsList = (list<Id>)wrapperData.data.get('ids');
        AuraResponse recordsData = ReportsAndDashBoardController.getReports(idsList,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('records'));
        rec = (List<ReportsAndDashBoardController.Record>)recordsData.Data.get('records');
        System.debug('rec='+rec);
    }

}