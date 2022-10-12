public without sharing class NotifyOnNewRDT {
    private Static String ORDER_TYPE_BRAND {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Brand');
        }set;
    }
    public Static String ORDER_TYPE_TRANSFER {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    @InvocableMethod 
	public static void notifyOnNewRTD(List<Id> orderIds){
        List<Id>transferOrderIdList = new List<Id>();
        List<Id>brandOrderIdList = new List<Id>();
        List<Id>brandOrderIdSample = new List<Id>();
         system.debug('##enter notifyOnNewRTD');
        for(Order__c ord : [select id,recordType.Name,Sample_Order__c,Retailer__r.Third_Party_Scheduler__c,isPreapproved__c,Piggyback_sample__c,(SELECT Id,Is_Sample__c FROM Order_Line_Items__r) from order__c where id IN: orderIds]){
        	if(ord.recordType.Name == ORDER_TYPE_TRANSFER && ord.Sample_Order__c == false)
                transferOrderIdList.add(ord.id);
            else if((ord.recordType.Name == ORDER_TYPE_BRAND && ((!ord.Sample_Order__c && !ord.Retailer__r.Third_Party_Scheduler__c) || ord.isPreapproved__c == true))
                    ||(ord.recordType.Name == ORDER_TYPE_TRANSFER && ord.Sample_Order__c == true && ord.isPreapproved__c == true) || 
                    (ord.recordType.Name == ORDER_TYPE_TRANSFER && ord.Sample_Order__c == true && ord.isPreapproved__c == false && ord.Retailer__r.Third_Party_Scheduler__c == false && ord.Piggyback_sample__c == false))
                brandOrderIdList.add(ord.id);
            else if((ord.recordType.Name == ORDER_TYPE_BRAND  && (ord.Sample_Order__c  || ord.Retailer__r.Third_Party_Scheduler__c)) || (  ord.recordType.Name == ORDER_TYPE_TRANSFER && ord.Sample_Order__c == true)){
                brandOrderIdSample.add(ord.id); 
            }
        }
        if(transferOrderIdList.size() > 0)
            notifyOnNewRetailerDiliveryTicket(transferOrderIdList, Label.SendTransferOrderDetailsToRetailerContact_Email_Template);
        
        if(brandOrderIdSample.size() > 0)
        	notifyOnNewRetailerDiliveryTicket(brandOrderIdSample, Label.SendRetailerOrderDetailsToRetailerSample_Email_Template);
        else if(brandOrderIdList.size() > 0)
        	notifyOnNewRetailerDiliveryTicket(brandOrderIdList, Label.SendOrderDetailsToRetailerContact_Email);
    }
    
    public static void notifyOnNewRetailerDiliveryTicket(List<Id> orderIds, String emailTemplateName){
        Order__c[] orders = [SELECT Name,Additional_Brand_Contact__c,Retailer__r.Third_Party_Scheduler__c,Request_Ship_Date__c,Requested_Delivery_Earliest_Time__c,Requested_Delivery_Latest_Time__c,isPreapproved__c,Additional_Brand_Contact__r.Email,RecordType.Name, Retailer_Contact__c, Customer__c,Customer__r.Email, Customer__r.ContactID, Customer__r.Contact.Orders_Email_Opt_In__c,Sales_Person__c, Sales_Person__r.Orders_Email_Opt_In__c ,Sales_Person__r.Active__c  , Sales_Person__r.Email, Retailer_Contact__r.Email, Order_Date__c, Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c,State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c, (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Is_Brand_Product__c  FROM Order_Line_Items__r),(SELECT Id, Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r) FROM Order__c WHERE Id IN :orderIds];
        EmailTemplate et = [Select id from EmailTemplate where DeveloperName =: emailTemplateName limit 1]; 
        List<Document> doc = new List<Document>();
            doc = [SELECT Id, Name, Body, ContentType, DeveloperName, Type FROM Document WHERE DeveloperName =: 'X8300'];
        
        
        if(!orders.isEmpty()){
            List<String> listOfContactIds;
            List<String> listOfToAddresses;
            List<String> ccEmails;
            List<String> listOfBCCAddresses = new List<String>();
            listOfBCCAddresses.addAll(Label.Brand_BCC_Addresses.split(','));
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address =: Label.Orders_Filigreen_Email];
            for(Order__c o: orders){
                listOfContactIds = new List<String>();
                listOfToAddresses = new List<String>();
                ccEmails = new List<String>();
                for(Retailer_Related_Contact__c rrc : o.Retailer_Related_Contacts__r){
                    listOfContactIds.add(rrc.Contact__c);
                    if(rrc.Contact__c != null && rrc.Contact__r.Email != null) 
                        listOfToAddresses.add(rrc.Contact__r.Email);
                } 
                if(o.Sales_Person__c  != null && o.Sales_Person__r.Email != null && o.Sales_Person__r.Orders_Email_Opt_In__c == true  && o.Sales_Person__r.Active__c == true){
                    listOfContactIds.add(o.Sales_Person__c);
                    ccEmails.add(o.Sales_Person__r.Email);
                }
                if(o.Retailer_Contact__c != null){
                    listOfContactIds.add(o.Retailer_Contact__c);
                    if(o.Retailer_Contact__r.Email != null) 
                        listOfToAddresses.add(o.Retailer_Contact__r.Email);
                }
                if(o.Additional_Brand_Contact__c != null){
                    listOfContactIds.add(o.Additional_Brand_Contact__c);
                    if(o.Additional_Brand_Contact__r.Email != null) 
                        ccEmails.add(o.Additional_Brand_Contact__r.Email);
                }
                Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                if(o.RecordType.Name == ORDER_TYPE_BRAND){
                    if(o.Customer__c != null && o.Customer__r.Email != null){
                        listOfContactIds.add(o.Customer__c); 
                        listOfToAddresses.add(o.Customer__r.Email);
                    }
                    if(o.Customer__c != null && o.Customer__r.ContactID != null && !o.Customer__r.Contact.Orders_Email_Opt_In__c && owea.size() > 0){
                    	msg.setOrgWideEmailAddressId(owea.get(0).Id);
                	}
                    if(ccs.RDT_CC_Email__c != null){
                    	ccEmails.addAll(ccs.RDT_CC_Email__c.split(','));
                	}
                }
                else if(o.RecordType.Name == ORDER_TYPE_TRANSFER){
                    list<string>ccAddressList = new List<string>();
                    list<string>bccAddressList = new List<string>();
                    
                    if(o.Customer__c != null && o.Customer__r.Email != null){
                        listOfToAddresses.add(o.Customer__r.Email);
                    }
                    
                    //if(o.Additional_Brand_Contact__c != null && o.Additional_Brand_Contact__r.Email != null)
                    	//ccAddressList.add(o.Additional_Brand_Contact__c);
                    ccEmails.addAll(Label.DL_ASR.split(','));
                    //bccAddressList.addAll(Label.Brand_BCC_Addresses.split(','));
                    msg.setCcAddresses(ccAddressList);
                    //msg.setBccAddresses(bccAddressList);
                }
                msg.setTemplateId(et.Id);
                msg.setWhatId(o.Id);
                if(listOfContactIds.size() > 0){
                	msg.settargetObjectId(listOfContactIds[0]);    
                }
                
                ccEmails.addAll(Label.Orders_Filigreen_Email.split(','));
                
                msg.setCcAddresses(ccEmails);
                /*if(doc.size() > 0 && o.isPreapproved__c && Label.SendOrderDetailsToRetailerContact_Email == emailTemplateName ){
                    //Create Email file attachment from document
                    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                    attach.setContentType(doc[0].ContentType);
                    attach.setFileName(doc[0].DeveloperName+'.'+doc[0].Type);
                    attach.setInline(false);
                    attach.Body = doc[0].Body;
                    
                    msg.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });//Set File Attachment
                }*/
                msg.setToAddresses(listOfToAddresses); 
                
                //msg.setBccAddresses(listOfBCCAddresses);
                if(listOfToAddresses.size() > 0){
                    if(!o.isPreapproved__c || (o.isPreapproved__c && o.Request_Ship_Date__c != null)){
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
                    }
                    
                }
            }
        }
    }
}