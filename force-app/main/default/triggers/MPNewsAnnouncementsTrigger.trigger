trigger MPNewsAnnouncementsTrigger on MP_News_Announcements__c (Before insert,Before update) {
    Boolean updateAllUsers = false;
    for(MP_News_Announcements__c news : trigger.new){
        if(trigger.isInsert || (trigger.isUpdate && news.News_Details__c != trigger.oldMap.get(news.id).News_Details__c)){
        	updateAllUsers = true;    
            break;
        }        	
    }
    if(updateAllUsers){
        profile p = [select Id, Name from Profile where name ='Customer Community Plus User Custom'];
        list<User>usrList = [select id from User where profileId =: p.id AND Don_t_Show_News_Again__c = true];
        for(User usr : usrList){
            usr.Don_t_Show_News_Again__c = false;
        }
        update usrList;
    }
}