/**
 * Copyright (c) 2021 Wearwovn
 * All rights reserved.
 * RegisterEntryLineTriggerHandler
 */
public class RegisterEntryLineTriggerHandler{
    
    public static void updateOldBalance(List<Register_Entry_Line__c> newRegisterEntries){
        Map<Id, Integer> bankRegisterEntryCount = new Map<Id, Integer>();
        Map<Id, List<Register_Entry_Line__c>> newRegisterEntriesByBankRegisterId = new Map<Id, List<Register_Entry_Line__c>>();
        
        // Get all bank register Ids and create map of register bank entries by bank register id
        for(Register_Entry_Line__c registerEntrySO : newRegisterEntries){
            bankRegisterEntryCount.put(registerEntrySO.Bank_Register__c, 0);
            
            List<Register_Entry_Line__c> tempRegisterEntries = newRegisterEntriesByBankRegisterId.get(registerEntrySO.Bank_Register__c);
            if(tempRegisterEntries == null){
                tempRegisterEntries = new List<Register_Entry_Line__c>();
                newRegisterEntriesByBankRegisterId.put(registerEntrySO.Bank_Register__c, tempRegisterEntries);
            }
            tempRegisterEntries.add(registerEntrySO);
        }
        
        // Retrieve existing register entry in descending order to get running balance of last record
        List<Register_Entry_Line__c> existingRegisterEntry = new List<Register_Entry_Line__c>();
        existingRegisterEntry = [Select Running_Balance__c, Bank_Register__c 
                                 From Register_Entry_Line__c 
                                 Where Bank_Register__c IN: bankRegisterEntryCount.keySet()
                                 ORDER By Name DESC];
                                 
        // Create map of bank register Id to last register entry record
        Map<Id, Register_Entry_Line__c> registerEntryByBankRegisterId = new Map<Id, Register_Entry_Line__c>();
        for(Register_Entry_Line__c registerEntrySO : existingRegisterEntry){
            Register_Entry_Line__c tempRegisterEntry = registerEntryByBankRegisterId.get(registerEntrySO.Bank_Register__c);
            
            // Store only first record of register entry in descending order for each bank register
            if(tempRegisterEntry == null){
                registerEntryByBankRegisterId.put(registerEntrySO.Bank_Register__c, registerEntrySO);
            }
        }
        
        Decimal firstOldBalance = 0.0;
        Integer entryCounter;
        // Set old balance of first record
        for(Integer i=0; i<newRegisterEntries.size(); i++){
            
            if(newRegisterEntries[i].Old_Balance__c == null){
            
                // If existing entry found then set running balance of last record as 
                // old balance of first record of trigger context
                // If existing entry not found then set running balance of last record as 
                // "0" of first record of trigger context
                entryCounter = bankRegisterEntryCount.get(newRegisterEntries[i].Bank_Register__c); 
                if(entryCounter == 0){
                    firstOldBalance = 0.0;
                    
                    Register_Entry_Line__c tempRegisterEntry = registerEntryByBankRegisterId.get(newRegisterEntries[i].Bank_Register__c);
                    
                    if(tempRegisterEntry != null){
                        firstOldBalance = tempRegisterEntry.Running_Balance__c;
                    }
                    newRegisterEntries[i].Old_Balance__c = firstOldBalance;
                }else{
                    // For second record onwards, set old balance as running balance of previous record
                    // Make sure record count considers of similar bank register attached to
                    List<Register_Entry_Line__c> tempRegisterEntries = newRegisterEntriesByBankRegisterId.get(newRegisterEntries[i].Bank_Register__c);
                    if(tempRegisterEntries != null && tempRegisterEntries.size() > 1){
                        for(Integer j=1; j<tempRegisterEntries.size(); j++){
                            if(entryCounter == j){
                                newRegisterEntries[i].Old_Balance__c = tempRegisterEntries[j-1].Running_Balance__c;
                            }
                        }
                    }
                }
                entryCounter++;
                bankRegisterEntryCount.put(newRegisterEntries[i].Bank_Register__c, entryCounter);
            }
        }
    }
    
     public static void updateReconciled(List<Register_Entry_Line__c> updatedRegisterEntries){
       
         List<Receive_Payment__c> rpaymentList = new List<Receive_Payment__c>();
         for(Register_Entry_Line__c registerEntrySO : updatedRegisterEntries){
             Receive_Payment__c rcpay = new Receive_Payment__c();
             rcpay.id = registerEntrySO.Related_Payment__c;
             if(registerEntrySO.Reconciled__c){
                 rcpay.Reconciled__c = True;
             }else{
                 rcpay.Reconciled__c = False;
             }
             rpaymentList.add(rcpay);
             
         }
         if(rpaymentList.size() > 0)
         {
             upsert rpaymentList;
         }
     }
    
    
}