trigger LastPaymentUpdate on Receive_Payment__c (after insert, after update) {
/*Map<Id,Date> Invlst = new Map<Id, Date>(); 
    for(Receive_Payment__c RP:trigger.new) {
        if(RP.Posted_Date__c !=null)
        {
       Invlst.put(RP.Invoice__c , RP.Posted_Date__c);     
        }else{
         Invlst.put(RP.Invoice__c , RP.Payment_Received_Date__c);         
        }
        
    } 
   List<Invoice__c> listUpdatedAccount = new List<Invoice__c>(); 
    for(Invoice__c acc:[Select id,Last_Payment_Date__c From Invoice__c Where Id IN :Invlst.Keyset()]) {
        if(Invlst.containsKey(acc.id)) {
            listUpdatedAccount.add(new Invoice__c(Id = acc.id, Last_Payment_Date__c=Invlst.get(acc.id)));
        }
    }
    update listUpdatedAccount;*/
}