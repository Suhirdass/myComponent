/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateShippingManifestfromPO  {

private ApexPages.StandardController stdController;
    private Purchase_Order__c po = null;

    public class UserException extends Exception{ }

    public CreateShippingManifestfromPO(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.assertNotEquals(null, controller, 'controller is null');
        po = ((Purchase_Order__c)stdController.getRecord());
        System.assertNotEquals(null, po, 'quote record is null');
    }

     public PageReference createTrShipManifest() {
        PageReference retPage = null;
        try {                      
            
            retPage = createOrder(po.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

    public static PageReference createOrder(Id poId)
     {

        PageReference retPage = null;
        ID pOrderID = poId;
        Purchase_Order__c po = [select id ,name
                ,PO_Status__c
                ,PO_Type__c
                ,Brand_Quote__c
                ,Brand_Quote__r.Planned_Ship_Date__c
				,Brand_Quote__r.Planned_Transfer_Date__c
                ,Ownership__c
                ,Opportunity_Name__c
                ,Sample_Order__c
                ,Purchase_Order_Instructions__c                
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
                ,Site__c
                ,Shipping_Method__c
                ,Shipping_Terms__c
                ,Window_End__c
                ,Window_Start__c
                ,Priority__c,
                                Driver__c,
                                Vehicle__c,
                                Planned_Ship_Transfer_Date__c                
                from Purchase_Order__c 
                where id =: pOrderID];

        //if (quote.fieldnameTBD != null){
            //throw new CustomerQuotationException('Brand Quote has already been converted to a Purchase Order.  You can only have one purchase order for a quote.');
        //}
        List<Purchase_Order_Line__c> poLines = [select id
                    ,name
                    ,Purchase_Order__c
                    ,Product_Name__c
                    ,Unit_Cost__c
                    ,Product_Title__c
                    ,Qty_Ordered__c,Brand_Quote_Line__r.IsPromo__c
                    ,Is_Sample__c,Ownership_Code__c 
                    from Purchase_Order_Line__c
                    where Purchase_Order__c =: pOrderID];

        Shipping_Manifest__c newTrShipManifest = new Shipping_Manifest__c();
        newTrShipManifest.Purchase_Order__c = pOrderID;
        newTrShipManifest.Shipment_Instructions__c = po.Purchase_Order_Instructions__c;
        newTrShipManifest.Status__c = 'Draft';
        newTrShipManifest.Opportunity_Name__c = po.Opportunity_Name__c;
        newTrShipManifest.Distributor_Name__c = po.Distributor_Name__c;
        newTrShipManifest.Distributor_License__c = po.Distributor_License__c;
        newTrShipManifest.Distributor_Contact__c = po.Distributor_Contact__c;
        newTrShipManifest.Supplier_Name__c = po.Supplier_Name__c;
        newTrShipManifest.Supplier_License__c = po.Supplier_License__c;
        newTrShipManifest.Supplier_Contact__c = po.Supplier_Contact__c;
        newTrShipManifest.Receiver_Name__c = po.Receiver_Name__c;
        newTrShipManifest.Receiver_License__c = po.Receiver_License__c;
        newTrShipManifest.Receiver_Contact__c = po.Receiver_Contact__c;
        newTrShipManifest.Brand_Quote__c = po.Brand_Quote__c;
        newTrShipManifest.Sample_Order__c = po.Sample_Order__c;
        newTrShipManifest.Ownership__c = po.Ownership__c;
        newTrShipManifest.Site__c = po.Site__c;
        newTrShipManifest.TSM_Type__c = 'Product';
        newTrShipManifest.Window_End__c = po.Window_End__c;
        newTrShipManifest.Window_Start__c = po.Window_Start__c;
        newTrShipManifest.Priority__c = po.Priority__c;
        newTrShipManifest.Driver__c = po.Driver__c;
         newTrShipManifest.Vehicle__c = po.Vehicle__c;
        newTrShipManifest.Planned_Ship_Transfer_Date__c = po.Planned_Ship_Transfer_Date__c;//po.Brand_Quote__r.Planned_Transfer_Date__c;
        newTrShipManifest.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        insert newTrShipManifest;

        List<Shipping_Manifest_Line__c> trManifestLineItems = new List<Shipping_Manifest_Line__c>();
        For (Purchase_Order_Line__c poline : poLines)
        {
            Shipping_Manifest_Line__c trManifestLineItem = new Shipping_Manifest_Line__c();
            trManifestLineItem.Purchase_Order_Line__c = poline.Id;
            trManifestLineItem.Product_Name__c = poline.Product_Name__c;
            trManifestLineItem.Product_Title__c = poline.Product_Title__c;
            trManifestLineItem.Unit_Cost__c = poline.Unit_Cost__c;
            trManifestLineItem.Qty_Ordered__c = poline.Qty_Ordered__c;
            trManifestLineItem.Shipping_Manifest__c = newTrShipManifest.Id;
            trManifestLineItem.Is_Sample__c = poline.Is_Sample__c;
            trManifestLineItem.IsPromo__c = poline.Brand_Quote_Line__r.IsPromo__c;
            trManifestLineItem.Ownership_Code__c = poline.Ownership_Code__c;
            trManifestLineItem.RecordTypeId = ShippinManifestSupport.getTSMLineRecordTypeId();
            trManifestLineItems.add(trManifestLineItem);
        }
        insert trManifestLineItems;

        retPage =new PageReference('/'+newTrShipManifest.Id);
        return retPage;
     }

     public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }

}