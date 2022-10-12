public class CreateFactoringServiceInvoiceController {
    public static String PAYMENT_TERMS_COD = 'COD';
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    @Auraenabled
    public static AuraResponse getRecordDetails(Id recordId){
        AuraResponse r = new AuraResponse('CreateFactoringServiceInvoiceController.getRecordDetails()');

        String q = 'SELECT Name,Factoring_Assignee__c,Factoring_Contact__c,Factoring_Rate__c  FROM ' + recordId.getSObjectType().getDescribe().getName() + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            r.data.put('record',records[0]);
            Purchase_Order__c objPO = (Purchase_Order__c) records[0];
            r.data.put('hasFactoringDetails',objPO.Factoring_Assignee__c != NULL && objPO.Factoring_Contact__c != NULL &&  objPO.Factoring_Rate__c > 0);
        }else{
            r.data.put('Error','No Record Found.');
            r.data.put('hasFactoringDetails',false);
        }
        return r;
    }
	@AuraEnabled
    public static AuraResponse createFactoringServiceInvoice(String recordId){
        AuraResponse r = new AuraResponse('CreateFactoringServiceInvoiceController.createFactoringServiceInvoice()');
        if(String.isNotBlank(recordId)){
            Purchase_Order__c objPO = [SELECT Id, Name 
                                        ,Sample_Order__c
                                        ,Ownership__c
                                        ,Opportunity_Name__c
                                        ,Distributor_Name__c
                                        ,Distributor_License__c
                                        ,Purchase_Order_Instructions__c
                                        ,Distributor_Contact__c
                                       	,Brand_Quote__r.Distributor_Name__c
                                        ,Brand_Quote__r.Distributor_License__c
                                        ,Brand_Quote__r.Distributor_Contact__c
                                        ,Receiver_Name__c
                                        ,Receiver_License__c
                                        ,Receiver_Contact__c
                                        ,Supplier_Name__c
                                        ,Supplier_License__c
                                        ,Supplier_Contact__c
                                       	,Brand_Quote__r.Supplier_Name__c
                                        ,Brand_Quote__r.Supplier_License__c
                                        ,Brand_Quote__r.Supplier_Contact__c
                                        ,Brand_Quote__c
                                        ,Payment_Terms__c
                                        ,Site__c
                                        ,Shipping_Method__c
                                        ,Shipping_Terms__c
                                        ,Ship_Confirmation_Date__c 
                                        ,Factoring_Assignee__c
                                        ,Factoring_Rate__c
                                        ,Factoring_Discount__c
                                        ,Factoring_Contact__c
                                        ,Customer_PO_or_Quote__c
                                       ,(SELECT Id
                                         ,Name
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
                                         FROM Purchase_Order_Lines__r
                                         WHERE POLI_Status__c != 'Cancelled')
                                    FROM Purchase_Order__c 
                                    WHERE Id = :recordId];
            
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.Purchase_Order__c= recordId;
            newInvoice.Site__c = objPO.Site__c;
            newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
            newInvoice.Invoice_Memo__c = objPO.Purchase_Order_Instructions__c;
            newInvoice.Shipping_Method__c = objPO.Shipping_Method__c;
            newInvoice.Shipping_Terms__c = objPO.Shipping_Terms__c;
            newInvoice.Payment_Terms__c = PAYMENT_TERMS_COD;//objPO.Payment_Terms__c;
            newInvoice.Sample_Order__c = objPO.Sample_Order__c;
            newInvoice.Brand_Quote__c = objPO.Brand_Quote__c;
            newInvoice.Opportunity_Name__c = objPO.Opportunity_Name__c;
            newInvoice.Distributor_Name__c = objPO.Distributor_Name__c;
            newInvoice.Distributor_License__c = objPO.Distributor_License__c;
            newInvoice.Distributor_Contact__c = objPO.Distributor_Contact__c;
            newInvoice.Supplier_Name__c = objPO.Brand_Quote__r.Distributor_Name__c;
            newInvoice.Supplier_License__c = objPO.Brand_Quote__r.Distributor_License__c;
            newInvoice.Supplier_Contact__c = objPO.Brand_Quote__r.Distributor_Contact__c;
            newInvoice.Receiver_Name__c = objPO.Brand_Quote__r.Supplier_Name__c;
            newInvoice.Receiver_License__c = objPO.Brand_Quote__r.Supplier_License__c;
            newInvoice.Receiver_Contact__c = objPO.Brand_Quote__r.Supplier_Contact__c;
            newInvoice.Ownership__c = objPO.Ownership__c;
            newInvoice.Ship_Confirmation_Date__c = objPO.Ship_Confirmation_Date__c;
            newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Factoring').getRecordTypeId();
            newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
            newInvoice.Factoring_Assignee__c = objPO.Factoring_Assignee__c;
            newInvoice.Factoring_Contact__c = objPO.Factoring_Contact__c;
            newInvoice.Factoring_Rate__c = objPO.Factoring_Rate__c;
            newInvoice.Customer_PO_or_Quote__c = objPO.Customer_PO_or_Quote__c;
            if(objPO.Factoring_Assignee__c != NULL && objPO.Factoring_Contact__c != NULL &&  objPO.Factoring_Rate__c > 0){
                Savepoint sp;
                try{
                    sp = Database.setSavepoint();
                    insert newInvoice;
                    List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
                    for (Purchase_Order_Line__c objPOlines: objPO.Purchase_Order_Lines__r){
                        Invoice_Line__c invLineItem = new Invoice_Line__c();
                        invLineItem.Invoice__c = newInvoice.Id;
                        invLineItem.PO_Line__c = objPOlines.Id;
                        invLineItem.Product_Name__c = objPOlines.Product_Name__c;
                        invLineItem.Product_Title__c = objPOlines.Product_Title__c;
                        invLineItem.Purchased_Date__c = objPOlines.Promised_Date__c;
                        invLineItem.Unit_Cannabis_Weight__c = objPOlines.WAVG_Cannabis_Weight__c;
                        invLineItem.Unit_Cultivation_Tax__c = objPOlines.WAVG_Unit_Cultivation_Tax__c;
                        invLineItem.Invoice_Qty__c = objPOlines.Qty_Ordered__c;
                        invLineItem.Retail_Wholesale_Price__c = objPO.Factoring_Discount__c;
                        if(objPOlines.Ownership_Code__c != null){
                            invLineItem.OwnershipCode__c = objPOlines.Ownership_Code__c;    
                        } else{
                            invLineItem.OwnershipCode__c = objPOlines.Purchase_Order__r.Ownership__c;
                        }
                        invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Factoring').getRecordTypeId();
                        invLineItems.add(invLineItem);
                    }
                    if(invLineItems.size() > 0){
                        insert invLineItems;
                        r.data.put('invoiceId',newInvoice.Id);
                    }
                }catch(Exception e){
                    System.debug('Exception:'+e.getMessage());
                    r.handleException(e);
                    if(!Test.isRunningTest()){
                        Database.rollback(sp);
                    }
                }
                /*Product2[] discountProducts = [SELECT Id, Name, Product_Short_Description__c FROM Product2 WHERE Family ='Discount' AND RecordType.Name = 'Discount' AND Producer_Name__c = :objPO.Factoring_Assignee__c];
                if(discountProducts.size() > 0){
                    Savepoint sp;
                    try{
                        insert newInvoice;
                        Invoice_Line__c invLineItem = new Invoice_Line__c();
                        invLineItem.Invoice__c = newInvoice.Id;
                        invLineItem.Product_Name__c = discountProducts[0].Id;
                        invLineItem.Invoice_Qty__c = 1;
                        invLineItem.Retail_Wholesale_Price__c = objPO.Factoring_Discount__c;
                        invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Factroing').getRecordTypeId();
                        insert invLineItem;
                        r.data.put('invoiceId',newInvoice.Id);
                    }catch(Exception e){
                        r.handleException(e);
                        if(!Test.isRunningTest()){
                            Database.rollback(sp);
                        }
                    }
                }*/
            }else{
                r.data.put('Error','Factoring Assignee and Factoring Rate cannot be blank.');
            }
            
        }
        return r;
    }
}