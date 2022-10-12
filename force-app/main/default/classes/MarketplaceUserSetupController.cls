public class MarketplaceUserSetupController {
    private static String Community_Plus_Profile{
        get{
            return String.isNotBlank(Community_Plus_Profile) ? Community_Plus_Profile : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Community_Plus_Profile');
        }set;
    }
    private static String Community_Standard_Profile{
        get{
            return String.isNotBlank(Community_Standard_Profile) ? Community_Standard_Profile : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Community_Standard_Profile');
        }set;
    }
    private static String Err_Msg_Users_Dont_Show_Reset{
        get{
            return String.isNotBlank(Err_Msg_Users_Dont_Show_Reset) ? Err_Msg_Users_Dont_Show_Reset : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','Err_Msg_Users_Dont_Show_Reset');
        }set;
    }
    private static String Err_Msg_Users_Terms_Reset{
        get{
            return String.isNotBlank(Err_Msg_Users_Terms_Reset) ? Err_Msg_Users_Terms_Reset : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','Err_Msg_Users_Terms_Reset');
        }set;
    }
    private static String Err_Msg_Select_User{
        get{
            return String.isNotBlank(Err_Msg_Select_User) ? Err_Msg_Select_User : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','Err_Msg_Select_User');
        }set;
    }
    private static String Tooltip_For_Marketplace_User_Search_Box{
        get{
            return String.isNotBlank(Tooltip_For_Marketplace_User_Search_Box) ? Tooltip_For_Marketplace_User_Search_Box : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','Tooltip_For_Marketplace_User_Search_Box');
        }set;
    }
    private static String SEARCHTERM_FILTER{
        get{
            return String.isNotBlank(SEARCHTERM_FILTER) ? SEARCHTERM_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','SearchTerm');
        }set;
    }
	@AuraEnabled(cacheable=true)
    public static AuraResponse getIds(Map<String, Object> filters){
    	AuraResponse r = new AuraResponse('MarketplaceUserSetupController.getIds()');   
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC' : 'DESC');
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Set<Id> ids = new Set<Id>();
        string queryStr = 'SELECT Id FROM User WHERE (Profile.Name =: Community_Plus_Profile OR  Profile.Name =: Community_Standard_Profile)';
        if(ProductsCtlr.hasFilter(filters, 'IsActive')){
        	Boolean status = Boolean.valueOf(filters.get('IsActive')); 
            queryStr += ' AND IsActive =: status';
        }
        
        String searchTerm = '';
        List<String> whereSearchParts = new List<String>();
        
        if(hasFilter(filters, SEARCHTERM_FILTER)){
            searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
            if(String.isNotBlank(searchTerm)){
                searchTerm = '%' + searchTerm + '%';
                whereSearchParts.add('(FirstName LIKE :searchTerm)');
                whereSearchParts.add('(LastName LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.DBA__c LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.Name LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.Type LIKE :searchTerm)');
                whereSearchParts.add('(Custom_License_Name__c LIKE :searchTerm)');
                 
            }
        }
        
        if(!whereSearchParts.isEmpty()){
            queryStr += ' AND ('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(User usr :Database.query(queryStr)){
            ids.add(usr.Id);
        }
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getUsers(List<String> ids, Map<String, Object> filters){
    	AuraResponse r = new AuraResponse('MarketplaceUserSetupController.getUsers()');
        List<userWrapper> userList = new List<userWrapper>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC' : 'DESC');
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        string queryStr = 'SELECT Id, FirstName, Custom_License_Name__c, LastName, Title, Contact.Account.DBA__c, Email, ';
        queryStr += 'Contact.Account.Type, Profile.Name, Don_t_Show_News_Again__c, Has_Accepted_Terms__c, LastLoginDate, ';
        queryStr += 'Contact.AccountId FROM User WHERE Id IN: ids';
        
        String searchTerm = '';
        List<String> whereSearchParts = new List<String>();
        
        if(hasFilter(filters, SEARCHTERM_FILTER)){
            searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
            if(String.isNotBlank(searchTerm)){
                searchTerm = '%' + searchTerm + '%';
                whereSearchParts.add('(FirstName LIKE :searchTerm)');
                whereSearchParts.add('(LastName LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.DBA__c LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.Name LIKE :searchTerm)');
                whereSearchParts.add('(Contact.Account.Type LIKE :searchTerm)');
                whereSearchParts.add('(Custom_License_Name__c LIKE :searchTerm)');
            }
        }
        
        if(!whereSearchParts.isEmpty()){
            queryStr += ' AND ('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(User usr : Database.query(queryStr)){
        	userList.add(new userWrapper(usr)); 
        }
        r.data.put('users', userList);
        r.data.put('Err_Msg_Select_User', Err_Msg_Select_User);
        r.data.put('Tooltip_For_Marketplace_User_Search_Box', Tooltip_For_Marketplace_User_Search_Box);
        return r;
    }    
    private static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }    
    @AuraEnabled
    public static AuraResponse resetUsers(Boolean resetTerms,List<String> selectedUsr){
        AuraResponse r = new AuraResponse('MarketplaceUserSetupController.resetUsersNews()');
        string queryStr = 'SELECT Id FROM User WHERE (Profile.Name =: Community_Plus_Profile OR  Profile.Name =: Community_Standard_Profile) AND  IsActive = true AND Id IN :selectedUsr';
        if(resetTerms)
            queryStr += ' AND Has_Accepted_Terms__c = true';
        else
            queryStr += ' AND Don_t_Show_News_Again__c = true';
        List<User> userList = Database.query(queryStr);
        for(User usr : userList){
            if(resetTerms)
            	usr.Has_Accepted_Terms__c = false;
            else
                usr.Don_t_Show_News_Again__c = false;                        	
        }
        update userList;
        if(resetTerms)
            r.data.put('ErrorMsg', Err_Msg_Users_Terms_Reset);
        else
            r.data.put('ErrorMsg', Err_Msg_Users_Dont_Show_Reset);
        return r;    
    }
    public class userWrapper{
    	@AuraEnabled 
        public boolean flag{get;set;}
        @AuraEnabled
        public User usr{get;set;}
        public userWrapper(User u){
            flag = false;
        	this.usr = u;    
        }
    }
}