/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateNewETR{
    private ApexPages.StandardController stdController;
    private Invoice__c Inv = null;

    
    public CreateNewETR(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        Inv = ((Invoice__c)stdController.getRecord());
        System.assertNotEquals(null, Inv, 'quote record is null');
    }

     public PageReference createETR() {
        PageReference retPage = null;
        try {
               List<Excise_Tax_Receipt__c> objects = [Select id from Excise_Tax_Receipt__c where Invoice__c =: Inv.Id and ETR_Status__c != 'Cancelled'];
            if (objects.size() >= 1) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'ETR has already been created'));
                        return retPage ; 
        }
            retPage = createOrder(Inv.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){

            ErrorLogs.log('CreateNewETR',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

    public static PageReference createOrder(Id InvoldId)
     {
        PageReference retPage = null;
        ID INVID = InvoldId;
        Invoice__c INV = [select id ,name
                ,AR_Status__c
                ,Site__c
                ,Sample_Order__c
                ,Brand_Quote__c
				,Sales_Order__c
                ,Opportunity_Name__c
                ,Distributor_Name__c
                ,Distributor_License__c
                ,Distributor_Contact__c
                ,Receiver_Name__c
                ,Receiver_License__c
                ,Receiver_Contact__c
                ,Supplier_Name__c
                ,Supplier_License__c
                ,Supplier_Contact__c
                ,Shipped_Date__c
                ,Payment_Terms__c
                ,Customer_PO_or_Quote__c
                ,Shipping_Method__c
                ,Shipping_Terms__c       
                from Invoice__c where id =: INVID];

        //if (quote.fieldnameTBD != null){
            //throw new CustomerQuotationException('Brand Quote has already been converted to a Purchase Order.  You can only have one purchase order for a quote.');
        //}
        List< Invoice_Line__c > InvLines = [select id
                    ,name
                    ,Invoice__c
					,Sales_Order_Line__c
                    ,Product_Name__c
                    ,Product_Title__c
                    ,Retail_Wholesale_Price__c
                    ,Invoice_Qty__c
                    from Invoice_Line__c
                    where Invoice__c =: INVID];

        
        Excise_Tax_Receipt__c newETR = new Excise_Tax_Receipt__c();  
        newETR.Invoice__c = INVID;
        newETR.Site__c = INV.Site__c;
        newETR.ETR_Status__c = 'Draft';
        newETR.Sample_Order__c = INV.Sample_Order__c;
        newETR.Brand_Quote__c = INV.Brand_Quote__c;
        newETR.Shipped_Date__c = INV.Shipped_Date__c;
        newETR.Shipping_Method__c = INV.Shipping_Method__c;
        newETR.Shipping_Terms__c = INV.Shipping_Terms__c;
        newETR.Payment_Terms__c = INV.Payment_Terms__c;
        newETR.Customer_PO_or_Quote__c = INV.Customer_PO_or_Quote__c;
        newETR.Opportunity_Name__c = INV.Opportunity_Name__c;
        newETR.Distributor_Name__c = INV.Distributor_Name__c;
        newETR.Distributor_License__c = INV.Distributor_License__c;
        newETR.Distributor_Contact__c = INV.Distributor_Contact__c;
        newETR.Supplier_Name__c = INV.Supplier_Name__c;
        newETR.Supplier_License__c = INV.Supplier_License__c;
        newETR.Supplier_Contact__c = INV.Supplier_Contact__c;
        newETR.Receiver_Name__c = INV.Receiver_Name__c;
        newETR.Receiver_License__c = INV.Receiver_License__c;
        newETR.Receiver_Contact__c = INV.Receiver_Contact__c;
		newETR.Sales_Order__c = INV.Sales_Order__c;
        insert newETR;
        
        List<Excise_Tax_Receipt_Line__c> ETRLineItems = new List<Excise_Tax_Receipt_Line__c>();
        For (Invoice_Line__c InvLine : InvLines)
        {
            Excise_Tax_Receipt_Line__c ETRLineItem = new Excise_Tax_Receipt_Line__c();
            ETRLineItem.Invoice_Line__c = InvLine.Id;
            ETRLineItem.Product_Name__c = InvLine.Product_Name__c;
            ETRLineItem.Product_Title__c = InvLine.Product_Title__c;
            ETRLineItem.Qty_Received__c = InvLine.Invoice_Qty__c;
            ETRLineItem.Retail_Wholesale_Price__c = InvLine.Retail_Wholesale_Price__c;
            ETRLineItem.Excise_Tax_Receipt__c = newETR.Id;
			ETRLineItem.Sales_Order_Line__c = InvLine.Sales_Order_Line__c;
            ETRLineItems.add(ETRLineItem);
        }
        insert ETRLineItems;
        
        retPage =new PageReference('/'+newETR.Id);
        return retPage;
     }

            public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }
}