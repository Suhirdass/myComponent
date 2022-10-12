public  with sharing class ReportsAndDashBoardController {
    private static String INVESTOR_DASHBOARD_FOLDER{
        get{
            return String.isNotBlank(INVESTOR_DASHBOARD_FOLDER) ? INVESTOR_DASHBOARD_FOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Dashboard','Investor_Dashboard_Folder');
        }set;
    }
    //public static Record siteReport =  new Record('custom site report','Product Inventory by Site V2','SR - Shows Product Inventory Details by Site','','',''); 
    //public static Record batchReport =  new Record('custom batch report','Product Inventory by Site and Batch','SR - Shows Product Inventory Details by Site','','',''); 
    static Community_Settings__c communitySetting {
        get{
            if(communitySetting == null){
                Map<String,Community_Settings__c> communitySettingMap = Community_Settings__c.getAll();
                communitySetting = communitySettingMap.get('default');
            }
            return communitySetting;
        }set;
    }
    
    static String MPReportFolder{
        get{
            if(communitySetting != null){
                if(ProductsCtlr.isBrand){
                    MPReportFolder = communitySetting.Brand_Report_Folder__c;
                }else{
                    MPReportFolder = communitySetting.Retailer_Report_Folder__c;
                }
            }
            return MPReportFolder;
        }set;
    }
    /*static String MPDashboardFolder{
        get{
            if(communitySetting != null){
                if(ProductsCtlr.isBrand){
                    MPDashboardFolder = communitySetting.Brand_Dashboard_Folder__c;
                }else{
                    MPDashboardFolder = communitySetting.Retailer_Dashboard_Folder__c;
                }
            }
            return MPDashboardFolder;
        }set;
    }*/

    public static Integer maxRecords = 49999;
    private static Boolean isCommunityPlusUser{
        get{
            User u = [SELECT Id, Name, User_License__c,  Has_Accepted_Terms__c FROM User WHERE Id=: UserInfo.getUserId()];
        	return 'Customer Community Plus'.equalsIgnoreCase(u.User_License__c);
        }
        set;
    }
    public static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
    
    public static Boolean hasListFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && !((List<Object>)filters.get(key)).isEmpty();
    }
    @AuraEnabled
    public static AuraResponse getRecentDashboardIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getDashboardIds()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Title, Description, DeveloperName,LastViewedDate FROM Dashboard';
        List<String> whereParts = new List<String>{'FolderName = :INVESTOR_DASHBOARD_FOLDER', 'LastViewedDate = LAST_N_DAYS:7'};
        String orderByField = 'Title';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Title LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##query:'+query);
        
        List<DashBoard> dashBoards = (DashBoard[])Database.query(query);
            list<Id> ids = new List<Id>();
            for(Dashboard d:dashBoards){
                ids.add(d.Id);
            }
        }else{
            r.data.put('ids',new List<Id>());
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse getDashboardIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getDashboardIds()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Title, Description, DeveloperName,LastViewedDate FROM Dashboard';
        List<String> whereParts = new List<String>{'FolderName = :INVESTOR_DASHBOARD_FOLDER'};
        String orderByField = 'Title';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Title LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##query:'+query);
        
        List<DashBoard> dashBoards =(DashBoard[])Database.query(query);
            list<Id> ids = new List<Id>();
            for(Dashboard d:dashBoards){
                ids.add(d.Id);
            }
        r.data.put('ids',ids);
        }else{
            r.data.put('ids',new List<Id>());
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse getDashboards(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getAllReports()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Title, Description, DeveloperName,LastViewedDate FROM Dashboard';
        List<String> whereParts = new List<String>{'Id IN :ids'};
        String orderByField = 'Title';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Title LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        Record[] dashboards = new Record[]{};
        for(Dashboard rep: (Dashboard[])Database.query(query)){
            dashboards.add(new Record(rep));
        }
        r.data.put('records',dashboards);
        }else{
            r.data.put('ids',new Set<Id>());
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse getRecentReportsIds(Map<String, Object> filters){
        
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getReportsIds()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Name, Description, DeveloperName,LastViewedDate FROM Report';
        List<String> whereParts = new List<String>{'FolderName = :MPReportFolder', 'LastViewedDate = LAST_N_DAYS:7'};
        String orderByField = 'Name';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Name LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##query:'+query);
        list<String>ids = new list<String>();
            list<Record>RecordList = new list<Record>();
            for(Report r1 : Database.query(query)){
            	//Record report = new Record(r1,orderByField,direction);
            	//RecordList.add(report);
            	ids.add(r1.id);
            }
            /*User usr = [select id,Inventory_By_Site_Report_View_Date__c,Inventory_By_Site_Batch_Report_View_Date__c from User where id =: userinfo.getUserId()];
            date dt = system.today().addDays(-7);
            if(usr.Inventory_By_Site_Report_View_Date__c != null && usr.Inventory_By_Site_Report_View_Date__c > dt){
                Record customSiteReport =  new Record(siteReport.id,siteReport.name,siteReport.description,MPReportFolder,orderByField,direction); 
                if(String.isNotBlank(searchTerm)){
                    string searchTerm1 = searchTerm.replace('%', '').toLowerCase();
                    if(customSiteReport.name.toLowerCase().contains(searchTerm1) || customSiteReport.description.toLowerCase().contains(searchTerm1) || customSiteReport.folderName.toLowerCase().contains(searchTerm1))     
                        RecordList.add(customSiteReport);
                }else
                    RecordList.add(customSiteReport);
            }
            
            if(usr.Inventory_By_Site_Batch_Report_View_Date__c != null && usr.Inventory_By_Site_Batch_Report_View_Date__c > dt){
                Record customBatchReport =  new Record(batchReport.id,batchReport.name,batchReport.description,MPReportFolder,orderByField,direction); 
                if(String.isNotBlank(searchTerm)){
                    string searchTerm1 = searchTerm.replace('%', '').toLowerCase();
                    if(customBatchReport.name.toLowerCase().contains(searchTerm1) || customBatchReport.description.toLowerCase().contains(searchTerm1) || customBatchReport.folderName.toLowerCase().contains(searchTerm1))     
                        RecordList.add(customBatchReport);
                }else
                    RecordList.add(customBatchReport);
            }
            
            RecordList.sort();
            for(Record r1 : RecordList){
                ids.add(r1.id);        
            }*/
        r.data.put('ids',ids);
        }else{
            r.data.put('ids',new list<Id>());
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse getReportsIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getReportsIds()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Name, Description, DeveloperName,LastViewedDate FROM Report';
        Folder[] MPFolders = [SELECT Id,Name FROM Folder WHERE Name =:MPReportFolder];
        
        List<String> whereParts = new List<String>{'FolderName = :MPReportFolder'};
        String orderByField = 'Name';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Name LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        
        query += ' LIMIT ' + maxRecords;
        System.debug('##query:'+query);
        
        list<String>ids = new list<String>();
        list<Record>RecordList = new list<Record>();
		for(Report r1 : Database.query(query)){
            ids.add(r1.id);
            //Record report = new Record(r1,orderByField,direction);
            //RecordList.add(report);
		}
        
            system.debug('ids.size() '+ids.size());
        /*Record customSiteReport =  new Record(siteReport.id,siteReport.name,siteReport.description,MPReportFolder,orderByField,direction); 
        Record customBatchReport =  new Record(batchReport.id,batchReport.name,batchReport.description,MPReportFolder,orderByField,direction); 
        if(String.isNotBlank(searchTerm)){
        	string searchTerm1 = searchTerm.replace('%', '').toLowerCase();
            if(customSiteReport.name.toLowerCase().contains(searchTerm1) || customSiteReport.description.toLowerCase().contains(searchTerm1) || customSiteReport.folderName.toLowerCase().contains(searchTerm1))     
            	RecordList.add(customSiteReport);
            if(customBatchReport.name.toLowerCase().contains(searchTerm1) || customBatchReport.description.toLowerCase().contains(searchTerm1) || customBatchReport.folderName.toLowerCase().contains(searchTerm1))     
            	RecordList.add(customBatchReport);
        }else{
        	RecordList.add(customSiteReport);
            RecordList.add(customBatchReport);
        }
        
        RecordList.sort();
        for(Record r1 : RecordList){
        	ids.add(r1.id);        
        }*/
        r.data.put('ids',ids);
        }else{
            r.data.put('ids',new list<Id>());
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getReports(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ReportsAndDashBoardController.getAllReports()');
        if(isCommunityPlusUser){
        String query = 'SELECT Id, FolderName, Name, Description, DeveloperName,LastViewedDate FROM Report';
        List<String> whereParts = new List<String>{'Id IN :ids'};
        String orderByField = 'Name';
        String direction = 'ASC';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Name LIKE :searchTerm OR Description LIKE :searchTerm OR FolderName LIKE :searchTerm ) ');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) ;
        }
        Record[] reports = new Record[]{};
        for(Report rep: (Report[])Database.query(query)){
            reports.add(new Record(rep));
        }
        /*if(ids.contains(siteReport.id)){
            Record customSiteReport =  new Record(siteReport.id,siteReport.name,siteReport.description,MPReportFolder,orderByField,direction); 
        	reports.add(customSiteReport);
        }
        if(ids.contains(batchReport.id)){
            Record customBatchReport =  new Record(batchReport.id,batchReport.name,batchReport.description,MPReportFolder,orderByField,direction); 
        	reports.add(customBatchReport);
        }
        reports.sort();*/
        r.data.put('records',reports);
        }else{
            r.data.put('ids',new list<Id>());
        }
        return r;
    }
    public class Record{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String name{set;get;}
        @AuraEnabled
        public String description{set;get;}
        @AuraEnabled
        public String folderName{set;get;}
        public Record(Report r){
            this.id = r.Id;
            this.name = r.Name;
            this.description = r.Description;
            this.folderName = r.FolderName;
        }
        public Record(Dashboard r){
            this.id = r.Id;
            this.name = r.Title;
            this.description = r.Description;
            this.folderName = r.FolderName;
        }
        /*public Record(Dashboard r,String sortByField,String sortOrder){
            this.id = r.Id;
            this.name = r.Title;
            this.description = r.Description;
            this.folderName = r.FolderName;
            this.sortBy = sortByField;
            this.sortOrder = sortOrder;
        }
        public Record(String reportId,String reportName,String reportDescription,String reportFolder,String sortByField,String sortOrder){
            this.id = reportId;
            this.name = reportName;
            this.description = reportDescription;
            this.folderName = reportFolder;
            this.sortBy = sortByField;
            this.sortOrder = sortOrder;
        }
        public Integer compareTo(Object objToCompare) {
            Record compareToRecord = (Record)objToCompare;
            integer returnVal = -1;
            if(sortBy == 'Name'){
                if(name != null && compareToRecord.name != null)
                	returnVal = name.compareTo(compareToRecord.name);
            }else{
                if(description != null && compareToRecord.description != null)
            		returnVal =  description.compareTo(compareToRecord.description); 
            }
            if(sortOrder == 'DESC')
            	returnVal = returnVal * -1;
            return returnVal;
        }*/
    }
}