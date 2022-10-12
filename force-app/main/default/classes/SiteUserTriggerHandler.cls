public class SiteUserTriggerHandler {

    public static void updateAssignedWarehouseIdsOnUser(Site_User__c[] newSiteUsers, Map<Id,Site_User__c> oldSiteUsers){
        Set<Id> userIds = new Set<Id>();
        Set<Id> activeSUserIds = new Set<Id>();
        Set<Id> inactiveSUserIds = new Set<Id>();
        User[] users = new User[]{};
        if(Trigger.isUpdate){
            for(Site_User__c siteUser: newSiteUsers){
                if(siteUser.Active__c == true && siteUser.Site__c != null && oldSiteUsers.get(siteUser.Id).Site__c != siteUser.Site__c){
                    activeSUserIds.add(siteUser.User__c);
                }else if(siteUser.Active__c == true && oldSiteUsers.get(siteUser.Id).User__c != siteUser.User__c){
                    activeSUserIds.add(siteUser.User__c);
                    inactiveSUserIds.add(oldSiteUsers.get(siteUser.Id).User__c);
                }else{
                    inactiveSUserIds.add(siteUser.User__c);
                }
            }
        }else{
            for(Site_User__c siteUser: newSiteUsers){
                if(siteUser.Active__c == true){
                    activeSUserIds.add(siteUser.User__c);
                }
            }
        }
        Map<Id, Set<String>> userAssignedSites = new Map<Id, Set<String >>();
        Site_User__c[] siteUsers = [SELECT Id, Site__c, User__c FROM Site_User__c WHERE (User__c IN : activeSUserIds OR User__c IN :inactiveSUserIds) AND Active__c = true];
        if(siteUsers.size() > 0){
            for(Site_User__c su: siteUsers){
                if(userAssignedSites.containsKey(su.User__c)){
                    userAssignedSites.get(su.User__c).add(su.Site__c);
                }else{
                    userAssignedSites.put(su.User__c, new Set<String >{su.Site__c});
                }
            }
        }else{
            for(Id userId: activeSUserIds){
                users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = ''));
            }
            for(Id userId: inactiveSUserIds){
                users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = ''));
            }
        }
        
        if(!userAssignedSites.isEmpty()){
            
            for(Id userId: activeSUserIds){
                if(userAssignedSites.containsKey(userId)){
                    List<String> siteIds = new List<String>(userAssignedSites.get(userId));
                    users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = String.join(siteIds,',')));
                }else{
                    users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = ''));
                }
            }
            for(Id userId: inactiveSUserIds){
                if(userAssignedSites.containsKey(userId)){
                    List<String> siteIds = new List<String>(userAssignedSites.get(userId));
                    users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = String.join(siteIds,',')));
                }else{
                    users.add(new User(Id = userId,Assigned_Warehouse_Ids__c = ''));
                }
            }
            
        }
        if(!users.isEmpty()){
            update users;
        }
    }
}