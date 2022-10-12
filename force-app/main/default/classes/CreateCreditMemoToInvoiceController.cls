public class CreateCreditMemoToInvoiceController {
    
    private static String Invoice_Ar_Status_Draft{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Draft) ? Invoice_Ar_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Draft');
        }set;
    }
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
     private static String Invoice_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Invoice_Line_Status_Cancelled) ? Invoice_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Cancelled');
        }set;
    }
     private static String Invoice_Line_Status_Rejected{
        get{
            return String.isNotBlank(Invoice_Line_Status_Rejected) ? Invoice_Line_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Rejected');
        }set;
    }
        public static String Invoice_Record_Type_Tax{
        get{
            return String.isNotBlank(Invoice_Record_Type_Tax) ? Invoice_Record_Type_Tax : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
    private static String Invoice_Ar_Status_Rejected{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Rejected) ? Invoice_Ar_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    private static String Invoice_Record_Type_Credit_Memo{
        get{
            return String.isNotBlank(Invoice_Record_Type_Credit_Memo) ? Invoice_Record_Type_Credit_Memo : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Credit_Memo');
        }set;
    }
	public static final String INVOICE_STATUS_CANCELLED = InvoiceSupport.INVOICE_STATUS_CANCELLED;
    public static final String INVOICE_COLLECTION_STATUS_PAID_IN_FULL = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAID_IN_FULL;
    public static final String INVOICE_COLLECTION_STATUS_PAST_DUE = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAST_DUE;
    public Invoice__c invoice {get; set;}
    
    // List of Invoice lines to display per page
    public List<InvoiceLineWrapper> setInvoiceLines {get; set;}
    
    // Total Invoice lines Wrapper list to process
    @testVisible
    private List<InvoiceLineWrapper> InvoiceLines;
    
    // Page size to display number of Invoice lines per page
    public String pageSize {get; set;}
    
    // Flag to check if any Invoice lines exists
    public Boolean hasInvoiceLines {get; set;}
    public String statusInv {get; set;}
    public String errorQB {get; set;}
    
     // Flag to check if any validation error exists
    public Boolean isValidationError {get; set;}
    
    // List of Sales Order Line Wrapper by Sales Order Line Id
    private Map<Id, InvoiceLineWrapper> InvoiceLinesWrapperById;
    
    // Constructor
    public CreateCreditMemoToInvoiceController(ApexPages.StandardController stdController) {
        invoice = (Invoice__c) stdController.getRecord();
        setInvoiceLines = new List<InvoiceLineWrapper>();
        InvoiceLines = new List<InvoiceLineWrapper>();
        InvoiceLinesWrapperById = new Map<Id, InvoiceLineWrapper>();
        hasInvoiceLines = false;
        isValidationError = false;
        pageSize = '25';
    }
    public CreateCreditMemoToInvoiceController(){}
    
    @AuraEnabled
    public static AuraResponse createInvoice(String recordId){
        System.debug('Calling init method...'+recordId);
        AuraResponse r = new AuraResponse('CreateCreditMemoToInvoiceController.init()');
        
     	string Err_Msg_greater_than_Invoice_Qty = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_greater_than_Invoice_Qty');
        string Err_Msg_Greater_than_0_Qty_to_Credit = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_Greater_than_0_Qty_to_Credit');
        
        CreateCreditMemoToInvoiceController assign = new CreateCreditMemoToInvoiceController();
        
        assign.invoice = getInvoiceAndLines(recordId);
        
        Decimal checkErrForAvailableQty = 0;
        for(Invoice_Line__c INLI :assign.invoice.Invoice_Lines__r){
            checkErrForAvailableQty += INLI.Invoice_Qty__c;
        }
        if(checkErrForAvailableQty == 0 || checkErrForAvailableQty < 0 ){
            r.data.put('Error', 'Available Qty to Credit must be greater than 0.');
            r.data.put('InvoiceId',assign.invoice.Id);
            return r;
        }
        
        assign.setInvoiceLines = getInvoiceLines(recordId,assign.invoice.Sales_Order__c);//new List<SalesOrderLineWrapper>();
        assign.InvoiceLines = new List<InvoiceLineWrapper>();
        assign.InvoiceLinesWrapperById = new Map<Id, InvoiceLineWrapper>();
        assign.hasInvoiceLines = false;
        assign.isValidationError = false;
       
        
         System.debug('assign.setSalesOrderLines.size() ... '+assign.setInvoiceLines.size());
         if(assign.setInvoiceLines != null && assign.setInvoiceLines.size() > 0) 
            {
                 assign.hasInvoiceLines = true;
            }else  {
                assign.hasInvoiceLines = false;
            }
        
        
        r.data.put('Err_Msg_Greater_than_0_Qty_to_Credit', Err_Msg_Greater_than_0_Qty_to_Credit != null ? Err_Msg_Greater_than_0_Qty_to_Credit : '');        
        r.data.put('Err_Msg_greater_than_Invoice_Qty', Err_Msg_greater_than_Invoice_Qty != null ? Err_Msg_greater_than_Invoice_Qty : '');        
        r.data.put('invoice', assign.invoice);
        r.data.put('setInvoiceLines', assign.setInvoiceLines);
        r.data.put('InvoiceLines', assign.InvoiceLines);
        r.data.put('InvoiceLinesWrapperById', assign.InvoiceLinesWrapperById);
        r.data.put('hasInvoiceLines', assign.hasInvoiceLines);
        r.data.put('isValidationError', assign.isValidationError);
        return r;

    }
    
    // Retrieve Invoice and related line records
    public static Invoice__c getInvoiceAndLines(String invoiceId){
        Invoice__c invoice;
        if(invoiceId != null){
            List<InvoiceLineWrapper> InvoiceLines;
            Map<Id, InvoiceLineWrapper> InvoiceLinesWrapperById;
            CustomIterable InvoiceLinesIterable;
            invoice = [Select Name,Sales_Order__c,AR_Type__c,Distributor_Contact__c, Sales_Order__r.Name,Receiver_Name__c,Receiver_Name__r.Name,Invoice_Due_Date__c,Collections_Status__c,
                       Brand_Quote__c,Brand_Quote__r.Name,Receiver_Contact__c,Receiver_License__c,Shipped_Date__c,Distributor_License__c,Distributor_Name__c,Distributor_Name__r.Name,Invoice_Memo__c,Opportunity_Name__c,Total_Product_Price__c,Excise_Tax_Balance__c,Customer_PO_or_Quote__c,
                       Payment_Terms__c,Shipping_Method__c,Shipping_Terms__c,Site__c,Supplier_Contact__c,Total_Excise_Tax_Amount__c,Invoice_Balance__c,Site__r.Name, Site__r.Warehouse_Name__c,
                       Ship_Confirmation_Date__c,Order_Booking_Fee__c,Pack_Out_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Mileage_Fee__c,Total_Weight_Fee__c,Retailer_PO__c,
                       Factoring_Assignee__c,Factoring_Contact__c,Factoring_Rate__c,Total_Invoice_Amount__c,Supplier_License__c,Supplier_Name__c,Invoice_Aged__c,RecordTypeId, Ownership__c,RecordType.Name,
                       (SELECT Id,Name,Sales_Order_Line__r.Name,Product_Name__r.Name,Product_Description__c,Unit_Excise_Tax__c,Invoice_Qty__c
                        FROM Invoice_Lines__r WHERE InvoiceLine_Status__c NOT IN (:Invoice_Line_Status_Rejected,:Invoice_Line_Status_Cancelled)) From Invoice__c Where Id =: invoiceId AND AR_Status__c NOT IN (:INVOICE_STATUS_CANCELLED,:Invoice_Ar_Status_Rejected)];
           /*    
            for(Invoice_Line__c InvoiceLinesInv : invoice.Invoice_Lines__r){
                
                InvoiceLineWrapper InvLineWrapper = new InvoiceLineWrapper(InvoiceLinesInv);
              
            } */
        }
        return invoice;
    }
    
    public static List<InvoiceLineWrapper>  getInvoiceLines(String invoiceId,String SOId){
        List<InvoiceLineWrapper> ilWrapper = new List<InvoiceLineWrapper>();
        System.debug('##SOId :'+ SOId + 'Invoice_Record_Type_Credit_Memo : '+Invoice_Record_Type_Credit_Memo);
        List <Invoice_Line__c> invlList =  [SELECT Id,Name,Invoice__c,Product_Title__c,Is_Sample__c,IsPromo__c,OwnershipCode__c,Pick_Pack_Fee__c,QA_Review_Fee__c,RecordType.Name,Unit_Cultivation_Tax__c,Unit_Cannabis_Weight__c,
                                            Total_Weight_lbs__c,Listing_Fee__c,ReCalc_Excise_Tax__c,InvoiceLine_Status__c,Retail_Wholesale_Price__c,Sales_Order_Line__c,Sales_Order_Line__r.Name,Product_Name__c,Product_Name__r.Family,Product_Name__r.Name,Product_Description__c,Unit_Excise_Tax__c,Invoice_Qty__c
                                            FROM Invoice_Line__c  WHERE Invoice__c =:invoiceId AND InvoiceLine_Status__c NOT IN (:Invoice_Line_Status_Rejected,:Invoice_Line_Status_Cancelled) ORDER BY Name];
        List <Invoice__c> creditInvoiceList = [SELECT Id ,(SELECT Id,Product_Name__c,Invoice_Qty__c FROM Invoice_Lines__r) FROM Invoice__c WHERE Sales_Order__c =: SOId AND RecordType.Name =: Invoice_Record_Type_Credit_Memo];
        Map<String,Decimal> ProductBasedINLIofCreditMemo = new Map<String,Decimal>();
        System.debug('## creditInvoiceList : '+creditInvoiceList.size());
        if(creditInvoiceList.size() > 0){
            for(Invoice__c INV : creditInvoiceList){
                for(Invoice_Line__c INLI : INV.Invoice_Lines__r){
                    Decimal AvlQty = 0;
                    if(ProductBasedINLIofCreditMemo.containsKey(INLI.Product_Name__c)){
                        AvlQty =  ProductBasedINLIofCreditMemo.get(INLI.Product_Name__c) + INLI.Invoice_Qty__c;
                        ProductBasedINLIofCreditMemo.put(INLI.Product_Name__c,AvlQty);
                    }else{
                        ProductBasedINLIofCreditMemo.put(INLI.Product_Name__c,INLI.Invoice_Qty__c);
                    }
                }
            }
        }
        System.debug('## ProductBasedINLIofCreditMemo : '+ProductBasedINLIofCreditMemo);
        for(Invoice_Line__c InvoiceLinesInv : invlList){
            Decimal avlQty = InvoiceLinesInv.Invoice_Qty__c - (ProductBasedINLIofCreditMemo.containsKey(InvoiceLinesInv.Product_Name__c) ? ProductBasedINLIofCreditMemo.get(InvoiceLinesInv.Product_Name__c) : 0 );
             System.debug('## avlQty : '+avlQty);
            InvoiceLineWrapper INLineWrapper = new InvoiceLineWrapper(InvoiceLinesInv,avlQty);

             //if all quantities are invoiced then make Invoice line as disabled
                 if(avlQty <= 0.0){
                    INLineWrapper.isDisabled = true;
                }
            ilWrapper.add(INLineWrapper);
        }  
        return ilWrapper;
    }
    
    @AuraEnabled
    public static AuraResponse createInvoiceAndLinesLight(Invoice__c invoice, List<InvoiceLineWrapper> setInvoiceLines){
      System.debug('Calling createInvoiceAndLinesLight ' +invoice);
        AuraResponse r = new AuraResponse('CreateCreditMemoToInvoiceController.createInvoiceAndLinesLight()');
        
        CreateCreditMemoToInvoiceController assign = new CreateCreditMemoToInvoiceController();

        String errorQB ='';
        Boolean hasInvLinesLight = false; 
        // create invoice
           Invoice__c invoiceToCreate = createInvoiceInstance(invoice);
        
        
        
        for(InvoiceLineWrapper invLineWrapper : setInvoiceLines){
            System.debug('soLineWrapper.qtyToBill;...'+invLineWrapper.qtyToCredit);
            Decimal qtyToCredit = invLineWrapper.qtyToCredit;
           
            Invoice_Line__c InvoiceLinesInv = invLineWrapper.invoiceLine;
              
            if(invLineWrapper.isSelected && !invLineWrapper.isDisabled){
                hasInvLinesLight = True;  
                // Check qty to Credit cannot be blank and must be positive 
                if(String.isBlank(String.valueOf(qtyToCredit)) == null || qtyToCredit <= 0 ){
                    system.debug('1st if');
                    errorQB = 'Error1';
                    r.data.put('errorQB',errorQB);
                    system.debug('errorQB-1'+errorQB);
                    return r;
                }
                // Check qty to Credit cannot be greater than qty to invoiced
                else if(qtyToCredit > InvoiceLinesInv.Invoice_Qty__c || invLineWrapper.invoiceQty < 0){
                    system.debug('2nd if');
                    errorQB = 'Error2';
                    r.data.put('errorQB',errorQB);
                    system.debug('errorQB-2'+errorQB);
                    return r;
                } 
            } 
        }
       	if(!hasInvLinesLight){
                errorQB = 'Error3';
                r.data.put('errorQB',errorQB);
            	system.debug('errorQB-3'+errorQB);
                return r;
        } 
         // create invoice lines based on selected line
        if((errorQB != 'Error1' || errorQB != 'Error2' ) || errorQB != 'Error3' ){
            system.debug('Inside invoiceToCreate before try block ');
            try{
                insert invoiceToCreate;
                system.debug('Inside invoiceToCreate try block');
                List<Invoice_Line__c> invoiceLinesToCreate = new List<Invoice_Line__c>();
                //List<Invoice_Line__c> updateInvoiceLines = new List<Invoice_Line__c>();
                for(InvoiceLineWrapper invLineWrapper : setInvoiceLines){
                    Invoice_Line__c InvoiceLinesInv = invLineWrapper.invoiceLine;
                    if(invLineWrapper.isSelected && !invLineWrapper.isDisabled){
                        Invoice_Line__c newInvoiceLine = createInvoiceLine(InvoiceLinesInv, 
                                                                           invLineWrapper.qtyToCredit, 
                                                                           invoiceToCreate.Id);
                        System.debug('invoiceLineSO... '+newInvoiceLine);
                        
                        invoiceLinesToCreate.add(newInvoiceLine);
                        //InvoiceLinesInv.Invoice_Qty__c = invLineWrapper.invoiceQty;
                        //updateInvoiceLines.add(InvoiceLinesInv);
                    }
                }
                insert invoiceLinesToCreate; 
                //update updateInvoiceLines;
                r.data.put('newInvoiceId',invoiceToCreate.Id);
            }
            catch(Exception e){
                r.data.put('Error',e.getMessage());
            }
        }
        return r;
    } 
    public static Invoice__c createInvoiceInstance(Invoice__c invoice){
        Invoice__c invoiceSO = new Invoice__c();
        invoiceSO.AR_Status__c            = Invoice_Ar_Status_Draft;//Invoice_Ar_Status_Approved;
        invoiceSO.AR_Type__c              = invoice.AR_Type__c;
        invoiceSO.Brand_Quote__c          = invoice.Brand_Quote__c;
        invoiceSO.Customer_PO_or_Quote__c = invoice.Customer_PO_or_Quote__c;
        invoiceSO.Distributor_Contact__c  = invoice.Distributor_Contact__c;
        invoiceSO.Distributor_License__c  = invoice.Distributor_License__c;
        invoiceSO.Distributor_Name__c     = invoice.Distributor_Name__c;
        invoiceSO.Invoice_Memo__c 		  = invoice.Invoice_Memo__c;
        invoiceSO.Opportunity_Name__c     = invoice.Opportunity_Name__c;
        invoiceSO.Payment_Terms__c        = invoice.Payment_Terms__c;
        invoiceSO.Receiver_Contact__c     = invoice.Receiver_Contact__c;
        invoiceSO.Receiver_Name__c        = invoice.Receiver_Name__c;
        invoiceSO.Receiver_License__c     = invoice.Receiver_License__c;
        invoiceSO.Sales_Order__c          = invoice.Sales_Order__c;
        invoiceSO.Sample_Order__c         = invoice.Sample_Order__c;
        invoiceSO.Shipped_Date__c         = invoice.Shipped_Date__c;
        invoiceSO.Shipping_Method__c      = invoice.Shipping_Method__c;
        invoiceSO.Shipping_Terms__c       = invoice.Shipping_Terms__c;
        invoiceSO.Site__c                 = invoice.Site__c;
        invoiceSO.Supplier_Contact__c     = invoice.Supplier_Contact__c;
        invoiceSO.Supplier_License__c     = invoice.Supplier_License__c;
        invoiceSO.Supplier_Name__c        = invoice.Supplier_Name__c;
        invoiceSO.Ownership__c            = invoice.Ownership__c;
        invoiceSO.Invoice_Due_Date__c     = invoice.Invoice_Due_Date__c;
        invoiceSO.Order_Booking_Fee__c = invoice.Order_Booking_Fee__c;
        invoiceSO.Pack_Out_Fee__c = invoice.Pack_Out_Fee__c;
        invoiceSO.Schedule_Dispatch_Fee__c = invoice.Schedule_Dispatch_Fee__c;
        invoiceSO.Stage_Manifest_Fee__c = invoice.Stage_Manifest_Fee__c;
        invoiceSO.Total_Mileage_Fee__c = invoice.Total_Mileage_Fee__c;
        invoiceSO.Total_Weight_Fee__c = invoice.Total_Weight_Fee__c;
        invoiceSO.Retailer_PO__c = invoice.Retailer_PO__c;
        invoiceSO.Factoring_Assignee__c = invoice.Factoring_Assignee__c;
        invoiceSO.Factoring_Contact__c = invoice.Factoring_Contact__c;
        invoiceSO.Factoring_Rate__c = invoice.Factoring_Rate__c;
        invoiceSO.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Credit Memo').getRecordTypeId();
        return invoiceSO;
    }
    
    public static Invoice_Line__c createInvoiceLine(Invoice_Line__c invLine,
                                             Decimal qtyToCredit,
                                             Id invoiceId){
        Invoice_Line__c invoiceLineSO = new Invoice_Line__c();
        invoiceLineSO.Invoice_Qty__c            = qtyToCredit;
        invoiceLineSO.Product_Name__c           = invLine.Product_Name__c;
        invoiceLineSO.Product_Title__c          = invLine.Product_Title__c;
        invoiceLineSO.Retail_Wholesale_Price__c = invLine.Retail_Wholesale_Price__c;
        invoiceLineSO.Sales_Order_Line__c       = invLine.Sales_Order_Line__c;                    
        invoiceLineSO.Invoice__c                = invoiceId;
        invoiceLineSO.InvoiceLine_Status__c     = invLine.InvoiceLine_Status__c; 
        invoiceLineSO.Listing_Fee__c     = invLine.Listing_Fee__c;                                         
        invoiceLineSO.Is_Sample__c              = invLine.Is_Sample__c;
        invoiceLineSO.IsPromo__c                = invLine.IsPromo__c;
        invoiceLineSO.OwnershipCode__c          = invLine.OwnershipCode__c;
        invoiceLineSO.Pick_Pack_Fee__c 			= invLine.Pick_Pack_Fee__c;
        invoiceLineSO.QA_Review_Fee__c 			= invLine.QA_Review_Fee__c;
        invoiceLineSO.Total_Weight_lbs__c 		= invLine.Total_Weight_lbs__c;
        invoiceLineSO.ReCalc_Excise_Tax__c 		= invLine.ReCalc_Excise_Tax__c;
        
        if(invLine.RecordType.Name == Invoice_Record_Type_Tax)
        	invoiceLineSO.Retail_Wholesale_Price__c = invLine.Unit_Cultivation_Tax__c;
                                                 
        invoiceLineSO.RecordTypeId =Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Credit Memo').getRecordTypeId();
        return invoiceLineSO;
    }
    
    // Wrapper class to store Sales order line details
    public class InvoiceLineWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public Boolean isDisabled {get; set;}
        @AuraEnabled
        public Invoice_Line__c invoiceLine {get; set;}
        @AuraEnabled
        public Decimal qtyToCredit {get; set;}
        @AuraEnabled
        public Decimal invoiceQty {get; set;}
        @AuraEnabled
        public Decimal AvlQty {get; set;}
        
        // Constructor
        public InvoiceLineWrapper(Invoice_Line__c invoiceLine,Decimal AvlQty){
            this.isSelected = false;
            this.isDisabled = false;
            this.invoiceLine = invoiceLine;
            this.AvlQty =AvlQty;
            this.invoiceQty =AvlQty;//invoiceLine.Invoice_Qty__c == null ? 0 :invoiceLine.Invoice_Qty__c;
            this.qtyToCredit = 0;//invoiceLine.Invoice_Qty__c
        }
         public InvoiceLineWrapper(){
            this.isSelected = false;
            this.isDisabled = false;
            this.invoiceLine = invoiceLine;
             this.AvlQty =0;
            this.invoiceQty =0;
            this.qtyToCredit = 0;
        }
    }
}