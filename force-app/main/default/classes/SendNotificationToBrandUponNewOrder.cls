/** Test Class: ProductsCtlrTest */
public class SendNotificationToBrandUponNewOrder {
	@InvocableMethod 
	public static void notifyOnNewRetailerOrder(List<Id> orderIds){
        System.debug('###notifyOnNewRetailerOrder...');
        Order__c[] orders = [SELECT Name, Retailer_Contact__c,Retailer_PO__c,Retailer_Contact__r.Name, Payment_Terms__c,Customer__c,Customer__r.Name,Customer__r.Email, Customer__r.ContactID, Customer__r.Contact.Orders_Email_Opt_In__c, Retailer_Contact__r.Email,Retailer__r.DBA__c,Retailer__r.Phone , Order_Date__c, Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c, 
                             (SELECT Name,Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.Licensee_Name__r.Name,Product__r.White_Labelled__c, Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,
                              Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Is_Brand_Product__c  FROM Order_Line_Items__r),(SELECT Id, Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r) FROM Order__c WHERE Id IN :orderIds];
        Map<Id,Order__c> ordersMap = new Map<Id,Order__c>(orders);
        Map<Id,Map<Id,List<Order_Line_Item__c>>> orderBrandOrderLineItems = new Map<Id,Map<Id,List<Order_Line_Item__c>>>();
        Map<Id,List<Order_Line_Item__c>> brandOrderLineItems = new Map<Id,List<Order_Line_Item__c>>();
        if(!orders.isEmpty()){
            List<String> listOfContactIds;
            List<String> listOfToAddresses;
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address =: Label.Orders_Filigreen_Email];
            for(Order__c o: orders){
                if(!o.Order_Line_Items__r.isEmpty()){
                    for(Order_Line_Item__c oli: o.Order_Line_Items__r){
                        if(oli.Product__r.White_Labelled__c == true){
                            if(brandOrderLineItems.containsKey(oli.Product__r.Licensee_Name__c)){
                                brandOrderLineItems.get(oli.Product__r.Licensee_Name__c).add(oli);
                            }else{
                                brandOrderLineItems.put(oli.Product__r.Licensee_Name__c, new List<Order_Line_Item__c>{oli});
                            }
                        }else{
                            if(brandOrderLineItems.containsKey(oli.Product__r.Producer_Name__c)){
                                brandOrderLineItems.get(oli.Product__r.Producer_Name__c).add(oli);
                            }else{
                                brandOrderLineItems.put(oli.Product__r.Producer_Name__c, new List<Order_Line_Item__c>{oli});
                            }
                        }
                        
                    }
                }
                orderBrandOrderLineItems.put(o.Id,brandOrderLineItems);
            }
            notifyBrandContactsOnNewOrder(ordersMap,orderBrandOrderLineItems,brandOrderLineItems.keySet(),owea);
        }
    }
    public static void notifyBrandContactsOnNewOrder(Map<Id,Order__c> ordersMap,Map<Id,Map<Id,List<Order_Line_Item__c>>> orderBrandOrderLineItems,Set<Id> brandIds,OrgWideEmailAddress[] owea){
        if(!brandIds.isEmpty()){
            Map<Id,Account> brandsMap = new Map<Id,Account>([SELECT Id, Name, (SELECT Id, FirstName,Name, Email FROM Contacts WHERE Active__c  = true AND Orders_Email_Opt_In__c = True AND Email != NULL) FROM Account WHERE Id IN :brandIds]);
            if(!orderBrandOrderLineItems.isEmpty()){
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                for(Id orderId: orderBrandOrderLineItems.keySet()){
                    Integer count = 0;
                    Order__c odr = ordersMap.get(orderId);
                    Map<Id,List<Order_Line_Item__c>> brandOrderLineItems = orderBrandOrderLineItems.get(orderId);
                    if(odr != null && !brandOrderLineItems.isEmpty()){
                        for(Id brandId: brandOrderLineItems.keySet()){
                            Account brand = brandsMap.get(brandId);
                            if(brand != null){
                                count += brand.Contacts != null ? brand.Contacts.size() : 0;
                                if(brand.Contacts != null && brand.Contacts.size() > 0){
                                    List<String> listOfToAddresses = new List<String>();
                                    Decimal totalProductPrice = 0;
                                    Decimal totalExciseTax = 0;
                                    List<Order_Line_Item__c> items = brandOrderLineItems.get(brandId);
                                    System.debug('Brand:'+brand);
                                    System.debug('Items:'+items);
                                    String itemsHTML = '<table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Brand</th><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Total Qty</th><th style="border:1px solid #000">Unit Price</th>'
                                        +'<th style="border:1px solid #000">Unit Excise Tax</th><th style="border:1px solid #000">Product Price</th><th style="border:1px solid #000">Total Excise Tax</th><th style="border:1px solid #000">Total Quoted Price</th></tr>';
                                    //                             String itemsHTML = '<table cellspacing="0" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Brand</th><th style="border:1px solid #000">Line Total Qty</th><th style="border:1px solid #000">Unit Price</th>'
                                    //                               +'<th style="border:1px solid #000">Unit Excise Tax</th><th style="border:1px solid #000">Line Product Price</th><th style="border:1px solid #000">Line Total Excise Tax</th><th style="border:1px solid #000">Total Quoted Price</th></tr>';
                                    
                                    if(!items.isEmpty()){
                                        for(Order_Line_Item__c oli: items){
                                            totalProductPrice += oli.Line_Total_Cost__c;
                                            totalExciseTax += oli.Line_Total_Excise_Tax__c;
                                            itemsHTML +='<tr style="border:1px solid #000">'
                                                /*+'<td style="border:1px solid #000;padding-left:5px;">'+oli.Name+'</td>'*/
                                                +'<td style="border:1px solid #000;padding-left:5px;">'+oli.Product__r.Brand_Name__c+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">'+oli.Product__r.Product_Short_Description__c+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">'+oli.Product__r.Description+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">'+(oli.Line_Total_Qty__c != null ?oli.Line_Total_Qty__c.setScale(0):0)+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">$'+getFormattedCurrency(oli.UnitPrice__c)+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">$'+getFormattedCurrency((oli.Unit_Excise_Tax__c !=null?oli.Unit_Excise_Tax__c.setScale(2):0.00))+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">$'+getFormattedCurrency((oli.Line_Total_Cost__c != null?oli.Line_Total_Cost__c.setScale(2):0.00))+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">$'+getFormattedCurrency((oli.Line_Total_Excise_Tax__c != null?oli.Line_Total_Excise_Tax__c.setScale(2):0.00))+'</td>'
                                                +'<td style="border:1px solid #000;padding-left:5px;">$'+getFormattedCurrency((oli.Total__c != null?oli.Total__c.setScale(2):0.00))+'</td></tr>';
                                            
                                        }
                                        
                                    }
                                    
                                    itemsHTML +='</table>';
                                    for(Contact con: brand.Contacts){
                                        System.debug('Contact Name:'+con);
                                        //listOfToAddresses.add(con.Email);
                                        String htmlBody = 'Hello '+con.FirstName+',<br><br>A new retail order '+odr.Name+' has been submitted by '+odr.Retailer_Contact__r.Name+' from '+odr.Retailer__r.DBA__c+'.<br>'
                                            +'<br><b>ORDER DETAILS</b><br>'
                                            +'Retailer Name: <b>'+odr.Retailer__r.DBA__c+'</b><br>'
                                            +'Retailer PO: <b>'+(odr.Retailer_PO__c != null?odr.Retailer_PO__c:'')+'</b><br>'
                                            +'Address: <b>'+odr.Shipping_Street__c+', '+odr.Shipping_City__c+', '+odr.Shipping_Province__c+', '+odr.Shipping_Zip__c+'</b><br>'
                                            +'Total Product Price: <b>$'+getFormattedCurrency(totalProductPrice)+'</b><br>'
                                            +'Total Excise Tax: <b>$'+getFormattedCurrency(totalExciseTax)+'</b><br>'
                                            +'Total Order Price: <b>$'+getFormattedCurrency(totalProductPrice+totalExciseTax)+'</b><br>'
                                            +'Payment Terms: <b>'+(odr.Payment_Terms__c != null?odr.Payment_Terms__c:'')+'</b><br><br>';
                                        htmlBody +=itemsHTML;
                                        /*htmlBody+= '<br/>Please review the order at your earliest convenience, by clicking here: <a href="'+Label.Instance_URL+odr.id+'">'+odr.Name+'</a><br/><br/>Thank you,<br/>'
                                            +'Filigreen<br/>';*/
                                        htmlBody+= '<br/>Thank you,<br/>WOVN<br/>';
                                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                        mail.setSubject('Marketplace order '+odr.Name+' from '+odr.Retailer__r.DBA__c);
                                        mail.setHtmlBody(htmlBody); 
                                        mail.setTargetObjectId(con.Id);
                                        if(System.Label.Brand_BCC_Addresses != null){
                                            //mail.SetBccaddresses(System.Label.Brand_BCC_Addresses.split(','));
                                        }
                                        
                                        mail.setSaveAsActivity(false);
                                        emails.add(mail);
                                        System.debug('##HTML Body::'+htmlBody);
                                        
                                    }
                                }
                            }
                        }
                        System.debug('Order Brand Contact count:'+count);
                    }
                }
                if(!emails.isEmpty()){
                    System.debug('###notifyOnNewRetailerOrder...'+emails.size());
                    try{
                        Messaging.sendEmail(emails);
                    } catch(Exception ex){}
                }
            }
        }
    }
    private static String getFormattedCurrency(Decimal x){
        String formattedValue = '';
        if(x == null){
            x = 0;
        }
        x = x.setScale(2);
        String y = String.valueOf(x);
        String z = '.';
        if(y.contains(',')) z = ',';
        y = y.substring(0, y.indexOf(z));
        if(x - Decimal.valueOf(y) == 0)
            formattedValue =  String.valueOf(x.format()) + z + '00';
        else formattedValue = String.valueOf(x.format());
        String[] values = formattedValue.split('\\.');
        if(values.size() == 1){
            formattedValue += '.00';
        }else if(values.size() == 2){
            String last = values[1];
            if(last.length() ==1){
                last += '0';
                values[1] = last;
            }
            formattedValue = String.join(values,'.');
        }
        
        return formattedValue;
    }
}