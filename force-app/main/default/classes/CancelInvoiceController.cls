/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelInvoiceController
 */
/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelInvoiceController
 */
public with sharing class CancelInvoiceController {

    public Invoice__c invoiceSO {get; set;}
    
    // Constructor
    public CancelInvoiceController(ApexPages.StandardController stdController) {
        invoiceSO = (Invoice__c) stdController.getRecord();
    }
    
    // Retrieve Invoice and related line records and update records
    public pageReference updateInevoiceAndLines(){
        
        List<Invoice__c> invoiceToUpdate = new List<Invoice__c>();
        List<Sales_Order_Line__c> soLinesToUpdate = new List<Sales_Order_Line__c>();
        Map<Id, Sales_Order_Line__c> soLineById = new Map<Id, Sales_Order_Line__c>();
		List<Invoice_Line__c> invLinesToUpdate = new List<Invoice_Line__c>();
        Map<Id, Invoice_Line__c> invLineById = new Map<Id, Invoice_Line__c>();
        if(invoiceSO.Id != null){
            invoiceToUpdate = [Select AR_Status__c,
                                   (Select Invoice_Qty__c,
                                           Sales_Order_Line__c
                                    From Invoice_Lines__r)
                               From Invoice__c
                               Where Id =: invoiceSO.Id ]; //AND AR_Status__c != :InvoiceSupport.INVOICE_STATUS_CANCELLED ];
            
            if(invoiceToUpdate.size() > 0){

				 // Check validation if ETR status is not cancelled
				if(invoiceToUpdate[0].AR_Status__c == InvoiceSupport.INVOICE_STATUS_CANCELLED){
					ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
																  Label.Already_Cancelled_Invoice);
					ApexPages.addMessage(msg);
					return null;
				}


                // Change status of Invoice as Cancelled
                invoiceToUpdate[0].AR_Status__c = InvoiceSupport.INVOICE_STATUS_CANCELLED;
                
                // Change Qty Invoiced of SO line as Invoice Qty of invoice line
                for(Invoice_Line__c invoiceLineSO : invoiceToUpdate[0].Invoice_Lines__r){
                    
					if(invoiceLineSO.Sales_Order_Line__c != null)
					{
						Sales_Order_Line__c soLineSO = new Sales_Order_Line__c();                    
						soLineSO.Id = invoiceLineSO.Sales_Order_Line__c;
						soLineSO.Qty_Invoiced__c = invoiceLineSO.Invoice_Qty__c;                    
						soLineById.put(soLineSO.Id, soLineSO);
					}

					Invoice_Line__c invLine = new Invoice_Line__c();                    
                    invLine.Id = invoiceLineSO.Id;
                    invLine.InvoiceLine_Status__c =  InvoiceSupport.INVOICE_STATUS_CANCELLED;                    
                    invLineById.put(invLine.Id, invLine);
                }
                
                // Get existing SO lines and update Qty Invoiced value
                if(!soLineById.isEmpty())
				{

					for(Sales_Order_Line__c soLineSO : [Select Qty_Invoiced__c 
														From Sales_Order_Line__c
														Where Id IN: soLineById.keySet()]){
                    
						Decimal qtyInvoiced = soLineById.get(soLineSO.Id).Qty_Invoiced__c;
						if(qtyInvoiced == null){
							qtyInvoiced = 0.0;
						}
                    
						// Add qty to existing SO line
						soLineSO.Qty_Invoiced__c -= qtyInvoiced;
                    
						soLineById.put(soLineSO.Id, soLineSO);
					}
				}
                
                Savepoint savePoint;
            
                try {
                    // Define Savepoint for rollback
                    savePoint = Database.setSavepoint();
                    
                    // perform DML operations
					update invLineById.values();
                    update invoiceToUpdate[0];
                
                     if(!soLineById.isEmpty())
						update soLineById.values();
                
                } catch (Exception ex) {
                    Database.rollback(savePoint);
                    
                    ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
                    ApexPages.addMessage(message);
                    return null;
                }
            }
        }
        return redirectToInvoicePage();
    }
    
    /**
     * Redirect to Invoice detil page
     *
     * @return PageReference
     */
    public PageReference redirectToInvoicePage() {
        PageReference page = new PageReference('/'+invoiceSO.Id);
        page.setRedirect(true);
        return page;
    }
}