@isTest
public class Metrc_TestdataFactory {
    public static User createUser(string userName,ID profId,String email){
        User tuser = new User(  firstname = 'tuserFname',
                            lastName = 'tuserLastname',
                            email = email,
                            Username = userName,
                            EmailEncodingKey = 'ISO-8859-1',
                            Alias ='tuser',
                            TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey = 'en_US',
                            LanguageLocaleKey = 'en_US',
                            ProfileId = profId);
        return tuser;
    }
    public static List<Metrc_IntegrationSettings__C> createIntegrationSettingData(){
        List<Metrc_IntegrationSettings__C> customsettingList = new List<Metrc_IntegrationSettings__C>();
        Metrc_IntegrationSettings__C obj1 = new Metrc_IntegrationSettings__C();
        obj1.Name='Endpoint';
        obj1.Value__c='https://api-ca.metrc.com/test';
        
        Metrc_IntegrationSettings__C obj2 = new Metrc_IntegrationSettings__C();
        obj2.Name='VendorAPIKey';
        obj2.Value__c='DASEQWEQWDASDAS';
        
        Metrc_IntegrationSettings__C obj3 = new Metrc_IntegrationSettings__C();
        obj3.Name='UserAPIKey';
        obj3.Value__c='sDwqeqwedQWDD';
        
        Metrc_IntegrationSettings__C obj4 = new Metrc_IntegrationSettings__C();
        obj4.Name='LicenseNumber';
        obj4.Value__c='ASDASDASDAS';
        Metrc_IntegrationSettings__C obj5 = new Metrc_IntegrationSettings__C();
        obj5.Name='Metrc_Alert';
        obj5.Value__c='testuser@gmail.com,testuser2@gmail.com';
        
        customsettingList.add(obj1);
        customsettingList.add(obj2);
        customsettingList.add(obj3);
        customsettingList.add(obj4);
         customsettingList.add(obj5);
        //INSERT customsettingList;
        return customsettingList;
    }
    Public static Strain__c createStrain(){
        Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true, Metrc_StrainID__c ='205872');
        return st;
    }
    Public static Product2 createProduct(ID StrainID){
        Recordtype recordtype =[select Id ,name from recordtype where DeveloperName ='Product'  and SobjectType ='Product2' limit 1];
        Product2 ProductObj = new Product2();
        ProductObj.Name ='Test Metrc';
        ProductObj.Description ='Test Metrc';
        ProductObj.Product_Short_Description__c='Test Metrc';
        ProductObj.Track_Trace_Category__c ='Capsule';
        ProductObj.Net_Weight_UOM__c='EA';
        ProductObj.Unit_Net_Weight__c=100;
        ProductObj.recordtypeID=recordtype.ID;
        ProductObj.Quantity_Type__c='Quantity';
        ProductObj.Family='Accessories';
        ProductObj.Strain__C=StrainID;
        return  ProductObj;
    }
    }