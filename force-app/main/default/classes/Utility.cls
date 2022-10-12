public without sharing class Utility {
    
    public static User loggedInUser = [SELECT AccountId,ContactId,Account.Platform_Level__c,Account.DBA__c, Account.Type, Account.Name, Contact.Account.Community_Price_Book__c FROM USER where Id=:UserInfo.getUserId()];
    
    @AuraEnabled
    public static void logout(){
        ApexPages.PageReference lgn = new ApexPages.PageReference(Site.getBaseUrl() + '/secur/logout.jsp');
        Aura.redirect(lgn);
    }
    
    
    public static Map<String, String> getBrandPriceBooks(){
        Map<String, String> brandPriceBooks = new Map<String, String>();
        for(Line_Card__c lineCard:[SELECT Community_Price_Book__c,Retailer_Excluded__c , Brand_Name__c FROM Line_Card__c WHERE Retailer_Name__c = :loggedInUser.AccountId]){
            if(lineCard.Community_Price_Book__c != null && !lineCard.Retailer_Excluded__c ){
                brandPriceBooks.put(lineCard.Brand_Name__c, lineCard.Community_Price_Book__c);
            }
        }
        return brandPriceBooks;
    }
    public static Map<String, String> distyBrandPriceBooks{
        get{
            if(distyBrandPriceBooks ==  null){
                distyBrandPriceBooks = new Map<String, String>();
                for(Disty_Brand_Relationship__c DBR :[SELECT Contact__c, Brand__c,Brand__r.Community_Price_Book__c, Active__c FROM Disty_Brand_Relationship__c WHERE Active__c = true AND Contact__c =: loggedInUser.ContactId]){
                    distyBrandPriceBooks.put(DBR.Brand__c,DBR.Brand__r.Community_Price_Book__c);
                }
            }
            return distyBrandPriceBooks;
        }set;
    }
    public static Set<String> hybridPriceBooks{
        get{
            if(hybridPriceBooks == null){
                hybridPriceBooks = new Set<String>();
                
                if(ProductsCtlr.isHybrid){
                    for(Account account: [SELECT Community_Price_Book__c FROM Account WHERE ParentId = :Utility.loggedInUser.AccountId AND Community_Price_Book__c != null]){
                        hybridPriceBooks.add(account.Community_Price_Book__c);
                    }
                }
            }
            return hybridPriceBooks;
        }set;
    }
    
    @AuraEnabled
    public static AuraResponse hasAccepted(){
        AuraResponse r = new AuraResponse('Utility.hasAccepted()');
        try{
            User u = new User(Id = UserInfo.getUserId(), Has_Accepted_Terms__c = true);
            update u;
        }catch(Exception e){
            r.handleException(e);
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse init(){
        AuraResponse r = new AuraResponse('Utility.init()');
        r = ProductsCtlr.getCartItems();
        r.data.put('user', new Map<String, String>{'id'=> '', 'name'=> ''});
        for(User u :[SELECT Name FROM User WHERE Id = :Userinfo.getUserId()]){
            r.data.put('user', new Map<String, String>{'id'=> u.Id, 'name'=> u.Name});
            break;
        }
        
        r.data.put('baseUrl', Site.getBaseUrl());
        
        return r;
    }
    
    public static Integer getCartTotal(){
        Integer total = 0;
        for(AggregateResult ar :[SELECT COUNT(ID) total FROM Order_Line_Item__c WHERE Order__r.Customer__c = :Userinfo.getUserId()  AND Order__r.Status__c = :'Draft' GROUP BY Order__c]){
            total = Integer.valueOf(ar.get('total'));
        }
        return total;
    }
    
    public static List<Map<String, String>> getPicklistItems(String objectAPIName, String fieldAPIName){
        List<Map<String, String>> options = new List<Map<String, String>>();
        
        SObjectType objectType = Schema.getGlobalDescribe().get(objectAPIName);
        for (Schema.PicklistEntry pickListValue : objectType.getDescribe().fields.getMap().get(fieldAPIName).getDescribe().getPickListValues()) {
            options.add(new Map<String, String>{'label'=> pickListValue.getLabel(), 'value'=> pickListValue.getValue()});
        }
        return options;
    }
    
    public class MyPickListInfo{
        public String validFor;
    }
    
    public static Map<String, List<String>> getFieldDependencies(String objectName, String controllingField, String dependentField){
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>();
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        
        Schema.DescribeSObjectResult describeResult = objType.getDescribe();
        Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
        Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get(dependentField).getDescribe();
        
        List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();
        
        for(Schema.PicklistEntry currControllingValue : controllingValues)
        {
            System.debug('ControllingField: Label:' + currControllingValue.getLabel());
            controllingInfo.put(currControllingValue.getLabel(), new List<String>());
        }
        
        for(Schema.PicklistEntry currDependentValue : dependentValues)
        {
            String jsonString = JSON.serialize(currDependentValue);
            
            MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);
            
            String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();
            
            System.debug('DependentField: Label:' + currDependentValue.getLabel() + ' ValidForInHex:' + hexString + ' JsonString:' + jsonString);
            
            Integer baseCount = 0;
            
            for(Integer curr : hexString.getChars())
            {
                Integer val = 0;
                
                if(curr >= 65)
                {
                    val = curr - 65 + 10;
                }
                else
                {
                    val = curr - 48;
                }
                
                if((val & 8) == 8)
                {
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 0].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 0].getLabel()).add(currDependentValue.getLabel());
                }
                if((val & 4) == 4)
                {
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 1].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 1].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 2) == 2)
                {
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 2].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 2].getLabel()).add(currDependentValue.getLabel());                    
                }
                if((val & 1) == 1)
                {
                    System.debug('Dependent Field: ' + currDependentValue.getLabel() + ' Partof ControllingField:' + controllingValues[baseCount + 3].getLabel());
                    controllingInfo.get(controllingValues[baseCount + 3].getLabel()).add(currDependentValue.getLabel());                    
                }
                
                baseCount += 4;
            }            
        } 
        
        System.debug('ControllingInfo: ' + controllingInfo);
        
        return controllingInfo;
    }
    public static string escapespecialchar(string data){
       if(data != null && data.containsAny('&')){
            data = data.replace('&','&amp;');       
        }  if(data != null && data.containsAny('\'')){
            data = data.replace('\'','&apos;');       
        }  if(data != null && data.containsAny('"')){
            data = data.replace('"','&quot;');       
        }  if(data != null && data.containsAny('.')){
            data = data.replace('.','&#46;');       
        }  if(data != null && data.containsAny('-')){
            data = data.replace('-','&#45;');       
        }  if(data != null && data.containsAny(',')){
            data = data.replace(',','&#44;');       
        }

       
        system.debug('datavalues>>'+ data);
     return  data;
    }
    
    /*@InvocableMethod
public static void notifyOnNewRetailerDiliveryTicket(List<Id> orderIds){
Order__c[] orders = [SELECT Name, Retailer_Contact__c, Customer__c,Customer__r.Email, Customer__r.ContactID, Customer__r.Contact.Orders_Email_Opt_In__c, Retailer_Contact__r.Email, Order_Date__c, Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c, (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Is_Brand_Product__c  FROM Order_Line_Items__r),(SELECT Id, Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r) FROM Order__c WHERE Id IN :orderIds];
EmailTemplate et = [Select id from EmailTemplate where DeveloperName =: Label.SendOrderDetailsToRetailerContact_Email limit 1];

if(!orders.isEmpty()){
List<String> listOfContactIds;
List<String> listOfToAddresses;
Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address =: Label.Orders_Filigreen_Email];
for(Order__c o: orders){
listOfContactIds = new List<String>();
listOfToAddresses = new List<String>();
for(Retailer_Related_Contact__c rrc : o.Retailer_Related_Contacts__r){
listOfContactIds.add(rrc.Contact__c);
if(rrc.Contact__c != null && rrc.Contact__r.Email != null)
listOfToAddresses.add(rrc.Contact__r.Email);
}
if(o.Retailer_Contact__c != null){
listOfContactIds.add(o.Retailer_Contact__c);
if(o.Retailer_Contact__r.Email != null)
listOfToAddresses.add(o.Retailer_Contact__r.Email);
}
if(o.Customer__c != null && o.Customer__r.Email != null){
listOfContactIds.add(o.Customer__c);
listOfToAddresses.add(o.Customer__r.Email);
}
Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
if(o.Customer__c != null && o.Customer__r.ContactID != null && !o.Customer__r.Contact.Orders_Email_Opt_In__c && owea.size() > 0){
msg.setOrgWideEmailAddressId(owea.get(0).Id);
}
msg.setTemplateId(et.Id);
msg.setWhatId(o.Id);
if(listOfContactIds.size() > 0){
msg.settargetObjectId(listOfContactIds[0]);
}
msg.setToAddresses(listOfToAddresses);
if(ccs.RDT_CC_Email__c != null){
msg.setCcAddresses(ccs.RDT_CC_Email__c.split(','));
}
if(listOfToAddresses.size() > 0){
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
}
}
}
}*/
}