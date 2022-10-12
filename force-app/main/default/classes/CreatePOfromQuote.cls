/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreatePOfromQuote  {

    private ApexPages.StandardController stdController;
    private Brand_Quote__c bq = null;
    public class UserException extends Exception{ }
    
    public CreatePOfromQuote(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        bq = ((Brand_Quote__c)stdController.getRecord());
        System.assertNotEquals(null, bq, 'quote record is null');
    }

     public PageReference createPO() {
        PageReference retPage = null;
        try {
            Brand_Quote__c bq = [select id,Name, BQ_Status__c from Brand_Quote__c where Id  =: bq.Id];
            if(bq.BQ_Status__c != 'Approved' && bq.BQ_Status__c != 'Shipped')
                 throw new UserException('Please submit Brand Quote for Approval and try again to create Purchase Order.');
            /*List<Purchase_Order__c> objects = [Select id from Purchase_Order__c where Brand_Quote__c =: bq.Id and PO_Status__c != 'Cancelled'];
            if (objects.size() >= 1) 
                throw new UserException('PO already exist for Brand Quote');*/
            retPage = createOrder(bq.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){
            ErrorLogs.log('CreatePOfromQuote:createPO()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

     public static PageReference createOrder(Id quoteId)
     {
        PageReference retPage = null;
        ID bqID = quoteId;
        Brand_Quote__c quote = [select id ,name,RecordTypeId
                ,BQ_Status__c
                ,Opportunity_Name__c 
                ,Opportunity_Name__r.AccountId
                ,Payment_Terms__c
                ,Sample_Order__c
                ,Site__c
                ,Ownership__c
                ,Shipping_Method__c
                ,Shipping_Terms__c
                ,Receiver_Name__c
                ,Receiver_License__c
                ,Receiver_Contact__c
                ,Supplier_Name__c
                ,Supplier_License__c
                ,Supplier_Contact__c
                ,Distributor_Name__c
                ,Distributor_License__c
                ,Distributor_Contact__c
                ,Planned_Transfer_Date__c
                from Brand_Quote__c where id =: bqID];

        //if (quote.fieldnameTBD != null){
            //throw new CustomerQuotationException('Brand Quote has already been converted to a Purchase Order.  You can only have one purchase order for a quote.');
        //}
        List<Brand_Quote_Line__c> quoteLines = [select id
                        ,name,Brand_Quote_Number__c
                        ,Disty_Margin__c
                        ,MOQ__c
                        ,Product_Title__c
                        ,Price_Book__c
                        ,Line_Total_Qty__c
                        ,Product_Name__c
                        ,Disty_Cost__c
                        ,Is_Sample__c
                    from Brand_Quote_Line__c
                    where Brand_Quote_Number__c =: bqID and Status__c != 'Cancelled' and Status__c != 'Rejected'];
                     
        string recordtypename = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosById().get(quote.RecordTypeId).getname();
        Id poRecordTypeID;
        Id poliRecordTypeID;
        if(recordtypename =='Sell Quote')
            {
                poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get('Invoice Only').getRecordTypeId();
                poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get('Invoice Only').getRecordTypeId();
            }else if(recordtypename =='RMA')
            {
                poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get('RMA').getRecordTypeId();
                poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get('RMA').getRecordTypeId();
            }
        else
            {
                poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get('Product').getRecordTypeId();
                poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get('Product').getRecordTypeId();
            }
        Purchase_Order__c newPO = new Purchase_Order__c();
        newPO.Brand_Quote__c = bqID;
        newPO.PO_Status__c = 'Draft';
        newPO.PO_Type__c = recordtypename;
        newPO.PO_Date__c = Date.today();
        newPO.Ownership__c = quote.Ownership__c;
        newPO.Opportunity_Name__c = quote.Opportunity_Name__c;
        newPO.Distributor_Name__c = quote.Distributor_Name__c;
        newPO.Distributor_License__c = quote.Distributor_License__c;
        newPO.Distributor_Contact__c = quote.Distributor_Contact__c;
        newPO.Supplier_Name__c = quote.Supplier_Name__c;
        newPO.Supplier_License__c = quote.Supplier_License__c;
        newPO.Supplier_Contact__c = quote.Supplier_Contact__c;        
        newPO.Receiver_Name__c = quote.Distributor_Name__c;
        newPO.Receiver_License__c = quote.Distributor_License__c;
        newPO.Receiver_Contact__c = quote.Distributor_Contact__c;
        newPO.Shipping_Terms__c = quote.Shipping_Terms__c;
        newPO.Shipping_Method__c = quote.Shipping_Method__c;
        newPO.Payment_Terms__c = quote.Payment_Terms__c;
        newPO.Sample_Order__c = quote.Sample_Order__c;
        newPO.RecordTypeId = poRecordTypeID;
        newPO.Site__c = quote.Site__c;
        newPO.Planned_Ship_Transfer_Date__c = quote.Planned_Transfer_Date__c;

        try
        {
            insert newPO;
            List<Purchase_Order_Line__c> poLineItems = new List<Purchase_Order_Line__c>();
            For (Brand_Quote_Line__c qline : quoteLines)
            {
                Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
                newPOLI.Brand_Quote_Line__c = qline.Id;
                newPOLI.Product_Name__c =  qline.Product_Name__c;
                newPOLI.Product_Title__c =  qline.Product_Title__c;
                newPOLI.Qty_Ordered__c = qline.Line_Total_Qty__c;
                newPOLI.Purchase_Order__c = newPO.Id;
                newPOLI.Unit_Cost__c = qline.Disty_Cost__c;
                newPOLI.Is_Sample__c = qline.Is_Sample__c;
                newPOLI.RecordTypeId = poliRecordTypeID;
                poLineItems.add(newPOLI);
            }
            insert poLineItems;
        }
        catch(Exception ex)
        {
            ErrorLogs.log('CreatePOfromQuote:createOrder()',ex.getStackTraceString(), ex.getMessage());
        }

        retPage =new PageReference('/'+newPO.Id);
        return retPage;
     }

     public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }
}