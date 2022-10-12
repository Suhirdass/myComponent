public class SMCancelAllRelatedItems {
    private Static String INVOICE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    public static void getRelatedItems(List<Shipping_Manifest__c> SMIds){
        Set<Id> SOIds 		= new Set<Id>();
        Set<Id> BQIds 		= new Set<Id>();
        Set<Id> POIds 		= new Set<Id>();
        Set<Id> InvoiceIds 	= new Set<Id>();
        
        for(Shipping_Manifest__c smObj : [SELECT Sales_Order__c,Brand_Quote__c,Sales_Order__r.SO_Status__c,Brand_Quote__r.BQ_Status__c FROM Shipping_Manifest__c WHERE Id IN :SMIds]){
            if(smObj.Sales_Order__c != null && smObj.Sales_Order__r.SO_Status__c != INVOICE_AR_STATUS_CANCELLED) SOIds.add(smObj.Sales_Order__c);
            if(smObj.Brand_Quote__c != null && smObj.Brand_Quote__r.BQ_Status__c != INVOICE_AR_STATUS_CANCELLED) BQIds.add(smObj.Brand_Quote__c);
        }
        if(SOIds.size() > 0){
            cancelSOandLines(SOIds);
            for(Invoice__c  invObj : [SELECT Id FROM Invoice__c WHERE Sales_Order__c IN :SOIds AND AR_Status__c != :INVOICE_AR_STATUS_CANCELLED AND RecordType.Name != :INVOICE_RECORDTYPE_SERVICE]){
                InvoiceIds.add(invObj.Id);
            }
        }
        if(BQIds.size() > 0){
            cancelBQandLines(BQIds);
            for(Purchase_Order__c   poObj : [SELECT Id FROM Purchase_Order__c  WHERE Brand_Quote__c IN :BQIds AND PO_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
                POIds.add(poObj.Id);
            }
            if(POIds.size() > 0){
              cancelPOandLines(POIds);
                for(Invoice__c  invObj : [SELECT Id FROM Invoice__c WHERE Purchase_Order__c IN :POIds AND AR_Status__c != :INVOICE_AR_STATUS_CANCELLED AND RecordType.Name != :INVOICE_RECORDTYPE_SERVICE]){
                    InvoiceIds.add(invObj.Id);
                }
            } 
        }
        if(InvoiceIds.size() > 0) cancelInvoiceandLines(InvoiceIds);
    }
    
    @future
    public static void cancelSOandLines(Set<ID> recordIds){
        System.debug('IN cancelSOandLines');
        ShippingManifestLineTriggerHandler.cancel(); 
        List<Sales_Order__c> orders = new List<Sales_Order__c>();
        List<Sales_Order_Line__c> orderLines = new List<Sales_Order_Line__c>();
        for(Sales_Order__c salesObj : [SELECT Id FROM Sales_Order__c WHERE Id IN :recordIds AND SO_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            orders.add(new Sales_Order__c(
                Id = salesObj.Id,
                SO_Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        for(Sales_Order_Line__c lineObj : [SELECT Id FROM Sales_Order_Line__c WHERE Sales_Order__c IN :recordIds AND Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            orderLines.add(new Sales_Order_Line__c(
                Id = lineObj.Id,
                Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        if(orders.size() > 0) update orders;
        if(orderLines.size() > 0) update orderLines;
    }
    
    @future
    public static void cancelBQandLines(Set<ID> recordIds){   
        System.debug('IN BQAndLines');
        ShippingManifestLineTriggerHandler.cancel(); 
        List<Brand_Quote__c> quotes = new List<Brand_Quote__c>();
        List<Brand_Quote_Line__c> quoteLines = new List<Brand_Quote_Line__c>();
        for(Brand_Quote__c bqObj : [SELECT Id FROM Brand_Quote__c WHERE Id IN :recordIds AND BQ_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            quotes.add(new Brand_Quote__c(
                Id = bqObj.Id,
                BQ_Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        for(Brand_Quote_Line__c lineObj : [SELECT Id FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c IN :recordIds AND Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            quoteLines.add(new Brand_Quote_Line__c(
                Id = lineObj.Id,
                Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        if(quotes.size() > 0) update quotes;
        if(quoteLines.size() > 0) update quoteLines;
    }
    
    @future
    public static void cancelPOandLines(Set<ID> recordIds){ 
        System.debug('IN cancelPOandLines');
        ShippingManifestLineTriggerHandler.cancel(); 
        List<Purchase_Order__c> orders = new List<Purchase_Order__c>();
        List<Purchase_Order_Line__c> orderLines = new List<Purchase_Order_Line__c>();
        for(Purchase_Order__c  salesObj : [SELECT Id FROM Purchase_Order__c WHERE Id IN :recordIds AND PO_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            orders.add(new Purchase_Order__c(
                Id = salesObj.Id,
                PO_Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        for(Purchase_Order_Line__c lineObj : [SELECT Id FROM Purchase_Order_Line__c WHERE Purchase_Order__c IN :recordIds AND POLI_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            orderLines.add(new Purchase_Order_Line__c(
                Id = lineObj.Id,
                POLI_Status__c  = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        if(orders.size() > 0) update orders;
        if(orderLines.size() > 0) update orderLines;
    }
    
    @future
    public static void cancelInvoiceandLines(Set<ID> recordIds){   
        System.debug('IN cancelInvoiceandLines');
        ShippingManifestLineTriggerHandler.cancel(); 
        List<Invoice__c> invoices = new List<Invoice__c>();
        List<Invoice_Line__c> lines = new List<Invoice_Line__c>();
        for(Invoice__c  invoiceObj : [SELECT Id FROM Invoice__c WHERE Id IN :recordIds AND AR_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            invoices.add(new Invoice__c(
                Id = invoiceObj.Id,
                AR_Status__c = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        for(Invoice_Line__c lineObj : [SELECT Id FROM Invoice_Line__c WHERE Invoice__c IN :recordIds AND InvoiceLine_Status__c != :INVOICE_AR_STATUS_CANCELLED]){
            lines.add(new Invoice_Line__c(
                Id = lineObj.Id,
                InvoiceLine_Status__c  = INVOICE_AR_STATUS_CANCELLED
            ));
        }
        if(invoices.size() > 0) update invoices;
        if(lines.size() > 0) update lines;
    }
}