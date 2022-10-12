/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReceivePaymentTriggerHandler
 */
public class ReceivePaymentTriggerHandler{
    
    public static final string RP_RECORD_TYPE_EXCISE_TAX = 'Excise Tax';
    public static final string RP_RECORD_TYPE_PRODUCT = 'Product';
    public static final string RP_RECORD_TYPE_CULTIVATION_TAX = 'Cultivation Tax';
    public Static String RP_RecordType_CreditCard{
        get{
            return String.isNotBlank(RP_RecordType_CreditCard) ? RP_RecordType_CreditCard: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_CreditCard');
        }set;
    }
    private static String Invoice_Record_Type_Credit_Memo{
        get{
            return String.isNotBlank(Invoice_Record_Type_Credit_Memo) ? Invoice_Record_Type_Credit_Memo : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Credit_Memo');
        }set;
    }
    public Static String Validation_Msg_for_delete_RecePayment{
        get{
            return String.isNotBlank(Validation_Msg_for_delete_RecePayment) ? Validation_Msg_for_delete_RecePayment: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Validation_Msg_for_delete_RecePayment');
        }set;
    }
     public Static String Validation_Msg_for_insert_update_RecePay{
        get{
            return String.isNotBlank(Validation_Msg_for_insert_update_RecePay) ? Validation_Msg_for_insert_update_RecePay: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Validation_Msg_for_insert_update_RecePay');
        }set;
    }
    private static String INVOICE_COLLECTION_STATUS_PASTDUE{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PASTDUE) ? INVOICE_COLLECTION_STATUS_PASTDUE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_PastDue');
        }set;
    }
    private static String INVOICE_COLLECTION_STATUS_PENDING{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PENDING) ? INVOICE_COLLECTION_STATUS_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_Pending');
        }set;
    }
    private static String INVOICE_COLLECTION_STATUS_PARTIALPAYMENT{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PARTIALPAYMENT) ? INVOICE_COLLECTION_STATUS_PARTIALPAYMENT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_partialPaymente');
        }set;
    }
    /**
     * Update invoice fields and Purchase Order fields related to roll up summary value of receive payments
     * Last Payment Date
     * Total Excise Tax Payments Received
     * Total Payments Received
     * Total Product Payments Received
     * @param receivePayments The trigger.new receive payment list
     */
    public static void updateInvoiceAttributesRelatedToReceivePayments(List<Receive_Payment__c> receivePayments,
                                                                       Map<Id, Receive_Payment__c> oldReceivePayments,
                                                                       Boolean isDeleteReceivePayment){
        Set<Id> invoiceIds = new Set<Id>();
        Set<Id> poIds = new Set<Id>();
                   // Date lastPaymentDate = null;
        // Retrieve all invoices
        for(Receive_Payment__c rpObj : receivePayments){
            if(rpObj.Invoice__c != null){
                invoiceIds.add(rpObj.Invoice__c);
            }else if(rpObj.Bill_Pay__c != null){
                poIds.add(rpObj.Bill_Pay__c);
            }
        }
        system.debug('rpObj'+receivePayments);
    
             
                                                                           
                                                                         
        // Calculate total fields of invoice
        if(invoiceIds.size() > 0){
            updateTotalFieldsOfInvoice(invoiceIds, oldReceivePayments, isDeleteReceivePayment);
        }
        
        // Calculate total fields of Purchase Order
        if(poIds.size() > 0){
            updateTotalFieldsOfPurchaseOrder(poIds, oldReceivePayments, isDeleteReceivePayment);
        }
    }
    public static void preventUpdatationOnLockedInvoice(List<Receive_Payment__c> newReceivePayments,List<Receive_Payment__c> oldReceivePayments){
        Set<Id> invoiceIds = new Set<Id>(); 
        if(Trigger.isDelete){
            for(Receive_Payment__c RP: oldReceivePayments){
                invoiceIds.add(RP.Invoice__c);
            }
        }else{
            for(Receive_Payment__c RP: newReceivePayments){
                invoiceIds.add(RP.Invoice__c);
            }
        }
        if(invoiceIds.size() > 0){
            List<Invoice__c> invoices = [SELECT Id FROM Invoice__c WHERE Id IN: invoiceIds AND IsLocked__c = true];
            if(invoices.size() > 0){
                if(Trigger.isDelete){
                    oldReceivePayments[0].addError(Validation_Msg_for_delete_RecePayment);
                    return;
                }else{
                    newReceivePayments[0].addError(Validation_Msg_for_insert_update_RecePay);
                    return;
                }
            }
        }
    }
    public static void updatePostedDate(List<Receive_Payment__c> receivePayments, Map<Id, Receive_Payment__c> oldReceivePayments){
        Set<Id> invIds = new Set<Id>();
          Map<Id,Date> Invlst = new Map<Id, Date>(); 
        for(Receive_Payment__c rpObj : receivePayments){
            if(rpObj.Invoice__c != null){
                if(Trigger.isInsert || (Trigger.isUpdate && rpObj.Posted_Date__c != oldReceivePayments.get(rpObj.Id).Posted_Date__c)){
                    invIds.add(rpObj.Invoice__c);
                     Invlst.put(rpObj.Invoice__c , rpObj.Posted_Date__c);  
                }
            }
        }
        List<Invoice__c> lstInvoice = [select Id,Posted_Date__c,(select Id,Posted_Date__c,Payment_Received_Date__c from Receive_Payments__r order by Posted_Date__c DESC nulls last) FROM Invoice__c WHERE ID IN : invIds AND Collections_Status__c = 'Paid in Full'];
        system.debug('lstInvoice>>'+lstInvoice);
        List<Invoice__c> updatedInvoice = new List<Invoice__c>();
       
        if(lstInvoice.size() > 0){
            for(Invoice__c inv : lstInvoice){
            	List<Receive_Payment__c> lstReceive = inv.Receive_Payments__r;
                system.debug('lstReceive>>'+lstReceive);
                if(lstReceive.size() > 0){
                    Boolean isHasRecords = true;
                    for(Receive_Payment__c rec : lstReceive){
                        if(rec.Posted_Date__c == null){
                        	isHasRecords = false;
                            break;
                        }    
                    }
                    if(isHasRecords){
                    	inv.Posted_Date__c = lstReceive[0].Posted_Date__c;
                        updatedInvoice.add(inv);    
                    }  
                }
            }
            
            if(updatedInvoice.size() > 0){
            	update updatedInvoice;    
            }
        }
    }  
    
    
    
    /**
     * Update invoice fields related to roll up summary value of receive payments
     * Last Payment Date
     * Total Excise Tax Payments Received
     * Total Payments Received
     * Total Product Payments Received
     * @param invoiceIds The set of invoice ids
     */
    private static void updateTotalFieldsOfInvoice(Set<Id> invoiceIds, 
                                                   Map<Id, Receive_Payment__c> oldReceivePayments,
                                                   Boolean isDeleteReceivePayment){
        if(invoiceIds.size() > 0){
            List<Invoice__c> invoicesToUpdate = [Select Last_Payment_Date__c,Invoice_Due_Date__c,Collections_Status__c,
                                                       Total_Excise_Tax_Payments_Received__c,
                                                       Total_Payments_Received__c,
                                                       Total_Product_Payments_Received__c,
                                                       Total_Cultivation_Tax_Payments_Received__c,
                                                       (Select Payment_Amount__c, Payment_Received_Date__c,Posted_Date__c, 
                                                        RecordType.Name From Receive_Payments__r Order BY Posted_Date__c DESC NULLS LAST,Payment_Received_Date__c DESC )
                                                From Invoice__c where Id IN: invoiceIds AND RecordType.Name !=: Invoice_Record_Type_Credit_Memo];
            system.debug('invoicesToUpdate'+invoicesToUpdate);
                
              //List<Receive_Payment__c> RPToUpdate = [Select Last_Payment_Date__c, 
          // Date lastPaymentDate = null;
            Decimal totalExciseTaxPayments;
            Decimal totalPaymentAmount;
            Decimal totalProductPaymentAmount;
            Decimal totalCultivationTaxAmount;
            Map<Id,Invoice__c> invoicesToUpdateMap = new Map<Id,Invoice__c>();
            // Iterate on all invoices - context from trigger
            for(Invoice__c invoiceSO : invoicesToUpdate){
                
                totalExciseTaxPayments = 0.0;
                totalPaymentAmount = 0.0;
                totalProductPaymentAmount = 0.0;
                totalCultivationTaxAmount = 0.0;
                

                if(invoiceSO.Invoice_Due_Date__c < Date.today() && invoiceSO.Receive_Payments__r.size() == 0){
                    invoiceSO.Collections_Status__c = INVOICE_COLLECTION_STATUS_PASTDUE;
                } else if(invoiceSO.Invoice_Due_Date__c >= Date.today() && invoiceSO.Receive_Payments__r.size() == 0){
                    invoiceSO.Collections_Status__c = INVOICE_COLLECTION_STATUS_PENDING;
                } else if(invoiceSO.Receive_Payments__r.size() > 0){
                    invoiceSO.Collections_Status__c = INVOICE_COLLECTION_STATUS_PARTIALPAYMENT;
                }
                
                if(invoiceSO.Receive_Payments__r.size() == 0){
                    invoiceSO.Last_Payment_Date__c = null;
                }
                
                if(invoiceSO.Receive_Payments__r.size() > 0){
                    invoiceSO.Last_Payment_Date__c = invoiceSO.Receive_Payments__r[0].Posted_Date__c != null ? invoiceSO.Receive_Payments__r[0].Posted_Date__c : invoiceSO.Receive_Payments__r[0].Payment_Received_Date__c;
                }
                
                
                // Iterate on all related receive payments
                for(Receive_Payment__c rpObj : invoiceSO.Receive_Payments__r){
                    // Calculate last payment date
                     /* if((!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)) && 
                      (lastPaymentDate == null || lastPaymentDate < rpObj.Payment_Received_Date__c )){
                             // lastPaymentDate = rpObj.Payment_Received_Date__c; 
                    }*/
                    
                    // Calculate Total Excise Tax Payments Received
                    if(rpObj.RecordType.Name == RP_RECORD_TYPE_EXCISE_TAX){
                        if(!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)){
                            totalExciseTaxPayments += rpObj.Payment_Amount__c;
                        }
                    }
                    
                    // Calculate Total Excise Tax Payments Received
                    if(rpObj.RecordType.Name == RP_RECORD_TYPE_PRODUCT){
                        if(!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)){
                            totalProductPaymentAmount += rpObj.Payment_Amount__c;
                        }
                    }
                    
                    // Calculate Total Cultivation Tax Payments Received
                    if(rpObj.RecordType.Name == RP_RECORD_TYPE_CULTIVATION_TAX){
                        if(!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)){
                            totalCultivationTaxAmount += rpObj.Payment_Amount__c;
                        }
                    }
                    
                    // Calculate Total Payments Received
                    if(!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)){
                        totalPaymentAmount += rpObj.Payment_Amount__c;
                    }
                }
                
                // Assign values to invoices
               // invoiceSO.Last_Payment_Date__c = lastPaymentDate;
                invoiceSO.Total_Excise_Tax_Payments_Received__c = totalExciseTaxPayments;
                invoiceSO.Total_Product_Payments_Received__c = totalProductPaymentAmount;
                invoiceSO.Total_Cultivation_Tax_Payments_Received__c = totalCultivationTaxAmount;
                invoiceSO.Total_Payments_Received__c = totalPaymentAmount;
                invoicesToUpdateMap.put(invoiceSO.Id,invoiceSO);
            }
            
           update invoicesToUpdateMap.values();
        }
    }
    
    /**
     * Update "Total Payments Made" of Purchase Order related to receive payments
     * @param poIds The set of Purchase Order Ids
     */
    private static void updateTotalFieldsOfPurchaseOrder(Set<Id> poIds,  
                                                         Map<Id, Receive_Payment__c> oldReceivePayments,
                                                         Boolean isDeleteReceivePayment){
        if(poIds.size() > 0){
            List<Purchase_Order__c> posToUpdate = [Select Total_Payments_Made__c,Total_Cost__c,Supplier_Payment_Settled_Date__c,
                                                  (Select Payment_Amount__c, Payment_Received_Date__c,Posted_Date__c  From Receive_Payments__r)
                                                From Purchase_Order__c where Id IN: poIds];
            
            Decimal totalPaymentsMade;
            
            // Iterate on all invoices - context from trigger
            for(Purchase_Order__c poSO : posToUpdate){
                
                totalPaymentsMade = 0.0;
                Date latestTransactionDate;
                // Iterate on all related receive payments
                for(Receive_Payment__c rpObj : poSO.Receive_Payments__r){
                    if((!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)) &&
                       (latestTransactionDate == null || rpObj.Payment_Received_Date__c > latestTransactionDate)){
                        latestTransactionDate = rpObj.Payment_Received_Date__c;
                    }
                    // Calculate Total Payments Made
                    if(!isDeleteReceivePayment || !oldReceivePayments.containsKey(rpObj.Id)){
                        totalPaymentsMade += rpObj.Payment_Amount__c;
                    }
                }
                
                // Assign values to invoices
                poSO.Total_Payments_Made__c = totalPaymentsMade;
                if(poSo.Total_Cost__c - totalPaymentsMade == 0){
                    poSo.Supplier_Payment_Settled_Date__c = latestTransactionDate;
                }else if(poSo.Total_Cost__c - totalPaymentsMade > 0){
                    poSo.Supplier_Payment_Settled_Date__c = null;
                }
            }
            update posToUpdate;
        }
    }
    
  public static void updateLastPaymentDate(List<Receive_Payment__c> receivePayments){
      system.debug('updateLastPaymentDate');
      system.debug('receivePayments'+receivePayments);
      Map<Id,Date> Invlst = new Map<Id, Date>(); 
      for(Receive_Payment__c RP:receivePayments) {
          if(RP.Posted_Date__c !=null)
          {
              Invlst.put(RP.Invoice__c , RP.Posted_Date__c);  
          }else{
              Invlst.put(RP.Invoice__c , RP.Payment_Received_Date__c);         
          }
          
      }  
      Map<Id,Date> InvlstBQ = new Map<Id, Date>(); 
      List<Invoice__c> listUpdatedinvpost = new List<Invoice__c>(); 
      for(Invoice__c acc:[Select id,Last_Payment_Date__c,Collections_Status__c,Posted_Date__c From Invoice__c Where Id IN :Invlst.Keyset()]) {
          if(Invlst.containsKey(acc.id)) {
              listUpdatedinvpost.add(new Invoice__c(Id = acc.id, Last_Payment_Date__c=Invlst.get(acc.id)));
              InvlstBQ.put(acc.id , acc.Last_Payment_Date__c);  
          }
      }
      List<Brand_Quote__c> listUpdatedBQLastPaymentDate = new List<Brand_Quote__c>(); 
      
      for(Brand_Quote__c BQ :[Select id,Last_Payment_Date__c From Brand_Quote__c Where Id IN :InvlstBQ.Keyset()])  
      { 
          if(InvlstBQ.containsKey(BQ.id)) {
              listUpdatedBQLastPaymentDate.add(new Brand_Quote__c(Id = BQ.id, Last_Payment_Date__c=InvlstBQ.get(BQ.id)));
          }  
      }
      // update listUpdatedBQLastPaymentDate;
      update listUpdatedinvpost;  
  }     
    
    public static void onDeleteCreditApplied(List<Receive_Payment__c> oldReceivePayments){
        Set<String> invIds = new Set<String>();
        Id creditMemoRecordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RP_RecordType_CreditCard).getRecordTypeId();
        for(Receive_Payment__c rp : oldReceivePayments){
            if(rp.RecordTypeId == creditMemoRecordTypeId){
                invIds.add(rp.Invoice__c);
                if(rp.Credit_Memo__c != null) invIds.add(rp.Credit_Memo__c);
            }
        }
        
        if(invIds.size() >0 ){
            updateInvoiceCreditMemo(invIds);
        }        
    }
    
    public static void creditAppliedCount(List<Receive_Payment__c> receivePayments,Boolean isUpdate,Map<Id, Receive_Payment__c> oldReceivePayments){
        Set<String> invIds = new Set<String>();
        Set<String> rpIds = new Set<String>();
        for(Receive_Payment__c rp : receivePayments){
            rpIds.add(rp.id);
        }
        for(Receive_Payment__c rp : [SELECT id,RecordType.Name,Invoice__c,Credit_Memo__c FROM Receive_Payment__c WHERE Id IN : rpIds]){
            system.debug('## RecordType.Name'+rp.RecordType.Name);
            if(rp.RecordType.Name == RP_RecordType_CreditCard){
                if(isUpdate){
                    if(oldReceivePayments.get(rp.Id).Invoice__c != rp.Invoice__c || oldReceivePayments.get(rp.Id).Credit_Memo__c != rp.Credit_Memo__c){
                        invIds.add(oldReceivePayments.get(rp.Id).Invoice__c);
                		if(oldReceivePayments.get(rp.Id).Invoice__c != null) invIds.add(oldReceivePayments.get(rp.Id).Invoice__c);
                    }
                }
                invIds.add(rp.Invoice__c);
                if(rp.Credit_Memo__c != null) invIds.add(rp.Credit_Memo__c);
            }
        }
        system.debug('## invIds'+invIds);
        if(invIds.size() >0 ){
            updateInvoiceCreditMemo(invIds);
        }
    }
    
    public static void updateInvoiceCreditMemo(Set<String> invIds){
        List<Invoice__c> invUpdateList = new List<Invoice__c>();
        for(Invoice__c inv : [SELECT id,Total_Payments_Received__c,(SELECT Id,Payment_Amount__c FROM Receive_Payments1__r WHERE RecordType.Name =: RP_RecordType_CreditCard) FROM Invoice__c WHERE id IN : invIds AND RecordType.Name =: Invoice_Record_Type_Credit_Memo]){
            
            if(inv.Receive_Payments1__r.size() > 0){
                inv.Total_Payments_Received__c = 0;
                for(Receive_Payment__c rp : inv.Receive_Payments1__r){
                    inv.Total_Payments_Received__c += rp.Payment_Amount__c;
                }
                invUpdateList.add(inv);
            }else{
                inv.Total_Payments_Received__c = 0;
                invUpdateList.add(inv);
            }
        }
        if(invUpdateList.size() > 0){
            update invUpdateList;
        }
    }
}