public class InvoiceTriggerHandler {
    
    public Static String INVOICE_AR_STATUS_APPROVED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_APPROVED) ? INVOICE_AR_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    public Static String INVOICE_AR_STATUS_SHIPPED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_SHIPPED) ? INVOICE_AR_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    Public Static String INVOICE_COLL_STATUS_PENDING{
        get{
            return String.isNotBlank(INVOICE_COLL_STATUS_PENDING) ? INVOICE_COLL_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_Pending');
        }set;
    }
    Public Static String INVOICE_COLL_STATUS_NOT_COLLECTABLE{
        get{
            return String.isNotBlank(INVOICE_COLL_STATUS_NOT_COLLECTABLE) ? INVOICE_COLL_STATUS_NOT_COLLECTABLE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_Not_Collectabl');
        }set;
    }
    private static String Invoice_Record_Type_Product{
        get{
            return String.isNotBlank(Invoice_Record_Type_Product) ? Invoice_Record_Type_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public static String Invoice_Record_Type_Tax{
        get{
            return String.isNotBlank(Invoice_Record_Type_Tax) ? Invoice_Record_Type_Tax : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
    public static String Validation_Msg_for_update_INV{
        get{
            return String.isNotBlank(Validation_Msg_for_update_INV) ? Validation_Msg_for_update_INV : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Validation_Msg_for_update_INV');
        }set;
    }
    public static String Validation_Msg_for_delete_INV{
        get{
            return String.isNotBlank(Validation_Msg_for_delete_INV) ? Validation_Msg_for_delete_INV : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Validation_Msg_for_delete_INV');
        }set;
    }
    
    Public Static String statusPaidInFull = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAID_IN_FULL;
    Public Static String statusPastDue = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAST_DUE;

    
    public static void afterInsert(List<Invoice__c> lstInvoice){
        Set<Id> invIds = new Set<Id>();
        
        for(Invoice__c inv : lstInvoice){
            if(inv.Collections_Status__c == statusPaidInFull){
                invIds.add(inv.Id);       
            }    
        }
        if(invIds.size() > 0){
            InvoiceTriggerHandler.updatePostedDate(invIds);    
        }
        InvoiceTriggerHandler.invoiceCollectionHelperInvoiceToSellQuote(lstInvoice,null,false);
    }
    
    public static void afterUpdate(List<Invoice__c> lstInvoice,Map<Id,Invoice__c> oldMap){
        Set<Id> invIds = new Set<Id>();
        for(Invoice__c inv : lstInvoice){
            Invoice__c oldInv = oldMap.get(inv.Id);
            if(inv.Collections_Status__c == statusPaidInFull && inv.Collections_Status__c != oldInv.Collections_Status__c){
                invIds.add(inv.Id);    
            }
        }
        if(invIds.size() > 0){
            InvoiceTriggerHandler.updatePostedDate(invIds);    
        }
        InvoiceTriggerHandler.invoiceCollectionHelperInvoiceToSellQuote(lstInvoice,oldMap,true);
    }
    public static void beforeDelete(List<Invoice__c> lstInvoice,Map<Id,Invoice__c> oldMap){
        for(Invoice__c inv: oldMap.values()){
            if(inv.IsLocked__c == true){
                lstInvoice[0].addError(Validation_Msg_for_delete_INV);
                return;
            }
        }
    }
    public static void beforeUpdate(List<Invoice__c> lstInvoice,Map<Id,Invoice__c> oldMap){
        for(Invoice__c inv: lstInvoice){
            if(oldMap.get(inv.Id).IsLocked__c == inv.IsLocked__c && inv.IsLocked__c == true){
                lstInvoice[0].addError(Validation_Msg_for_update_INV);
                return;
            }
        }
        updateInvoiceCollectionValues(lstInvoice,oldMap,true);
    }
    
    public static void beforeInsert(List<Invoice__c> lstInvoice){
        updateInvoiceCollectionValues(lstInvoice,null,false);
        //Update Invoice Fields Sales Person and Order Type
        /*Set<Id> invIds = (new Map<Id,Invoice__c>(lstInvoice)).keySet();
        Map<Id,Invoice__c> mapList = new Map<Id,Invoice__c>();
        for(Invoice__c inv : [SELECT Id,Name,Sales_Person__c,Order_Type__c,Brand_Quote__c,Brand_Quote__r.Sales_Person__c,Brand_Quote__r.Order_Type__c FROM Invoice__c WHERE Id In : invIds]){
            if(inv.Brand_Quote__r.Sales_Person__c != null && inv.Brand_Quote__r.Order_Type__c != null){
                inv.Order_Type__c = inv.Brand_Quote__r.Order_Type__c;
                inv.Sales_Person__c = inv.Brand_Quote__r.Sales_Person__c;
                mapList.put(inv.Id,inv);    
            }    
        }
        for(Invoice__c inv : lstInvoice){
            if(mapList.containsKey(inv.Id)){
                Invoice__c invRec = mapList.get(inv.Id);
                inv.Order_Type__c = invRec.Order_Type__c;
                inv.Sales_Person__c = invRec.Sales_Person__c;
            }
        }*/
    }
    
    public static void invoiceCollectionHelperInvoiceToSellQuote(List<Invoice__c> lstInvoice,Map<Id,Invoice__c> oldMap, Boolean isUpdateInvoice){
        
        List<Brand_Quote__c> lstBrandToUpdate = new list<Brand_Quote__c>();
        
       /* Set<Id> bqIds = new Set<Id>();
        Set<Id> SOIds = new Set<Id>();
        string rtName ='';
        for(Invoice__c inv : lstInvoice){
            if(inv.RecordTypeId != null )
                rtName = Schema.getGlobalDescribe().get('Invoice__c').getDescribe().getRecordTypeInfosById().get(inv.RecordTypeId).getName();
            
            if(rtName == Invoice_Record_Type_Product && inv.Sales_Order__c != NULL ){
                 SOIds.add(inv.Sales_Order__c);
            }
            if(inv.Brand_Quote__c != null){
             	bqIds.add(inv.Brand_Quote__c);   
            }	
            if(inv.Sales_Order__c != NULL){
                SOIds.add(inv.Sales_Order__c);
            }
        }
        
        if(bqIds.size() > 0){
            Map<Id,Brand_Quote__c> mapBq = new Map<Id,Brand_Quote__c>([SELECT Id,Name FROM Brand_Quote__c WHERE Id IN :bqIds]);
        }*/
        Map<Id, Map<Id,Brand_Quote__c>> mapOfBQListForUpdate = new Map<Id, Map<Id,Brand_Quote__c>>();
        Set<Id> invIds = new Set<Id>();
        system.debug('##lstInvoice :'+lstInvoice.size());
        for(Invoice__c inv : lstInvoice){
            String recTypeName = '';
            
            if(inv.RecordTypeId != null )
                recTypeName = Schema.getGlobalDescribe().get('Invoice__c').getDescribe().getRecordTypeInfosById().get(inv.RecordTypeId).getName();
            system.debug('##recTypeName : '+recTypeName);
            Brand_Quote__c bq = new Brand_Quote__c();
            Map<Id,Brand_Quote__c> BQMap = new Map<Id,Brand_Quote__c>();
            //Invoice Collection Status Changes 1
            if(recTypeName == Invoice_Record_Type_Product && inv.Posted_Date__c != null && 
               (inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED || inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED) && inv.Brand_Quote__c != null){
                   //Brand_Quote__c bq = new Brand_Quote__c();
                   system.debug('##enter first If');
                   bq.Id = inv.Brand_Quote__c;
                   bq.Collection_Status__c = inv.Collections_Status__c;
                   bq.Last_Payment_Date__c = inv.Posted_Date__c;
                   invIds.add(inv.Id);
                   
                   if(mapOfBQListForUpdate.containsKey(inv.Sales_Order__c)){
                      BQMap =  mapOfBQListForUpdate.get(inv.Sales_Order__c);//.add(bq);
                   }else{
                       BQMap = new Map<Id,Brand_Quote__c>();
                   }
                   BQMap.put(bq.Id,bq);
                   mapOfBQListForUpdate.put(inv.Sales_Order__c,BQMap); 
               } else if(isUpdateInvoice){
                   Invoice__c oldInvoice = oldMap.get(inv.Id);
                   if(inv.Posted_Date__c == null && recTypeName == Invoice_Record_Type_Product && (oldInvoice.AR_Status__c != inv.AR_Status__c || oldInvoice.Invoice_Balance__c != inv.Invoice_Balance__c )&&
                      (inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED || inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED) && inv.Brand_Quote__c != null){
                          // Brand_Quote__c bq = new Brand_Quote__c();
                          system.debug('##enter Second If');
                          bq.Id = inv.Brand_Quote__c;
                          bq.Collection_Status__c = inv.Collections_Status__c;
                          invIds.add(inv.Id);
                          if(mapOfBQListForUpdate.containsKey(inv.Sales_Order__c)){
                              BQMap =  mapOfBQListForUpdate.get(inv.Sales_Order__c);//.add(bq);
                          }else{
                              BQMap = new Map<Id,Brand_Quote__c>();
                          }
                          BQMap.put(bq.Id,bq);
                          mapOfBQListForUpdate.put(inv.Sales_Order__c,BQMap); 
                      } 
                   else if(recTypeName == Invoice_Record_Type_Product && (inv.AR_Status__c == INVOICE_AR_STATUS_CANCELLED || inv.AR_Status__c == INVOICE_AR_STATUS_REJECTED) &&
                           inv.Brand_Quote__c != null && oldInvoice.AR_Status__c != inv.AR_Status__c){
                               //Brand_Quote__c bq = new Brand_Quote__c();
                               system.debug('##enter Third If');
                               bq.Id = inv.Brand_Quote__c;
                               bq.Collection_Status__c = inv.Collections_Status__c;
                               bq.Last_Payment_Date__c = inv.Posted_Date__c;
                               invIds.add(inv.Id);
                               if(mapOfBQListForUpdate.containsKey(inv.Sales_Order__c)){
                                   BQMap =  mapOfBQListForUpdate.get(inv.Sales_Order__c);//.add(bq);
                               }else{
                                   BQMap = new Map<Id,Brand_Quote__c>();
                               }
                               BQMap.put(bq.Id,bq);
                               mapOfBQListForUpdate.put(inv.Sales_Order__c,BQMap);      
                           }
                   
               }
        }
        
        Map<String, List<Invoice__c>> mapOfInvoiceList = new Map<String, List<Invoice__c>>();
        System.debug('##mapOfBQListForUpdate :'+mapOfBQListForUpdate);
        
        if(mapOfBQListForUpdate.size() > 0 ){
            for(Invoice__c inv :[SELECT Id,Sales_Order__c FROM Invoice__c WHERE RecordType.Name =: Invoice_Record_Type_Product AND Posted_Date__c = null AND Sales_Order__c IN : mapOfBQListForUpdate.keySet() AND Id NOT IN : invIds]){
                if(mapOfInvoiceList.containsKey(inv.Sales_Order__c)){
                    mapOfInvoiceList.get(inv.Sales_Order__c).add(inv);
                }else{
                    mapOfInvoiceList.put(inv.Sales_Order__c,new List<Invoice__c>{inv}); 
                }
            }
            System.debug('##mapOfInvoiceList :'+mapOfInvoiceList);
                for(String SOId : mapOfBQListForUpdate.keySet()){
                    if(mapOfInvoiceList.containsKey(SOId) ){
                        if(mapOfInvoiceList.get(SOId).size() == 0)
                        	lstBrandToUpdate.addAll(mapOfBQListForUpdate.get(SOId).values());
                    }else{
                        lstBrandToUpdate.addAll(mapOfBQListForUpdate.get(SOId).values());
                    }
                }
            
        }
		if(lstBrandToUpdate.size() > 0){
            update lstBrandToUpdate;
        }        
       /* for(Invoice__c inv : lstInvoice){
            //String recTypeName = '';
            String recDevloperName = '';
            
            if(inv.RecordTypeId != null )
                recTypeName = Schema.getGlobalDescribe().get('Invoice__c').getDescribe().getRecordTypeInfosById().get(inv.RecordTypeId).getName();
            	recDevloperName = Schema.getGlobalDescribe().get('Invoice__c').getDescribe().getRecordTypeInfosById().get(inv.RecordTypeId).getDeveloperName();
                    
            //Invoice Collection Status Changes 1
            if(recTypeName == Invoice_Record_Type_Product && inv.Posted_Date__c != null && 
               (inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED || inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED) && inv.Brand_Quote__c != null){
                   Brand_Quote__c bq = new Brand_Quote__c();
                   bq.Id = inv.Brand_Quote__c;
                   bq.Collection_Status__c = inv.Collections_Status__c;
                   bq.Last_Payment_Date__c = inv.Posted_Date__c;
                   lstBrandToUpdate.add(bq); 
            } else if(isUpdateInvoice){
				Invoice__c oldInvoice = oldMap.get(inv.Id);
                if(inv.Posted_Date__c == null && recTypeName == Invoice_Record_Type_Product && oldInvoice.AR_Status__c != inv.AR_Status__c &&
                   (inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED || inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED) && inv.Brand_Quote__c != null){
                       Brand_Quote__c bq = new Brand_Quote__c();
                       bq.Id = inv.Brand_Quote__c;
                       bq.Collection_Status__c = inv.Collections_Status__c;
                       lstBrandToUpdate.add(bq);
                } 
                else if(recTypeName == Invoice_Record_Type_Product && (inv.AR_Status__c == INVOICE_AR_STATUS_CANCELLED || inv.AR_Status__c == INVOICE_AR_STATUS_REJECTED) &&
                        inv.Brand_Quote__c != null && oldInvoice.AR_Status__c != inv.AR_Status__c){
                            Brand_Quote__c bq = new Brand_Quote__c();
                            bq.Id = inv.Brand_Quote__c;
                            bq.Collection_Status__c = inv.Collections_Status__c;
                            bq.Last_Payment_Date__c = inv.Posted_Date__c;
                            lstBrandToUpdate.add(bq);        
                }
        	}
        }*/
        
    }
    
    public static void updateOpenBalance(List<Invoice__c> lstInvoice){
        Set<Id> accIds = new Set<Id>();
        Set<Id> brandIds = new Set<Id>();
        Set<Id> retailerId = new Set<Id>();
        Set<Id> invoiceIds = (new Map<Id,Invoice__c>(lstInvoice)).keySet();
        
        for(Invoice__c inv : lstInvoice){
            if(inv.Ownership__c != null){ 
                brandIds.add(inv.Ownership__c);
            }
            if(inv.Receiver_Name__c != null){
            	retailerId.add(inv.Receiver_Name__c);
                accIds.add(inv.Receiver_Name__c);
            }
        }
        if(accIds.size() > 0){
            List<Account> updateAccountList = new List<Account>();
            for(Account acc : [SELECT Id,Name,Open_Balance_Cultivation_Tax__c,Open_Balance_Products__c,Open_Balance_Services__c,
                               (SELECT Id,Name,RecordType.Name,Invoice_Balance__c FROM Invoices2__r 
                                WHERE RecordType.Name IN (:Invoice_Record_Type_Product,:INVOICE_RECORDTYPE_SERVICE,:Invoice_Record_Type_Tax) AND AR_Status__c IN(:INVOICE_AR_STATUS_APPROVED,:INVOICE_AR_STATUS_SHIPPED) AND  Collections_Status__c IN(:INVOICE_COLL_STATUS_PENDING,:statusPaidInFull,:statusPastDue) ) FROM Account WHERE Id IN : accIds]){
                                    Decimal totalProduct = 0;
                                    Decimal totalService = 0;
                                    Decimal totaltax = 0;
                                    for(Invoice__c inv : acc.Invoices2__r){
                                        if(inv.RecordType.Name == Invoice_Record_Type_Product){
                                            totalProduct += inv.Invoice_Balance__c;
                                            //acc.Open_Balance_Products__c = acc.Open_Balance_Products__c != null	? acc.Open_Balance_Products__c + inv.Invoice_Balance__c : inv.Invoice_Balance__c;    
                                        } else if(inv.RecordType.Name == INVOICE_RECORDTYPE_SERVICE){
                                            totalService += inv.Invoice_Balance__c;
                                            //acc.Open_Balance_Services__c = acc.Open_Balance_Services__c != null	? acc.Open_Balance_Services__c + inv.Invoice_Balance__c : inv.Invoice_Balance__c;    
                                        } else if(inv.RecordType.Name == Invoice_Record_Type_Tax){
                                            totaltax += inv.Invoice_Balance__c;
                                            //acc.Open_Balance_Cultivation_Tax__c = acc.Open_Balance_Cultivation_Tax__c != null	? acc.Open_Balance_Cultivation_Tax__c + inv.Invoice_Balance__c : inv.Invoice_Balance__c;    
                                        }
                                    }
                                    acc.Open_Balance_Products__c 		= totalProduct;
                                    acc.Open_Balance_Services__c 		= totalService;
                                    acc.Open_Balance_Cultivation_Tax__c = totaltax;
                                    updateAccountList.add(acc);
            }
            
            if(updateAccountList.size() > 0){
                update updateAccountList;
            }
        }
        
        List<Invoice__c> listInvoice = new List<Invoice__c>([SELECT Id,Receiver_Name__c,Ownership__c,Invoice_Balance__c,RecordType.Name FROM Invoice__c
                                                             WHERE RecordType.Name = :Invoice_Record_Type_Product AND Ownership__c IN : brandIds AND Receiver_Name__c IN : retailerId]);
        
        if(listInvoice.size() > 0){
            List<Line_Card__c> lineToUpdate = new List<Line_Card__c>();
            for(Line_Card__c lc: [SELECT Id,Brand_Name__c,Retailer_Name__c,Total_Open_Balance__c FROM Line_Card__c WHERE Retailer_Name__c IN : retailerId AND Brand_Name__c IN :brandIds]){
                Decimal total = 0;
                for(Invoice__c inv : listInvoice){
                    if(inv.Ownership__c == lc.Brand_Name__c && inv.Receiver_Name__c == lc.Retailer_Name__c){
                        total += inv.Invoice_Balance__c;
                    	//lc.Total_Open_Balance__c = lc.Total_Open_Balance__c != null ? lc.Total_Open_Balance__c + inv.Invoice_Balance__c : inv.Invoice_Balance__c; 		    
                    }	    
                }
                lc.Total_Open_Balance__c = total;
                lineToUpdate.add(lc);
        	}
            if(lineToUpdate.size() > 0){
            	update lineToUpdate;    
            }
        }
        
    }
    
    public static void updateInvoiceCollectionValues(List<Invoice__c> lstInvoice,Map<Id,Invoice__c> oldMap,Boolean isUpdateInvoice){
        if(lstInvoice.size() > 0){
            for(Invoice__c inv : lstInvoice){
                system.debug('inv.Invoice_Due_Date__c '+inv.Invoice_Due_Date__c);
                system.debug('inv.Invoice_Balance__c '+inv.Invoice_Balance__c);
                system.debug('inv.AR_Status__c '+inv.AR_Status__c);
                system.debug('inv.Ship_Confirmation_Date__c '+inv.Ship_Confirmation_Date__c);
                system.debug('inv.Collections_Status__c '+inv.Collections_Status__c);
                // Invoice collection status PB
                if((inv.Invoice_Due_Date__c == NULL || inv.Invoice_Due_Date__c >= Date.today()) && inv.Invoice_Balance__c > 0.0){
                    inv.Collections_Status__c = INVOICE_COLL_STATUS_PENDING;  
                    system.debug('aaaaaa pending aaaaaaaaa');
                }
                
                //Update Product Invoice Collection Status to Past Due
                if(inv.Invoice_Balance__c > 0.0 && (inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED || inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED) && 
                   inv.Invoice_Due_Date__c < Date.today()){
                       inv.Collections_Status__c = statusPastDue;
                       system.debug('aaaaaa past due aaaaaaaaa');
                   }
                //Update Invoice Collection Status to Paid in Full
                if(inv.Ship_Confirmation_Date__c != null && inv.Invoice_Balance__c == 0.00 &&
                   (inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED || inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED)){
                       inv.Collections_Status__c = statusPaidInFull;
                       system.debug('aaaaaa paid in full aaaaaaaaa');
                   } 
                
                //Update Invoice Collection Status to Paid in Full
                if(inv.Invoice_Balance__c <= 0.00 && (inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED || inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED)){
                    inv.Collections_Status__c = statusPaidInFull;
                    system.debug('aaaaaa paid in full 2 aaaaaaaaa');
                } 
                
                //Update Payment & Posted Date
                /*if(inv.Ship_Confirmation_Date__c != null && inv.Invoice_Balance__c == 0.00 && inv.Posted_Date__c == null &&
                   (inv.AR_Status__c == INVOICE_AR_STATUS_APPROVED || inv.AR_Status__c == INVOICE_AR_STATUS_SHIPPED)){
                       //inv.Posted_Date__c = inv.Ship_Confirmation_Date__c;
                       inv.Last_Payment_Date__c = inv.Ship_Confirmation_Date__c;
                   }  */                                
                //Update Cancelled or Rejected Invoice Collect Status
                if(inv.AR_Status__c == INVOICE_AR_STATUS_CANCELLED || inv.AR_Status__c == INVOICE_AR_STATUS_REJECTED){
                    inv.Collections_Status__c = INVOICE_COLL_STATUS_NOT_COLLECTABLE;
                    system.debug('aaaaaa collectable aaaaaaaaa');
                }
                
                
                // Invoice_ApplyLateFee V1.2 PB
                if(inv.ApplyLateFee__c && (inv.LateFeeAmount__c == null || inv.LateFeeAmount__c == 0)){
                    Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
                    if(ccs.LateFee__c != null){
                        inv.LateFeeAmount__c = inv.Total_Product_Price__c * ccs.LateFee__c;
                    }
                    inv.TotalInvoiceAmountLateFee__c = inv.Total_Invoice_Amount__c + inv.LateFeeAmount__c;
                } else if(isUpdateInvoice){
                    Invoice__c oldInvoice = oldMap.get(inv.Id);
                    if(inv.ApplyLateFee__c && inv.LateFeeAmount__c != oldInvoice.LateFeeAmount__c){
                        inv.TotalInvoiceAmountLateFee__c = inv.Total_Invoice_Amount__c + inv.LateFeeAmount__c;    
                    } else if(!inv.ApplyLateFee__c && inv.ApplyLateFee__c != oldInvoice.ApplyLateFee__c){
                        inv.LateFeeAmount__c = 0;
                        inv.TotalInvoiceAmountLateFee__c = inv.Total_Invoice_Amount__c;    
                    }
                }
            }
        }
    }
    
    public static void updatePostedDate(Set<Id> invIds){
        List<Invoice__c> lstInvoice = [select Id,Posted_Date__c,(select Id,Posted_Date__c,Payment_Received_Date__c from Receive_Payments__r order by Posted_Date__c DESC nulls last) from Invoice__c where ID In : invIds];
        
        List<Invoice__c> updatedInvoice = new List<Invoice__c>();
        
        if(lstInvoice.size() > 0){
            for(Invoice__c inv : lstInvoice){
                List<Receive_Payment__c> lstReceive = inv.Receive_Payments__r;
                if(lstReceive.size() > 0){
                    Boolean isHasRecords = true;
                    for(Receive_Payment__c rec : lstReceive){
                        if(rec.Posted_Date__c == null){
                            isHasRecords = false;
                            break;
                        }    
                    }
                    system.debug('##isHasRecords :'+isHasRecords +' ## PRD :'+lstReceive[0].Payment_Received_Date__c);
                    if(isHasRecords){
                        
                        inv.Posted_Date__c = lstReceive[0].Payment_Received_Date__c;
                        updatedInvoice.add(inv);    
                    }  
                }
            }
            
            if(updatedInvoice.size() > 0){
                update updatedInvoice;    
            }
        }
        
    } 
    
}