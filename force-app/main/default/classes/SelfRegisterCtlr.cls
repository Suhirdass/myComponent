public without sharing class SelfRegisterCtlr {
    public String firstName{get;set;}
    public String lastName{get;set;} 
    public String companyName{get;set;}
    public String title{get;set;}
    public String email{get;set;}
    public String phone{get;set;}
    public String licenseNumber{get;set;}
    public Boolean flag{get;set;}
    public Boolean response{get;set;}
    transient  public Attachment fileData {
        get {
            if (fileData == null)
                fileData = new Attachment();
            return fileData;
        }
        set;
    }
    
    public SelfRegisterCtlr(){
        flag = false;
    }
    
    public Pagereference saveRegistrationDetails(){
        System.debug('In function');
        User_Self_Registration__c userData = new User_Self_Registration__c();
        userData.First_Name__c = firstName;
        userData.Last_Name__c = lastName;
        userData.Company_Name_DBA__c = companyName;
        userData.Title__c = title;
        userData.Email__c = email;
        userData.Phone_Number__c = phone;
        userData.State_License_Number__c  = licenseNumber;
        userData.Response__c  = response;
        try{
            insert userData;  
            fileData.OwnerId = UserInfo.getUserId();
            fileData.ParentId = userData.Id;//Record Id the file is attached to
            fileData.IsPrivate = true;
            fileData.ContentType = 'image/jpeg';
            if(fileData.name != null && fileData.body != null){
            	insert fileData;    
            }
            flag = true;
        	PageReference pr = new PageReference('/s/registrationsuccessfull');
        	pr.setRedirect(true);
        	return pr;
        }catch(Exception ex){
            System.debug(ex.getMessage());
        }
        return null;
    }
    @AuraEnabled
    public static AuraResponse registerNewUser(String firstName,String lastName,
                                 String dbaName,String phone,String email,
                                 String title,String stateLicense,Boolean sendMeCopy) {
        AuraResponse r = new AuraResponse('SelfRegisterCtlr.registerNewUser()');
        System.debug('##sendMeCopy:'+sendMeCopy);
        User_Self_Registration__c userData = new User_Self_Registration__c();
        userData.First_Name__c = firstName;
        userData.Last_Name__c = lastName;
        userData.Company_Name_DBA__c = dbaName;
        userData.Title__c = title;
        userData.Email__c = email;
        userData.Phone_Number__c = phone;
        userData.State_License_Number__c  = stateLicense;
        userData.Response__c  = sendMeCopy;
                                     
        try{
            insert userData; 
            sendEmail(userData.Id,false,false,'','','');
            if(sendMeCopy)
            	sendEmail(userData.Id,true,false,'','','');
        	r.data.put('id', userData.Id);
        }catch(Exception ex){
            r.data.put('flag', false);
            r.data.put('error', ex.getMessage());
        }
        return r;                                        
     }
    
    @AuraEnabled
    public static AuraResponse saveTheFile(String firstName,String lastName,
                                 String dbaName,String phone,String email,
                                 String title,String stateLicense,Boolean sendMeCopy,
                                 String fileName,String base64Data, String contentType) {
        AuraResponse r = new AuraResponse('SelfRegisterCtlr.saveTheFile()');
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 		System.debug('##sendMeCopy:'+sendMeCopy);
		System.debug('In function');
        User_Self_Registration__c userData = new User_Self_Registration__c();
        userData.First_Name__c = firstName;
        userData.Last_Name__c = lastName;
        userData.Company_Name_DBA__c = dbaName;
        userData.Title__c = title;
        userData.Email__c = email;
        userData.Phone_Number__c = phone;
        userData.State_License_Number__c  = stateLicense;
        userData.Response__c  = sendMeCopy;
        try{
            insert userData;  
            Attachment oAttachment = new Attachment();
            //oAttachment.OwnerId = UserInfo.getUserId();
            oAttachment.ParentId = userData.Id;//Record Id the file is attached to
            oAttachment.IsPrivate = true;
            oAttachment.Body = EncodingUtil.base64Decode(base64Data);
            oAttachment.Name = fileName;
            oAttachment.ContentType = contentType;
            insert oAttachment;
            sendEmail(userData.Id,false,true,fileName,base64Data,contentType);
            if(sendMeCopy)
            	sendEmail(userData.Id,true,true,fileName,base64Data,contentType);
            Boolean flag = true;
        	r.data.put('flag', flag);
        }catch(Exception ex){
            r.data.put('flag', false);
            r.data.put('error', ex.getMessage());
        }
        return r;                             
    }
    public static void sendEmail(String UserSelfRegId, Boolean isResponse, Boolean hasAttachment,String fileName, String base64Data, String contentType){
        List<User_Self_Registration__c>userList = [select id,Company_Name_DBA__c,First_Name__c,Last_Name__c,Title__c,Email__c,
        Phone_Number__c,State_License_Number__c from User_Self_Registration__c where id =: UserSelfRegId];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        list<Messaging.EmailFileAttachment>attachmentList = new list<Messaging.EmailFileAttachment>();
        system.debug('UserSelfRegId :'+UserSelfRegId);
        if(hasAttachment){
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(fileName);
            efa.setBody(EncodingUtil.base64Decode(base64Data));
            efa.setContentType(contentType);
            efa.setInline(false);
            attachmentList.add(efa);
        }
        
        list<string>toAddList = new List<string>();
        if(!isResponse){
            for(user usr : [select id, name, email, isactive, profile.name, userrole.name, usertype from user where id in (select userorgroupid from groupmember where group.developername =: Label.New_User_Self_Registration)]){
                toAddList.add(usr.email);    
            }
        }else{
            toAddList.add(userList[0].Email__c);
        }
        if(attachmentList.size()>0){
            email.setFileAttachments(attachmentList);
        }
        
        string emailBody = '<div style="background-color:#065E66;height:50px;min-width:383px;"></div><div style="background-color:#065E66;min-width:383px;"><table style="margin: 0 auto;background-color: rgb(255,255,255);color: rgb(0,0,0);font-size: 12.0pt;"><tr><td>';
        emailBody += 'Hi '+(isResponse?userList[0].First_Name__c + ' ' + userList[0].Last_Name__c:'Team')+',</td></tr><tr><td style="padding:5px;">';
        emailBody += (isResponse?'Successfully Submitted Self Registration Form for B2B.':'New User registered using marketplace self-registration form.')+'</td></tr><tr><td style="padding:5px;">';
        emailBody += 'Company & DBA Name: '+ userList[0].Company_Name_DBA__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'First Name: ' + userList[0].First_Name__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'Last Name: ' + userList[0].Last_Name__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'Title: ' + userList[0].Title__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'Email: ' + userList[0].Email__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'Phone Number: ' + userList[0].Phone_Number__c + '</td></tr><tr><td style="padding:5px;">';
        emailBody += 'State License Number: ' + userList[0].State_License_Number__c + '</td></tr><tr><td style="padding:5px;">';
        if(!isResponse){
            emailBody += 'Record URL: <a href="' +System.Label.Org_URL/*URL.getSalesforceBaseUrl().toExternalForm()+'/'*/+userList[0].Id+ '">'+System.Label.Org_URL/*URL.getSalesforceBaseUrl().toExternalForm()+'/'*/+userList[0].Id+'</td></tr><tr><td>';
        }
        emailBody += 'Thanks,<br>Marketplace Team</td></tr></table></div>';
        if(!isResponse){
            email.setSubject('New user registration has been submitted via Marketplace');
        }else{
            email.setSubject('Successfully Submitted Filigreen Self Registration Form for B2B');
        }
        email.setHtmlBody(emailBody);
        email.setToAddresses(toAddList);
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
    }
    @AuraEnabled
    public static AuraResponse saveTheFile(String recordId,String fileName,
                                 String base64Data, String contentType) {
        AuraResponse r = new AuraResponse('SelfRegisterCtlr.saveTheFile()');
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
		System.debug('In function');
        
        try{
            Attachment oAttachment = new Attachment();
            //oAttachment.OwnerId = UserInfo.getUserId();
            oAttachment.ParentId = recordId;//Record Id the file is attached to
            oAttachment.IsPrivate = true;
            oAttachment.Body = EncodingUtil.base64Decode(base64Data);
            oAttachment.Name = fileName;
            oAttachment.ContentType = contentType;
            insert oAttachment;
            Boolean flag = true;
        	r.data.put('flag', flag);
        }catch(Exception ex){
            r.data.put('flag', false);
            r.data.put('error', ex.getMessage());
        }
        return r;                             
    }
}