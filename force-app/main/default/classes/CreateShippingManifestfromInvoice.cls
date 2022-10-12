/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateShippingManifestfromInvoice  {

private ApexPages.StandardController stdController;
    private Invoice__c Inv = null;

    
    public CreateShippingManifestfromInvoice(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        Inv = ((Invoice__c)stdController.getRecord());
        System.assertNotEquals(null, Inv, 'Invoice record is null');
    }

     public PageReference createReShipManifest() {
        PageReference retPage = null;
        try {
               List<Shipping_Manifest__c> objects = [Select id from Shipping_Manifest__c where Invoice__c =: Inv.Id];
            if (objects.size() >= 1) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'RSM has already been created'));
                        return retPage ; 
        }
            retPage = createOrder(Inv.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

    public static PageReference createOrder(Id InvoldId)
     {
        PageReference retPage = null;
        ID InvId = InvoldId;
        Invoice__c Inv = [select id ,name
                ,AR_Status__c
                ,Opportunity_Name__c
                ,Sample_Order__c
                ,Distributor_Name__c
                ,Distributor_License__c
                ,Distributor_Contact__c
                ,Supplier_Name__c
                ,Supplier_License__c
                ,Supplier_Contact__c
                ,Receiver_Name__c
                ,Receiver_License__c
                ,Receiver_Contact__c
                ,Payment_Terms__c
                ,Customer_PO_or_Quote__c
                ,Brand_Quote__c
                ,Site__c
                ,Shipping_Method__c
                ,Shipping_Terms__c
                , Shipped_Date__c
                from Invoice__c 
                where id =: InvID];

        //if (quote.fieldnameTBD != null){
            //throw new CustomerQuotationException('Sales Order has already been converted to a RSM.  You can only have one RSM for a SO.');
        //}
        List<Invoice_Line__c> InvLines = [select id
                    ,name
                    ,Invoice__c
                    ,Product_Name__c
                    ,Product_Title__c
                    ,Retail_Wholesale_Price__c
                    ,Invoice_Qty__c
                    ,Is_Sample__c,IsPromo__c
                    from Invoice_Line__c
                    where Invoice__c =: InvID];

        Shipping_Manifest__c newReShipManifest = new Shipping_Manifest__c();
        newReShipManifest.Invoice__c = InvID;
        newReShipManifest.Site__c = Inv.Site__c;
        newReShipManifest.Sample_Order__c = Inv.Sample_Order__c;
        newReShipManifest.Brand_Quote__c = Inv.Brand_Quote__c;
        newReShipManifest.Shipping_Method__c = Inv.Shipping_Method__c;
        newReShipManifest.Shipping_Terms__c = Inv.Shipping_Terms__c;
        newReShipManifest.Planned_Ship_Transfer_Date__c = Inv.Shipped_Date__c;
        newReShipManifest.Payment_Terms__c = Inv.Payment_Terms__c;
        newReShipManifest.Customer_PO_or_Quote__c = Inv.Customer_PO_or_Quote__c;
        newReShipManifest.Opportunity_Name__c = Inv.Opportunity_Name__c;
        newReShipManifest.Distributor_Name__c = Inv.Distributor_Name__c;
        newReShipManifest.Distributor_License__c = Inv.Distributor_License__c;
        newReShipManifest.Distributor_Contact__c = Inv.Distributor_Contact__c;
        newReShipManifest.Supplier_Name__c = Inv.Supplier_Name__c;
        newReShipManifest.Supplier_License__c = Inv.Supplier_License__c;
        newReShipManifest.Supplier_Contact__c = Inv.Supplier_Contact__c;
        newReShipManifest.Receiver_Name__c = Inv.Receiver_Name__c;
        newReShipManifest.Receiver_License__c = Inv.Receiver_License__c;
        newReShipManifest.Receiver_Contact__c = Inv.Receiver_Contact__c;
        newReShipManifest.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert newReShipManifest;
        
        List<Shipping_Manifest_Line__c> reManifestLineItems = new List<Shipping_Manifest_Line__c>();
        For (Invoice_Line__c Invline : InvLines)
        {
            Shipping_Manifest_Line__c reManifestLineItem = new Shipping_Manifest_Line__c();
            reManifestLineItem.Invoice_Line__c = Invline.Id;
            reManifestLineItem.Product_Name__c = Invline.Product_Name__c;
            reManifestLineItem.Product_Title__c = Invline.Product_Title__c;
            reManifestLineItem.Retail_Wholesale_Price__c = Invline.Retail_Wholesale_Price__c;
            reManifestLineItem.Shipment_Qty__c = Invline.Invoice_Qty__c;
            reManifestLineItem.Shipping_Manifest__c = newReShipManifest.Id;
            reManifestLineItem.Is_Sample__c = Invline.Is_Sample__c;
            reManifestLineItem.IsPromo__c = Invline.IsPromo__c;
            reManifestLineItem.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
            reManifestLineItems.add(reManifestLineItem);
        }
        insert reManifestLineItems;


        retPage =new PageReference('/'+newReShipManifest.Id);
        return retPage;
     }

     public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }

}