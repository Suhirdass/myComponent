public with sharing class InvoiceCollectionController {
	@AuraEnabled
    public static List<PendingInvoice> fatchInvoice(string searchText){
        List<PendingInvoice> invoices = new List<PendingInvoice>();
        String searchString = '%' + searchText.trim() + '%';        
        List<String> collectionStatus = new List<String>{'Pending','Past Due'};
        for(Invoice__c inv:[SELECT id,Name,Shipped_Date__c,Receiver_DBA__c,Ship_Confirmation_Date__c,Invoice_Balance__c,Product_Balance__c,Excise_Tax_Balance__c,Invoice_Due_Date__c,Invoice_Memo__c,Total_Invoice_Amount__c,
                Payment_Terms__c,Total_Excise_Tax_Amount__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Name,Brand_Quote__r.Opportunity_Name__r.Order__c 
                FROM Invoice__c 
                            WHERE Invoice_Balance__c > 0.0 AND Collections_Status__c IN: collectionStatus AND (Receiver_Name__r.Name Like: searchString OR Receiver_Name__r.DBA__c Like: searchString OR Name Like: searchString)  order by Invoice_Due_Date__c DESC, Collections_Status__c LIMIT 100]){
                                invoices.add(new PendingInvoice(inv));
                            }
        return invoices;
    }
    public static Map<String,List<String>> checkValidation(List<PendingInvoice> invoices){
        Map<String,List<String>> r = new Map<String,List<String>>();
        List<String> errors = new List<String>();
        Boolean hasValidationError = false;
        if(!invoices.isEmpty()){
            Set<Id> invoiceIds = new Set<Id>();
            Set<String> uniqueRPString = new Set<String>();
            
            // Get all existing invoice ids
            for(PendingInvoice invoiceWrapper : invoices){
                invoiceIds.add(invoiceWrapper.invoice.Id);
            }
            // Get all existing related receive payments
                for(Receive_Payment__c rpObj : [Select Invoice__c,
                                                Payment_Amount__c,
                                                Payment_Form__c,
                                                Payment_Memo__c,
                                                Payment_Received_Date__c,
                                                RecordTypeId
                                                From Receive_Payment__c
                                                Where Invoice__c IN: invoiceIds]){
                                                    uniqueRPString.add(generateRPParametersString(rpObj.Invoice__c,
                                                                                                  rpObj.Payment_Amount__c.stripTrailingZeros(),
                                                                                                  rpObj.Payment_Form__c,
                                                                                                  rpObj.Payment_Memo__c,
                                                                                                  rpObj.Payment_Received_Date__c,
                                                                                                  rpObj.RecordTypeId));
                                                }
            for(PendingInvoice invoiceWrapper : invoices){
                Receive_Payment__c receivePaymentSO = invoiceWrapper.receivePaymentSO;
                System.debug('###receivePaymentSO:'+receivePaymentSO);
                receivePaymentSO.Payment_Form__c =  receivePaymentSO.Payment_Form__c == '' ? null:receivePaymentSO.Payment_Form__c;
                // Payment form value should not be blank if payment or tax amount is > 0
                if(receivePaymentSO != null && 
                   (invoiceWrapper.productAmount != null && invoiceWrapper.productAmount != '' && Decimal.valueOf(invoiceWrapper.productAmount) > 0 ||
                    invoiceWrapper.taxAmount != null && invoiceWrapper.taxAmount != '' && Decimal.valueOf(invoiceWrapper.taxAmount) > 0) &&
                   receivePaymentSO.Payment_Form__c == null){
                       errors.add(Label.Payment_Form_is_Mandatory);
                       hasValidationError = true;
                       break;
                   }else{
                       if(receivePaymentSO != null){ 
                           
                           // Check for product amount validation - cannot be greater than invoice balance
                           if(invoiceWrapper.productAmount != null && invoiceWrapper.productAmount != '' && Decimal.valueOf(invoiceWrapper.productAmount) > 0 &&
                              Decimal.valueOf(invoiceWrapper.productAmount) > invoiceWrapper.invoice.Product_Balance__c){
                                  
                                  errors.add(String.format(Label.Excise_product_amount_validation, 
                                                    new List<String>{invoiceWrapper.productAmount,
                                                        String.valueOf(invoiceWrapper.invoice.Product_Balance__c)}));

                                  hasValidationError = true;
                              }
                           
                           // Check for excise tax amount validation - cannot be greater than excise tax balance
                           if(invoiceWrapper.taxAmount != null && invoiceWrapper.taxAmount != '' && Decimal.valueOf(invoiceWrapper.taxAmount) > 0 &&
                              Decimal.valueOf(invoiceWrapper.taxAmount) > invoiceWrapper.invoice.Excise_Tax_Balance__c){
                                  
                                  errors.add(String.format(Label.Excise_tax_amount_validation, 
                                             new List<String>{invoiceWrapper.taxAmount,
                                             String.valueOf(invoiceWrapper.invoice.Excise_Tax_Balance__c)}));
                                  hasValidationError = true;
                                  
                                  // Check if existing RP entry is already created - BE-2019-05-0000000209
                              }else{
                                  String rpString = '';
                                  Id recordTypeId = null;
                                  
                                  // Check product amount entry
                                  if(invoiceWrapper.productAmount != null && invoiceWrapper.productAmount != ''){
                                      recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RSMSupport.RECEIVE_PAYMENT_RECORD_TYPE_PRODUCT).getRecordTypeId();
                                      
                                      rpString = generateRPParametersString(invoiceWrapper.invoice.Id,
                                                                            Decimal.valueOf(invoiceWrapper.productAmount).stripTrailingZeros(),
                                                                            invoiceWrapper.receivePaymentSO.Payment_Form__c,
                                                                            invoiceWrapper.receivePaymentSO.Payment_Memo__c,
                                                                            invoiceWrapper.receivePaymentSO.Payment_Received_Date__c,
                                                                            recordTypeId);
                                      
                                      if(uniqueRPString.contains(rpString)){
                                          
                                          errors.add(String.format(Label.Duplicate_Product_Amount_Payment, 
                                                     new List<String>{invoiceWrapper.productAmount}));
                                          hasValidationError = true;
                                      }
                                  }
                                  
                                  // Check Tax Amount entry
                                  if(invoiceWrapper.taxAmount != null && invoiceWrapper.taxAmount != ''){
                                      recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RSMSupport.RECEIVE_PAYMENT_RECORD_TYPE_EXCISE_TAX).getRecordTypeId();
                                      
                                      rpString = generateRPParametersString(invoiceWrapper.invoice.Id,
                                                                            Decimal.valueOf(invoiceWrapper.taxAmount).stripTrailingZeros(),
                                                                            invoiceWrapper.receivePaymentSO.Payment_Form__c,
                                                                            invoiceWrapper.receivePaymentSO.Payment_Memo__c,
                                                                            invoiceWrapper.receivePaymentSO.Payment_Received_Date__c,
                                                                            recordTypeId);
                                      
                                      if(uniqueRPString.contains(rpString)){
                                          
                                          errors.add(String.format(Label.Duplicate_Tax_Amount_Payment, 
                                                     new List<String>{invoiceWrapper.taxAmount}));
                                          hasValidationError = true;
                                      }
                                  }
                              }
                       }
                   }
            }
        }
        r.put((hasValidationError?'error':'success'),errors);
        
        return r;
    }
    @AuraEnabled
    public static Map<String,Object> updateInvoices(String invoiceJSON,String searchText){
        System.debug('###invoiceJSON::'+invoiceJSON);
        Integer updateInvoiceCount = 0;
        Map<String,Object> r = new Map<String,Object>();

        List<PendingInvoice> invoices = (List<PendingInvoice>) JSON.deserialize(invoiceJSON, List<PendingInvoice>.class);
        System.debug('###invoices:'+invoices);
        Map<String,List<String>> validationCheck = checkValidation(invoices);
        r.put('data',invoices);
        if(validationCheck.containsKey('error')){
            r.put('error',validationCheck.get('error'));
            return r;
        }
        
        if(!invoices.isEmpty()){
            List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>();
            Map<String,Receive_Payment__c> invoiceRPMap = new Map<String,Receive_Payment__c>();
            for(PendingInvoice invoiceObj : invoices){
                if(invoiceObj.receivePaymentSO.Payment_Form__c != null){
                    updateInvoiceCount++;
                    // Make entry for product record type
                    if(invoiceObj.productAmount != null && invoiceObj.productAmount != '' && Decimal.valueOf(invoiceObj.productAmount) != 0.0){
                        invoiceObj.receivePaymentSO.Payment_Amount__c = Decimal.valueOf(invoiceObj.productAmount);
                        invoiceObj.receivePaymentSO.RecordTypeId = 
                            Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RSMSupport.RECEIVE_PAYMENT_RECORD_TYPE_PRODUCT).getRecordTypeId();
                        receivePayments.add(invoiceObj.receivePaymentSO);
                        invoiceRPMap.put(invoiceObj.invoice.Id+'-RP',invoiceObj.receivePaymentSO);
                    }
                    
                    // Make entry for excise tax record type
                    if(invoiceObj.taxAmount != null && invoiceObj.taxAmount != '' && Decimal.valueOf(invoiceObj.taxAmount) != 0.0){
                        Receive_Payment__c clonedReceivePaymentSO = invoiceObj.receivePaymentSO.clone(false, true);
                        clonedReceivePaymentSO.Payment_Amount__c = Decimal.valueOf(invoiceObj.taxAmount);
                        clonedReceivePaymentSO.RecordTypeId = 
                            Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RSMSupport.RECEIVE_PAYMENT_RECORD_TYPE_EXCISE_TAX).getRecordTypeId();
                        receivePayments.add(clonedReceivePaymentSO);
                        invoiceRPMap.put(invoiceObj.invoice.Id+'-TAX',clonedReceivePaymentSO);
                    }
                }
            }
            
            if(invoiceRPMap.size() > 0){
                insert invoiceRPMap.values();
            }
        }
        if(updateInvoiceCount == 0){
            r.put('warning','No changes to update Invoice');
            return r;
        }
        r.put('invoices',fatchInvoice(searchText));
        r.put('success','Invoices Updated successfully');
        return r;
    }
    /**
* Contact all receive payments parameters in one string
*/
    private static String generateRPParametersString(Id invoiceId,
                                              Decimal paymentAmount,
                                              String paymentForm,
                                              String paymentMemo,
                                              Date paymentReceivedDate,
                                              Id recordTypeId){
                                                  String rpString = '';
                                                  rpString += invoiceId;
                                                  rpString += paymentAmount != null && paymentAmount > 0 ? String.valueOf(paymentAmount) : '';
                                                  rpString += paymentForm;
                                                  rpString += paymentMemo;
                                                  rpString += paymentReceivedDate != null ? paymentReceivedDate.format() : '';
                                                  rpString += recordTypeId;
                                                  
                                                  return rpString;
                                              }
    public static List<SelectOption> getPicklistItems(String objectAPIName, String fieldAPIName){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None', ''));
        SObjectType objectType = Schema.getGlobalDescribe().get(objectAPIName);
        for (Schema.PicklistEntry pickListValue : objectType.getDescribe().fields.getMap().get(fieldAPIName).getDescribe().getPickListValues()) {
            options.add(new SelectOption(pickListValue.getLabel(), pickListValue.getValue()));
        }
        return options;
    }
    public class SelectOption{
        @AuraEnabled
        public String label{set;get;}
        @AuraEnabled
        public String value{set;get;}
        
        public SelectOption(String label, String value){
            this.label = label;
            this.value = value;
        }
    }
    
    public class PendingInvoice{
        @AuraEnabled
        public Invoice__c invoice{set;get;}
        @AuraEnabled
        public String paymentForm{set;get;}
        @AuraEnabled
        public String paymentMemo{set;get;}
        @AuraEnabled
        public Receive_Payment__c receivePaymentSO{set;get;}
        @AuraEnabled
        public List<SelectOption> paymentFormOptions{set;get;}
        @AuraEnabled
        public String productAmount {get; set;}
        @AuraEnabled
        public String taxAmount {get; set;}
        public PendingInvoice(Invoice__c invoice){
            this.invoice = invoice;
            this.receivePaymentSO = new Receive_Payment__c();
            this.receivePaymentSO.Payment_Received_Date__c = System.Today();
            this.receivePaymentSO.Invoice__c = invoice.Id;
            this.paymentFormOptions = getPicklistItems('Receive_Payment__c','Payment_Form__c');
        }
    }
}