public without sharing class SettingsCtlr{
    private static String Community_Plus_Profile {
        get{
            return String.isNotBlank(Community_Plus_Profile ) ? Community_Plus_Profile  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Community_Plus_Profile');
        }set;
    }
    private static String Community_Plus_User {
        get{
            return String.isNotBlank(Community_Plus_User ) ? Community_Plus_User  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Community_Plus_User');
        }set;
    }
    private static String Customer_Community_User {
        get{
            return String.isNotBlank(Customer_Community_User ) ? Customer_Community_User  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Customer_Community_User');
        }set;
    }
    private static String Community_Standard {
        get{
            return String.isNotBlank(Community_Standard ) ? Community_Standard  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Profile','Community_Standard');
        }set;
    }
    @AuraEnabled
    public static AuraResponse getProfile(){
        AuraResponse r = new AuraResponse('Settings.getProfile()');
        
        List<UserProfile> existingUsers = new List<UserProfile>();
        
        UserProfile up = new UserProfile();
        r.data.put('profile', up);
        for(User u :[SELECT Id,FirstName, LastName, Email, Title,Account.Platform_Level__c,Account.Membership_Level__c, IsActive,AccountId, Contact.Account.Name,Contact.Primary_Contact__c ,Account.Total_Community_License__c,  Phone, MobilePhone FROM User WHERE Id = :Userinfo.getUserId()]){
            up = new UserProfile(u);
             r.data.put('platformLevel', u.Account.Platform_Level__c);
            r.data.put('membershipLevel', u.Account.Membership_Level__c);
            r.data.put('totalLicenseLimit', (u.Account.Total_Community_License__c != null?u.Account.Total_Community_License__c:0));
            r.data.put('profile', up);
            break;
        }
        
		String accountId = up.accountId;
        if(String.isNotBlank(accountId)){
            
            for(User u: [SELECT Id, FirstName, LastName,Email,IsActive,Title, UserName,AccountId, Contact.Account.Name,Contact.Primary_Contact__c ,Account.Total_Community_License__c,  Phone, MobilePhone FROM User WHERE AccountId =: accountId Order By isActive DESC]){
                existingUsers.add(new UserProfile(u));
                
            }
            Integer totalLicenseUsed = [SELECT Id FROM User WHERE AccountId =: accountId  AND IsActive = true].size();
            r.data.put('totalLicenseUsed', totalLicenseUsed);
            
          
           
            
        }
        r.data.put('existingUsers', existingUsers);
        r.data.put('isBrand', ProductsCtlr.isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse createProfile(String profileData){
        AuraResponse r = new AuraResponse('Settings.createProfile()');
        Savepoint sp = Database.setSavepoint();
        try{
            List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name IN(:Community_Plus_Profile,:Customer_Community_User)];
            User currentUser = [SELECT Account.Name,Account.dBA__c,AccountId FROM User WHERE Id = :Userinfo.getUserId()];
            UserProfile profile = (UserProfile)JSON.deserialize(profileData, UserProfile.class);
            
            String brandName = (currentUser.Account.dBA__c != null?currentUser.Account.dBA__c:currentUser.Account.Name);
            brandName = brandName.replaceAll(' ', '-');
            
            Contact con = new Contact(FirstName = profile.firstName,lastName = profile.lastName,Email = profile.email,AccountId=currentUser.AccountId,Title = profile.title);
            insert con;
            
            User u = new User();
            if(String.isNotBlank(profile.profileType)){
                if(profile.profileType == Community_Plus_User){
                    for(Profile p: profiles){
                        if(profile.profileType == Community_Plus_User && p.Name == Community_Plus_Profile){
                            u.ProfileId = p.Id;
                            break;
                        }else if(profile.profileType == Community_Standard && p.Name == Customer_Community_User){
                            u.ProfileId = p.Id;
                            break;
                        }
                    }
                }
            }
            u.firstName = profile.firstName;
            u.lastName = profile.lastName;
            u.Username = profile.email+'.'+brandName;
            u.Email = profile.email;
            u.ContactId = con.Id;
            u.Title = profile.title;
            u.CommunityNickname = profile.lastName.right(4);
            u.Alias = profile.firstName.left(4)+profile.lastName.left(4);
            u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
            u.LocaleSidKey = 'en_US'; // Required
            u.EmailEncodingKey = 'ISO-8859-1'; // Required
            u.LanguageLocaleKey = 'en_US'; // Required
            insert u;
            
            Integer totalLicenseUsed = [SELECT Id FROM User WHERE AccountId =: currentUser.AccountId AND IsActive = true].size();
            r.data.put('totalLicenseUsed', totalLicenseUsed);
        }catch(Exception e){
            Database.rollback(sp);
            r.handleException(e);
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse updateUserDetails(String userDetails){
        AuraResponse r = new AuraResponse('Settings.updateUserDetails()');
        
        List<UserProfile> existingUsers = new List<UserProfile>();
        try{
            User usr = (User) JSON.deserialize(userDetails, User.class);
            update usr;

            User currentUser = [SELECT AccountId FROM User WHERE Id = :Userinfo.getUserId()];
            for(User u: [SELECT Id, FirstName, LastName,Email,IsActive,Title, UserName,AccountId, Contact.Account.Name,Contact.Primary_Contact__c ,Account.Total_Community_License__c,  Phone, MobilePhone FROM User WHERE AccountId =: currentUser.AccountId Order By isActive DESC]){
                existingUsers.add(new UserProfile(u));   
            }
            r.data.put('existingUsers', existingUsers);
        }catch(Exception e){
            r.handleException(e);
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse updateProfile(String profileData){
        AuraResponse r = new AuraResponse('Settings.updateProfile()');
        
        UserProfile profile = (UserProfile)JSON.deserialize(profileData, UserProfile.class);
        User u = new User(Id = UserInfo.getUserId(),
                          FirstName = profile.firstName,
                          LastName = profile.lastname,
                          Title = profile.title,
                          Email = profile.email,
                          Phone = profile.phone,
                          MobilePhone = profile.mobilePhone);
        
        try{
            update u;
            r.data.put('user', new Map<String, String>{'id'=> '', 'name'=> ''});
            
            for(User userInfo :[SELECT Name FROM User WHERE Id = :Userinfo.getUserId()]){
                r.data.put('user', new Map<String, String>{'id'=> userInfo.Id, 'name'=> userInfo.Name});
                break;
            }
        }catch(Exception e){
            r.handleException(e);
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse updatePassword(String passwordData){
        AuraResponse r = new AuraResponse('Settings.updatePassword()');
        Password password = (Password)JSON.deserialize(passwordData, Password.class);
        try{
            PageReference ref = Site.changePassword(password.newPassword, password.verifyNewPassword, password.oldPassword);   
        }catch(Exception e){
            r.handleException(e);        
        }
        
        return r;
    }
    
    public class UserProfile{
        @AuraEnabled
        public String firstName{get;set;}
        @AuraEnabled
        public String Id{get;set;}
        @AuraEnabled
        public String lastName{get;set;}
        @AuraEnabled
        public String email{get;set;}
        @AuraEnabled
        public String title{get;set;}
        @AuraEnabled
        public String accountName{get;set;}
        @AuraEnabled
        public String accountId{get;set;}
        @AuraEnabled
        public String phone{get;set;}
        @AuraEnabled
        public Boolean isActive{get;set;}
        @AuraEnabled
        public String mobilePhone{get;set;}
        @AuraEnabled
        public Boolean isPrimaryContact{get;set;}
        @AuraEnabled
        public String profileType{get;set;}
        public UserProfile(){
            this.firstName = UserInfo.getFirstName();
            this.lastName = UserInfo.getLastName();
            this.email = UserInfo.getUserEmail();
            this.accountName = '';
            this.title = '';
            this.isPrimaryContact = false;
        }
        
        public UserProfile(User u){
            this.Id = u.Id;
            this.firstName = u.FirstName;
            this.lastName = u.LastName;
            this.email = u.Email;
            this.title = u.Title;
            this.isActive = u.IsActive;
            this.accountName = u.Contact.Account.Name;
            this.phone = u.Phone;
            this.mobilePhone = u.MobilePhone;
            this.accountId = u.AccountId;
            this.isPrimaryContact = u.Contact.Primary_Contact__c;
        }
    }
    
    public class Password{
        public String newPassword{get;set;}
        public String verifyNewPassword{get;set;}
        public String oldPassword{get;set;}
    }
    
}