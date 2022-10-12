public without sharing class printDashboardPdfCtrl {
    public Object filters{get;set;}
    public List<ReportsAndDashBoardController.Record> rec{get;set;}
    
    public printDashboardPdfCtrl(){
        dashboardsData();  
    }
    
    public void dashboardsData(){
        String filters = ApexPages.currentPage().getParameters().get('filters');//'{ "orderByField": "Name", "isASC": false }';
        String checkRecentReports = ApexPages.currentPage().getParameters().get('recent');
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        AuraResponse wrapperData;
        if(checkRecentReports == 'true')
            wrapperData = ReportsAndDashBoardController.getRecentDashboardIds(mapOfFilters);
        else
            wrapperData = ReportsAndDashBoardController.getDashboardIds(mapOfFilters);
        System.debug('wrapperData='+wrapperData);
        list<Id> idsList = (list<Id>)wrapperData.data.get('ids');
        AuraResponse recordsData = ReportsAndDashBoardController.getDashboards(idsList,mapOfFilters);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('records'));
        rec = (List<ReportsAndDashBoardController.Record>)recordsData.Data.get('records');
        System.debug('rec='+rec);
    }
}