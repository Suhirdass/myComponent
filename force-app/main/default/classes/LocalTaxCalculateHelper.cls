public class LocalTaxCalculateHelper {
    public static Map<String, Tax_Table__c > cityTaxMap{
        get{
            if(cityTaxMap == null){
                cityTaxMap = new Map<String, Tax_Table__c >();
                for(Tax_Table__c tt: [SELECT Id,Active__c ,Actual_Tax_Rate_on_Product_Rev__c ,City__c, End_Date__c , Start_Date__c , Taxable_Gross_Receipts_Rate__c, Tax_Due_Rate__c  FROM Tax_Table__c WHERE Active__c = true]){
                    cityTaxMap.put(tt.City__c,tt);
                }
            }
            return cityTaxMap;
        }set;
    }
    /*public static void calculateTaxOnCity(Sales_Order_Line__c [] newList, Map<Id,Sales_Order_Line__c > oldSOLineMap){
        Set<Id> SOIds = new Set<Id>();
        Map<Id,Sales_Order_Line__c[]>SOLinesMap = new Map<Id,Sales_Order_Line__c[]>();
        for(Sales_Order_Line__c SOL: newList){
            if(Trigger.isInsert || (Trigger.isUpdate && (SOL.Qty_Ordered__c  != oldSOLineMap.get(SOL.Id).Qty_Ordered__c  || SOL.Retail_Wholesale_Price__c  != oldSOLineMap.get(SOL.Id).Retail_Wholesale_Price__c))){
                if(SOLinesMap.containsKey(SOL.Sales_Order__c)){
                    SOLinesMap.get(SOL.Sales_Order__c ).add(SOL);
                }else{
                    SOLinesMap.put(SOL.Sales_Order__c , new Sales_Order_Line__c[]{SOL});
                }
                SOIds.add(SOL.Sales_Order__c);
            }
        }
        if(!SOIds.isEmpty()){
            Sales_Order__c[] SOrders = [SELECT Delivery_City__c, Planned_Ship_Date__c FROM Sales_Order__c WHERE Id IN:SOIds];
            for(Sales_Order__c SO: SOrders){
                Sales_Order_Line__c[] items  = SOLinesMap.get(SO.Id);
                if(cityTaxMap.containsKey(SO.Delivery_City__c)){
                    Tax_Table__c tt = cityTaxMap.get(SO.Delivery_City__c);
                    System.debug('###Tax_Table__c:::'+tt);
                    Decimal subTotal = 0;
                    decimal taxRateOnProd = tt.Actual_Tax_Rate_on_Product_Rev__c != null?tt.Actual_Tax_Rate_on_Product_Rev__c/100:0;
                    decimal taxableGrossReceiptsRate = tt.Taxable_Gross_Receipts_Rate__c != null?tt.Taxable_Gross_Receipts_Rate__c/100:0; 
                    decimal taxDueRate = tt.Tax_Due_Rate__c != null?tt.Tax_Due_Rate__c/100:0;
                    
                    if(!items.isEmpty() && tt != null && tt.End_Date__c >= SO.Planned_Ship_Date__c){
                        for(Sales_Order_Line__c SOL: items){
                            subTotal = SOL.Qty_Ordered__c * SOL.Retail_Wholesale_Price__c * taxableGrossReceiptsRate * taxDueRate;
                            if(taxRateOnProd > 0){
                                subTotal = subTotal * taxRateOnProd;
                            }
                            SOL.Subtotal_Local_Cannabis_Tax__c = subTotal;
                        }
                        
                    }else{
                        for(Sales_Order_Line__c SOL: items){
                            SOL.Subtotal_Local_Cannabis_Tax__c = 0;
                        }
                    }
                    
                }else{
                    for(Sales_Order_Line__c SOL: items){
                        SOL.Subtotal_Local_Cannabis_Tax__c = 0;
                    }
                }
            }
        }
    }
    public static void calculateTaxOnCity(Brand_Quote_Line__c[] newList, Map<Id,Brand_Quote_Line__c> oldBQLineMap){
        Set<Id> BQIds = new Set<Id>();
        Map<Id,Brand_Quote_Line__c[]>BQLinesMap = new Map<Id,Brand_Quote_Line__c[]>();
        for(Brand_Quote_Line__c BQL: newList){
            if(Trigger.isInsert || (Trigger.isUpdate && (BQL.MOQ__c != oldBQLineMap.get(BQL.Id).MOQ__c || BQL.Retail_Wholesale_Price__c  != oldBQLineMap.get(BQL.Id).Retail_Wholesale_Price__c || BQL.Quantity_Cases__c != oldBQLineMap.get(BQL.Id).Quantity_Cases__c ))){
                if(BQLinesMap.containsKey(BQL.Brand_Quote_Number__c)){
                    BQLinesMap.get(BQL.Brand_Quote_Number__c).add(BQL);
                }else{
                    BQLinesMap.put(BQL.Brand_Quote_Number__c, new Brand_Quote_Line__c[]{BQL});
                }
                BQIds.add(BQL.Brand_Quote_Number__c);
            }
        }
        if(!BQIds.isEmpty()){
            Brand_Quote__c [] BQs = [SELECT Delivery_City__c , Planned_Ship_Date__c FROM Brand_Quote__c WHERE Id IN :BQIds];
            for(Brand_Quote__c BQ: BQs){
                Brand_Quote_Line__c[] items = BQLinesMap.get(BQ.Id);
                if(cityTaxMap.containsKey(BQ.Delivery_City__c)){
                    Tax_Table__c tt = cityTaxMap.get(BQ.Delivery_City__c);
                    System.debug('###Tax_Table__c:::'+tt);
                    Decimal subTotal = 0;
                    decimal taxRateOnProd = tt.Actual_Tax_Rate_on_Product_Rev__c != null?tt.Actual_Tax_Rate_on_Product_Rev__c/100:0;
                    decimal taxableGrossReceiptsRate = tt.Taxable_Gross_Receipts_Rate__c != null?tt.Taxable_Gross_Receipts_Rate__c/100:0; 
                    decimal taxDueRate = tt.Tax_Due_Rate__c != null?tt.Tax_Due_Rate__c/100:0;
                    
                    if(!items.isEmpty() && tt != null && tt.End_Date__c >= BQ.Planned_Ship_Date__c){
                        for(Brand_Quote_Line__c BQL: items){
                            subTotal = BQL.MOQ__c * BQL.Quantity_Cases__c * BQL.Retail_Wholesale_Price__c  * taxableGrossReceiptsRate * taxDueRate;
                            if(taxRateOnProd > 0){
                                subTotal = subTotal * taxRateOnProd;
                            }
                            BQL.Subtotal_Local_Cannabis_Tax__c = subTotal;
                        }
                        
                    }else{
                        for(Brand_Quote_Line__c BQL: items){
                            BQL.Subtotal_Local_Cannabis_Tax__c = 0;
                        }
                    }
                    
                }else{
                    for(Brand_Quote_Line__c BQL: items){
                        BQL.Subtotal_Local_Cannabis_Tax__c = 0;
                    }
                }
            }
        }
        //MOQ__c * Quantity_Cases__c * Retail_Wholesale_Price__c 
    }
	*/
    public static void calculateTaxOnCity(Invoice_Line__c[] newList, Map<Id,Invoice_Line__c> oldInvoiceLineMap){
        Set<Id> invoiceIds = new Set<Id>();
        Map<Id,Invoice_Line__c[]>invoiceLinesMap = new Map<Id,Invoice_Line__c[]>();
        for(Invoice_Line__c IL: newList){
            if(Trigger.isInsert || (Trigger.isUpdate && (IL.Invoice_Qty__c !=  oldInvoiceLineMap.get(IL.Id).Invoice_Qty__c || IL.Retail_Wholesale_Price__c  !=  oldInvoiceLineMap.get(IL.Id).Retail_Wholesale_Price__c ))){
                if(invoiceLinesMap.containsKey(IL.Invoice__c)){
                    invoiceLinesMap.get(IL.Invoice__c).add(IL);
                }else{
                    invoiceLinesMap.put(IL.Invoice__c, new Invoice_Line__c[]{IL});
                }
                invoiceIds.add(IL.Invoice__c);
            }
        }
        if(!invoiceIds.isEmpty()){
            
            Invoice__c[] invoices = [SELECT Id, Invoice_Date__c ,Delivery_City__c FROM Invoice__c WHERE Id IN: invoiceIds];
            
            for(Invoice__c inv: invoices){
                Invoice_Line__c[] items = invoiceLinesMap.get(inv.Id);
                if(cityTaxMap.containsKey(inv.Delivery_City__c)){
                    Tax_Table__c tt = cityTaxMap.get(inv.Delivery_City__c);
                    System.debug('###Tax_Table__c:::'+tt);
                    Decimal subTotal = 0;
                    decimal taxRateOnProd = tt.Actual_Tax_Rate_on_Product_Rev__c != null?tt.Actual_Tax_Rate_on_Product_Rev__c/100:0;
                    decimal taxableGrossReceiptsRate = tt.Taxable_Gross_Receipts_Rate__c != null?tt.Taxable_Gross_Receipts_Rate__c/100:0; 
                    decimal taxDueRate = tt.Tax_Due_Rate__c != null?tt.Tax_Due_Rate__c/100:0;
                    
                    if(!items.isEmpty() && tt != null && tt.End_Date__c >= inv.Invoice_Date__c){
                        for(Invoice_Line__c invLine: items){
                            subTotal = invLine.Line_Total_Product_Price__c * taxableGrossReceiptsRate * taxDueRate;
                            if(taxRateOnProd > 0){
                                subTotal = subTotal * taxRateOnProd;
                            }
                            invLine.Subtotal_Local_Cannabis_Tax__c = subTotal;
                        }
                        
                    }else{
                        for(Invoice_Line__c invLine: items){
                            invLine.Subtotal_Local_Cannabis_Tax__c = 0;
                        }
                    }
                    
                }else{
                    for(Invoice_Line__c invLine: items){
                        invLine.Subtotal_Local_Cannabis_Tax__c = 0;
                    }
                }
            }
        }
        
    }
}