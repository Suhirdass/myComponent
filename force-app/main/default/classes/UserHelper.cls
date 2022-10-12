public class UserHelper {
    private static String Portal_Login_Type_Standard{
        get{
            return String.isNotBlank(Portal_Login_Type_Standard) ? Portal_Login_Type_Standard : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Contact','Portal_Login_Type_Standard');
        }set;
    }
    private static String Portal_Login_Type_Community_Plus{
        get{
            return String.isNotBlank(Portal_Login_Type_Community_Plus) ? Portal_Login_Type_Community_Plus : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Contact','Portal_Login_Type_Community_Plus');
        }set;
    }
    public static void portalLoginTypeUpdate(List<User>users,Map<Id,User> oldMap){
        List<Contact> conList = new List<Contact>();
        for(user u :users){
            if((Trigger.isInsert || (Trigger.isUpdate && (u.IsActive != oldMap.get(u.Id).IsActive || u.ProfileId != oldMap.get(u.Id).ProfileId))) && u.ContactId != NULL){
                Contact con = new Contact(Id=u.ContactId);
                con.Portal_Login_Type__c = u.IsActive == false?null:(u.User_License__c == 'Customer Community Plus' ? Portal_Login_Type_Community_Plus : Portal_Login_Type_Standard);
                conList.add(con);
            }
            
        }
        if(conList.size()>0)
            updateContacts(JSON.serialize(conList));
    }
    public static void onBeforeInsertUpdate(List<User>users,Map<Id,User> oldMap){
        for(user u :users){
            if(u.Has_Accepted_Terms__c == True && (Trigger.isInsert || (Trigger.isUpdate && u.Has_Accepted_Terms__c != oldMap.get(u.Id).Has_Accepted_Terms__c))){
                u.Terms_Accepted_Date__c = system.now();
            }
        }        
    }
    @future
    public static void updateContacts(String conJSON){
        List<Contact> contacts = (Contact[])JSON.deserialize(conJSON, Contact[].class);
        if(contacts.size()>0){
            update contacts;
        }
    }
}