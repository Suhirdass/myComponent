/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.
     •  Test class  Name:  CreateRLfromPOlineTest

*/
public class CreateCTIfromPO{
	private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    private ApexPages.StandardController stdController;
    private Purchase_Order__c po = null;
    
    public CreateCTIfromPO(ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        po = ((Purchase_Order__c)stdController.getRecord());
        System.assertNotEquals(null, po, 'po record is null');
    }

     public PageReference createCTI() {
        PageReference retPage = null;
        try {

            Purchase_Order__c poDetail = [select id, PO_Status__c from Purchase_Order__c where Id  =: po.Id];
            if(poDetail.PO_Status__c == 'Draft')
            {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Please submit PO for Approval and try again to create Cultivation Tax Invoice.'));
                    return retPage ;
            }
			
			if(poDetail.PO_Status__c == 'Cancelled')
            {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Cannot create Cultivation Tax Invoice on Cancelled PO.'));
                    return retPage ;
            }

            List<Invoice__c> objects = [Select id from Invoice__c where Purchase_Order__c =: po.Id and (AR_Status__c = 'Approved' or AR_Status__c = 'Shipped')];
            if (objects.size() >= 1) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'CTI has already been created'));
                        return retPage ;
          }
            retPage = createCTInvoice(po.Id);
            retPage.setRedirect(true);
        } catch (Exception ex){

            ErrorLogs.log('CreateCTIfromPO',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }
    
    public CreateCTIfromPO(){}  
    
    @AuraEnabled
    public static AuraResponse createCTILight(String recordId){
        System.debug('Calling createCTILight method...'+recordId);
        AuraResponse r = new AuraResponse('CreateCTIfromPO.createCTILight()');
        
         string setInvoice;
     	
        CreateCTIfromPO assign = new CreateCTIfromPO();
        Purchase_Order__c statusPO = [select id, PO_Status__c from Purchase_Order__c where Id  =: recordId];
        System.debug('statusPO data...'+statusPO);
        List<Invoice__c> objects = [Select id from Invoice__c where Purchase_Order__c =: recordId and (AR_Status__c = 'Approved' or AR_Status__c = 'Shipped')];
        
        String statusPOerror;
       

            if(statusPO.PO_Status__c == 'Draft')
            {
                	system.debug('1st if');
                    statusPOerror = 'Error1';
                	r.data.put('statusPOerror',statusPOerror);
                    return r;
            }else if(statusPO.PO_Status__c == 'Cancelled')
            {
                	system.debug('2nd if');
                    statusPOerror = 'Error2';
                	r.data.put('statusPOerror',statusPOerror);
                    return r;
            }else if (objects.size() >= 1) {
                system.debug('3rd if');
           		statusPOerror = 'Error3';
                r.data.put('statusPOerror',statusPOerror);
                 return r;
          }else{
                system.debug('No err 3rd if');
              //createCTInvoice(recordId);
             setInvoice = createCTInvoiceLight(recordId);
               r.data.put('setInvoice',setInvoice);
            }
		
        return r;
    }
    
       public static string createCTInvoiceLight(Id pooldId)
     {
       // PageReference retPage = null;
        
        ID poID = pooldId;
        Purchase_Order__c objPO= [select id ,name
                ,Sample_Order__c
                ,Receiver_Name__r.Payment_Terms__c
                ,Ownership__c
                ,Opportunity_Name__c
                ,Distributor_Name__c
                ,Purchase_Order_Instructions__c
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
				,Ship_Confirmation_Date__c 
                from Purchase_Order__c where id =: poID ];

        List<Purchase_Order_Line__c> poLines= [select id
                    ,name
                    ,Purchase_Order__c
                    ,Product_Name__c
                    ,Purchase_Order__r.Ownership__c
                    ,Product_Title__c
                    ,Apply_Cultivation_Tax__c
                    ,WAVG_Unit_Cultivation_Tax__c
                    ,WAVG_Cannabis_Weight__c
                    ,Cannabis_Weight_UOM__c
                    ,Qty_Ordered__c
                    ,Promised_Date__c
                    ,Subtotal_Cannabis_Weight__c,
                    Ownership_Code__c 
                    from Purchase_Order_Line__c
                    where Purchase_Order__c =: poID and POLI_Status__c != 'Cancelled'
                    AND (Product_Name__r.Auto_Allocation__c = FALSE OR 
                    (Product_Name__r.Auto_Allocation__c = TRUE AND Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))];


        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Purchase_Order__c= poID;
         newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
        newInvoice.Site__c = objPO.Site__c;
        newInvoice.Shipping_Method__c = objPO.Shipping_Method__c;
        newInvoice.Shipping_Terms__c = objPO.Shipping_Terms__c;
       newInvoice.Payment_Terms__c = objPO.Receiver_Name__r.Payment_Terms__c;
        newInvoice.Sample_Order__c = objPO.Sample_Order__c;
        newInvoice.Invoice_Memo__c = objPO.Purchase_Order_Instructions__c; 
        newInvoice.Brand_Quote__c = objPO.Brand_Quote__c;
        newInvoice.Opportunity_Name__c = objPO.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = objPO.Distributor_Name__c;
        newInvoice.Distributor_License__c = objPO.Distributor_License__c;
        newInvoice.Distributor_Contact__c = objPO.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = objPO.Supplier_Name__c;
        newInvoice.Supplier_License__c = objPO.Supplier_License__c;
        newInvoice.Supplier_Contact__c = objPO.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = objPO.Receiver_Name__c;
        newInvoice.Receiver_License__c = objPO.Receiver_License__c;
        newInvoice.Receiver_Contact__c = objPO.Receiver_Contact__c;
		newInvoice.Ownership__c = objPO.Ownership__c;
		newInvoice.Ship_Confirmation_Date__c = objPO.Ship_Confirmation_Date__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
		newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
        insert newInvoice;
        
        List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
        For (Purchase_Order_Line__c objPOlines: poLines)
        {
            Invoice_Line__c invLineItem = new Invoice_Line__c();
            invLineItem.Invoice__c = newInvoice.Id;
            invLineItem.PO_Line__c = objPOlines.Id;
            invLineItem.Product_Name__c = objPOlines.Product_Name__c;
            invLineItem.Product_Title__c = objPOlines.Product_Title__c;
            invLineItem.Purchased_Date__c = objPOlines.Promised_Date__c;
            invLineItem.Unit_Cannabis_Weight__c = objPOlines.WAVG_Cannabis_Weight__c;
            invLineItem.Unit_Cultivation_Tax__c = objPOlines.WAVG_Unit_Cultivation_Tax__c;
            invLineItem.Invoice_Qty__c = objPOlines.Qty_Ordered__c;
            if(objPOlines.Ownership_Code__c != null){
            	invLineItem.OwnershipCode__c = objPOlines.Ownership_Code__c;    
            } else{
                invLineItem.OwnershipCode__c = objPOlines.Purchase_Order__r.Ownership__c;
            }
            invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
            invLineItems.add(invLineItem);
        }
        insert invLineItems;
        String retPage = newInvoice.Id;
       system.debug(' retPage Lightning output.....'+ retPage);
        return retPage;
     }
    
  
    public static PageReference createCTInvoice(Id pooldId)
     {
        PageReference retPage = null;
        ID poID = pooldId;
        Purchase_Order__c objPO= [select id ,name
                ,Sample_Order__c
                ,Ownership__c
                ,Opportunity_Name__c
                ,Distributor_Name__c
                ,Distributor_License__c
                ,Distributor_Contact__c
                ,Receiver_Name__c
                ,Purchase_Order_Instructions__c
                ,Receiver_License__c
                ,Receiver_Contact__c
                ,Supplier_Name__c
                ,Supplier_License__c
                ,Supplier_Contact__c
                ,Brand_Quote__c,Brand_Quote__r.RecordType.Name
                ,Payment_Terms__c
                ,Site__c
                ,Shipping_Method__c
                ,Shipping_Terms__c
				,Ship_Confirmation_Date__c 
                from Purchase_Order__c where id =: poID ];

        List<Purchase_Order_Line__c> poLines= [select id
                    ,name
                    ,Purchase_Order__c
                    ,Purchase_Order__r.Ownership__c
                    ,Product_Name__c
                    ,Product_Title__c
                    ,Apply_Cultivation_Tax__c
                    ,WAVG_Unit_Cultivation_Tax__c
                    ,WAVG_Cannabis_Weight__c
                    ,Cannabis_Weight_UOM__c
                    ,Qty_Ordered__c
                    ,Promised_Date__c
                    ,Subtotal_Cannabis_Weight__c
                    ,Ownership_Code__c
                    from Purchase_Order_Line__c
                    where Purchase_Order__c =: poID and POLI_Status__c != 'Cancelled'];


        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Purchase_Order__c= poID;
        newInvoice.Site__c = objPO.Site__c;
        newInvoice.Shipping_Method__c = objPO.Shipping_Method__c;
        newInvoice.Shipping_Terms__c = objPO.Shipping_Terms__c;
        newInvoice.Invoice_Memo__c = objPO.Purchase_Order_Instructions__c; 
        newInvoice.Payment_Terms__c = 'COD';// objPO.Payment_Terms__c;
        newInvoice.Sample_Order__c = objPO.Sample_Order__c;
        newInvoice.Brand_Quote__c = objPO.Brand_Quote__c;
        newInvoice.Opportunity_Name__c = objPO.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = objPO.Distributor_Name__c;
        newInvoice.Distributor_License__c = objPO.Distributor_License__c;
        newInvoice.Distributor_Contact__c = objPO.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = objPO.Supplier_Name__c;
        newInvoice.Supplier_License__c = objPO.Supplier_License__c;
        newInvoice.Supplier_Contact__c = objPO.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = objPO.Receiver_Name__c;
        newInvoice.Receiver_License__c = objPO.Receiver_License__c;
        newInvoice.Receiver_Contact__c = objPO.Receiver_Contact__c;
		newInvoice.Ownership__c = objPO.Ownership__c; 
		newInvoice.Ship_Confirmation_Date__c = objPO.Ship_Confirmation_Date__c;
        if(objPO.Brand_Quote__r.RecordType.Name == 'Transfer Quote')
        	newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
         else
             newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
		newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
        
         insert newInvoice;
        
        List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
        For (Purchase_Order_Line__c objPOlines: poLines)
        {
            Invoice_Line__c invLineItem = new Invoice_Line__c();
            invLineItem.Invoice__c = newInvoice.Id;
            invLineItem.PO_Line__c = objPOlines.Id;
            invLineItem.Product_Name__c = objPOlines.Product_Name__c;
            invLineItem.Product_Title__c = objPOlines.Product_Title__c;
            invLineItem.Purchased_Date__c = objPOlines.Promised_Date__c;
            invLineItem.Unit_Cannabis_Weight__c = objPOlines.WAVG_Cannabis_Weight__c;
            invLineItem.Unit_Cultivation_Tax__c = objPOlines.WAVG_Unit_Cultivation_Tax__c;
            invLineItem.Invoice_Qty__c = objPOlines.Qty_Ordered__c;
            
            if(objPOlines.Ownership_Code__c != null){
            	invLineItem.OwnershipCode__c = objPOlines.Ownership_Code__c;    
            } else{
                invLineItem.OwnershipCode__c = objPOlines.Purchase_Order__r.Ownership__c;
            }
            if(objPO.Brand_Quote__r.RecordType.Name == 'Transfer Quote')
            	invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
            else
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
        @Auraenabled

 public static String getRecordName(Id recordId){
        return DataCRUDUtility.getRecordName(recordId);
    }
}