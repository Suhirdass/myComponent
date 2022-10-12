@RestResource(urlMapping='/createOrder/*')
global without sharing class QuickBaseWebhook {
    
    @HttpGet
    global static String getData() {
        return 'ReturnDatafromSalesforce';
    }
    
    @HttpPost
    global static Map<String, String> createOrder() {
        Brand_Quote__c newQuote = new Brand_Quote__c(BQ_Status__c = 'Draft');
        Map<String, String> r = new Map<String, String>();
        RestRequest request = RestContext.request;
        System.debug('Actual Request: ' + request);
		System.debug('Order request: ' + request.requestBody.toString());
		Order order = (Order)JSON.deserialize(request.requestBody.toString(), Order.Class);
        if(order.ReadyforDelivery == 'yes'){
            Brand_Quote__c[] bq = [SELECT Id, KP_Ready_for_Delivery__c FROM Brand_Quote__c WHERE Kushy_Punch_Order_Number__c = :order.OrderNumber];
            if(bq.size() > 0 && bq[0].KP_Ready_for_Delivery__c == true){
                return r;
            }
        }
        Site__c[] companySites = [SELECT Id FROM Site__c WHERE Name= : Label.Company_Site_Id];
        Account collective;
        //if(String.isNotBlank(order.AccountName)){
		if(String.isNotBlank(order.StateLicense)){
			State_Licenses__c[] sls = [SELECT Id,License_Name__c FROM State_Licenses__c  WHERE License_Number__c =: order.StateLicense];

	        Account[] collectives = [SELECT Id FROM Account WHERE Id =: sls[0].License_Name__c];//dBA__c =: order.AccountName];
            Account[] kushyPunchs = [SELECT Id ,(SELECT Id FROM State_Licenses__r WHERE License_Class__c ='AM-License') FROM Account WHERE dBA__c = 'Kushy Punch'];
            
            if(!collectives.isEmpty()){
                collective = collectives[0];
                newQuote.Receiver_Name__c = collective.Id;
                Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
                Opportunity opp;
                for(Opportunity op: [SELECT Id FROM Opportunity WHERE Name = :order.OrderNumber]){
                    opp = op;
                }
                if(opp == null){
                    opp  = new Opportunity(RecordTypeId = oppRecordTypeId,Name = order.OrderNumber,AccountId = collective.Id,Sales_Origin__c = 'Disty',Site_Name__c = (companySites.isEmpty()?null:companySites[0].Id),StageName = 'Proposal/Price Quote',Type = 'Existing Business');
                    if(!kushyPunchs.isEmpty()){
                        opp.Ownership__c = kushyPunchs[0].Id;
                    }
                    if(String.isNotBlank(order.OrderDate)){
                        String[] orderDateStr = order.OrderDate.split('-');
                        String str = orderDateStr[2]+'-'+orderDateStr[0]+'-'+orderDateStr[1];
                        opp.CloseDate = Date.valueOf(str);
                    }else{
                        opp.CloseDate = System.today();
                    }
                    insert opp;
                }
                newQuote.Opportunity_Name__c = opp.Id;
                System.debug('##opp::'+opp);
            }
            
            if(!kushyPunchs.isEmpty()){
                newQuote.Supplier_Name__c = kushyPunchs[0].Id;
                if(kushyPunchs[0].State_Licenses__r.size() > 0){
                    newQuote.Supplier_License__c = kushyPunchs[0].State_Licenses__r[0].Id;
                }
                newQuote.Ownership__c = kushyPunchs[0].Id;
            }
        }
        if(String.isNotBlank(order.ContactName)){
            Contact receiverContact;
            //String[] names = order.SalesRep.split(', ');
            //String cName = names[1]+' '+names[0]; 
            //for(Contact con: [SELECT Id, Name FROM Contact WHERE Name =: cName and account.dba__c = 'Kushy Punch']){
			for(Contact con: [SELECT Id, Name FROM Contact WHERE Name =: order.ContactName]){
                receiverContact = con;
                break;
            }
            if(receiverContact != null){
                newQuote.Receiver_Contact__c = receiverContact.Id;
            }
        }
		if(String.isNotBlank(order.SalesRep)){
            Contact supplierContact;
            String[] names = order.SalesRep.split(', ');
            String sName = names[1]+' '+names[0]; 
            for(Contact con: [SELECT Id, Name FROM Contact WHERE Name =: sName and account.dba__c = 'Kushy Punch']){
			//for(Contact con: [SELECT Id, Name FROM Contact WHERE Name =: order.ContactName]){
                supplierContact = con;
                break;
            }
            if(supplierContact != null){
                newQuote.Supplier_Contact__c = supplierContact.Id;
            }
        }
        if(String.isNotBlank(order.StateLicense)){
            State_Licenses__c[] sls = [SELECT Id FROM State_Licenses__c  WHERE License_Number__c =: order.StateLicense];
            if(!sls.isEmpty()){
                newQuote.Receiver_License__c = sls[0].Id;
            }
            
        }
        newQuote.Customer_PO_or_Quote__c = order.OrderNumber;
        Id oppRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get('Sell Quote').getRecordTypeId();
        List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c,Default_KP_Contact__c from Company_Custom_Settings__c];
        if(defaultIDs.size() >0){
            if(defaultIDs[0].Default_Distributor__c != null)
                newQuote.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
            if(defaultIDs[0].Default_License__c != null)
                newQuote.Distributor_License__c = defaultIDs[0].Default_License__c;
            if(defaultIDs[0].Default_Contact__c != null)
                newQuote.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
			if(defaultIDs[0].Default_KP_Contact__c != null)
			{
				List<Contact> distyCOntact = [Select id from contact where name =: defaultIDs[0].Default_KP_Contact__c and AccountId =: defaultIDs[0].Default_Distributor__c];
                if(distyCOntact.size() >0)
					newQuote.Distributor_Contact__c = distyCOntact[0].Id;
			}
        }
        newQuote.Payment_Terms__c = 'COD';
        newQuote.Site__c = (companySites.isEmpty()?null:companySites[0].Id);
        newQuote.Sales_Origin__c  = 'Disty';
        newQuote.RecordTypeId = oppRecordTypeId;
        newQuote.Kushy_Punch_Order_Number__c = order.OrderNumber;
        if(order.ReadyforDelivery == 'yes'){
            newQuote.KP_Ready_for_Delivery__c = true;
        }
        if(String.isNotBlank(order.OrderDate)){
            String[] orderDateStr = order.OrderDate.split('-');
            String str = orderDateStr[2]+'-'+orderDateStr[0]+'-'+orderDateStr[1];
            newQuote.Supplier_Acceptance_Date__c = Date.valueOf(str);
        }
		if(String.isNotBlank(order.RequestedShipDate)){
			String[] reqDate = order.RequestedShipDate.split('-');
			String str = reqDate[2]+'-'+reqDate[0]+'-'+reqDate[1];
			newQuote.Requested_Ship_Date__c = Date.valueOf(str);
		}
		if(String.isNotBlank(order.Notes)){
			newQuote.Notes__c	 = order.Notes;
		}
        Database.upsert(newQuote,Brand_Quote__c.Fields.Kushy_Punch_Order_Number__c,false);
        
        System.debug('Order: ' + order);
        r.put('name', order.OrderNumber);
        return r;
    }
    
    public class Order{
        public String OrderNumber					{get;set;}
        public String OrderId 						{get;set;}
        public String OrderDate    					{get;set;}
        public String AccountName    				{get;set;}
        public String ContactName    				{get;set;}
        public String SalesRep       				{get;set;}
        public String OrderStatus        			{get;set;}
        public String TotalComminssion              {get;set;}
        public String TotalDiscountPrice            {get;set;}
        public String Notes                  		{get;set;}
        public String StateLicense                  {get;set;}
        public String ReadyforDelivery              {get;set;}
		public String RequestedShipDate              {get;set;}
        
    }
    
}