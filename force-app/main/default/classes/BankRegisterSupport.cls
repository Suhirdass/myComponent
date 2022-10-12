/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * BankRegisterSupport
 */
public class BankRegisterSupport{
  
    
     private static String REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT) ? REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Resgister_EntryLine_RecordType_Debit');
        }set;
    }
     private static String REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT) ? REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Resgister_EntryLine_RecordType_Credit');
        }set;
    }
  
    private static String INVOICE_OBJECT{
        get{
            return String.isNotBlank(INVOICE_OBJECT) ? INVOICE_OBJECT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_obj_Name');
        }set;
    }
     private static String PO_OBJECT{
        get{
            return String.isNotBlank(PO_OBJECT) ? PO_OBJECT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Obj_Name');
        }set;
    }
     private static String REGISTER_ENTRY_LINE_SOBJECT_API_NAME{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_SOBJECT_API_NAME) ? REGISTER_ENTRY_LINE_SOBJECT_API_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Register_Entry_Obj_Name');
        }set;
    } 
 
    public static void generateBankEntryRelatedToBillPay(Id billpayId, Id bankRegisterId,String entityToPay){
        if(billpayId == null){return;
        }
        
        // Get related receive payment based on Id
        List<Bill_Pay__c> billpays = Billpays(billpayId);
        if(billpays == null){  return;
        }
        
        List<Register_Entry_Line__c> registerEntries = [Select Id,
                                                               Reconciled__c,
                                                               Name,Credit_Amount__c
                                                        From Register_Entry_Line__c
                                                        Where Bank_Register__c =: bankRegisterId
                                                        AND Bill_Pay__c =:billpays[0].Id];
                                                        
        if(registerEntries != null && registerEntries.size() > 0){  editExistingRegisterEntrybillpay(billpays[0], registerEntries[0], bankRegisterId, entityToPay);
        }else{
         createNewRegisterEntrybillpay(billpays[0], bankRegisterId, entityToPay);
        }
    }
     
    
    public static List<Bill_Pay__c> Billpays(Id billpayId){
        return [Select  id,Name,Supplier_Bill__c,Payment_Form__c,Payment_Memo__c,Payment_Amount__c,Payment_Date__c,Reconciliation_Notes__c,Post_Date__c
                                                   from Bill_Pay__c Where Id =:billpayId];
    }
      
    
        public static void editExistingRegisterEntrybillpay(Bill_Pay__c billSO, Register_Entry_Line__c registerEntrySO, Id bankRegisterId,String entityToPay){
    
        // If reconcile flag is false - audit is not yet reviewed then update existing register line
       if(!registerEntrySO.Reconciled__c){  registerEntrySO = createRegisterEntryInstancebill(billSO,   registerEntrySO,bankRegisterId,  entityToPay);
            
        // If reconcile flag is true - audit is already reviewed then send email alert
        }else{
            registerEntrySO.Changes_Made_after_Reconciliation__c = true;sendEmailForChangeInReceivePaymentbillpay(billSO, registerEntrySO);
        }
        update registerEntrySO;
    }
    
   public static void sendEmailForChangeInReceivePaymentbillpay(Bill_Pay__c billSO,  Register_Entry_Line__c registerEntrySO){
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        if(ccs != null && ccs.Bank_Registry_Email__c != NULL){  Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = ccs.Bank_Registry_Email__c.split(','); message.subject = 'Change in Receive payment ' + billSO.Name;
            String textBody = 'There are some changes reported in ' + billSO.Name;
            textBody += ' after reconciled flag set to true in register entry ' + registerEntrySO.Name;
            textBody += '\nPlease have a look and do appropriate actions';
            message.plainTextBody = textBody;Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {message});   
        }
        
    }
     
       public static void createNewRegisterEntrybillpay(Bill_Pay__c billSO, 
                                              Id bankRegisterId, 
                                              String entityToPay){
        Register_Entry_Line__c registerEntrySO = createRegisterEntryInstancebill(billSO, 
                                                                             null, 
                                                                             bankRegisterId,
                                                                             entityToPay);
        String recordTypeName = entityToPay == INVOICE_OBJECT ? REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT : REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT; 
        registerEntrySO.RecordTypeId = getRecordTypeId(REGISTER_ENTRY_LINE_SOBJECT_API_NAME,recordTypeName);
        
        registerEntrySO.Bank_Register__c = bankRegisterId;
        insert registerEntrySO;
    }
    
 
      
    
   public static Register_Entry_Line__c createRegisterEntryInstancebill(Bill_Pay__c billSO,
                                                                     Register_Entry_Line__c registerEntrySO,
                                                                     Id bankRegisterId,
                                                                     String entityToPay){
        if(registerEntrySO == null){
            registerEntrySO = new Register_Entry_Line__c();
        }
       registerEntrySO.Entry_Date__c = billSO.Post_Date__c;
        registerEntrySO.Entry_Memo__c = billSO.Reconciliation_Notes__c;
        registerEntrySO.Bill_Pay__c = billSO.Id;
        registerEntrySO.Reconciled__c = false;
        if(entityToPay == PO_OBJECT){
            registerEntrySO.Credit_Amount__c = billSO.Payment_Amount__c;
           // registerEntrySO.Payee__c = billSO.Bill_Pay__r.Supplier_Name__c;
        }
      
        registerEntrySO.Old_Balance__c = getOldBalanceOfRegisterEntry(bankRegisterId, registerEntrySO, entityToPay);
        return registerEntrySO;
    }  
    
    
    
    
    
    
    /**
     * Generate bank register entry related to Receive payment
     * @param receivePaymentSO The Receive Payment record
     * @param bankRegisterId The Id of bank register record
     * @param entityToPay The API name of object for which receive payment is used. i.e. Invoice__c or Purchase_Order__c
     */
    public static void generateBankEntryRelatedToReceivePayment(Id receivePaymentId, 
                                                                Id bankRegisterId,
                                                                String entityToPay){
        if(receivePaymentId == null){ return;
        }
        
        // Get related receive payment based on Id
        List<Receive_Payment__c> receivePayments = retrieveReceivePayment(receivePaymentId);
        if(receivePayments == null){ return;
        }
        
        List<Register_Entry_Line__c> registerEntries = [Select Id,
                                                               Reconciled__c,
                                                               Name,Credit_Amount__c
                                                        From Register_Entry_Line__c
                                                        Where Bank_Register__c =: bankRegisterId
                                                        AND Related_Payment__c =:receivePayments[0].Id];
                                                        
        if(registerEntries != null && registerEntries.size() > 0){
            editExistingRegisterEntry(receivePayments[0], registerEntries[0], bankRegisterId, entityToPay);
        }else{
            
            createNewRegisterEntry(receivePayments[0], bankRegisterId, entityToPay);
        }
    }
    
    /**
     * Retrieve Receive payment record
     * @param receivePaymentId The Id of Receive Payment record
     *
     * @return The list of receive payment - Must be one record
     */
    public static List<Receive_Payment__c> retrieveReceivePayment(Id receivePaymentId){
        return [Select Reconciliation_Notes__c,
                       Posted_Date__c,
                       Payment_Amount__c,
                       Invoice__r.Receiver_Name__c,
                       Bill_Pay__r.Supplier_Name__c,
                       Name
                From Receive_Payment__c
                Where Id =:receivePaymentId];
    }
    
    /**
     * Create new bank register entry related to Receive payment
     * @param receivePaymentSO The Receive Payment record
     * @param bankRegisterId The Id of bank register record
     */
    public static void createNewRegisterEntry(Receive_Payment__c receivePaymentSO, 
                                              Id bankRegisterId, 
                                              String entityToPay){
        Register_Entry_Line__c registerEntrySO = createRegisterEntryInstance(receivePaymentSO, 
                                                                             null, 
                                                                             bankRegisterId,
                                                                             entityToPay);
        String recordTypeName = entityToPay == INVOICE_OBJECT ? REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT : REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT; 
        registerEntrySO.RecordTypeId = getRecordTypeId(REGISTER_ENTRY_LINE_SOBJECT_API_NAME, 
                                                       recordTypeName);
        
        registerEntrySO.Bank_Register__c = bankRegisterId;
        insert registerEntrySO;
    }
    
    /**
     * Edit existing bank register entry related to Receive payment
     * @param receivePaymentSO The Receive Payment record
     * @param registerEntrySO The Register entry line record
     * @param bankRegisterId The Id of bank register record
     */
    public static void editExistingRegisterEntry(Receive_Payment__c receivePaymentSO,
                                                 Register_Entry_Line__c registerEntrySO,
                                                 Id bankRegisterId,
                                                 String entityToPay){
    
        // If reconcile flag is false - audit is not yet reviewed then update existing register line
        if(!registerEntrySO.Reconciled__c){
            registerEntrySO = createRegisterEntryInstance(receivePaymentSO, 
                                                          registerEntrySO, 
                                                          bankRegisterId, 
                                                          entityToPay);
            
        // If reconcile flag is true - audit is already reviewed then send email alert
        }else{
            registerEntrySO.Changes_Made_after_Reconciliation__c = true;
            sendEmailForChangeInReceivePayment(receivePaymentSO, registerEntrySO);
        }
        update registerEntrySO;
    }
    
    /**
     * Create Register entry instance
     * @param receivePaymentSO The Receive Payment record
     * @param registerEntrySO The Register entry line record
     * @param bankRegisterId The Id of bank register record
     *
     * @return The instance of register entry line
     */
    public static Register_Entry_Line__c createRegisterEntryInstance(Receive_Payment__c receivePaymentSO,
                                                                     Register_Entry_Line__c registerEntrySO,
                                                                     Id bankRegisterId,
                                                                     String entityToPay){
        if(registerEntrySO == null){
            registerEntrySO = new Register_Entry_Line__c();
        }
        registerEntrySO.Entry_Date__c = receivePaymentSO.Posted_Date__c;
        registerEntrySO.Entry_Memo__c = receivePaymentSO.Reconciliation_Notes__c;
        registerEntrySO.Related_Payment__c = receivePaymentSO.Id;
        registerEntrySO.Reconciled__c = false;
        
        // For invoice, store payment amount value as credit amount in bank
        if(entityToPay == INVOICE_OBJECT){
            registerEntrySO.Debit_Amount__c  = receivePaymentSO.Payment_Amount__c;
            registerEntrySO.Payee__c = receivePaymentSO.Invoice__r.Receiver_Name__c;
        // For PO, store payment amount value as debit amount in bank
        }else if(entityToPay == PO_OBJECT){  registerEntrySO.Credit_Amount__c = receivePaymentSO.Payment_Amount__c;
            registerEntrySO.Payee__c = receivePaymentSO.Bill_Pay__r.Supplier_Name__c;
        }
        registerEntrySO.Old_Balance__c = getOldBalanceOfRegisterEntry(bankRegisterId, registerEntrySO, entityToPay);
        return registerEntrySO;
    }
    
    /**
     * Send email alert for change in receive payment after reconciled flag set to true
     * @param receivePaymentSO The Receive Payment record
     * @param registerEntrySO The Register entry line record
     */
    public static void sendEmailForChangeInReceivePayment(Receive_Payment__c receivePaymentSO,
                                                          Register_Entry_Line__c registerEntrySO){
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        if(ccs != null && ccs.Bank_Registry_Email__c != NULL){ Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = ccs.Bank_Registry_Email__c.split(',');
                message.subject = 'Change in Receive payment ' + receivePaymentSO.Name;
            String textBody = 'There are some changes reported in ' + receivePaymentSO.Name;
            textBody += ' after reconciled flag set to true in register entry ' + registerEntrySO.Name;
            textBody += '\nPlease have a look and do appropriate actions';
            message.plainTextBody = textBody; Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {message});   
        }
        
    }
    
    /**
     * Edit existing bank register entry related to Receive payment
     * @param receivePaymentSO The Receive Payment record
     * @param registerEntrySO The Register entry line record
     */
    public static Id getRecordTypeId(String objectAPIName, String recordTypeName){
        Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe();
        return sobjectResult.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }
    
    /**
     * Get old balance of register entry
     * @param bankRegisterId The Id of bank register record
     *
     */
    public static Decimal getOldBalanceOfRegisterEntry(Id bankRegisterId,Register_Entry_Line__c currentRegisterEntry,String entityToPay){
        
        /*Id depositRecordTypeId = getRecordTypeId(REGISTER_ENTRY_LINE_SOBJECT_API_NAME, 
                                                 REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT);*/
        
        
        List<Bank_Register__c> bankRegisters = [Select Starting_Balance__c,
                                                (Select Old_Balance__c, Credit_Amount__c, 
                                                        Debit_Amount__c, Running_Balance__c
                                                From Register_Entry_Lines__r 
                                                Order By Id ASC)
                                                From Bank_Register__c
                                                Where Id =: bankRegisterId];
                                                        
        if(bankRegisters == null || bankRegisters.size() == 0){return 0.0;
        }
        
        // For first register entry, set old balance as 0
        if(bankRegisters[0].Register_Entry_Lines__r == null || bankRegisters[0].Register_Entry_Lines__r.size() == 0){
            return 0.0;
        }
        
        // For second register entry record onwards, set old balance as running balance of previous record
        // If this is a new register entry creation then get last existing register entry running balance
        Integer registerEntrySize = bankRegisters[0].Register_Entry_Lines__r.size();
        List<Register_Entry_Line__c> registerEntries = bankRegisters[0].Register_Entry_Lines__r;
        Decimal oldBalance;
        if(currentRegisterEntry.Id == null){
            oldBalance = registerEntries[registerEntrySize - 1].Running_Balance__c;
            return oldBalance;
        }
        
        // If this is a change in existing register entry then search for post entries
        // if it is last entry then do nothing
        if(registerEntries[registerEntrySize - 1].Id == currentRegisterEntry.Id){
            return registerEntries[registerEntrySize - 1].Old_Balance__c;
        }
        
        // Check current entry index and return that entry's old balance
        // Get the index of next register entry after current register entry is updated
        Integer changeIndex = 0;
        List<Register_Entry_Line__c> registerEntriesToUpdate = new List<Register_Entry_Line__c>();
        for(Integer i=0; i<registerEntrySize - 1; i++){
            if(registerEntries[i].Id == currentRegisterEntry.Id){
                oldBalance = registerEntries[i].Old_Balance__c;
                
                if(entityToPay == INVOICE_OBJECT){
                    registerEntries[i].Debit_Amount__c  = currentRegisterEntry.Credit_Amount__c; }else if(entityToPay == PO_OBJECT){registerEntries[i].Credit_Amount__c = currentRegisterEntry.Debit_Amount__c;
                }
                
                changeIndex = i + 1;   break;
            }
        }
        
        // Update post register entry's old balance as intermediate entry is updated
        Decimal oldBalanceOther;   Integer counter = 0;
        Decimal creditAmount; Decimal debitAmount;
        List<List<Register_Entry_Line__c>> registerEntriesListToUpdate = new List<List<Register_Entry_Line__c>>();                                  
      
        for(Integer i=changeIndex; i<registerEntrySize; i++){
            if(counter == 10000){ registerEntriesListToUpdate.add(registerEntriesToUpdate); registerEntriesToUpdate = new List<Register_Entry_Line__c>();
                counter = 0;
            }
            oldBalanceOther = registerEntries[i-1].Old_Balance__c; creditAmount = registerEntries[i-1].Credit_Amount__c != null ? registerEntries[i-1].Credit_Amount__c : 0;
            debitAmount = registerEntries[i-1].Debit_Amount__c != null ? registerEntries[i-1].Debit_Amount__c : 0;registerEntries[i].Old_Balance__c = oldBalanceOther + creditAmount - debitAmount;
                registerEntriesToUpdate.add(registerEntries[i]);counter++;
        }
        if(registerEntriesToUpdate.size() > 0){registerEntriesListToUpdate.add(registerEntriesToUpdate);                                                 
        }
        for(List<Register_Entry_Line__c> lst:registerEntriesListToUpdate){ updateRegisterEntries(JSON.serialize(lst));
        	//update lst;                                         
        }
        //update registerEntriesToUpdate;
        return oldBalance;
    }
    
    @future
    public static void updateRegisterEntries(String entriesJSON){ List<Register_Entry_Line__c> lst = (List<Register_Entry_Line__c>)JSON.deserialize(entriesJSON, List<Register_Entry_Line__c>.class);
        update lst;
    }
}