public without sharing class NotifyApprovedRescheduleDelivery {
    
    @InvocableMethod 
    public static void notifyOnApprovedRescheduleDelivery(List<Id> orderRevisionIds){
        System.debug('##orderRevisionIds'+ orderRevisionIds);
        List<Id>brandOrderIdsIdList = new List<Id>();
        Map<String,List<Id>> odrOfOrderRevision =new Map<String,List<Id>>();
        
        for(Order_Revision__c ord : [SELECT id,Order__c FROM Order_Revision__c WHERE id IN: orderRevisionIds]){
            brandOrderIdsIdList.add(ord.Order__c);
            if(odrOfOrderRevision.containsKey(ord.Order__c)){
                List<Id> ORIds =  odrOfOrderRevision.get(ord.Order__c);
                ORIds.add(ord.id);
                odrOfOrderRevision.put(ord.Order__c,ORIds);
            }else{
                odrOfOrderRevision.put(ord.Order__c,new List<Id>{ord.id});
            }
            
        }
        
        if(brandOrderIdsIdList.size() > 0){
            Order__c[] orders = [SELECT Name,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,RecordType.Name, Retailer_Contact__c, Customer__c,Customer__r.Email, Customer__r.ContactID, Customer__r.Contact.Orders_Email_Opt_In__c,Sales_Person__c, Sales_Person__r.Orders_Email_Opt_In__c ,Sales_Person__r.Active__c  , Sales_Person__r.Email, Retailer_Contact__r.Email, Order_Date__c, Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c, (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Is_Brand_Product__c  FROM Order_Line_Items__r),(SELECT Id, Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r) FROM Order__c WHERE Id IN :brandOrderIdsIdList];
            EmailTemplate et = [Select id from EmailTemplate where DeveloperName =: Label.SendOrderRevisionDetailsToApprovedRescheduleDelivery_Email_Template limit 1]; 
            if(!orders.isEmpty()){
                List<String> listOfContactIds;
                List<String> listOfToAddresses;
                Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address =: Label.Orders_Filigreen_Email];
                for(Order__c o: orders){
                    for(Id ORId : odrOfOrderRevision.get(o.id)){
                        listOfContactIds = new List<String>();
                        listOfToAddresses = new List<String>();
                        for(Retailer_Related_Contact__c rrc : o.Retailer_Related_Contacts__r){
                            listOfContactIds.add(rrc.Contact__c);
                            if(rrc.Contact__c != null && rrc.Contact__r.Email != null) 
                                listOfToAddresses.add(rrc.Contact__r.Email);
                        } 
                        if(o.Sales_Person__c  != null && o.Sales_Person__r.Email != null && o.Sales_Person__r.Orders_Email_Opt_In__c == true  && o.Sales_Person__r.Active__c == true){
                            listOfContactIds.add(o.Sales_Person__c);
                            listOfToAddresses.add(o.Sales_Person__r.Email);
                        }
                        if(o.Retailer_Contact__c != null){
                            listOfContactIds.add(o.Retailer_Contact__c);
                            if(o.Retailer_Contact__r.Email != null) 
                                listOfToAddresses.add(o.Retailer_Contact__r.Email);
                        }
                        if(o.Additional_Brand_Contact__c != null){
                            listOfContactIds.add(o.Additional_Brand_Contact__c);
                            if(o.Additional_Brand_Contact__r.Email != null) 
                                listOfToAddresses.add(o.Additional_Brand_Contact__r.Email);
                        }
                        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                        if(o.RecordType.Name == 'Brand'){
                            if(o.Customer__c != null && o.Customer__r.Email != null){
                                listOfContactIds.add(o.Customer__c); 
                                listOfToAddresses.add(o.Customer__r.Email);
                            }
                            if(o.Customer__c != null && o.Customer__r.ContactID != null && !o.Customer__r.Contact.Orders_Email_Opt_In__c && owea.size() > 0){
                                msg.setOrgWideEmailAddressId(owea.get(0).Id);
                            }
                        }
                        else if(o.RecordType.Name == 'Transfer'){
                            list<string>ccAddressList = new List<string>();
                            list<string>bccAddressList = new List<string>();
                            ccAddressList.addAll(Label.DL_ASR.split(','));
                            msg.setCcAddresses(ccAddressList);
                        }
                        msg.setTemplateId(et.Id);
                        msg.setWhatId(ORId);
                        if(listOfContactIds.size() > 0){
                            msg.settargetObjectId(listOfContactIds[0]);    
                        }
                        msg.setToAddresses(listOfToAddresses); 
                        if(listOfToAddresses.size() > 0){
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
                        }
                    }
                }
            }
        }
        //NotifyOnNewRDT.notifyOnNewRetailerDiliveryTicket(brandOrderRevisionIdsIdList, Label.SendOrderRevisionDetailsToApprovedRescheduleDelivery_Email_Template);
    }
}