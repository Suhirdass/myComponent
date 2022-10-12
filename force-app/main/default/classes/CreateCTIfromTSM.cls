/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.
     •  Test class  Name:  CreateRLfromPOlineTest

*/
public class CreateCTIfromTSM{

    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c tsm= null;
    private Id tsmRecordTypeId;

    
    public CreateCTIfromTSM(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        tsm = ((Shipping_Manifest__c)stdController.getRecord());
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        System.assertNotEquals(null, tsm, 'tsm record is null');
    }

     public PageReference createCTI() {
        PageReference retPage = null;
        try {

            Shipping_Manifest__c tsmDetail = [select id, Status__c from Shipping_Manifest__c where Id  =: tsm.Id AND RecordTypeId =: tsmRecordTypeId];
            if(tsmDetail.Status__c == 'Draft')
                 {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Please submit TSM for Approval and try again to create Cultivation Tax Invoice.'));
                    return retPage ;
                }

            List<Invoice__c> objects = [Select id from Invoice__c where Shipping_Manifest__c =: tsm.Id AND AR_Status__c != 'Cancelled'];
            if (objects.size() >= 1) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'CTI has already been created'));
                        return retPage ;
          }                        
            retPage = createCTInvoice(tsm.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){

            ErrorLogs.log('CreateCTIfromCTR',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

    public static PageReference createCTInvoice(Id tsmoldId)
     {
        PageReference retPage = null;
        ID tsmID = tsmoldId;
        Id tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        Shipping_Manifest__c objTSM= [select id ,name
                ,Sample_Order__c
                ,Ownership__c
                ,Shipment_Instructions__c
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
                ,Brand_Quote__c
                ,Payment_Terms__c
                ,Planned_Ship_Transfer_Date__c
                ,Site__c
                ,Shipping_Method__c
                ,Shipping_Terms__c       
                from Shipping_Manifest__c where id =: tsmID AND RecordTypeId =: tsmRecordTypeId];

        List<Shipping_Manifest_Line__c> tsmLines= [select id
                    ,name
                    ,Shipping_Manifest__c
                    ,Product_Name__c
                    ,Product_Title__c
                    ,Apply_Cultivation_Tax__c
                    ,Unit_Cultivation_Tax__c
                    ,Lot_Cannabis_Category__c
                    ,Cannabis_Weight_UOM__c
                    ,Qty_Ordered__c
                    ,Subtotal_Cannabis_Weight__c
                    from Shipping_Manifest_Line__c
                    where Shipping_Manifest__c =: tsmID];


        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Shipping_Manifest__c= tsmID;
        newInvoice.Site__c = objTSM.Site__c;
        newInvoice.Shipping_Method__c = objTSM.Shipping_Method__c;
        newInvoice.Shipping_Terms__c = objTSM.Shipping_Terms__c;
        newInvoice.Payment_Terms__c = objTSM.Payment_Terms__c;
        newInvoice.Sample_Order__c = objTSM.Sample_Order__c;
        newInvoice.Invoice_Memo__c = objTSM.Shipment_Instructions__c;
        newInvoice.Shipped_Date__c = objTSM.Planned_Ship_Transfer_Date__c;
        newInvoice.Brand_Quote__c = objTSM.Brand_Quote__c;
        newInvoice.Opportunity_Name__c = objTSM.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = objTSM.Distributor_Name__c;
        newInvoice.Distributor_License__c = objTSM.Distributor_License__c;
        newInvoice.Distributor_Contact__c = objTSM.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = objTSM.Supplier_Name__c;
        newInvoice.Supplier_License__c = objTSM.Supplier_License__c;
        newInvoice.Supplier_Contact__c = objTSM.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = objTSM.Receiver_Name__c;
        newInvoice.Receiver_License__c = objTSM.Receiver_License__c;
        newInvoice.Receiver_Contact__c = objTSM.Receiver_Contact__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
        newInvoice.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(objTSM.Planned_Ship_Transfer_Date__c,
                                                                                           objTSM.Payment_Terms__c);

        insert newInvoice;
        
        List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
        For (Shipping_Manifest_Line__c objTSMlines: tsmLines)
        {
            Invoice_Line__c invLineItem = new Invoice_Line__c();
            invLineItem.Invoice__c = newInvoice.Id;
            invLineItem.Shipping_Manifest_Line__c = objTSMlines.Id;
            invLineItem.Product_Name__c = objTSMlines.Product_Name__c;
            invLineItem.Product_Title__c = objTSMlines.Product_Title__c;
            invLineItem.Unit_Cultivation_Tax__c = objTSMlines.Unit_Cultivation_Tax__c;
            invLineItem.Invoice_Qty__c = objTSMlines.Qty_Ordered__c;
            invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
            invLineItems.add(invLineItem);
        }
        insert invLineItems;
        retPage =new PageReference('/'+newInvoice.Id);
        return retPage;
     }

     public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }

}