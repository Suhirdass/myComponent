@isTest
public class ReportsAndDashBoardControllerTest {
    public static testmethod void runTest(){
        Account acc = new Account();
        acc.Name = 'test acc';
        insert acc;
        
        Contact con = new Contact();
        con.firstName = 'test';
        con.LastName = 'Con';
        con.email = 'test@test.com';
        con.AccountId = acc.id;
        insert con;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        
        User u = new User(alias = 'standt', email=con.email,emailencodingkey='UTF-8', lastname=con.lastname,
			firstname=con.firstname, languagelocalekey='en_US',localesidkey='en_US', profileid = p.Id, contactId=con.Id,
			timezonesidkey='America/Los_Angeles',username=con.email);
        u.setOptions(dmo);
        insert u;
        
		 
        
        System.runAs(u) {                         
            Map<String, Object> filters = new Map<String, Object> {'orderByField' =>'Description', 'isASC' => true,'searchTerm' =>'Product'};
			AuraResponse r = ReportsAndDashBoardController.getRecentReportsIds(filters);
            
			List<String> ids = new List<String>();
            list<Id> ids2 = (list<Id>)r.data.get('ids');
            for(Id reportId : ids2){
            	ids.add(reportId);  
            }
            system.debug('--ids--'+ids);
			r = ReportsAndDashBoardController.getReports(ids,filters);
            r = ReportsAndDashBoardController.getReportsIds(filters); 
            r = ReportsAndDashBoardController.getRecentDashboardIds(filters); 
            Set<Id> idsSet = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            /*for(Id idStr : idsSet){
                idsList.add(idStr);
            }*/
            r = ReportsAndDashBoardController.getDashboards(idsList,filters);
            r = ReportsAndDashBoardController.getDashboardIds(filters);
            ReportsAndDashBoardController.hasListFilter(filters,'t');
            
		}
	}
}