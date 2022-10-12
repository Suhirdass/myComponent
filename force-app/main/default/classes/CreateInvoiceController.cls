/********************************************************************
* Project           : Filigreen
*
* Apex name         : CreateInvoiceController.apxc
*
* Test Class name   : CreateInvoiceControllerTest.apxc
*
* Author            : Vijay Salem
*
* Date created      : 7/24/2019
*
* Purpose           : Apex Controller for createInvoice.cmp
*
* Revision History  :
*
* Date        Author      		Ref    Revision (Date in YYYYMMDD format) 
* 7/24/2019    Vijay Salem       1      Apex created for VF. 
* 7/28/2020    Praveen Ayyanar   2      Apex modified for Lightning component.
*
**********************************************************************/

public class CreateInvoiceController {

    private static final String SO_STATUS_APPROVED = SalesOrderSupport.SO_STATUS_APPROVED; 
    private static final String SO_STATUS_CANCELLED = SalesOrderSupport.SO_STATUS_CANCELLED; 
    private static final String SO_LINE_STATUS_REJECTED = SalesOrderSupport.SO_LINE_STATUS_REJECTED;
    private static final String SO_LINE_STATUS_CANCELLED = SalesOrderSupport.SO_LINE_STATUS_CANCELLED;
    
    private static String Invoice_Ar_Status_Draft{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Draft) ? Invoice_Ar_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Draft');
        }set;
    }
    private static String SOLI_RecordType_Product{
        get{
            return String.isNotBlank(SOLI_RecordType_Product) ? SOLI_RecordType_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_Product');
        }set;
    }
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    private static String Account_Plateformlevel_ZASP {
        get{
            return String.isNotBlank(Account_Plateformlevel_ZASP ) ? Account_Plateformlevel_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    private static String Account_Plateformlevel_IRR {
        get{
            return String.isNotBlank(Account_Plateformlevel_IRR ) ? Account_Plateformlevel_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
    private Static String SO_RECORDTYPE_TRANSFER {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_TRANSFER) ? SO_RECORDTYPE_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Transfer');
        }set;
    }
    
    public Sales_Order__c salesOrderSO {get; set;}
    public String invoices {get;set;}
    
    public List<Invoice__c> invoiceData {get;set;}
    
    // List of Sales Order lines to display per page
    public List<SalesOrderLineWrapper> setSalesOrderLines {get; set;}
    
    // Total Sales Order lines Iterable to process
    public CustomIterable salesOrderLinesIterable {get; set;}
    
    // Total Sales Order lines Wrapper list to process
    @testVisible
    private List<SalesOrderLineWrapper> salesOrderLines;
    
    // Page size to display number of Sales Order lines per page
    public String pageSize {get; set;}
    
    // Flag to check if any sales order lines exists
    public Boolean hasSalesOrderLines {get; set;}
    public String statusSO {get; set;}
    public String errorQB {get; set;}
    
    // Flag to check if any validation error exists
    public Boolean isValidationError {get; set;}
    
    // List of Sales Order Line Wrapper by Sales Order Line Id
    private Map<Id, SalesOrderLineWrapper> salesOrderLineWrapperById;
    
    // Constructor
    public CreateInvoiceController(ApexPages.StandardController stdController) {
        salesOrderSO = (Sales_Order__c) stdController.getRecord();
        setSalesOrderLines = new List<SalesOrderLineWrapper>();
        salesOrderLines = new List<SalesOrderLineWrapper>();
        salesOrderLineWrapperById = new Map<Id, SalesOrderLineWrapper>();
        hasSalesOrderLines = false;
        isValidationError = false;
        getInvoices();
        pageSize = '25';
    }
    
    //FG-211 start
    
    public CreateInvoiceController(){}
    
    @AuraEnabled
    public static AuraResponse createInvoice(String recordId){
        System.debug('Calling CreateInvoice method...'+recordId);
        AuraResponse r = new AuraResponse('CreateInvoiceController.CreateInvoice()');
     	
        CreateInvoiceController assign = new CreateInvoiceController();
        
        assign.salesOrderSO = getSalesOrderAndLines(recordId);
        
        if(assign.salesOrderSO.RecordType.Name == SO_RECORDTYPE_TRANSFER && (assign.salesOrderSO.Receiver_Name__r.Platform_Level__c == Account_Plateformlevel_ZASP || assign.salesOrderSO.Receiver_Name__r.Platform_Level__c == Account_Plateformlevel_ZASP)){
            List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Max_IB__c,Account__c FROM Account_Setting__c WHERE Account__c = :assign.salesOrderSO.Receiver_Name__c];
            if(accSettingList.size() > 0 && accSettingList[0].Mthly_OB__c <= accSettingList[0].Max_OB__c){
                r.data.put('error', 'Fulfillment Invoice Not Created');
                return r;
            }
        }
        
        assign.setSalesOrderLines = getSalesOrderLines(recordId);//new List<SalesOrderLineWrapper>();
        assign.salesOrderLines = new List<SalesOrderLineWrapper>();
        assign.salesOrderLineWrapperById = new Map<Id, SalesOrderLineWrapper>();
        assign.hasSalesOrderLines = false;
        assign.isValidationError = false;
        assign.invoiceData = getInvoiceData(recordId);
       
        assign.getInvoices();
        
        assign.pageSize = '25';
         System.debug('assign.setSalesOrderLines.size() ... '+assign.setSalesOrderLines.size());
         if(assign.setSalesOrderLines != null && assign.setSalesOrderLines.size() > 0) 
            {
                 assign.hasSalesOrderLines = true;
            }else  {
                assign.hasSalesOrderLines = false;
            }

        if(assign.salesOrderSO.SO_Status__c == SO_STATUS_CANCELLED){
            
                string statusSO = assign.salesOrderSO.SO_Status__c;
                r.data.put('statusSO',statusSO);
          
                return r;
        }
         else if(assign.salesOrderSO.SO_Status__c == 'Rejected'){
                         string statusSO = assign.salesOrderSO.SO_Status__c;
                r.data.put('statusSO',statusSO);
        
                return r;
        }
    

    	string statusSO = 'Approved';
        r.data.put('statusSO',statusSO);
        r.data.put('salesOrderSO', assign.salesOrderSO);
        r.data.put('setSalesOrderLines', assign.setSalesOrderLines);
        r.data.put('salesOrderLines', assign.salesOrderLines);
        r.data.put('salesOrderLineWrapperById', assign.salesOrderLineWrapperById);
        r.data.put('hasSalesOrderLines', assign.hasSalesOrderLines);
        r.data.put('isValidationError', assign.isValidationError);
        r.data.put('invoiceData', assign.invoiceData);
        System.debug('invoiceData.. '+assign.invoiceData);
        return r;

    }
    


//Create Invoice Function Button Start

@AuraEnabled
    public static AuraResponse createInvoiceAndLinesLight(Sales_Order__c salesOrderSO, List<SalesOrderLineWrapper> setSalesOrderLines){
      System.debug('Calling createInvoiceAndLinesLight ');
        AuraResponse r = new AuraResponse('CreateInvoiceController.createInvoiceAndLinesLight()');
        
        CreateInvoiceController assign = new CreateInvoiceController();

        String errorQB;
        Boolean hasSOLinesLight = false; 
        
        for(SalesOrderLineWrapper soLineWrapper : setSalesOrderLines){
            System.debug('soLineWrapper.qtyToBill;...'+soLineWrapper.qtyToBill);
            Decimal qtyToBill = soLineWrapper.qtyToBill;
           
            Sales_Order_Line__c salesOrderLineSO = soLineWrapper.salesOrderLineSO;
              
            if(soLineWrapper.isSelected && !soLineWrapper.isDisabled){
                hasSOLinesLight = True;  
                // Check qty to bill cannot be blank and must be positive 
                if(String.isBlank(String.valueOf(qtyToBill)) == null || qtyToBill <= 0 ){
                    system.debug('1st if');
                errorQB = 'Error1';
                r.data.put('errorQB',errorQB);
            	system.debug('errorQB-1'+errorQB);
                return r;
                }
                // Check qty to bill cannot be greater than qty to invoiced
                else if(qtyToBill > salesOrderLineSO.Qty_To_Invoiced__c){
                     system.debug('2nd if');
                errorQB = 'Error2';
                r.data.put('errorQB',errorQB);
            	system.debug('errorQB-2'+errorQB);
                return r;
                } 
                } 
        }
         if(!hasSOLinesLight){
                errorQB = 'Error3';
                r.data.put('errorQB',errorQB);
            	system.debug('errorQB-3'+errorQB);
                return r;
        } 
       // create invoice
           Invoice__c invoiceToCreate = createInvoiceInstance(salesOrderSO);
        system.debug('invoiceToCreate.....'+invoiceToCreate);
        system.debug('invoiceToCreate collection status .....'+invoiceToCreate.Collections_Status__c);
         // create invoice lines based on selected order line
        if(errorQB != 'Error1' || errorQB != 'Error2' || errorQB != 'Error3' ){
        try{
            insert invoiceToCreate;
            system.debug('Inside invoiceToCreate try block');
            List<Invoice_Line__c> invoiceLinesToCreate = new List<Invoice_Line__c>();
            
            // update sales order line with qty invoiced
            List<Sales_Order_Line__c> soLineToUpdate = new List<Sales_Order_Line__c>();
             for(SalesOrderLineWrapper soLineWrapper : setSalesOrderLines){


                Sales_Order_Line__c salesOrderLineSO = soLineWrapper.salesOrderLineSO;
                system.debug('salesOrderLineSO....'+salesOrderLineSO);
                 if(soLineWrapper.isSelected && !soLineWrapper.isDisabled){
                    // Create new invoice lines based on qty to bill value
                    Invoice_Line__c invoiceLineSO = createInvoiceLine(salesOrderLineSO, 
                                                                       soLineWrapper.qtyToBill, 
                                                                      invoiceToCreate.Id);
                    System.debug('invoiceLineSO... '+invoiceLineSO);
                    
                    invoiceLinesToCreate.add(invoiceLineSO);
                    
                    // Increase qty that is invoiced
                    salesOrderLineSO.Qty_Invoiced__c = salesOrderLineSO.Qty_Invoiced__c == null ?  
                                                       soLineWrapper.qtyToBill :
                                                       salesOrderLineSO.Qty_Invoiced__c + soLineWrapper.qtyToBill;
                    System.debug('salesOrderLineSO.Qty_Invoiced__c... '+salesOrderLineSO.Qty_Invoiced__c);
                    soLineToUpdate.add(salesOrderLineSO);   
                 }
               }
            insert invoiceLinesToCreate;
            update soLineToUpdate;     
             }
        catch(Exception e){
            
        }
            }
        return r;
    } 


//Method to fetch and display invoices
public static List<Invoice__c> getInvoiceData(String salesOrderId) {
		
        List<Invoice__c> invoiceDetails = [select id,Sales_Order__c, Sales_Order__r.Name, Name from Invoice__c  where Sales_Order__c =: salesOrderId];
       return invoiceDetails;
    }
 
//Method to get UID in Create invoice light   

    public static String getInventoryPositionList(Id solId) {
        List<Inventory_Position__c> sollist = [select  UID_New__r.name from Inventory_Position__c 
                                       where Sales_Order_Line__c =:solId];  
        
        map<string,string> sollistTwo = new map<string,string>();
            for(Integer i=0; i < sollist.size(); i++) {
                if(sollist[i].UID_New__r.name != null || !String.isBlank(sollist[i].UID_New__r.name)){
                    sollistTwo.put(sollist[i].UID_New__r.name,sollist[i].UID_New__r.name);    
                }
            }
        
        String UIDName='';
            List<String> mapString = new List<String>();
            mapString = sollistTwo.values();
            for(Integer i=0; i< mapString.size(); i++){
                if(i == 0){
                    UIDName = mapString.get(i);
                }else{
                    UIDName = UIDName+','+'<br/>'+mapString.get(i);
                }
            }
        return UIDName;
    }
    
 public static List<SalesOrderLineWrapper>  getSalesOrderLines(String salesOrderId){
        List<SalesOrderLineWrapper> slWrapper = new List<SalesOrderLineWrapper>();
        
        List <Sales_Order_Line__c> solList =  [Select Name, Arrival_Date__c,
                            Brand_Quote_Line__c,Product_Name__c, Product_Name__r.Name, Product_Title__c, Product_Description__c,
							Promised_Date__c, Producer_Name__c, MOQ__c, Qty_Ordered__c, Qty_Invoiced__c, Qty_To_Invoiced__c, 
							Quantity_Cases__c, Request_Date__c, Retail_Wholesale_Price__c, Line_Total_Price__c, Is_Sample__c,IsPromo__c, 
							Sales_Order__c,Ownership_Code__c, Status__c,RecordType.Name From Sales_Order_Line__c  where Sales_Order__c =:salesOrderId ORDER BY Name];

        for(Sales_Order_Line__c salesOrderLineSO : solList){
            
            if(salesOrderLineSO.Status__c != SO_LINE_STATUS_REJECTED) {
                if(salesOrderLineSO.Status__c != SO_LINE_STATUS_CANCELLED){
                // Add sales order lines in iterable interface
                salesOrderLineSO.UID__c = getInventoryPositionList(salesOrderLineSO.Id);
                SalesOrderLineWrapper soLineWrapper = new SalesOrderLineWrapper(salesOrderLineSO);

             //if all quantities are invoiced then make sales order line as disabled
                 if(salesOrderLineSO.Qty_To_Invoiced__c <= 0.0){
                    soLineWrapper.isDisabled = true;
                }
                slWrapper.add(soLineWrapper);
           	}
          }     
       }  
        return slWrapper;
    }
    
    // Retrieve Sales order and related line records
    public static Sales_Order__c getSalesOrderAndLines(String salesOrderId){
        Sales_Order__c salesOrderSO;
        if(salesOrderId != null){
            List<SalesOrderLineWrapper> salesOrderLines;
            Map<Id, SalesOrderLineWrapper> salesOrderLineWrapperById;
            CustomIterable salesOrderLinesIterable;
            salesOrderSO = [Select Name, Brand_Quote__c, Distributor_Contact__c, Distributor_License__c, Distributor_Name__c, Distributor_DBA__c, Customer_PO_or_Quote__c, Opportunity_Name__r.Name,Retailer_PO__c,Factoring_Contact__c, 
                            Payment_Terms__c, Planned_Ship_Date__c, Receiver_Contact__c, Receiver_License__c, Receiver_Name__c, Receiver_DBA__c,Receiver_Name__r.Platform_Level__c, Sales_Order_Instructions__c,Ship_Confirmation_Date__c,Factoring_Assignee__c,
                            Factoring_Rate__c,Sample_Order__c, Shipping_Method__c, Shipping_Terms__c, Site__r.Name, Site__r.Warehouse_Name__c, Total_Price__c, Total_Line_Items__c, SO_Date__c, SO_Status__c, SO_Type__c,  
                            Supplier_Contact__c, Supplier_License__c, Supplier_Name__c, Supplier_DBA__c, Allocated__c, RecordTypeId, Ownership__c,RecordType.Name,Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c From Sales_Order__c Where Id =: salesOrderId];
               
            for(Sales_Order_Line__c salesOrderLineSO : salesOrderSO.Sales_Order_Lines__r){
                //hasSalesOrderLines = true;
                
                // Add sales order lines in iterable interface
                SalesOrderLineWrapper soLineWrapper = new SalesOrderLineWrapper(salesOrderLineSO);
              
            } 
        }
        return salesOrderSO;
    }
    

    
    //FG-211 End
    
    // Retrieve Sales order and related line records
    public pageReference retrieveSalesOrderAndLines(){
        if(salesOrderSO.Id != null){
            salesOrderSO = [Select Name,
                                   Brand_Quote__c,
                                   Distributor_Contact__c,
                                   Distributor_License__c,
                                   Distributor_Name__c,
                                   Customer_PO_or_Quote__c,
                                   Opportunity_Name__c,
                                   Payment_Terms__c,
                                   Planned_Ship_Date__c,
                                   Receiver_Contact__c,
                                   Receiver_License__c,
                                   Receiver_Name__c,
                            	   Receiver_Name__r.Platform_Level__c,
                                   Sales_Order_Instructions__c,
                                   Sample_Order__c,
                                   Shipping_Method__c,
                                   Shipping_Terms__c,
                                   Site__c,
                                   Total_Price__c,
                                   Total_Line_Items__c,
                                   SO_Date__c,
                                   SO_Status__c,
                                   SO_Type__c,
                                   Supplier_Contact__c,
                                   Supplier_License__c,
                                   Supplier_Name__c,
                                   Allocated__c,
                                   RecordTypeId,
                            	   Retailer_PO__c,
                                   Ownership__c,
                                   Total_Weight_Fee__c , 
                                     Total_Mileage_Fee__c  , 
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,RecordType.Name,
                                   Factoring_Assignee__c,Factoring_Contact__c,
                                   Factoring_Rate__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c,
                                   (Select Name,
                                           Arrival_Date__c,
                                           Brand_Quote_Line__c,
                                           Product_Name__c,
                                           Product_Name__r.Name,
                                           Product_Title__c,
                                           Product_Description__c,
                                           Promised_Date__c,
                                           UID__c,
                                           Producer_Name__c,
                                           MOQ__c,
                                           Qty_Ordered__c,
                                           Qty_Invoiced__c,
                                           Qty_To_Invoiced__c,
                                           Quantity_Cases__c,
                                           Request_Date__c,
                                           Retail_Wholesale_Price__c,
                                           Line_Total_Price__c,
                                           Is_Sample__c,IsPromo__c,
                                           Ownership_Code__c
                                    	   ,Pick_Pack_Fee__c,
                                    		QA_Review_Fee__c, Total_Weight_lbs__c,RecordType.Name
                                    From Sales_Order_Lines__r
                                    ORDER BY Name)
                            From Sales_Order__c
                            Where Id =: salesOrderSO.Id];
                            
            // Perform validations - If any validation fails then do not need to create invoices
            if(checkValidation()){
                isValidationError = true;
                return null;
            }
            
            // Create wrapper list of Sales Order Lines
            for(Sales_Order_Line__c salesOrderLineSO : salesOrderSO.Sales_Order_Lines__r){
                
                hasSalesOrderLines = true;
                
                // Add sales order lines in iterable interface
                SalesOrderLineWrapper soLineWrapper = new SalesOrderLineWrapper(salesOrderLineSO);
                
                // if all quantities are invoiced then make sales order line as disabled
                if(salesOrderLineSO.Qty_To_Invoiced__c == 0.0){
                    soLineWrapper.isDisabled = true;
                }
                salesOrderLines.add(soLineWrapper);
                
                // Construct map of sales order line wrapper by sales order line id
                salesOrderLineWrapperById.put(salesOrderLineSO.Id, soLineWrapper);
                salesOrderLinesIterable = new CustomIterable(salesOrderLines, Integer.valueOf(pageSize)); 
                nextSalesOrderLines();
            }
        }
        return null;
    }
    
    /**
     * Create Invoice and Lines
     *
     * @return PageReference
     */
    public void getInvoices(){
        List< Invoice__c > invoicesList = [SELECT Id,Name FROM Invoice__c WHERE Sales_Order__c = :salesOrderSO.Id];
        invoices = JSON.serialize(invoicesList);
        //return new List<Invoice__c>();
    }
    
    /**
     * Create Invoice and Lines
     *
     * @return PageReference
     */
    public PageReference createInvoiceAndLines(){
        
        // Perform validations - If any validation fails then do not need to create invoices
        if(validateInputs()){
            return null;
        }
        
        Savepoint savePoint;
        
        try {
        
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
        
            // create invoice
            Invoice__c invoiceToCreate = createInvoiceInstance(salesOrderSO);
            insert invoiceToCreate;
            
            // create invoice lines based on selected order line
            List<Invoice_Line__c> invoiceLinesToCreate = new List<Invoice_Line__c>();
            
            // update sales order line with qty invoiced
            List<Sales_Order_Line__c> soLineToUpdate = new List<Sales_Order_Line__c>();
            for(SalesOrderLineWrapper soLineWrapper : salesOrderLines){
                
                Sales_Order_Line__c salesOrderLineSO = soLineWrapper.salesOrderLineSO;
                
                if(soLineWrapper.isSelected && !soLineWrapper.isDisabled){
                    
                    // Create new invoice lines based on qty to bill value
                    Invoice_Line__c invoiceLineSO = createInvoiceLine(salesOrderLineSO, 
                                                                      soLineWrapper.qtyToBill, 
                                                                      invoiceToCreate.Id);
                    invoiceLinesToCreate.add(invoiceLineSO);
                    
                    // Increase qty that is invoiced
                    salesOrderLineSO.Qty_Invoiced__c = salesOrderLineSO.Qty_Invoiced__c == null ?  
                                                       soLineWrapper.qtyToBill :
                                                       salesOrderLineSO.Qty_Invoiced__c + soLineWrapper.qtyToBill;
                    soLineToUpdate.add(salesOrderLineSO);
                }
            }
            
            insert invoiceLinesToCreate;
            update soLineToUpdate;
        
        } catch (Exception ex) {
            Database.rollback(savePoint);
            
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(message);
            return null;
        }
        return redirectToSalesOrderPage();
    }
    
    /**
     * Create instance of Invoice
     *
     * @param soLineSO The Sales order record
     * @return instance of Invoice
     */
    public static Invoice__c createInvoiceInstance(Sales_Order__c salesOrderSO){
        Invoice__c invoiceSO = new Invoice__c();
        invoiceSO.AR_Status__c            = Invoice_Ar_Status_Approved; //salesOrderSO.SO_Status__c;
        invoiceSO.AR_Type__c              = salesOrderSO.SO_Type__c;
        invoiceSO.Brand_Quote__c          = salesOrderSO.Brand_Quote__c;
        invoiceSO.Customer_PO_or_Quote__c = salesOrderSO.Customer_PO_or_Quote__c;
        invoiceSO.Distributor_Contact__c  = salesOrderSO.Distributor_Contact__c;
        invoiceSO.Distributor_License__c  = salesOrderSO.Distributor_License__c;
        invoiceSO.Distributor_Name__c     = salesOrderSO.Distributor_Name__c;
        //invoiceSO.Invoice_Memo__c 		  = salesOrderSO.Sales_Order_Instructions__c;
        invoiceSO.Invoice_Memo__c = salesOrderSO.Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c;
        invoiceSO.Opportunity_Name__c     = salesOrderSO.Opportunity_Name__c;
        invoiceSO.Payment_Terms__c        = salesOrderSO.Payment_Terms__c;
        invoiceSO.Receiver_Contact__c     = salesOrderSO.Receiver_Contact__c;
        invoiceSO.Receiver_Name__c        = salesOrderSO.Receiver_Name__c;
        invoiceSO.Receiver_License__c     = salesOrderSO.Receiver_License__c;
        invoiceSO.Sales_Order__c          = salesOrderSO.Id;
        invoiceSO.Sample_Order__c         = salesOrderSO.Sample_Order__c;
        invoiceSO.Shipped_Date__c         = salesOrderSO.Planned_Ship_Date__c;
        invoiceSO.Shipping_Method__c      = salesOrderSO.Shipping_Method__c;
        invoiceSO.Shipping_Terms__c       = salesOrderSO.Shipping_Terms__c;
        invoiceSO.Site__c                 = salesOrderSO.Site__c;
        invoiceSO.Supplier_Contact__c     = salesOrderSO.Supplier_Contact__c;
        invoiceSO.Supplier_License__c     = salesOrderSO.Supplier_License__c;
        invoiceSO.Supplier_Name__c        = salesOrderSO.Supplier_Name__c;
        invoiceSO.Ownership__c            = salesOrderSO.Ownership__c;
        invoiceSO.Invoice_Due_Date__c     = InvoiceSupport.calculateInvoiceDueDate(salesOrderSO.Ship_Confirmation_Date__c,salesOrderSO.Planned_Ship_Date__c,
                                                                                   salesOrderSO.Payment_Terms__c);
        invoiceSO.Order_Booking_Fee__c = salesOrderSO.Order_Booking_Fee__c;
        invoiceSO.Pack_Out_Fee__c = salesOrderSO.Pack_Out_Fee__c;
        invoiceSO.Schedule_Dispatch_Fee__c = salesOrderSO.Schedule_Dispatch_Fee__c;
        invoiceSO.Stage_Manifest_Fee__c = salesOrderSO.Stage_Manifest_Fee__c;
        invoiceSO.Total_Mileage_Fee__c = salesOrderSO.Total_Mileage_Fee__c;
        invoiceSO.Total_Weight_Fee__c = salesOrderSO.Total_Weight_Fee__c;
        invoiceSO.Retailer_PO__c = salesOrderSO.Retailer_PO__c;
        invoiceSO.Factoring_Assignee__c = salesOrderSO.Factoring_Assignee__c;
        invoiceSO.Factoring_Contact__c = salesOrderSO.Factoring_Contact__c;
        invoiceSO.Factoring_Rate__c = salesOrderSO.Factoring_Rate__c;
        system.debug(invoiceSO.Retailer_PO__c+'invoiceSO.Retailer_PO__c');
        if(salesOrderSO.RecordType.Name == 'Transfer'){
            invoiceSO.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        }
        return invoiceSO;
    }
    
    
    
    /**
     * Create instance of Invoice Line
     *
     * @param soLineSO The Sales order line record
     * @param qtyToBill The number of invoiced qty
     * @param invoiceId The Id of invoice record 
     *
     * @return instance of Invoice Line
     */
    public static Invoice_Line__c createInvoiceLine(Sales_Order_Line__c soLineSO,
                                             Decimal qtyToBill,
                                             Id invoiceId){
        Invoice_Line__c invoiceLineSO = new Invoice_Line__c();
        invoiceLineSO.Invoice_Qty__c            = qtyToBill;
        invoiceLineSO.Product_Name__c           = soLineSO.Product_Name__c;
        invoiceLineSO.Product_Title__c          = soLineSO.Product_Title__c;
        invoiceLineSO.Retail_Wholesale_Price__c = soLineSO.Retail_Wholesale_Price__c;
        invoiceLineSO.Sales_Order_Line__c       = soLineSO.Id;                    
        invoiceLineSO.Invoice__c                = invoiceId;
        invoiceLineSO.Is_Sample__c              = soLineSO.Is_Sample__c;
        invoiceLineSO.IsPromo__c                = soLineSO.IsPromo__c;
        invoiceLineSO.OwnershipCode__c          = soLineSO.Ownership_Code__c;
        invoiceLineSO.Pick_Pack_Fee__c 			= soLineSO.Pick_Pack_Fee__c;
        invoiceLineSO.QA_Review_Fee__c 			= soLineSO.QA_Review_Fee__c;
        invoiceLineSO.Total_Weight_lbs__c 		= soLineSO.Total_Weight_lbs__c;
		if(soLineSO.RecordType.Name == 'Transfer')
        	invoiceLineSO.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        if(soLineSO.RecordType.Name == SOLI_RecordType_Product)
            invoiceLineSO.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(SOLI_RecordType_Product).getRecordTypeId();
        return invoiceLineSO;
    }
    
    /**
     * Validate Sales order lines updated by user
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean validateInputs(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        Boolean hasSOLineSelected = false;
        string recordtypename = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosById().get(salesOrderSO.RecordTypeId).getname();
        // Check for cancelled SO
        if(salesOrderSO.SO_Status__c == SO_STATUS_CANCELLED){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Cancelled_SO);
            ApexPages.addMessage(message);
        
        // Check if SO Allocated is true and Status is Approved
        } else      
        {
            if(salesOrderSO.SO_Status__c != SO_STATUS_APPROVED && salesOrderSO.SO_Status__c != SalesOrderSupport.SO_STATUS_SHIPPED) 
            {
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO);
            ApexPages.addMessage(message);
            }
         else 
         //removed recordtypename == 'Product' on April 5th, 2019.
         if(salesOrderSO.SO_Status__c == SO_STATUS_APPROVED && !salesOrderSO.Allocated__c)
         {
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO);
            ApexPages.addMessage(message);
         }
        
        } 
        /*if(salesOrderSO.SO_Status__c != SO_STATUS_APPROVED || !salesOrderSO.Allocated__c){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO);
            ApexPages.addMessage(message);
        } */
        
        if(hasValidationError){
            return hasValidationError;
        }
        
        for(SalesOrderLineWrapper soLineWrapper : salesOrderLines){
            
            Decimal qtyToBill = soLineWrapper.qtyToBill;
            Sales_Order_Line__c salesOrderLineSO = soLineWrapper.salesOrderLineSO;
            
            if(soLineWrapper.isSelected && !soLineWrapper.isDisabled){
                hasSOLineSelected = true;
                
                // Check qty to bill cannot be blank and must be positive
                if(String.isBlank(String.valueOf(qtyToBill)) == null || qtyToBill <= 0 ){
                    message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                    String.format(Label.Qty_To_Bill_Positive_Value, 
                                                    new List<String>{salesOrderLineSO.Product_Name__r.Name}));
                    ApexPages.addMessage(message);
                    hasValidationError = true;
                }
                
                // Check qty to bill cannot be greater than qty to invoiced
                else if(qtyToBill > salesOrderLineSO.Qty_To_Invoiced__c){
                    message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                              String.format(Label.Qty_To_Bill_Cannot_Be_Greater_Than_Qty_To_Invoiced, 
                                              new List<String>{salesOrderLineSO.Product_Name__r.Name}));
                    ApexPages.addMessage(message);
                    hasValidationError = true;
                }
            }
        }
        
        // Validation to check if any sales order line selected or not
        if(!hasSOLineSelected){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Sales_Order_Line_Selected);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }
        return hasValidationError;
    }
    
    /**
     * Check validation to create invoice
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        Boolean hasSOLineSelected = false;
        string recordtypename = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosById().get(salesOrderSO.RecordTypeId).getname();
        // Check for cancelled SO
        if(salesOrderSO.SO_Status__c == SO_STATUS_CANCELLED){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Cancelled_SO);
            ApexPages.addMessage(message);
        
        // Check if SO Allocated is true and Status is Approved
//        } else if(salesOrderSO.SO_Status__c != SO_STATUS_APPROVED || !salesOrderSO.Allocated__c){
        } else 
        { 
            if(salesOrderSO.SO_Status__c != SO_STATUS_APPROVED && salesOrderSO.SO_Status__c != SalesOrderSupport.SO_STATUS_SHIPPED) 
            {
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO);
            ApexPages.addMessage(message);
            }
         else 
         if(salesOrderSO.SO_Status__c == SO_STATUS_APPROVED && recordtypename == 'Product' && !salesOrderSO.Allocated__c)
         {
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Create_Invoice_For_Non_Allocated_Or_Non_Approved_SO);
            ApexPages.addMessage(message);
         }
        }
        return hasValidationError;
    }
    
    /**
     * Get Page size options to display number of sales order lines per page
     */
    public List<SelectOption> getPageSizeOptions() {
        List<SelectOption> options = new List<SelectOption>();        
        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('25', '25'));
        options.add(new SelectOption('50', '50'));
        options.add(new SelectOption('100', '100'));
        
        return options; 
    }
    
    // flag to check if next and last link should be disabled or not
    public Boolean hasNextSalesOrderLines {
        get{
            return salesOrderLinesIterable.hasNext();
        }
        set;
    }
    
    // flag to check if previous and first link should be disabled or not
    public Boolean hasPreviousSalesOrderLines {
        get{
            return salesOrderLinesIterable.hasPrevious();
        }
        set;
    }
    
    // Sales Order Lines to be displayed on next link
    public void nextSalesOrderLines(){
        setSalesOrderLines.clear();
        for(Object salesOrderLineSO :salesOrderLinesIterable.next()) {
            setSalesOrderLines.add((SalesOrderLineWrapper)salesOrderLineSO);
        }
    }
    
    // Sales Order Lines to be displayed on previous link
    public void previousSalesOrderLines(){
        setSalesOrderLines.clear();
        for(Object salesOrderLineSO :salesOrderLinesIterable.previous()) {
            setSalesOrderLines.add((SalesOrderLineWrapper)salesOrderLineSO);
        }
    }
    
    // Sales Order Lines to be displayed on first link
    public void firstSalesOrderLines(){
        setSalesOrderLines.clear();
        for(Object salesOrderLineSO :salesOrderLinesIterable.first()) {
            setSalesOrderLines.add((SalesOrderLineWrapper)salesOrderLineSO);
        }
    }
    
    // Sales Order Lines to be displayed on last link
    public void lastSalesOrderLines(){
        setSalesOrderLines.clear();
        for(Object salesOrderLineSO :salesOrderLinesIterable.last()) {
            setSalesOrderLines.add((SalesOrderLineWrapper)salesOrderLineSO);
        }
    }
    
    /**
     * Cancel action - Redirect to Sales Order detail page
     *
     * @return PageReference
     */
    public PageReference cancelAction() {
        return redirectToSalesOrderPage();
    }
    
    /**
     * Redirect to Sales order detail page
     *
     * @return PageReference
     */
    private PageReference redirectToSalesOrderPage() {
        PageReference page = new PageReference('/'+salesOrderSO.Id);
        page.setRedirect(true);
        return page;
    }
    
    /**
     * Change the number of sales order lines to display according to selected page size
     */
    public PageReference doResetSalesOrderLinesPageSize() {
        salesOrderLinesIterable = new CustomIterable(salesOrderLines, Integer.valueOf(pageSize)); 
        nextSalesOrderLines(); 
        return null;
    }
    
    /**
     * Update all SO lines Qty to bill with Qty to invoice value on selecting all SO lines
     * If all SO lines unchecked then reset Qty to bill as 0
     */
    public void updateQtyToBillForAllSOLines(){
        
        for(SalesOrderLineWrapper soLineWrapper : salesOrderLines){
            
            if(soLineWrapper.isSelected){
                soLineWrapper.qtyToBill = soLineWrapper.salesOrderLineSO.Qty_To_Invoiced__c;
            }else{
                soLineWrapper.qtyToBill = 0;
            }
        }
    }
    
             // Retrieve Sales order and related line records
    @AuraEnabled
    public static AuraResponse retrieveSalesOrderAndLinesLight(){
        AuraResponse r = new AuraResponse('CreateInvoiceController.retrieveSalesOrderAndLinesLight()');
        CreateInvoiceController assign = new CreateInvoiceController();
        
        if(assign.salesOrderSO.Id != null){
               assign.hasSalesOrderLines = true;
            assign.salesOrderSO = [Select Name,
                                   Brand_Quote__c,
                                   Distributor_Contact__c,
                                   Distributor_License__c,
                                   Distributor_Name__c,
                                   Customer_PO_or_Quote__c,
                                   Opportunity_Name__c,
                                   Payment_Terms__c,
                                   Planned_Ship_Date__c,
                                   Receiver_Contact__c,
                                   Receiver_License__c,
                                   Receiver_Name__c,
                                   Receiver_Name__r.Platform_Level__c,
                                   RecordType.Name,
                                   Sales_Order_Instructions__c,
                                   Sample_Order__c,
                                   Shipping_Method__c,
                                   Shipping_Terms__c,
                                   Site__c,
                                   Total_Price__c,
                                   Total_Line_Items__c,
                                   SO_Date__c,
                                   SO_Status__c,
                                   SO_Type__c,
                                   Supplier_Contact__c,
                                   Supplier_License__c,
                                   Supplier_Name__c,
                                   Allocated__c,
                                   RecordTypeId,
                                   Ownership__c,
                                   Retailer_PO__c,
                                   Factoring_Assignee__c,
                                   Factoring_Contact__c,
                                Factoring_Rate__c,
                                   (Select Name,
                                           Arrival_Date__c,
                                           Brand_Quote_Line__c,
                                           Product_Name__c,
                                           Product_Name__r.Name,
                                           Product_Title__c,
                                           Product_Description__c,
                                           Promised_Date__c,
                                           UID__c,
                                           Producer_Name__c,
                                           MOQ__c,
                                           Qty_Ordered__c,
                                           Qty_Invoiced__c,
                                           Qty_To_Invoiced__c,
                                           Quantity_Cases__c,
                                           Request_Date__c,
                                           Retail_Wholesale_Price__c,
                                           Line_Total_Price__c,
                                           Is_Sample__c,IsPromo__c,
                                           Sales_Order__c,Ownership_Code__c
                                    From Sales_Order_Lines__r
                                    ORDER BY Name)
                            From Sales_Order__c
                            Where Id =: assign.salesOrderSO.Id];
                            
            // Perform validations - If any validation fails then do not need to create invoices
            if(assign.checkValidation()){
                assign.isValidationError = true;
                return null;
            }
         
            // Create wrapper list of Sales Order Lines
        }
        return r;
    }
    
    
    // Wrapper class to store Sales order line details
    public class SalesOrderLineWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public Boolean isDisabled {get; set;}
        @AuraEnabled
        public Sales_Order_Line__c salesOrderLineSO {get; set;}
        @AuraEnabled
        public Decimal qtyToBill {get; set;}
        
        // Constructor
        public SalesOrderLineWrapper(Sales_Order_Line__c salesOrderLineSO){
            this.isSelected = false;
            this.isDisabled = false;
            this.salesOrderLineSO = salesOrderLineSO;
            this.qtyToBill = 0;
        }
         public SalesOrderLineWrapper(){
            this.isSelected = false;
            this.isDisabled = false;
            this.salesOrderLineSO = salesOrderLineSO;
            this.qtyToBill = 0;
        }
    }
}