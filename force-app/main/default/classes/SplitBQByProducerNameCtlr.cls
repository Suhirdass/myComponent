/********************************************************************
* Project           : Filigreen
*
* Apex name         : SplitBQByProducerNameCtlr.apxc
* 
* Test Class name   : SplitBQByProducerNameTest.apxc
*
* Author            : Vijay Salem
*
* Date created      : 7/24/2019
*
* Purpose           : Apex Controller for CreateSellQuote.cmp & CreateBuyQuote.cmp 
*
* Revision History  :
*
* Date        Author      		Ref    Revision (Date in YYYYMMDD format) 
* 5/04/2020    Vijay Salem       1      Apex created for VF. 
* 7/21/2020    Praveen Ayyanar   2      Apex modified for Lightning component.
*
**********************************************************************/
public class SplitBQByProducerNameCtlr {
    
    public String oppId{get;set;}
    public Boolean isSample{get;set;}
    public Boolean isMulti{get;set;}
    public Opportunity opp{get;set;}
    public Service_Ticket__c serviceTicket{get;set;}
    public String OppRecordType{get;set;}
    public String bQuote;
    public List<ProducerWrpr> lineItems{get;set;}
    public Map<Id,PricebookEntry> sampleProductPrice;
    public String redirectId;
    public Map<String, List<oppLineWrapper>> mapModule {get;set;} 
    public Map<String, Integer> moduleCountMap{get;set;}
    public List<String> moduleList {get;set;}
    public List<oppLineWrapper> finalList {get;set;}
    public Boolean hasLines{get;set;}
    public  String message;
    public  String LabelMessage;
    public  Set<Id> sampleProductsPricebook {get;set;}
    public  Set<Id> sampleProductsId {get;set;}
    public  Set<Id> sampleProsetIds {get;set;}
    public  List<Id> sampleProductsLst {get;set;}
    
    private Static String ST_Transfer_Method_Drop_Off{
        get{
            return String.isNotBlank(ST_Transfer_Method_Drop_Off) ? ST_Transfer_Method_Drop_Off: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Drop_Off');
        }set;
    }
    private Static String ST_Transfer_Method_Pick_up{
        get{
            return String.isNotBlank(ST_Transfer_Method_Pick_up) ? ST_Transfer_Method_Pick_up: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Pick_Up');
        }set;
    }
    public Static String PricebookInActive{
        get{
            return String.isNotBlank(PricebookInActive) ? PricebookInActive: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','Err_Pricebook_InActive');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_SERVICE{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Service');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_TRANSFER{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Transfer_Quote');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_BUY{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Buy');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_SELL{
        get{
            
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Sell');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_RMA{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_RMA');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_LAB{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Lab_Quote');
        }set;
    }
    private Static String OPPORTUNITY_RMA_RECORDTYPE  {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_DevName_RMA');
        }set;
    }
    private Static String   OPPORTUNITY_SERVICE_RECORDTYPE { 
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_DevName_Service');
        }set;
    }
    public Static String  OPPORTUNITY_BUY_RECORDTYPE{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_DevName_Buy_Opportunity');
        }set;
    }
    public Static String OPPORTUNITY_BUYSELL_RECORDTYPE {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_Name_BuySell');
        }set;
    }
    private Static String OPPORTUNITY_LAB_RECORDTYPE {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_DevName_Lab_Opportunity');
        }set;
    }
    private Static String OPPORTUNITY_TRANSFER_RECORDTYPE{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_Name_Transfer');
        }set;
    }
    public Static String BRANDQUOTELINERECORDTYPE_RMALINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_RMALINE) ? BRANDQUOTELINERECORDTYPE_RMALINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_RMALine');
        }set;
    }
    public Static String BRANDQUOTELINERECORDTYPE_BUYQOUTELINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_BUYQOUTELINE) ? BRANDQUOTELINERECORDTYPE_BUYQOUTELINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_BuyQuoteLine');
        }set;
    }
    private Static String BRANDQUOTELINERECORDTYPE_SELLLINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_SELLLINE) ? BRANDQUOTELINERECORDTYPE_SELLLINE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_SellLine');
        }set;
    }
    public Static String BRANDQUOTELINERECORDTYPE_LABLINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_LABLINE) ? BRANDQUOTELINERECORDTYPE_LABLINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_Lab_QuoteLine');
        }set;
    }
    private Static String BRANDQUOTELINERECORDTYPE_SERVICELINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_SERVICELINE) ? BRANDQUOTELINERECORDTYPE_SERVICELINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_ServiceLine');
        }set;
    }
    private Static String BRANDQUOTELINERECORDTYPE_TRANSFERLINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_TRANSFERLINE) ? BRANDQUOTELINERECORDTYPE_TRANSFERLINE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_Transfer_QuoteLine');
        }set;
    }	
    private Static String BRANDQUOTETERMS_BRANDQUOTEEXW { 
        get{
            return  String.isNotBlank(BRANDQUOTETerms_BRANDQUOTEEXW) ? BRANDQUOTETerms_BRANDQUOTEEXW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_EXW');
        }set;
    }	
    private Static String BRANDQUOTETERMS_BRANDQUOTEFCA{
        get{
            return  String.isNotBlank(BRANDQUOTETerms_BRANDQUOTEFCA) ? BRANDQUOTETerms_BRANDQUOTEFCA :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_FCA');
        }set;
    }	
    private Static String BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION{
        get{
            return  String.isNotBlank(BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION) ? BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_InternalConversion');
        }set;
    }	
    private Static String BRANDQUOTESHIPPINGMETHOD_DISTRIBUTORDELIVERY{
        get{
            return  String.isNotBlank(BRANDQUOTESHIPPINGMETHOD_DISTRIBUTORDELIVERY) ?BRANDQUOTESHIPPINGMETHOD_DISTRIBUTORDELIVERY :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Distributor_Delivery');
        }set;
    }	
    public Static String BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP{
        get{
            return  String.isNotBlank(BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP) ? BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_DistributorPickup');
        }set;
    }
    public Static String BRANDQUOTESHIPPINGMETHOD_SUPPLIERPICKUP{
        get{
            return  String.isNotBlank(BRANDQUOTESHIPPINGMETHOD_SUPPLIERPICKUP) ? BRANDQUOTESHIPPINGMETHOD_SUPPLIERPICKUP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_SupplierPickup');
        }set;
    }
    private Static String STATUS_DRAFT{ 
        get{
            return  String.isNotBlank(STATUS_DRAFT) ? STATUS_DRAFT :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Draft');
        }set;
    }
    public Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
        }set;
    }
    public Static String TYPE_SELLQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_SELLQUOTE) ? TYPE_SELLQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_SellQuote');
        }set;
    }
    private Static String BQ_ORDER_TYPE_BRAND{ 
        get{
            return  String.isNotBlank(BQ_ORDER_TYPE_BRAND) ? BQ_ORDER_TYPE_BRAND :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_OrderType_Brand');
        }set;
    }
    
    public Static String ErrMsgCreate_Quote_OrderRetailerContact{
        get{
            return String.isNotBlank(ErrMsgCreate_Quote_OrderRetailerContact) ? ErrMsgCreate_Quote_OrderRetailerContact: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','ErrMsgCreate_Quote_OrderRetailerContact');
        }set;
    }
    public Static String ErrMsgCreate_Quote_OrderStateLicense{
        get{
            return String.isNotBlank(ErrMsgCreate_Quote_OrderStateLicense) ? ErrMsgCreate_Quote_OrderStateLicense: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','ErrMsgCreate_Quote_OrderStateLicense');
        }set;
    }
    public Static String ErrMsgCreate_Quote_STBrandContact{
        get{
            return String.isNotBlank(ErrMsgCreate_Quote_STBrandContact) ? ErrMsgCreate_Quote_STBrandContact: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','ErrMsgCreate_Quote_STBrandContact');
        }set;
    }
    public Static String ErrMsgCreate_Quote_STStateLicense{
        get{
            return String.isNotBlank(ErrMsgCreate_Quote_STStateLicense) ? ErrMsgCreate_Quote_STStateLicense: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','ErrMsgCreate_Quote_STStateLicense');
        }set;
    }
     private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private static String STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) ? STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_License_Holder_RecordType');
        }set;
    }
    private static String STATE_LICENSE_NONCANNABIS_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_NONCANNABIS_RECORDTYPE) ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_NonCannabis_RecordType');
        }set;
    }
    private static String State_License_WhiteLabel_RecordType{
        get{
            return String.isNotBlank(State_License_WhiteLabel_RecordType) ? State_License_WhiteLabel_RecordType : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_WhiteLabel_RecordType');
        }set;
    }
    private static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    public SplitBQByProducerNameCtlr(ApexPages.StandardController controller) {
        sampleProductPrice = new Map<Id,PricebookEntry>();
        Opportunity opp1 = ((Opportunity)controller.getRecord());
        oppID = opp1.Id;       
        opp = [SELECT Id, Name,RecordType.DeveloperName, Order__c,Order__r.Request_Ship_Date__c, Order__r.State_License__c FROM Opportunity WHERE Id =:oppId];
        OppRecordType = opp.RecordType.DeveloperName;
        lineItems = new List<ProducerWrpr>();
        isSample = false;
        isMulti = false;
        bQuote  = apexpages.currentpage().getparameters().get('type');
        processItems();
    }
    
    public SplitBQByProducerNameCtlr(){
        
    }
    
    @AuraEnabled
    public static AuraResponse splitBQByProducerName(String recordId,String type){
        AuraResponse r = new AuraResponse('splitBQByProducerName.splitBQByProducerName()');
        
        SplitBQByProducerNameCtlr ctrl = new SplitBQByProducerNameCtlr();
        
        ctrl.oppId = recordId;
        ctrl.sampleProductPrice = new Map<Id,PricebookEntry>();  
        ctrl.opp = [SELECT Id, Name,Sample_Order__c, Account.DBA__c, Account.Id, Opportunity_Number__c, Order__r.Order_Date__c, Payment_Terms__c, 
                    RecordType.DeveloperName, Order__r.Name, Order__c, Order__r.State_License__c,Order__r.Retailer_DBA__c,
                    Order__r.Transporter__r.License_Name__c,Order__r.Transporter__c,Order__r.Site__r.License_ID__r.License_Name__c,
					Order__r.Site__r.License_ID__c,Order__r.Account__c,Order__r.Invoice_Memo__c,Order__r.Sample_Order__c,
                    Order__r.Retailer_Contact__c,Order__r.Retailer_Contact__r.AccountId,Order__r.Retailer_Contact__r.Name,
                    Order__r.Special_Instructions__c,Order__r.State_License__r.License_Number__c,Order__r.State_License__r.License_Name__c,
                    Order__r.Retailer__c,Order__r.Account__r.Type,Order__r.Order_Type__c,Site_Name__r.Name,Site_Name__r.Warehouse_Name__c, Site_Name__c FROM Opportunity WHERE Id =:recordId]; 
        
        List<Service_Ticket__c> serviceTicketList = [SELECT Id,Name,Transfer_Method__c,Licensed_Premise__r.Default_Warehouse__c,Licensed_Premise__r.Default_Warehouse__r.License_ID__c,Licensed_Premise__r.RecordType.Name,
                            Licensed_Premise__r.State_License_Holder__c,Destination_Site__c,Destination_Site__r.License_ID__c,Destination_Site__r.License_ID__r.License_Name__c,
                            Licensed_Premise__r.Default_Warehouse__r.License_ID__r.License_Name__c,Special_Instruction__c,Request_Date_Time__c,Licensed_Premise__c,
                                                     Transporter__r.License_Name__c,Transporter__c,Licensed_Premise__r.State_License_Holder__r.Name,
                                                     Licensed_Premise__r.License_Number__c,Brand_Contact__c,Brand_Contact__r.Name,
                                                     Brand_Name__c,Brand_Name__r.Name,Brand_Name__r.DBA__c,Brand_Contact__r.AccountId,
                                                     Licensed_Premise__r.License_Name__c,(SELECT Id,Name,New_Packaged_Product__c,Qty_Per_Multi_Unit__c FROM Service_Ticket_Lines__r)
                                                     FROM Service_Ticket__c where Opportunity__c =: recordId Limit 1];
        ctrl.serviceTicket = serviceTicketList.size() >0 ? serviceTicketList[0] : new Service_Ticket__c();
        ctrl.OppRecordType = ctrl.opp.RecordType.DeveloperName;
        ctrl.lineItems = new List<ProducerWrpr>();
        ctrl.isSample = false;
        ctrl.isMulti = false;
        ctrl.bQuote = type;
        ctrl.mapModule = new Map<String, List<oppLineWrapper>>();
        ctrl.moduleCountMap = new Map<String, Integer>();
        ctrl.moduleList = new List<String>();
        ctrl.finalList = new List<oppLineWrapper>();          
        ctrl.hasLines = false;   
        ctrl.processItems();
        ctrl.getOppoLinesLight();
        
        if(ctrl.lineItems.size() > 0){
            ctrl.hasLines = true;
        }
        r.data.put('records', ctrl.lineItems);
        r.data.put('oppName', ctrl.opp);
        r.data.put('mapModule', ctrl.mapModule);
        r.data.put('moduleCountMap', ctrl.moduleCountMap);
        r.data.put('moduleList', ctrl.moduleList);
        r.data.put('finalList', ctrl.finalList);
        r.data.put('hasLines', ctrl.hasLines);
        r.data.put('Error',ctrl.message);
        r.data.put('serviceTicket',ctrl.serviceTicket);
        
        Boolean OrderRetailerContactError,OrderStateLicenseError,STBrandContactError,STStateLicenseError;
        OrderRetailerContactError = OrderStateLicenseError = STBrandContactError = STStateLicenseError = false;
        if(ctrl.opp.Order__c != null){
            if(ctrl.opp.Order__r.Retailer__c != ctrl.opp.Order__r.Retailer_Contact__r.AccountId){
                OrderRetailerContactError = true;
            	r.data.put('OrderRetailerContactErrorMsg',ErrMsgCreate_Quote_OrderRetailerContact);    
            }
            if(ctrl.opp.Order__r.Retailer__c != ctrl.opp.Order__r.State_License__r.License_Name__c){
            	OrderStateLicenseError = true;
            	r.data.put('OrderStateLicenseErrorMsg',ErrMsgCreate_Quote_OrderStateLicense);        
            }
        }else{
        	if(ctrl.serviceTicket.Brand_Name__c != ctrl.serviceTicket.Brand_Contact__r.AccountId){
                STBrandContactError = true;
            	r.data.put('STBrandContactErrorMsg',ErrMsgCreate_Quote_STBrandContact);    
            }
            if((ctrl.serviceTicket.Brand_Name__c != ctrl.serviceTicket.Licensed_Premise__r.License_Name__c) && (ctrl.serviceTicket.Licensed_Premise__r.RecordType.Name == State_License_WhiteLabel_RecordType && ctrl.serviceTicket.Brand_Name__c != ctrl.serviceTicket.Licensed_Premise__r.State_License_Holder__c)){
            	STStateLicenseError = true;
            	r.data.put('STStateLicenseErrorMsg',ErrMsgCreate_Quote_STStateLicense);        
            }    
        }
		r.data.put('OrderRetailerContactError',OrderRetailerContactError);
        r.data.put('OrderStateLicenseError',OrderStateLicenseError);
        r.data.put('STBrandContactError',STBrandContactError);
        r.data.put('STStateLicenseError',STStateLicenseError);        
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse createQuoteRec(Opportunity oppRec,List<ProducerWrpr> wrp,Boolean multi,String type){
        AuraResponse r = new AuraResponse('CreateBuyQuoteController.createQuoteRec()');
        SplitBQByProducerNameCtlr ctrl = new SplitBQByProducerNameCtlr();
        ctrl.lineItems = wrp;
        ctrl.OppRecordType = oppRec.RecordType.DeveloperName;
        ctrl.oppID = oppRec.Id;
        ctrl.isMulti = multi;
        ctrl.bQuote = type;
        List<Service_Ticket__c> serviceTicketList = [SELECT Id,Licensed_Premise__c,Brand_Contact__c,Brand_Name__c,Licensed_Premise__r.RecordType.Name,Licensed_Premise__r.State_License_Holder__c,
			Brand_Contact__r.AccountId,Licensed_Premise__r.License_Name__c from Service_Ticket__c where Opportunity__c =: 
			oppRec.Id Limit 1];
        Boolean hasError = false;
        if(oppRec.Order__c != null){
            if(oppRec.Order__r.Retailer__c != oppRec.Order__r.Retailer_Contact__r.AccountId){
                hasError = true;
                r.data.put('OrderRetailerContactError',true);
            	r.data.put('OrderRetailerContactErrorMsg',ErrMsgCreate_Quote_OrderRetailerContact);    
            }
            if(oppRec.Order__r.Retailer__c != oppRec.Order__r.State_License__r.License_Name__c){
                hasError = true;
            	r.data.put('OrderStateLicenseError',true);
            	r.data.put('OrderStateLicenseErrorMsg',ErrMsgCreate_Quote_OrderStateLicense);        
            }
        }else{
        	if(serviceTicketList.size() > 0 && serviceTicketList[0].Brand_Name__c != serviceTicketList[0].Brand_Contact__r.AccountId){
                hasError = true;
                r.data.put('STBrandContactError',true);
            	r.data.put('STBrandContactErrorMsg',ErrMsgCreate_Quote_STBrandContact);    
            }
            
            if(serviceTicketList.size() > 0 && (serviceTicketList[0].Brand_Name__c != serviceTicketList[0].Licensed_Premise__r.License_Name__c) && (serviceTicketList[0].Licensed_Premise__r.RecordType.Name == State_License_WhiteLabel_RecordType && serviceTicketList[0].Brand_Name__c != serviceTicketList[0].Licensed_Premise__r.State_License_Holder__c)){
                hasError = true;
                r.data.put('STStateLicenseError',true);        
            	r.data.put('STStateLicenseErrorMsg',ErrMsgCreate_Quote_STStateLicense);        
            }    
        }
        r.data.put('hasError',hasError);
        if(!hasError){
        	ctrl.createQuotes();
        	r.data.put('Error',ctrl.message);
        	r.data.put('redirectId', ctrl.redirectId);   
        }
        return r;
    }
    
    public void getOppoLinesLight(){
        list <OpportunityLineItem> oppLineItems = [SELECT Id,Producer_Name__c,Quantity ,UnitPrice , Product_Title__c  ,Is_Sample__c,Order_Line_Item__r.IsPromo__c,
                                                   MOQ__c, ListPrice, PricebookEntry.Disty_Discount_Per_Unit__c, TotalPrice, Product2Id, PricebookEntryId,
                                                   PricebookEntry.Name,Harvest_Batch_Code__c, Line_Total_Qty__c,Listing_Fee__c,
                                                   PricebookEntry.PriceBook2ID,Ownership_Code__c, PricebookEntry.Product2ID, PricebookEntry.Product2.Family,PricebookEntry.Product2.Licensee_Name__r.Name,
                                                   PricebookEntry.DistyMargin__c , Disty_Discount_Per_Unit__c, Product_Description__c,PricebookEntry.Product2.Name,PricebookEntry.Product2.Producer_Name__r.Name,
                                                   PriceBook_Id__c,Product2.Producer_Name__c,PricebookEntry.Product2.Licensee_Name__c,PricebookEntry.Product2.White_Labelled__c,PricebookEntry.Product2.Producer_Name__c  
                                                   FROM OpportunityLineItem
                                                   WHERE OpportunityId = :oppId];
        
        for(OpportunityLineItem conObj : oppLineItems)
        {
            List<oppLineWrapper> conWrapperList = new List<oppLineWrapper>();
            String mapKey = conObj.PricebookEntry.Product2.White_Labelled__c ==  true ? conObj.PricebookEntry.Product2.Licensee_Name__c : conObj.PricebookEntry.Product2.Producer_Name__c;
            if(mapModule.containsKey(mapKey))
            {
                conWrapperList = mapModule.get(mapKey);
                conWrapperList.add(new oppLineWrapper(conObj));
                mapModule.put(mapKey, conWrapperList);
                modulecountMap.put(mapKey, conWrapperList.size());
            }
            else
            {
                conWrapperList.add(new oppLineWrapper(conObj, 1));
                mapModule.put(mapKey, conWrapperList);
                modulecountMap.put(mapKey, conWrapperList.size());
            }
        }
        for ( String productName: mapModule.keySet()) {
            Integer size = mapModule.get(productName).size();
            for(oppLineWrapper oppLine :mapModule.get(productName) ){
                oppLine.size =size;
                for(Service_Ticket_Line__c stLine : serviceTicket.Service_Ticket_Lines__r){
                    if(oppLine.ProdNameID == stLine.New_Packaged_Product__c){
                        oppLine.MOQ = stLine.Qty_Per_Multi_Unit__c;
                        oppLine.LineTotal = oppLine.MOQ * oppLine.Quantity;
                        break;
                    }
                }
                finalList.add(oppLine);
            }                  
        } 
        moduleList = new List<String>(mapModule.keySet());   
    }
    
    public void processItems(){
        Map<String,List<OpportunityLineItem>> items = new Map<String,List<OpportunityLineItem>>();
        Map<String,OpportunityLineItem> productNameDescription = new Map<String,OpportunityLineItem>();
        Set<String> producerSampleQuote = new Set<String>();
        Set<String> producerNewQuote = new Set<String>();
        Set<Id> sampleProducts = new Set<Id>();
        for(OpportunityLineItem item : [SELECT Id, PricebookEntry.Name,Harvest_Batch_Code__c,PricebookEntry.IsActive,Producer_Name__c,Quantity ,UnitPrice , Product_Title__c  ,Is_Sample__c,Order_Line_Item__r.IsPromo__c,
                                        MOQ__c, ListPrice, PricebookEntry.Disty_Discount_Per_Unit__c, TotalPrice, Product2Id, PricebookEntryId,
                                        PricebookEntry.PriceBook2ID,Ownership_Code__c, PricebookEntry.Product2ID, PricebookEntry.Product2.Family,
                                        PricebookEntry.DistyMargin__c , Disty_Discount_Per_Unit__c, Product_Description__c,PricebookEntry.Product2.Name,
                                        PriceBook_Id__c,Opportunity.RecordTypeId, PricebookEntry.PriceBook2.Name,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Listing_Fee__c
                                        FROM OpportunityLineItem
                                        WHERE OpportunityId = :oppId])
        {	
            
            List<OpportunityLineItem> ls = new List<OpportunityLineItem>();
            producerNewQuote.add(item.Producer_Name__c);
            if(item.Is_Sample__c){
                isSample = true;
                sampleProducts.add(item.Product2Id);
            }
            if(items.containsKey(item.Producer_Name__c)){
                ls = items.get(item.Producer_Name__c);
            }
            ls.add(item);
            items.put(item.Producer_Name__c,ls);
            productNameDescription.put(item.Producer_Name__c,item);
        }
        if(sampleProducts.size() > 0){
            List<Pricebook2> samplePb = [SELECT Id FROM Pricebook2 WHERE Name = :Label.Sample_Price_Book LIMIT 1];
            if(samplePb.size() > 0){
                for(PricebookEntry entry : [SELECT UnitPrice,Pricebook2.Name, IsActive,Product2Id,Disty_Discount_Per_Unit__c,DistyMargin__c FROM PricebookEntry WHERE Product2Id IN :sampleProducts AND Pricebook2Id =:samplePb[0].Id]){
                    sampleProductPrice.put(entry.Product2Id, entry);
                }
            }
        }
        
        if(items.keySet().size() > 0){
            for(String pName : items.keySet()){
                ProducerWrpr p = new ProducerWrpr();
                p.producerName = pName;
                p.productDescription = productNameDescription.get(pName);
                p.items = items.get(pName);
                lineItems.add(p);
            }
        }else{
            createQuotes();
        }
    }
    public PageReference backToOpportunity(){
        PageReference retPage =new PageReference('/'+oppID);
        retPage.setRedirect(true);
        return retPage;
    }
    public PageReference createQuotes(){
        try{     
            
            Id bqId;
            if(OppRecordType == OPPORTUNITY_SERVICE_RECORDTYPE)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_SERVICE);
            else if(OppRecordType == OPPORTUNITY_TRANSFER_RECORDTYPE)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_TRANSFER);
            else if(OppRecordType == OPPORTUNITY_BUY_RECORDTYPE)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_BUY);
            else if(OppRecordType == OPPORTUNITY_RMA_RECORDTYPE)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_RMA);
            else if(OppRecordType == OPPORTUNITY_LAB_RECORDTYPE)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_LAB);
            else if(bQuote != null && bQuote == BRANDQUOTERECORDTYPE_BUY)
                bqId =  createQuote(BRANDQUOTERECORDTYPE_BUY);
            else
                bqId = createQuote(BRANDQUOTERECORDTYPE_SELL);
            
            
            if(isMulti){
                redirectId = oppID;
                return backToOpportunity();
            }else{
                redirectId = bqId;
                PageReference retPage =new PageReference('/'+bqId);
                retPage.setRedirect(true);
                return retPage;
            }
        }catch (Exception ex){
            ErrorLogs.log('SplitBQByProducerNameCtlr:createQuotes()',ex.getStackTraceString(), ex.getMessage());
            if(UserInfo.getUiThemeDisplayed() == 'Theme4d'){
                message = ex.getMessage();
            }else{
                ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
                if(ApexPages.currentPage() != null){
                    ApexPages.addMessage(errMsg);
                }
                
            }
            
        }
        
        return null;
    }
    
    
    public Id createQuote(String quoteType){
        sampleProductsPricebook = new Set<Id>();  
        sampleProductsId = new Set<Id>();  
        sampleProductsLst = new List<Id>();  
        sampleProsetIds = new Set<Id>();
        List<Brand_Quote_Line__c> quoteLines = new List<Brand_Quote_Line__c>();
        List<Company_Custom_Settings__c> defaultIDs = [SELECT Default_Distributor__c,Default_License__c,Default_Contact__c FROM Company_Custom_Settings__c];
        List<Pricebook2> samplePbList = [SELECT Id FROM Pricebook2 WHERE Name = :Label.Sample_Price_Book LIMIT 1];
        Opportunity opp = [SELECT AccountId, Site_Name__c,Site_Name__r.License_ID__c,
                           Site_Name__r.License_ID__r.License_Name__c,Sample_Order__c,
                           Site_Name__r.License_ID__r.Contact__c,Sales_Origin__c,Ownership__c,
                           Order__c,Order__r.Name,Order__r.Retailer_Contact__c,
                           Order__r.Request_Ship_Date__c,Order__r.Retailer_PO__c,
                           Order__r.Retailer__c,Order__r.Exclude_Excise_Tax__c,
                           Order__r.Customer__r.ContactId,Payment_Terms__c,
                           Order__r.State_License__c,
                           Order__r.Factoring_Assignee__c,
                           Order__r.Factoring_Contact__c,
                           Order__r.Factoring_Rate__c,
                           Order__r.Special_Instructions__c,
                           Order__r.Factoring_Discount__c,
                           Order__r.Account__c,
                           Order__r.Account__r.Type,Order__r.Order_Type__c,
                           Order__r.Transporter__r.License_Name__c,Order__r.Transporter__c,Order__r.Site__r.License_ID__r.License_Name__c,
						   Order__r.Site__r.License_ID__c,Order__r.Invoice_Memo__c,
                           Total_Weight_Fee__c , Total_Mileage_Fee__c  , Order__r.Sample_Order__c,
                           Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                           Pack_Out_Fee__c , Order_Booking_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,
                           Requested_Transfer_Date__c ,Service_Staging_Fee__c ,Ownership__r.Membership_Level__c,
                           (SELECT Id,Name,Transfer_Method__c,Licensed_Premise__c,Special_Instruction__c,Licensed_Premise__r.License_Name__c,Brand_Name__c,
                            Licensed_Premise__r.Default_Warehouse__c,Licensed_Premise__r.Default_Warehouse__r.License_ID__c,Licensed_Premise__r.RecordType.Name,
                            Transporter__r.License_Name__c,Transporter__c,Licensed_Premise__r.State_License_Holder__c,Licensed_Premise__r.License_Number__c,
                            Destination_Site__c,Destination_Site__r.License_ID__c,Destination_Site__r.License_ID__r.License_Name__c,
                            Licensed_Premise__r.Default_Warehouse__r.License_ID__r.License_Name__c FROM Service_Tickets__r)
                           FROM Opportunity WHERE Id =: oppID];
        
        List<Service_Ticket_Line__c> lstSTline = new List<Service_Ticket_Line__c>();
        if(opp.Service_Tickets__r.size() > 0){
            lstSTline = [SELECT Id,Name,New_Packaged_Product__c,Qty_Per_Multi_Unit__c,New_Packaged_Product__r.MOQ__c FROM Service_Ticket_Line__c WHERE Service_Ticket__c =: opp.Service_Tickets__r[0].Id];
        }
        
        String ownership = opp.Ownership__c;
        String siteName = opp.Site_Name__c;
        Id recTypeID = getRecordType(quoteType);
        String paymentTerms = opp.Payment_Terms__c;
        Brand_Quote__c newQuote1 = new Brand_Quote__c();
        if(isMulti){
            for(ProducerWrpr wp : lineItems){
                
                Brand_Quote__c newQuote = new Brand_Quote__c();
                String sampleQuoteId = '';
                String newQuoteId = '';
                getQuote(newQuote,opp,defaultIDs,recTypeID,quoteType);
                insert newQuote;
                newQuoteId = newQuote.Id;
                Pricebook2 samplePb = samplePbList.size() > 0 ? samplePbList[0] : new Pricebook2();
                List<Brand_Quote_Line__c> bqItems =  createQuoteLines(newQuoteId, quoteType/*,sampleQuoteId*/,wp.items,samplePb,lstSTline);
                quoteLines.addAll(bqItems);
            }    
        }else{
            
            getQuote(newQuote1,opp,defaultIDs,recTypeID,quoteType);
            insert newQuote1;
            List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>();
            List<string> Productsnames = new List<string>();
            List<string> pricebooknames = new List<string>();
            string allproductName ;
            for(ProducerWrpr wp : lineItems){
                for(OpportunityLineItem lines : wp.items){
                    //validating related product price book active or inactive.
                    if(lines.PricebookEntry.IsActive == false && quoteType==BRANDQUOTERECORDTYPE_BUY)   
                    {
                        
                        Productsnames.add(lines.PricebookEntry.Name);
                        allproductName = string.join(Productsnames ,', ');
                        message = String.format(PricebookInActive,new List<String>{String.valueOf(allproductName),String.valueOf(TYPE_BUYQUOTE)});
                        
                    }
                    else if(lines.PricebookEntry.IsActive == false && quoteType== BRANDQUOTERECORDTYPE_SELL)
                    {
                        Productsnames.add(lines.PricebookEntry.Name);
                        allproductName = string.join(Productsnames ,', ');
                        message = String.format(PricebookInActive,  new List<String>{String.valueOf(allproductName),String.valueOf(TYPE_SELLQUOTE)}); 
                    }
                }
                oppItems.addAll(wp.items);
                
            }
            Pricebook2 samplePb = samplePbList.size() > 0 ? samplePbList[0] : new Pricebook2();
            List<Brand_Quote_Line__c> bqItems =  createQuoteLines(newQuote1.Id, quoteType/*,sampleQuoteId*/,oppItems,samplePb,lstSTline);
            quoteLines.addAll(bqItems);
        }
        
        insert quoteLines;
        
       	List<Brand_Quote__c> bqList = [SELECT id,OwnerId,Opportunity_Name__r.Account.Type,Supplier_Name__c,Supplier_Contact__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Opportunity_Name__r.Order__c,Supplier_License__c,Distributor_Contact__c,Distributor_Name__c,Ownership__r.Type FROM Brand_Quote__c WHERE Opportunity_Name__c =: oppID];
        if(bqList.size() > 0){
            Set<string> recordTypeNames = new Set<string>();
            Set<Id> distributorIds = new Set<Id>();  
            Set<Id> supplierIds = new Set<Id>(); 
            Set<Id> receiverIds = new Set<Id>(); 
            for(Brand_Quote__c bq : bqList){
                recordTypeNames.add(bq.Opportunity_Name__r.Account.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE);
                
                supplierIds.add(bq.Supplier_Name__c);
                distributorIds.add(bq.Distributor_Name__c);
                receiverIds.add(bq.Receiver_Name__c);
                
            }
            system.debug('##supplierIds:'+supplierIds);
            System.debug('##recordTypeNames:'+recordTypeNames);
            
            supplierIds.addAll(receiverIds);
            distributorIds.addAll(supplierIds);
                
            Map<String,List<State_Licenses__c>> statelicenses = new Map<String,List<State_Licenses__c>>();
            for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__c WHERE License_Name__c IN : supplierIds AND RecordType.Name IN : recordTypeNames AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
                if(statelicenses.containsKey(st.License_Name__c)) {
                    List<State_Licenses__c> statelicense = statelicenses.get(st.License_Name__c);
                    statelicense.add(st);
                    statelicenses.put(st.License_Name__c, statelicense);
                } else {
                    statelicenses.put(st.License_Name__c, new List<State_Licenses__c> { st });
                }
            }
            Map<Id,List<Contact>> distributorContacts = new Map<Id,List<Contact>>();
            for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId IN : distributorIds AND Active__c = true ORDER BY CreatedDate ASC]){
                if(distributorContacts.containsKey(con.AccountId)) {
                    List<Contact> conList = distributorContacts.get(con.AccountId);
                    conList.add(con);
                    distributorContacts.put(con.AccountId, conList);
                } else {
                    distributorContacts.put(con.AccountId, new List<Contact> { con });
                }
            }
            if(!statelicenses.isEmpty()){
                for(Brand_Quote__c bq : bqList){
                    if(bq.Supplier_License__c == NULL && statelicenses.containsKey(bq.Supplier_Name__c)){
                        System.debug('##statelicenses'+statelicenses.get(bq.Supplier_Name__c)[0].id );
                        bq.Supplier_License__c = statelicenses.get(bq.Supplier_Name__c)[0].id;
                    }
                    if(bq.Receiver_License__c == NULL && statelicenses.containsKey(bq.Receiver_Name__c)){
                        System.debug('##Receiver statelicenses'+statelicenses.get(bq.Receiver_Name__c)[0].id );
                        bq.Receiver_License__c = statelicenses.get(bq.Receiver_Name__c)[0].id;
                    }
                    
                }
            }
            if(!distributorContacts.isEmpty()){
                for(Brand_Quote__c bq : bqList){
                    if(bq.Distributor_Contact__c == NULL && distributorContacts.containsKey(bq.Distributor_Name__c)){
                        System.debug('##Distributor_Contact__c'+distributorContacts.get(bq.Distributor_Name__c)[0].id );
                        bq.Distributor_Contact__c = distributorContacts.get(bq.Distributor_Name__c)[0].id;
                    }
                    if(bq.Receiver_Contact__c == NULL && distributorContacts.containsKey(bq.Receiver_Name__c)){
                        System.debug('##Receiver_Contact__c'+distributorContacts.get(bq.Receiver_Name__c)[0].id );
                        bq.Receiver_Contact__c = distributorContacts.get(bq.Receiver_Name__c)[0].id;
                    }
                    if(bq.Supplier_Contact__c == NULL && distributorContacts.containsKey(bq.Supplier_Name__c)){
                        System.debug('##Supplier_Contact__c'+distributorContacts.get(bq.Supplier_Name__c)[0].id );
                        bq.Supplier_Contact__c = distributorContacts.get(bq.Supplier_Name__c)[0].id;
                    }
                }
            }
            if(!statelicenses.isEmpty() || !distributorContacts.isEmpty()){
                update bqList;
            }
        }
        if(!isMulti){
            return newQuote1.Id;
        }
        return null;
    } 
    
    public void getQuote(Brand_Quote__c newQuote, Opportunity opp,List<Company_Custom_Settings__c> defaultIDs,Id recTypeID, String quoteType){
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                     Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                     FROM Shipping_Rates_Table__c 
                                                     WHERE Site__c = :opp.Site_Name__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :opp.Ownership__r.Membership_Level__c
                                                     Order By Mileage_Bracket__c];
        newQuote.Opportunity_Name__c = oppID;
       
        
        newQuote.Distributor_Name__c = opp.Site_Name__r.License_ID__r.License_Name__c;
        newQuote.Distributor_License__c = opp.Site_Name__r.License_ID__c;
        newQuote.Distributor_Contact__c = opp.Site_Name__r.License_ID__r.Contact__c;
        newQuote.BQ_Status__c = STATUS_DRAFT;
        newQuote.Ownership__c = opp.Ownership__c;
        newQuote.Customer_PO_or_Quote__c=opp.Order__r.Name;
        newQuote.Order_Booking_Fee__c = opp.Order_Booking_Fee__c;
        newQuote.Service_Booking_Fee__c = opp.Service_Booking_Fee__c;
        newQuote.Service_Scheduling_Fee__c = opp.Service_Scheduling_Fee__c;
        newQuote.Service_Staging_Fee__c  = opp.Service_Staging_Fee__c ;
        newQuote.Pack_Out_Fee__c = opp.Pack_Out_Fee__c;
        newQuote.Schedule_Dispatch_Fee__c = opp.Schedule_Dispatch_Fee__c;
        newQuote.Stage_Manifest_Fee__c = opp.Stage_Manifest_Fee__c;
        newQuote.Total_Mileage_Fee__c = opp.Total_Mileage_Fee__c;
        newQuote.Total_Weight_Fee__c = opp.Total_Weight_Fee__c;
        newQuote.Site__c = opp.Site_Name__c;
        newQuote.RecordTypeId = recTypeID;
        if(opp.Order__c != null){
            newQuote.Apply_Excise_Tax__c = (opp.Order__r.Exclude_Excise_Tax__c == false);
            newQuote.Requested_Ship_Date__c = opp.Order__r.Request_Ship_Date__c;
            newQuote.Retailer_PO__c = opp.Order__r.Retailer_PO__c;
            newQuote.Factoring_Assignee__c =  opp.Order__r.Factoring_Assignee__c;
            newQuote.Factoring_Contact__c = opp.Order__r.Factoring_Contact__c;
            newQuote.Factoring_Rate__c = opp.Order__r.Factoring_Rate__c;
            newQuote.Factoring_Discount__c = opp.Order__r.Factoring_Discount__c;
            newQuote.Requested_Transfer_Date__c = opp.Requested_Transfer_Date__c;
            newQuote.Notes__c = opp.Order__r.Special_Instructions__c;
            newQuote.Invoice_Memo__c = opp.Order__r.Invoice_Memo__c;
        }
        
        newQuote.Sample_Order__c = opp.Sample_Order__c;
        if(!(opp.Service_Tickets__r.size() > 0)){
        	newQuote.Order_Type__c = BQ_ORDER_TYPE_BRAND;
        }
        
        if(quoteType ==BRANDQUOTERECORDTYPE_SELL || quoteType == BRANDQUOTERECORDTYPE_RMA){	
            newQuote.Payment_Terms__c = opp.Payment_Terms__c;
        }
        
        if((quoteType ==BRANDQUOTERECORDTYPE_SELL || quoteType == BRANDQUOTERECORDTYPE_TRANSFER)){
            newQuote.Shipping_Method__c = BRANDQUOTESHIPPINGMETHOD_DISTRIBUTORDELIVERY; 
            newQuote.Shipping_Terms__c = BRANDQUOTETERMS_BRANDQUOTEFCA; 
        } else if(quoteType == BRANDQUOTERECORDTYPE_BUY){
            newQuote.Payment_Terms__c = opp.Payment_Terms__c;
            newQuote.Shipping_Method__c = BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP; 
            newQuote.Shipping_Terms__c = BRANDQUOTETERMS_BRANDQUOTEFCA; 
        } else if(quoteType == BRANDQUOTERECORDTYPE_SERVICE){
            newQuote.Shipping_Method__c = BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION; 
            newQuote.Shipping_Terms__c = BRANDQUOTETERMS_BRANDQUOTEEXW; 
        } else if(quoteType ==BRANDQUOTERECORDTYPE_LAB){
            newQuote.Shipping_Method__c = BRANDQUOTEShippingMethod_SUPPLIERPICKUP; 
            newQuote.Shipping_Terms__c = BRANDQUOTETERMS_BRANDQUOTEEXW; 
        }
        if(opp.Order__c == null && opp.Service_Tickets__r.size() == 0 ){
            newQuote.Distributor_Name__c = opp.Site_Name__r.License_ID__r.License_Name__c;
            newQuote.Supplier_Name__c = opp.Site_Name__r.License_ID__r.License_Name__c;
            newQuote.Receiver_Name__c = opp.AccountId;
            newQuote.Ownership__c = opp.Ownership__c;
            newQuote.Supplier_License__c = opp.Site_Name__r.License_ID__c;
        }
        if((quoteType == BRANDQUOTERECORDTYPE_RMA || quoteType == BRANDQUOTERECORDTYPE_BUY || quoteType == BRANDQUOTERECORDTYPE_TRANSFER) && opp.Order__c != null){
            Shipping_Manifest__c[] SMs = [SELECT Id, Distributor_Name__c , Distributor_License__c ,Distributor_Contact__c , Receiver_Name__c , Receiver_License__c ,Receiver_Contact__c  FROM Shipping_Manifest__c WHERE Order_Number__c = :opp.Order__c];
            if(SMs.size()>0){
                if(quoteType == BRANDQUOTERECORDTYPE_RMA){
                    newQuote.Receiver_Contact__c = SMs[0].Distributor_Contact__c;
                    newQuote.Receiver_Name__c = SMs[0].Distributor_Name__c;
                    newQuote.Receiver_License__c = SMs[0].Distributor_License__c;
                }else{
                    newQuote.Receiver_Contact__c = SMs[0].Receiver_Contact__c;
                    newQuote.Receiver_Name__c = SMs[0].Receiver_Name__c;
                    newQuote.Receiver_License__c = SMs[0].Receiver_License__c;
                }
            }
            newQuote.Supplier_Name__c = opp.Order__r.Retailer__c;
            newQuote.Supplier_Contact__c = opp.Order__r.Retailer_Contact__c;
            newQuote.Supplier_License__c = opp.Order__r.State_License__c;
        }
        if(quoteType == BRANDQUOTERECORDTYPE_TRANSFER && opp.Order__r.Sample_Order__c == true){
            newQuote.Supplier_Name__c = opp.Order__r.Account__c;
            newQuote.Supplier_Contact__c = opp.Order__r.Customer__r.ContactId;
            newQuote.Supplier_License__c = null;
        }
        if((quoteType == BRANDQUOTERECORDTYPE_BUY || quoteType == BRANDQUOTERECORDTYPE_TRANSFER) && opp.Order__c == null){
            
            if(opp.Service_Tickets__r.size() > 0){
                
               
                newQuote.Notes__c = opp.Service_Tickets__r[0].Special_Instruction__c;
                if(opp.Service_Tickets__r[0].Transfer_Method__c == ST_Transfer_Method_Drop_Off){
                    newQuote.Notes__c = opp.Service_Tickets__r[0].Special_Instruction__c;
                    newQuote.Distributor_Name__c = opp.Service_Tickets__r[0].Transporter__r.License_Name__c;
                    newQuote.Distributor_License__c = opp.Service_Tickets__r[0].Transporter__c;                  
                    newQuote.Receiver_Name__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__r.License_Name__c;
                    newQuote.Receiver_License__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__c;
                    newQuote.Supplier_Name__c = opp.Service_Tickets__r[0].Brand_Name__c;
                    newQuote.Supplier_License__c = opp.Service_Tickets__r[0].Licensed_Premise__c;
                    
                }else if(opp.Service_Tickets__r[0].Transfer_Method__c == ST_Transfer_Method_Pick_up){
                    newQuote.Distributor_Name__c = opp.Service_Tickets__r[0].Transporter__r.License_Name__c;
                    newQuote.Distributor_License__c = opp.Service_Tickets__r[0].Transporter__c;  
                    newQuote.Receiver_Name__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__r.License_Name__c;
                    newQuote.Receiver_License__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__c;
                    newQuote.Supplier_Name__c = opp.Service_Tickets__r[0].Brand_Name__c;
                    newQuote.Supplier_License__c = opp.Service_Tickets__r[0].Licensed_Premise__c;
                    
                } else {
                    
                    newQuote.Receiver_Name__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__r.License_Name__c;
                    newQuote.Receiver_License__c = opp.Service_Tickets__r[0].Destination_Site__r.License_ID__c;
                }
                
                if(opp.Service_Tickets__r[0].Licensed_Premise__r.RecordType.Name == State_License_WhiteLabel_RecordType){
                    List<State_Licenses__c> slList =[SELECT id FROM State_Licenses__c WHERE Id !=: opp.Service_Tickets__r[0].Licensed_Premise__c AND License_Number__c =: opp.Service_Tickets__r[0].Licensed_Premise__r.License_Number__c AND License_Name__c =:opp.Service_Tickets__r[0].Licensed_Premise__r.State_License_Holder__c AND License_Status__c = : STATE_LICENSE_ACTIVE];
                    newQuote.Supplier_Name__c = opp.Service_Tickets__r[0].Licensed_Premise__r.State_License_Holder__c;
                    newQuote.Supplier_License__c = slList[0].id;
                }
            }               
            
        }
        if(opp.Order__c != null && quoteType == BRANDQUOTERECORDTYPE_TRANSFER && opp.Order__r.Sample_Order__c != true){
            newQuote.Distributor_Name__c = opp.Order__r.Transporter__r.License_Name__c;
            newQuote.Distributor_License__c = opp.Order__r.Transporter__c; 
            newQuote.Supplier_Name__c = opp.Order__r.Account__c;
            newQuote.Supplier_License__c = null;
            //newQuote.Supplier_License__c = opp.Order__r.Site__r.License_ID__c;
            newQuote.Receiver_Name__c = opp.Order__r.Retailer__c;
            newQuote.Receiver_License__c = opp.Order__r.State_License__c;
        }
        if(opp.Order__c != null && (opp.Order__r.Order_Type__c == BQ_ORDER_TYPE_BRAND || quoteType == BRANDQUOTERECORDTYPE_TRANSFER ) && opp.Order__r.Account__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER && defaultIDs.size() >0){
            system.debug('inside Acc');
            if(defaultIDs[0].Default_Distributor__c != null){
                newQuote.Supplier_Name__c = defaultIDs[0].Default_Distributor__c;
            }    
            if(defaultIDs[0].Default_License__c != null){
                newQuote.Supplier_License__c = defaultIDs[0].Default_License__c;
            }    
            if(defaultIDs[0].Default_Contact__c != null){
                newQuote.Supplier_Contact__c = defaultIDs[0].Default_Contact__c;
            }   
              newQuote.Receiver_Name__c = opp.Order__r.Retailer__c;
            newQuote.Receiver_License__c = opp.Order__r.State_License__c;
        }
        
        
    }
    
    public List<Brand_Quote_Line__c> createQuoteLines(String bqID, String quoteType,List<OpportunityLineItem> items,Pricebook2 samplePb,List<Service_Ticket_Line__c> lstSTline){
        System.debug('##createQuoteLines:'+items);
        List<Brand_Quote_Line__c> bqLineItems = new List<Brand_Quote_Line__c>();
        Id bqLIrecordtypeID;
        if(quoteType == BRANDQUOTERECORDTYPE_BUY) 
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_BUYQOUTELINE).getRecordTypeId();
        else if(quoteType == BRANDQUOTERECORDTYPE_SELL)
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_SELLLINE).getRecordTypeId();
        else If(quoteType == BRANDQUOTERECORDTYPE_RMA)
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_RMALINE).getRecordTypeId();
        else if(quoteType == BRANDQUOTERECORDTYPE_TRANSFER)
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_TRANSFERLINE).getRecordTypeId();
        else if(quoteType == BRANDQUOTERECORDTYPE_SERVICE)
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_SERVICELINE).getRecordTypeId();
        else if(quoteType == BRANDQUOTERECORDTYPE_LAB)
            bqLIrecordtypeID = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_LABLINE).getRecordTypeId();
        
        for (OpportunityLineItem  opptyLineItems : items){
            Brand_Quote_Line__c newQuoteLineItems = new Brand_Quote_Line__c();
            newQuoteLineItems.Product_Name__c = opptyLineItems.Product2Id;
            newQuoteLineItems.Is_Sample__c = opptyLineItems.Is_Sample__c;
            newQuoteLineItems.IsPromo__c = opptyLineItems.Order_Line_Item__r.IsPromo__c;
            newQuoteLineItems.Pick_Pack_Fee__c = opptyLineItems.Pick_Pack_Fee__c;
            newQuoteLineItems.QA_Review_Fee__c = opptyLineItems.QA_Review_Fee__c;
            newQuoteLineItems.Total_Weight_lbs__c = opptyLineItems.Total_Weight_lbs__c;
            newQuoteLineItems.Disty_Margin__c = opptyLineItems.PricebookEntry.DistyMargin__c;
            newQuoteLineItems.Disty_Discount_Per_Unit__c = opptyLineItems.Disty_Discount_Per_Unit__c;
            newQuoteLineItems.Retail_Wholesale_Price__c = opptyLineItems.UnitPrice;
            newQuoteLineItems.Price_Book__c = (opptyLineItems.PriceBook_Id__c != null?opptyLineItems.PriceBook_Id__c: opptyLineItems.PricebookEntry.PriceBook2ID); 
            newQuoteLineItems.Brand_Quote_Number__c = bqID;
            Boolean isSetMOQ = false;
            if(lstSTline.size() >0){
                for(Service_Ticket_Line__c stLine : lstSTline){
                    if(opptyLineItems.Product2Id == stLine.New_Packaged_Product__c){
                        newQuoteLineItems.MOQ__c = stLine.Qty_Per_Multi_Unit__c;
                        isSetMOQ = true;
                        break;
                    }
                }
            }
            
            if(!isSetMOQ){
                newQuoteLineItems.MOQ__c = opptyLineItems.MOQ__c;
            }
            newQuoteLineItems.Product_Title__c = opptyLineItems.Product_Title__c;
            newQuoteLineItems.Ownership_Code__c = opptyLineItems.Ownership_Code__c;
            newQuoteLineItems.Quantity_Cases__c = opptyLineItems.Quantity;
            newQuoteLineItems.RecordTypeId = bqLIrecordtypeID;
            newQuoteLineItems.Opportunity_Line_Item_Id__c = opptyLineItems.Id;
            newQuoteLineItems.Listing_Fee__c = opptyLineItems.Listing_Fee__c;
            newQuoteLineItems.Harvest_Batch_Code__c = opptyLineItems.Harvest_Batch_Code__c;
            bqLineItems.add(newQuoteLineItems); 
        }
        try{
            return bqLineItems;
        }catch (Exception ex){ 
            return null;
        }
    }
    
    public ID getRecordType(String recTypeName){
        recordtype recTypeID = [select id from recordtype where sObjectType = 'Brand_Quote__c' AND DeveloperName =:recTypeName limit 1];
        return recTypeID.Id;
    }
    public class ProducerWrpr{
        @AuraEnabled public String producerName{get;set;}
        @AuraEnabled public OpportunityLineItem productDescription{get;set;}
        @AuraEnabled public List<OpportunityLineItem> items{get;set;}
    }
    
    public Class oppLineWrapper {
        public oppLineWrapper(OpportunityLineItem oppObj)
        {
            this.ProducName = oppObj.PricebookEntry.Product2.White_Labelled__c ==  true ? oppObj.PricebookEntry.Product2.Licensee_Name__r.Name : oppObj.PricebookEntry.Product2.Producer_Name__r.Name;
            this.ProducNameID = oppObj.PricebookEntry.Product2.White_Labelled__c ==  true ? oppObj.PricebookEntry.Product2.Licensee_Name__c : oppObj.PricebookEntry.Product2.Producer_Name__c;
            this.ProdName = oppObj.PricebookEntry.Product2.Name;
            this.ProdNameID = oppObj.Product2Id;
            this.ProdDes = oppObj.Product_Description__c;
            this.MOQ = oppObj.MOQ__c;
            this.counter = 2;
            this.Quantity = oppObj.Quantity;
            this.LineTotal = oppObj.Line_Total_Qty__c;
            this.UnitPrice = oppObj.UnitPrice;
            this.TotalPrice = oppObj.TotalPrice;
            this.isSample = oppObj.Is_Sample__c;
            this.isPromo = oppObj.Order_Line_Item__r.IsPromo__c;
        }
        
        public oppLineWrapper(OpportunityLineItem oppObj, Integer counter)
        {
            this.ProducName = oppObj.PricebookEntry.Product2.White_Labelled__c ==  true ? oppObj.PricebookEntry.Product2.Licensee_Name__r.Name : oppObj.PricebookEntry.Product2.Producer_Name__r.Name;
            this.ProducNameID = oppObj.PricebookEntry.Product2.White_Labelled__c ==  true ? oppObj.PricebookEntry.Product2.Licensee_Name__c : oppObj.PricebookEntry.Product2.Producer_Name__c;
            this.ProdName = oppObj.PricebookEntry.Product2.Name;
            this.ProdNameID = oppObj.Product2Id;
            this.ProdDes = oppObj.Product_Description__c;
            this.MOQ = oppObj.MOQ__c;
            this.counter = counter;
            this.Quantity = oppObj.Quantity;
            this.LineTotal = oppObj.Line_Total_Qty__c;
            this.UnitPrice = oppObj.UnitPrice;
            this.TotalPrice = oppObj.TotalPrice;
            this.isSample = oppObj.Is_Sample__c;
            this.isPromo = oppObj.Order_Line_Item__r.IsPromo__c;
        }
        
        @AuraEnabled public String ProducName {get;set;}
        @AuraEnabled public String ProducNameID {get;set;}
        @AuraEnabled  public String ProdName {get;set;}
        @AuraEnabled  public String ProdNameID {get;set;}
        @AuraEnabled public String ProdDes {get;set;}
        @AuraEnabled public Integer counter {get;set;}
        @AuraEnabled public decimal MOQ {get;set;}
        @AuraEnabled public decimal Quantity {get;set;}
        @AuraEnabled public decimal LineTotal {get;set;}
        @AuraEnabled public decimal UnitPrice {get;set;}
        @AuraEnabled public decimal TotalPrice {get;set;}
        @AuraEnabled public Integer size { get; set; } 
        @AuraEnabled public Boolean isSample { get; set; }
        @AuraEnabled public Boolean isPromo {get;set;}
    }
    
}