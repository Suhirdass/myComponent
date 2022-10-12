/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateQuote  {

    private ApexPages.StandardController stdController;
    Opportunity bq;
    private ID oppID;
	String OppRecordType;

    public CreateQuote(ApexPages.StandardController controller) {
        System.debug('inside the constructor ' + controller);
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        bq = ((Opportunity)stdController.getRecord());
        oppID = bq.Id;       
        //System.assertNotEquals(null, cq, 'quote record is null');   
    }

    public PageReference createSellQuote() {
        PageReference retPage = null;
        try                
        {                   
            //Id newSQ = createQuote('sell_quote');
			OppRecordType = [select RecordType.DeveloperName from Opportunity where id =: oppID].RecordType.DeveloperName;
			Id newSQ;
			if(OppRecordType == 'Service_Opportunity')
				newSQ = createQuote('Service_Quote');
			else
				newSQ = createQuote('sell_quote');
            retPage =new PageReference('/'+newSQ);
            retPage.setRedirect(true);                        
        }
        catch (Exception ex)
        {
            ErrorLogs.log('CreateQuote:createSellQuote()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(errMsg);
        }
        return retPage;
    }

    public PageReference createBuyQuote() 
    {
        PageReference retPage = null;
        try
        {
            Id newBQ = createQuote('buy_quote');            
            retPage =new PageReference('/'+newBQ);
            retPage.setRedirect(true);

        }
        catch (Exception ex)
        {
            ErrorLogs.log('CreateQuote:createBuyQuote()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(errMsg);
        }
        return retPage;
    }

    public Id createQuote(String quoteType)
    {
        Brand_Quote__c newQuote = new Brand_Quote__c();
        newQuote.Opportunity_Name__c = oppID;
        List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
        if(defaultIDs.size() >0)
        {
            if(defaultIDs[0].Default_Distributor__c != null)
                newQuote.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
            if(defaultIDs[0].Default_License__c != null)
                newQuote.Distributor_License__c = defaultIDs[0].Default_License__c;
            if(defaultIDs[0].Default_Contact__c != null)
                newQuote.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
        }
        //newQuote.Distributor_Contact__c = user.Id;
        newQuote.BQ_Status__c = 'Draft';
        system.debug('****'+oppID);
        newQuote.Ownership__c = [select Ownership__c from Opportunity where id =: oppID].Ownership__c;
        newQuote.Sales_Origin__c = [select Sales_Origin__c from Opportunity where id =: oppID].Sales_Origin__c;
        newQuote.Site__c = [select Site_Name__c from Opportunity where id =: oppID].Site_Name__c;
        //newQuote.Payment_Terms__c = [select Payment_Terms__c from Opportunity where id =: oppID].Payment_Terms__c;
        id recTypeID = getRecordType(quoteType);
        newQuote.RecordTypeId = recTypeID;
        system.debug('**$$$**'+newQuote);
        
        if(quoteType =='sell_quote')
        {
            newQuote.Payment_Terms__c = [select Payment_Terms__c from Opportunity where id =: oppID].Payment_Terms__c;
			Opportunity opp = [select Order__c,Order__r.Retailer_Contact__c,Order__r.Retailer__c,Order__r.Exclude_Excise_Tax__c,  Order__r.Customer__r.ContactId from Opportunity where id =: oppID];
            if(opp.Order__c != null){
                newQuote.Apply_Excise_Tax__c = (opp.Order__r.Exclude_Excise_Tax__c == false);
                newQuote.Receiver_Name__c = opp.Order__r.Retailer__c;
				newQuote.Receiver_Contact__c =  opp.Order__r.Retailer_Contact__c;// opp.Order__r.Customer__r.ContactId;
            }  
            /*Opportunity opp = [select Order__c, Order__r.Customer__r.ContactId from Opportunity where id =: oppID];
            if(opp.Order__c != null){
            system.debug('**$$$123**'+opp.Order__r.Customer__r.ContactId);
                newQuote.Receiver_Contact__c =  opp.Order__r.Customer__r.ContactId;
            }
            */
            //newQuote.Receiver_Name__c = [select AccountId from Opportunity where id =: oppID].AccountId;
            //newQuote.Supplier_Name__c = [select Ownership__c from Opportunity where id =: oppID].Ownership__c;
        }
        try{ insert newQuote;}
        catch(Exception ex)
        {
            ErrorLogs.log('CreateQuote:createQuote()',ex.getStackTraceString(), ex.getMessage());
        }
        createQuoteLines(newQuote.Id, quoteType);
        return newQuote.Id;
    }
    public void createQuoteLines(Id bqID, String quoteType)
    {
        List<Brand_Quote_Line__c> bqLineItems = new List<Brand_Quote_Line__c>();
        Opportunity oppty = [SELECT Id, Name, Account.Name, 
                                    (SELECT Quantity,MOQ__c, Product_Title__c, UnitPrice, ListPrice, PricebookEntry.Disty_Discount_Per_Unit__c, TotalPrice, Product2Id, PricebookEntryId, PricebookEntry.Name,
                                        PricebookEntry.PriceBook2ID, PricebookEntry.Product2ID, PricebookEntry.Product2.Family,
                                        PricebookEntry.DistyMargin__c , Disty_Discount_Per_Unit__c
                                        FROM OpportunityLineItems) FROM Opportunity where id =: oppID];
        
		id bqLIrecordtypeID;
		If(quoteType == 'buy_quote')
			bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get('Buy Quote Line').getRecordTypeId();
		else
		{
			If(quoteType == 'sell_quote')
				bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get('Sell Quote Line').getRecordTypeId();
			else
			{
				If(quoteType == 'Service_Quote')
				bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get('Service Line').getRecordTypeId();
			}
		}

		for (OpportunityLineItem  opptyLineItems:oppty.OpportunityLineItems)
        {
            Brand_Quote_Line__c newQuoteLineItems = new Brand_Quote_Line__c();
            newQuoteLineItems.Brand_Quote_Number__c = bqID;
            newQuoteLineItems.Product_Name__c = opptyLineItems.Product2Id;
            newQuoteLineItems.Price_Book__c = opptyLineItems.PricebookEntry.PriceBook2ID;
            newQuoteLineItems.Disty_Margin__c = opptyLineItems.PricebookEntry.DistyMargin__c;
            newQuoteLineItems.MOQ__c = opptyLineItems.MOQ__c;
            newQuoteLineItems.Product_Title__c = opptyLineItems.Product_Title__c;
            newQuoteLineItems.Quantity_Cases__c = opptyLineItems.Quantity;
            newQuoteLineItems.Disty_Discount_Per_Unit__c = opptyLineItems.Disty_Discount_Per_Unit__c; //opptyLineItems.PricebookEntry.Disty_Discount_Per_Unit__c;
            newQuoteLineItems.Retail_Wholesale_Price__c = opptyLineItems.UnitPrice;
			newQuoteLineItems.RecordTypeId = bqLIrecordtypeID;
            bqLineItems.add(newQuoteLineItems);
        }
        try{
            insert bqLineItems;
            }
            catch (Exception ex)
            { 
                ErrorLogs.log('CreateQuote','Quote Id:'+bqID + ' - '+ ex.getStackTraceString(), ex.getMessage());
            }
    }
    public ID getRecordType(String recTypeName)
    {
        recordtype recTypeID = [select id from recordtype where DeveloperName =:recTypeName limit 1];
        return recTypeID.Id;
    }
    public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }
}