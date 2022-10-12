public with sharing class EmailInvoiceController {
    public list<Invoice__c>invoiceList{get;set;}
    public EmailInvoiceController(){
        string searchText = apexpages.currentpage().getparameters().get('searchText');
    	invoiceList = fatchInvoice(searchText);
    }
	@AuraEnabled
    public static List<Invoice__c> fatchInvoice(string searchText){
        String searchString = '%' + searchText.trim() + '%';        
        List<String> collectionStatus = FiligreenConfigurationUtility.getCollectionStatus('Invoice');
        return [SELECT Id,Name,Receiver_Name__r.Name,Brand_Quote__r.Opportunity_Name__r.Order__c,Shipped_Date__c,
                Brand_Quote__r.Opportunity_Name__r.Order__r.Name,Ship_Confirmation_Date__c,Invoice_Balance__c,Receiver_DBA__c,
                Product_Balance__c,Excise_Tax_Balance__c,Invoice_Due_Date__c,AR_Status__c,Total_Invoice_Amount__c FROM Invoice__c WHERE Invoice_Balance__c > 0.0 AND 
                Collections_Status__c IN: collectionStatus AND (Receiver_Name__r.Name Like: searchString OR Name 
				Like: searchString OR Receiver_DBA__c Like: searchString) order by Invoice_Due_Date__c DESC, Collections_Status__c LIMIT 100];
    } 
}