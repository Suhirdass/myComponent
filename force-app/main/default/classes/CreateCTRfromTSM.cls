/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.
     
•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateCTRfromTSM{

    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c tsm= null;

    
    public CreateCTRfromTSM(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        tsm = ((Shipping_Manifest__c)stdController.getRecord());
        System.assertNotEquals(null, tsm, 'tsm record is null');
    }

     public PageReference createCTR() {
        PageReference retPage = null;
        try {
            List<Cultivation_Tax_Receipt__c> objects = [Select id from Cultivation_Tax_Receipt__c where Shipping_Manifest__c =: tsm.Id];
            if (objects.size() >= 1) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'CTR has already been created'));
                        return retPage ;
          }                        
            retPage = createOrder(tsm.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){

            ErrorLogs.log('CreateCTRfromCTR',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }

    public static PageReference createOrder(Id tsmoldId)
     {
        PageReference retPage = null;
        ID tsmID = tsmoldId;
        Shipping_Manifest__c objTSM= [select id ,name
                ,Sample_Order__c
                ,Ownership__c
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
                ,Site__c
                ,Shipping_Method__c
                ,Shipping_Terms__c       
                from Shipping_Manifest__c where id =: tsmID AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];

        //if (quote.fieldnameTBD != null){
            //throw new CustomerQuotationException('Brand Quote has already been converted to a Purchase Order.  You can only have one purchase order for a quote.');
        //}
        List<Shipping_Manifest_Line__c> tsmLines= [select id
                    ,name
                    ,Shipping_Manifest__c
                    ,Product_Name__c
                    ,Product_Title__c
                    ,Product_Name__r.Cultivation_Tax_Amount__c
                    ,Qty_Ordered__c
                    from Shipping_Manifest_Line__c
                    where Shipping_Manifest__c =: tsmID];


        Cultivation_Tax_Receipt__c newCTR = new Cultivation_Tax_Receipt__c();
        newCTR.Shipping_Manifest__c= tsmID;
        newCTR.Site__c = objTSM.Site__c;
        newCTR.Shipping_Method__c = objTSM.Shipping_Method__c;
        newCTR.Shipping_Terms__c = objTSM.Shipping_Terms__c;
        newCTR.Payment_Terms__c = objTSM.Payment_Terms__c;
        newCTR.Ownership__c = objTSM.Ownership__c;
        newCTR.Sample_Order__c = objTSM.Sample_Order__c;
        newCTR.Brand_Quote__c = objTSM.Brand_Quote__c;
        newCTR.Opportunity_Name__c = objTSM.Opportunity_Name__c;
        newCTR.Distributor_Name__c = objTSM.Distributor_Name__c;
        newCTR.Distributor_License__c = objTSM.Distributor_License__c;
        newCTR.Distributor_Contact__c = objTSM.Distributor_Contact__c;
        newCTR.Supplier_Name__c = objTSM.Supplier_Name__c;
        newCTR.Supplier_License__c = objTSM.Supplier_License__c;
        newCTR.Supplier_Contact__c = objTSM.Supplier_Contact__c;
        newCTR.Receiver_Name__c = objTSM.Receiver_Name__c;
        newCTR.Receiver_License__c = objTSM.Receiver_License__c;
        newCTR.Receiver_Contact__c = objTSM.Receiver_Contact__c;
        insert newCTR;
        
        List<Cultivation_Tax_Receipt_Line__c> CTRLineItems = new List<Cultivation_Tax_Receipt_Line__c>();
        For (Shipping_Manifest_Line__c objTSMlines: tsmLines)
        {
            Cultivation_Tax_Receipt_Line__c CTRLineItem = new Cultivation_Tax_Receipt_Line__c();
            CTRLineItem.Shipping_Manifest_Line__c= objTSMlines.Id;
            CTRLineItem.Product_Name__c = objTSMlines.Product_Name__c;
            CTRLineItem.Product_Title__c = objTSMlines.Product_Title__c;
            CTRLineItem.Qty_Ordered__c = objTSMlines.Qty_Ordered__c;
            CTRLineItem.Line_Total_CT_Amount__c = objTSMlines.Qty_Ordered__c * objTSMlines.Product_Name__r.Cultivation_Tax_Amount__c;
            CTRLineItem.Cultivation_Tax_Receipt__c = newCTR.Id;
            CTRLineItems.add(CTRLineItem);
        }
        insert CTRLineItems;
        
        retPage =new PageReference('/'+newCTR.Id);
        return retPage;
     }

     public PageReference goBack() {
            return stdController.view().setRedirect(true);
    }

}