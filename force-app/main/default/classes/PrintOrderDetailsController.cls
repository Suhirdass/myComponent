public without sharing class PrintOrderDetailsController {
    public List<RetailDeliveryTicketsCtlr.RetailDeliveryTicketLineItem>retailDeliveryTicketLineItems{get;set;}
    public RetailDeliveryTicketsCtlr.RetailDeliveryTicket retailDeliveryTicket{get;set;}
    public decimal totalQty{get;set;}
    public string shippingAddress{get;set;}
    public decimal subTotal{get;set;}
    public decimal totalExciseTax{get;set;}
    public decimal grandTotal{get;set;}
    public decimal factoringDiscount{get;set;}
    public decimal shippingFee{get;set;}
    public decimal totalServicesfee{get;set;}
    public decimal orderProcessingFee{get;set;}
    public decimal distribution{get;set;}
    public string headerTxt{get;set;}
    public List<Invoice__c> invoices{get;set;}
    public List<Shipping_Manifest__c> shipmenifestList{get;set;}
    public boolean  fromOrder{get;set;}
    public boolean isExportWithFees{get;set;}
    public String BarCodeORQRCodeMSG{get;set;}
    public String ThirdPartySchedulerMSG{get;set;}
    public PrintOrderDetailsController(){
        decimal totalPickPack = 0;
        decimal totalQAReview = 0;
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        isExportWithFees= Boolean.valueOf(ApexPages.currentPage().getParameters().get('ExportWithFees'));
        fromOrder = ApexPages.currentPage().getParameters().get('fromOrder') != null ? boolean.valueof(ApexPages.currentPage().getParameters().get('fromOrder')) : true;
        AuraResponse wrapperData = RetailDeliveryTicketsCtlr.getRetailDeliveryTicket(recordId);
        retailDeliveryTicket = (RetailDeliveryTicketsCtlr.RetailDeliveryTicket)wrapperData.data.get('retailDeliveryTicket');
        retailDeliveryTicketLineItems = (List<RetailDeliveryTicketsCtlr.RetailDeliveryTicketLineItem>)wrapperData.data.get('retailDeliveryTicketLineItems');
        invoices = (List<Invoice__c>) wrapperData.data.get('invoiceList');
        BarCodeORQRCodeMSG = (String) wrapperData.data.get('BarCodeORQRCodeMSG');
        ThirdPartySchedulerMSG = (String) wrapperData.data.get('ThirdPartySchedulerMSG');
        shipmenifestList = (List<Shipping_Manifest__c>) wrapperData.data.get('shipmenifestList');
        Order__c odr = [SELECT Id,Total_Product_Price__c,Total_Excise_Tax_Amount__c From Order__c WHERE id =: recordId];
        string add = retailDeliveryTicket.stateLicenseName;
        list<string> addList = add.split('-');
        if(addList.size() > 2)
            shippingAddress = addList[2];
        subTotal = totalExciseTax = shippingFee = totalServicesfee = distribution = orderProcessingFee = 0;
        
        for(RetailDeliveryTicketsCtlr.RetailDeliveryTicketLineItem entry : retailDeliveryTicketLineItems){
            /*if(entry.Product != null && entry.Product != ''){
                if(entry.isDiscountProduct){
                    subTotal -= entry.MOQ * entry.orderQty * entry.salesPrice ;
                }else{
                    subTotal += entry.MOQ * entry.orderQty * entry.salesPrice ;
                }
                if(!retailDeliveryTicket.excludeExciseTax){
                    
                    if (!entry.isSample && entry.applyExciseTax != 'No') {
                        if(entry.isDiscountProduct){
                            totalExciseTax -= decimal.valueof(entry.salesPrice * entry.orderQty * entry.MOQ) * 1.8 * 0.15;
                        }else{
                            totalExciseTax += decimal.valueof(entry.salesPrice * entry.orderQty * entry.MOQ) * 1.8 * 0.15;
                        }
                        
                    }
                    //totalExciseTax = subTotal == 0 ? 0:totalExciseTax;
                }
            } */
            if(entry.pickPackFee != null){
                totalPickPack += entry.pickPackFee;
            }
            if(entry.QAReviewFee != null){
                totalQAReview += entry.QAReviewFee;
            }
        }
        subTotal = odr.Total_Product_Price__c;
        totalExciseTax = odr.Total_Excise_Tax_Amount__c;
        grandTotal = subTotal + totalExciseTax ;
        shippingFee = retailDeliveryTicket.scheduleDispatchFee + retailDeliveryTicket.totalMileageFee + retailDeliveryTicket.totalWeightFee;
        orderProcessingFee = retailDeliveryTicket.orderBookingFee + totalPickPack + totalQAReview  + retailDeliveryTicket.stageManifestFee + retailDeliveryTicket.packOutFee; 
        totalServicesfee = orderProcessingFee + shippingFee;
        distribution = integer.valueof(subTotal) > 0 ? totalServicesfee/integer.valueof(subTotal) : 0;
        distribution = distribution * 100;
        
        Decimal factoringRate ;
        if(retailDeliveryTicket.factoringRate != null){
           factoringRate = retailDeliveryTicket.factoringRate;
        } else {
            factoringRate = 0;
        }
        System.debug('factoringRate = '+factoringRate);
        System.debug('grandTotal = '+grandTotal);
        factoringDiscount  = grandTotal * factoringRate / 100; 
        if(fromOrder){
           //grandTotal = subTotal + totalExciseTax - factoringDiscount; 
        }
        headerTxt = fromOrder  ?  'Order Details #' : 'Outbound Transfer Details #';
        if(fromOrder){
            retailDeliveryTicket.specialDeliveryInstructions = retailDeliveryTicket.specialDeliveryInstructions != null && retailDeliveryTicket.specialDeliveryInstructions != '' ? insertBreak(retailDeliveryTicket.specialDeliveryInstructions) : '';
            retailDeliveryTicket.invoiceMemo = retailDeliveryTicket.invoiceMemo != null && retailDeliveryTicket.invoiceMemo != '' ? insertBreak(retailDeliveryTicket.invoiceMemo) : '';
        }
    }
    
    public static string insertBreak(String hyperLink) { // hyperLink is the URL
        final Integer linkLength = hyperLink.length();
        final Integer maxLength = 30;
        if(linkLength > (maxLength + 10)){
        Integer varCount = (linkLength/maxLength);
        
        if (math.mod(linkLength, maxLength) > 0)
            varCount++;
        
        String fullLink = '';
        integer startValue = 0;
        integer endValue = maxLength;
        for (Integer i = varCount; i >= 0; i--) { 
            fullLink += hyperLink.substring(startValue, endValue) + ' ';
            startValue = endValue;
            endValue = (endValue + maxLength) > linkLength ? linkLength : (endValue + maxLength);
        }
        return fullLink;
        }else{
             return hyperLink;
        }
        
    }
}