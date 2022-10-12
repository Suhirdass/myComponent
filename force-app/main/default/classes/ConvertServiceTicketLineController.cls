public class ConvertServiceTicketLineController {
    
    private Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
        }set;
    }
    private Static String TYPE_SERVICEQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_SERVICEQUOTE) ? TYPE_SERVICEQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Service_Quote');
        }set;
    }
    private Static String BRANDQUOTELINERECORDTYPE_BUYQOUTELINE{
        get{
            return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_BUYQOUTELINE) ? BRANDQUOTELINERECORDTYPE_BUYQOUTELINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_BuyQuoteLine');
        }set;
    }
    private Static String STATUS_DRAFT{ 
        get{
            return  String.isNotBlank(STATUS_DRAFT) ? STATUS_DRAFT :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Draft');
        }set;
    }
    private Static String BQ_ORDER_TYPE_BRAND{ 
        get{
            return  String.isNotBlank(BQ_ORDER_TYPE_BRAND) ? BQ_ORDER_TYPE_BRAND :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_OrderType_Brand');
        }set;
    }
    private Static String BQ_SALES_ORIGIN_BRAND{ 
        get{
            return  String.isNotBlank(BQ_SALES_ORIGIN_BRAND) ? BQ_SALES_ORIGIN_BRAND :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Sales_Origin_Brand');
        }set;
    }
    private Static String STL_STATUS_ACCEPTED{ 
        get{
            return  String.isNotBlank(STL_STATUS_ACCEPTED) ? STL_STATUS_ACCEPTED :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','STL_Status_Accepted');
        }set;
    }
    private Static String BQL_PRODUCT_TITLE_DISTRIBUTOR{
        get{
            return  String.isNotBlank(BQL_PRODUCT_TITLE_DISTRIBUTOR) ? BQL_PRODUCT_TITLE_DISTRIBUTOR :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQL_Product_Title_Distributor');
        }set;
    }
    private Static String BQ_ERR_MSG_TRANSFER_CUSTUDY_MUST_SELECT{ 
        get{
            return  String.isNotBlank(BQ_ERR_MSG_TRANSFER_CUSTUDY_MUST_SELECT) ? BQ_ERR_MSG_TRANSFER_CUSTUDY_MUST_SELECT :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Err_Msg_Transfer_custudy_must_Select');
        }set;
    }
    private Static String BRANDQUOTELINERECORDTYPE_SERVICELINE{
        get{
           return  String.isNotBlank(BRANDQUOTELINERECORDTYPE_SERVICELINE) ? BRANDQUOTELINERECORDTYPE_SERVICELINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BQ_Record_Type_DevName_ServiceLine');
        }set;
    }
    private Static String ERR_MSG_APPROVED_BRAND_QUOTE{ 
        get{ 
            return String.isNotBlank(ERR_MSG_APPROVED_BRAND_QUOTE) ? ERR_MSG_APPROVED_BRAND_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_Approved_BQ');
        }set;
    }
    private Static String FILIGREEN_ORIGINATED_SALES{ 
        get{ 
            return String.isNotBlank(FILIGREEN_ORIGINATED_SALES) ? FILIGREEN_ORIGINATED_SALES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','Filigreen_Originated_Sales');
        }set;
    }
    private Static String BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION{
        get{
            return  String.isNotBlank(BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION) ? BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_InternalConversion');
        }set;
    }
    private Static String BRANDQUOTETERMS_BRANDQUOTEEXW { 
        get{
            return  String.isNotBlank(BRANDQUOTETerms_BRANDQUOTEEXW) ? BRANDQUOTETerms_BRANDQUOTEEXW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_EXW');
        }set;
    }	
    private static String PRODUCT_NAME_LABELING{
        get{
            return String.isNotBlank(PRODUCT_NAME_LABELING) ? PRODUCT_NAME_LABELING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Labeling');
        }set;
    }
    private static String PRODUCT_NAME_JARRING{
        get{
            return String.isNotBlank(PRODUCT_NAME_JARRING) ? PRODUCT_NAME_JARRING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Jarring');
        }set;
    }
    private static String PRODUCT_NAME_TESTING{
        get{
            return String.isNotBlank(PRODUCT_NAME_TESTING) ? PRODUCT_NAME_TESTING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Testing');
        }set;
    }
    private static String PRODUCT_NAME_BAGGING{
        get{
            return String.isNotBlank(PRODUCT_NAME_BAGGING) ? PRODUCT_NAME_BAGGING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Bagging');
        }set;
    }
    private static String PRODUCT_NAME_PRE_ROLLING{
        get{
            return String.isNotBlank(PRODUCT_NAME_PRE_ROLLING) ? PRODUCT_NAME_PRE_ROLLING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Pre_Rolling');
        }set;
    }
    private static String PRODUCT_NAME_TAMPER_CLAMSHELL{
        get{
            return String.isNotBlank(PRODUCT_NAME_TAMPER_CLAMSHELL) ? PRODUCT_NAME_TAMPER_CLAMSHELL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Tamper_Clamshell');
        }set;
    }
    private static String PRODUCT_NAME_TAMPER_PROOF_LABEL{
        get{
            return String.isNotBlank(PRODUCT_NAME_TAMPER_PROOF_LABEL) ? PRODUCT_NAME_TAMPER_PROOF_LABEL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Tamper_Proof_Label');
        }set;
    }
    private static String PRODUCT_NAME_TAMPER_SHRINK_BAND{
        get{
            return String.isNotBlank(PRODUCT_NAME_TAMPER_SHRINK_BAND) ? PRODUCT_NAME_TAMPER_SHRINK_BAND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Tamper_Shrink_Band');
        }set;
    }
    private static String PRODUCT_NAME_HEAT_SEAL{
        get{
            return String.isNotBlank(PRODUCT_NAME_HEAT_SEAL) ? PRODUCT_NAME_HEAT_SEAL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Heat_Seal');
        }set;
    }
    private static String PRODUCT_NAME_LABEL_LARGE{
        get{
            return String.isNotBlank(PRODUCT_NAME_LABEL_LARGE) ? PRODUCT_NAME_LABEL_LARGE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Label_Large');
        }set;
    }
    private static String PRODUCT_NAME_LABEL_MEDIUM{
        get{
            return String.isNotBlank(PRODUCT_NAME_LABEL_MEDIUM) ? PRODUCT_NAME_LABEL_MEDIUM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Label_Medium');
        }set;
    }
    private static String PRODUCT_NAME_LABEL_SMALL{
        get{
            return String.isNotBlank(PRODUCT_NAME_LABEL_SMALL) ? PRODUCT_NAME_LABEL_SMALL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Label_Small');
        }set;
    }
    private static String STL_PACKAGE_TYPE_PRE_ROLLING{
        get{
            return String.isNotBlank(STL_PACKAGE_TYPE_PRE_ROLLING) ? STL_PACKAGE_TYPE_PRE_ROLLING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','STL_Package_Type_Pre_Rolling');
        }set;
    }
    private static String STL_PACKAGE_TYPE_PRE_ROLL_PACKING{
        get{
            return String.isNotBlank(STL_PACKAGE_TYPE_PRE_ROLL_PACKING) ? STL_PACKAGE_TYPE_PRE_ROLL_PACKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','STL_Package_Type_Pre_Roll_Packing');
        }set;
    }
    private static String STL_PACKAGE_TYPE_JARRING{
        get{
            return String.isNotBlank(STL_PACKAGE_TYPE_JARRING) ? STL_PACKAGE_TYPE_JARRING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','STL_Package_Type_Jarring');
        }set;
    }
    private static String STL_PACKAGE_TYPE_BAGGING{
        get{
            return String.isNotBlank(STL_PACKAGE_TYPE_BAGGING) ? STL_PACKAGE_TYPE_BAGGING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','STL_Package_Type_Bagging');
        }set;
    }
    
    
    Service_Ticket__c st;
    Service_Ticket_Line__c stl;
    public Service_Ticket_Line__c stlobj {get; set;}
    public Service_Ticket_Line__c stlSEobj {get; set;}
    
    public static Brand_Quote__c bqs {get;set;}
    public static String message;
    public Service_Ticket_Line__c stllst {get;set;}
    
    private Id BQRecordTypeId;
    private Id bliRecordTypeId;
    private ApexPages.StandardController stdController;
    public ConvertServiceTicketLineController(ApexPages.StandardController controller){
        this.stdController = controller;
        stlobj = (Service_Ticket_Line__c)stdController.getRecord();
        stlSEobj=(Service_Ticket_Line__c)stdController.getRecord();
        stl = (Service_Ticket_Line__c)controller.getRecord();
    }
    
    
    public  ConvertServiceTicketLineController(){ }
    
    public PageReference createBuyQuote(){
        PageReference pr;
        Id BQRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(TYPE_BUYQUOTE).getRecordTypeId();
        Id bliRecordTypeId = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_BUYQOUTELINE).getRecordTypeId();
        if(stl != null){
            stl = [SELECT Id, Name,Brand_Quote__c/*,CRP_Required__c*/,Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                   Total_Label_Qty__c  , Package_Type__c,Status__c,Total_Converted_Cases__c ,
                   Per_Unit_Weight_g__c , Service_Ticket__c,Service_Ticket__r.Name,Service_Ticket__r.Brand_Name__c,Service_Ticket__r.Brand_Contact__c,Service_Ticket__r.Licensed_Premise__c ,Service_Ticket__r.Opportunity__c,
                   Service_Ticket__r.Opportunity__r.Site_Name__c,Service_Ticket__r.Opportunity__r.Ownership__c,Service_Ticket__r.Opportunity__r.Payment_Terms__c,
                   New_Packaged_Product__c ,Qty_Per_Multi_Unit__c, Retail_Wholesale_Price__c,Spl_Packaging_Notes__c  ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                   Total_Desired_Retail_Ready_Form__c ,Total_Units__c ,UID__c, /*Final_Total_Labels_Qty__c,*/Transfer_of_Custody__c, Tamper_Type__c    
                   FROM Service_Ticket_Line__c WHERE Id = :stl.Id];
            List<Brand_Quote__c> BQs = [SELECT Id,Service_Ticket_Line__c FROM Brand_Quote__c where Service_Ticket_Line__c = :stl.Id AND RecordTypeId = :BQRecordTypeId];
            if(BQs.size()> 0 ){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,
                                                              Label.Already_Converted_Service_Ticket_Line);
                ApexPages.addMessage(msg);
                return pr;
            }
            if(stl.Transfer_of_Custody__c  == true){
                Brand_Quote__c newBQ = new Brand_Quote__c(
                    RecordTypeId = BQRecordTypeId,
                    BQ_Status__c = STATUS_DRAFT,
                    Order_Type__c = BQ_ORDER_TYPE_BRAND,
                    Supplier_Name__c = stl.Service_Ticket__r.Brand_Name__c,
                    Supplier_Contact__c = stl.Service_Ticket__r.Brand_Contact__c,
                    Supplier_License__c = stl.Service_Ticket__r.Licensed_Premise__c ,
                    Customer_PO_or_Quote__c = stl.Service_Ticket__r.Name+'-'+stl.Name,
                    Opportunity_Name__c  = stl.Service_Ticket__r.Opportunity__c,
                    Sales_Origin__c = BQ_SALES_ORIGIN_BRAND,
                    Site__c = stl.Service_Ticket__r.Opportunity__r.Site_Name__c,
                    Ownership__c = stl.Service_Ticket__r.Opportunity__r.Ownership__c,
                    Payment_Terms__c = stl.Service_Ticket__r.Opportunity__r.Payment_Terms__c);
                List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
                if(defaultIDs.size() >0){
                    if(defaultIDs[0].Default_Distributor__c != null)
                        newBQ.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
                    newBQ.Receiver_Name__c  = defaultIDs[0].Default_Distributor__c;
                    if(defaultIDs[0].Default_License__c != null)
                        newBQ.Distributor_License__c = defaultIDs[0].Default_License__c;
                    newBQ.Receiver_License__c = defaultIDs[0].Default_License__c;
                    if(defaultIDs[0].Default_Contact__c != null)
                        newBQ.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
                }
                newBQ.Service_Ticket_Line__c = stl.Id;
                insert newBQ;
                stl.Status__c = STL_STATUS_ACCEPTED;
                update stl;
                
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId = bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = stl.New_Packaged_Product__c,
                    Quantity_Cases__c = stl.Total_Units__c  ,
                    MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                for(PriceBookEntry pbe : [SELECT Id,Product2.Name,PriceBook2Id, UnitPrice FROM PriceBookEntry WHERE Product2Id = :stl.New_Packaged_Product__c LIMIT 1]){
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                insert bql;
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,BQ_ERR_MSG_TRANSFER_CUSTUDY_MUST_SELECT);
                ApexPages.addMessage(msg);
                return pr;
            }
        }
        return pr;
    }
    public PageReference convertServiceTicketLine(){
        PageReference pr;
        Id BQRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(TYPE_SERVICEQUOTE).getRecordTypeId();
        Id bliRecordTypeId = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_SERVICELINE).getRecordTypeId();
        if(stl != null){
            stl = [SELECT Id, Name,Brand_Quote__c/*,CRP_Required__c*/,Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                   Total_Label_Qty__c  , Package_Type__c,Status__c,Total_Converted_Cases__c ,Subtotal_Label_Qty__c,Service_Ticket__r.Request_Date_Time__c,
                   Per_Unit_Weight_g__c , Service_Ticket__c,Service_Ticket__r.Name,Service_Ticket__r.Opportunity__c,Service_Ticket__r.Licensed_Premise__c,
                   Service_Ticket__r.Opportunity__r.Site_Name__c,Service_Ticket__r.Opportunity__r.Ownership__c,Service_Ticket__r.Brand_Contact__c,Service_Ticket__r.Opportunity__r.AccountId,Service_Ticket__r.Opportunity__r.Payment_Terms__c,
                   New_Packaged_Product__c ,Qty_Per_Multi_Unit__c, Retail_Wholesale_Price__c,Spl_Packaging_Notes__c  ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                   Total_Desired_Retail_Ready_Form__c ,Total_Units__c ,UID__c,Converted_Single_Qty__c, /*Final_Total_Labels_Qty__c,*/Transfer_of_Custody__c, Tamper_Type__c,
                   Qty_Label_Large__c , Qty_Label_Medium__c  , Qty_Label_Small__c, Qty_of_Misc_Label__c, Total_Pre_Roll_Packs__c    
                   FROM Service_Ticket_Line__c WHERE Id = :stl.Id];
            List<Brand_Quote__c> BQs = [SELECT Id,Service_Ticket_Line__c FROM Brand_Quote__c where Service_Ticket_Line__c = :stl.Id AND RecordTypeId = :BQRecordTypeId];
            if(BQs.size()> 0 /*stl.Brand_Quote__c != null*/){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,
                                                              Label.Already_Converted_Service_Ticket_Line);
                ApexPages.addMessage(msg);
                return pr;
            }
            Savepoint sp = Database.setSavepoint();
            try{
                Map<String,String> packageTypeConfigProductMap = new Map<String,String>();
                Map<String,Package_Type_Config__c> packageTypeConfigMap = Package_Type_Config__c.getAll();
                Set<String> serviceProducts = new Set<String>{PRODUCT_NAME_LABELING, PRODUCT_NAME_JARRING, PRODUCT_NAME_TESTING, PRODUCT_NAME_BAGGING, PRODUCT_NAME_PRE_ROLLING, PRODUCT_NAME_TAMPER_CLAMSHELL, PRODUCT_NAME_TAMPER_PROOF_LABEL, PRODUCT_NAME_TAMPER_SHRINK_BAND, PRODUCT_NAME_HEAT_SEAL, PRODUCT_NAME_LABEL_LARGE, PRODUCT_NAME_LABEL_MEDIUM, PRODUCT_NAME_LABEL_SMALL};
                    for(String key: packageTypeConfigMap.keySet()){
                        serviceProducts.add(key);
                        Package_Type_Config__c PTC = packageTypeConfigMap.get(key);
                        packageTypeConfigProductMap.put(PTC.Package_Type__c+' '+PTC.Size__c,key);
                    }    
                PriceBookEntry[] pbeList = [SELECT Id,Product2.Name,PriceBook2Id, UnitPrice FROM PriceBookEntry WHERE PriceBook2.Name =: FILIGREEN_ORIGINATED_SALES AND Product2.Name IN :serviceProducts];
                Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
                for(PriceBookEntry pbe: pbeList){
                    pbeMap.put(pbe.Product2.Name,pbe);
                }
                Product2[] products = [SELECT Id, Name FROM Product2 WHERE Name IN :serviceProducts];
                Map<String,Product2> productMap = new Map<String,Product2>();
                for(Product2 p: Products){
                    productMap.put(p.Name,p);
                }
                
                Brand_Quote_Line__c[] BQLines = new Brand_Quote_Line__c[]{};
                    
                    Brand_Quote__c newBQ = new Brand_Quote__c(
                        RecordTypeId = BQRecordTypeId,
                        BQ_Status__c = STATUS_DRAFT,
                        Order_Type__c = BQ_ORDER_TYPE_BRAND,
                        Customer_PO_or_Quote__c = stl.Service_Ticket__r.Name+'-'+stl.Name,
                        Opportunity_Name__c  = stl.Service_Ticket__r.Opportunity__c,
                        Receiver_Name__c  = stl.Service_Ticket__r.Opportunity__r.AccountId,
                        Receiver_Contact__c = stl.Service_Ticket__r.Brand_Contact__c,
                        Receiver_License__c  = stl.Service_Ticket__r.Licensed_Premise__c,
                        Sales_Origin__c = BQ_SALES_ORIGIN_BRAND,
                        Shipping_Method__c = BRANDQUOTESHIPPINGMETHOD_INTERNALCONVERSION,
                        Shipping_Terms__c = BRANDQUOTETERMS_BRANDQUOTEEXW,
                        Requested_Transfer_Date__c = Date.valueOf(stl.Service_Ticket__r.Request_Date_Time__c),
                        Site__c = stl.Service_Ticket__r.Opportunity__r.Site_Name__c,
                        Payment_Terms__c = stl.Service_Ticket__r.Opportunity__r.Payment_Terms__c);
                List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
                if(defaultIDs.size() >0)
                {
                    if(defaultIDs[0].Default_Distributor__c != null){
                        newBQ.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
                        newBQ.Supplier_Name__c  = defaultIDs[0].Default_Distributor__c;
                        newBQ.Ownership__c = defaultIDs[0].Default_Distributor__c;
                    }
                    if(defaultIDs[0].Default_License__c != null){
                        newBQ.Distributor_License__c = defaultIDs[0].Default_License__c;
                        newBQ.Supplier_License__c  = defaultIDs[0].Default_License__c;
                    }
                    if(defaultIDs[0].Default_Contact__c != null)
                        newBQ.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
                }
                newBQ.Service_Ticket_Line__c = stl.Id;
                insert newBQ;
                //stl.Brand_Quote__c = newBQ.Id;
                stl.Status__c = STL_STATUS_ACCEPTED;
                update stl;
                
                if(stl.Tamper_Type__c != null && productMap.containsKey(stl.Tamper_Type__c)){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Product_Name__c = productMap.get(stl.Tamper_Type__c).Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c,
                        MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                        bql.Quantity_Cases__c = stl.Total_Pre_Roll_Packs__c;
                    }
                    if(pbeMap.containsKey(stl.Tamper_Type__c)){
                        PriceBookEntry pbe = pbeMap.get(stl.Tamper_Type__c);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                }
                if(stl.Qty_Label_Large__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_LARGE)){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_LARGE).Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c * stl.Qty_Label_Large__c,
                        MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                        bql.Quantity_Cases__c = stl.Total_Pre_Roll_Packs__c * stl.Qty_Label_Large__c;
                    }
                    if(pbeMap.containsKey(PRODUCT_NAME_LABEL_LARGE)){
                        PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_LARGE);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                }
                if(stl.Qty_Label_Medium__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_MEDIUM).Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c * stl.Qty_Label_Medium__c,
                        MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                        bql.Quantity_Cases__c = stl.Total_Pre_Roll_Packs__c * stl.Qty_Label_Medium__c;
                    }
                    if(pbeMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                        PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_MEDIUM);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                }
                if(stl.Qty_Label_Small__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_SMALL)){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_SMALL).Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c * stl.Qty_Label_Small__c,
                        MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                        bql.Quantity_Cases__c = stl.Total_Pre_Roll_Packs__c * stl.Qty_Label_Small__c;
                    }
                    if(pbeMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                        PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_SMALL);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                }
                if(stl.Qty_of_Misc_Label__c > 0 && productMap.containsKey(PRODUCT_NAME_LABELING)){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Product_Name__c = productMap.get(PRODUCT_NAME_LABELING).Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c * stl.Qty_of_Misc_Label__c,
                        MOQ__c = 1,Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                        bql.Quantity_Cases__c = stl.Total_Pre_Roll_Packs__c * stl.Qty_of_Misc_Label__c;
                    }
                    if(pbeMap.containsKey(PRODUCT_NAME_LABELING)){
                        PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABELING);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                    
                }
                if(stl.Package_Type__c == STL_PACKAGE_TYPE_JARRING && (productMap.containsKey(PRODUCT_NAME_JARRING) || packageTypeConfigProductMap.containsKey(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c))){
                    //stl.Total_Units__c*stl.Total_Label_Qty__c
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c,MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    String productName = '';
                    if(packageTypeConfigProductMap.containsKey(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c)){
                        productName = packageTypeConfigProductMap.get(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c);
                        if(productMap.containsKey(productName)){
                            bql.Product_Name__c = productMap.get(productName).Id;
                        }
                    }else if(productMap.containsKey(PRODUCT_NAME_JARRING)){
                        bql.Product_Name__c = productMap.get(PRODUCT_NAME_JARRING).Id;
                    }
                    if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_JARRING)){
                        PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_JARRING);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    
                    BQLines.add(bql);
                    
                }
                if(stl.Package_Type__c == STL_PACKAGE_TYPE_BAGGING && (productMap.containsKey(PRODUCT_NAME_BAGGING) || packageTypeConfigProductMap.containsKey(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c))){
                    //stl.Total_Units__c*stl.Total_Label_Qty__c
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c,MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    String productName = '';
                    if(packageTypeConfigProductMap.containsKey(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c)){
                        productName = packageTypeConfigProductMap.get(stl.Package_Type__c +' '+stl.Desired_Retail_Ready_Form__c);
                        if(productMap.containsKey(productName)){
                            bql.Product_Name__c = productMap.get(productName).Id;
                        }
                    }else if(productMap.containsKey(PRODUCT_NAME_BAGGING)){
                        bql.Product_Name__c = productMap.get(PRODUCT_NAME_BAGGING).Id;
                    }
                    if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_BAGGING)){
                        PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_BAGGING);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                    
                }
                if(stl.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING && (productMap.containsKey(PRODUCT_NAME_PRE_ROLLING) || packageTypeConfigProductMap.containsKey('Prerolling '+stl.Desired_Retail_Ready_Form__c))){
                    //stl.Total_Units__c*stl.Total_Label_Qty__c
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                        RecordTypeId = bliRecordTypeId,
                        Brand_Quote_Number__c = newBQ.Id,
                        Quantity_Cases__c = stl.Converted_Single_Qty__c,MOQ__c = 1,
                        Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                    );
                    String productName = '';
                    if(packageTypeConfigProductMap.containsKey('Prerolling '+stl.Desired_Retail_Ready_Form__c)){
                        productName = packageTypeConfigProductMap.get('Prerolling '+stl.Desired_Retail_Ready_Form__c);
                        if(productMap.containsKey(productName)){
                            bql.Product_Name__c = productMap.get(productName).Id;
                        }
                    }else if(productMap.containsKey(PRODUCT_NAME_PRE_ROLLING)){
                        bql.Product_Name__c = productMap.get(PRODUCT_NAME_PRE_ROLLING).Id;
                    }
                    if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_PRE_ROLLING)){
                        PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_PRE_ROLLING);
                        bql.Price_Book__c = pbe.PriceBook2Id;
                        bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                    }
                    BQLines.add(bql);
                }
                if(!BQLines.isEmpty()){
                    insert BQLines;
                    pr = new PageReference('/'+stl.Id);
                }
            }catch(Exception e){
                System.debug('###CSTLC Exception:'+e.getMessage());
                Database.rollback(sp);
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                ApexPages.addMessage(msg);
                return pr;
            }
        }
        return pr;
    }
    
    @AuraEnabled
    public static AuraResponse createBuyQuote(String recordId){
        AuraResponse r = new AuraResponse('ConvertServiceTicketLineController.createBuyQuote()');    
        ConvertServiceTicketLineController assign = new ConvertServiceTicketLineController();
        assign.stlobj = new Service_Ticket_Line__c();
        
        List<Service_Ticket_Line__c> stllst = [SELECT Id, Name,Brand_Quote__c/*,CRP_Required__c*/,Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                                               Total_Label_Qty__c  , Package_Type__c,Status__c,Total_Converted_Cases__c ,Service_Ticket__r.Request_Date_Time__c,
                                               Per_Unit_Weight_g__c , Service_Ticket__c,Service_Ticket__r.Name,Service_Ticket__r.Brand_Name__c,Service_Ticket__r.Brand_Contact__c,Service_Ticket__r.Licensed_Premise__c ,Service_Ticket__r.Opportunity__c,
                                               Service_Ticket__r.Opportunity__r.Site_Name__c,Service_Ticket__r.Opportunity__r.Ownership__c,Service_Ticket__r.Opportunity__r.Payment_Terms__c,
                                               New_Packaged_Product__c ,Qty_Per_Multi_Unit__c, Retail_Wholesale_Price__c,Spl_Packaging_Notes__c  ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                                               Total_Desired_Retail_Ready_Form__c ,Total_Units__c ,UID__c, /*Final_Total_Labels_Qty__c,*/Transfer_of_Custody__c, Tamper_Type__c ,
                                               Qty_Label_Small__c , Qty_Label_Medium__c, Qty_Label_Large__c  
                                               FROM Service_Ticket_Line__c WHERE Id =: recordId];
        
        if(stllst.size() > 0){
            assign.stlobj  = stllst[0];  
        }
        assign.BQRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(TYPE_BUYQUOTE).getRecordTypeId();
        assign.bliRecordTypeId = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_BUYQOUTELINE).getRecordTypeId();
        
        //BQs = new List<Brand_Quote__c> ();
        List  <Brand_Quote__c>  BQs = [SELECT Id,Service_Ticket_Line__c,RecordTypeId FROM Brand_Quote__c where Service_Ticket_Line__c = :recordId AND RecordTypeId =:assign.BQRecordTypeId ];
        if(BQs.size()>0){
            r.data.put('BQs', BQs.size());
            return r;
        }
        
        if(assign.stlobj.Transfer_of_Custody__c == true){
            Brand_Quote__c newBQ = new Brand_Quote__c(
                RecordTypeId = assign.BQRecordTypeId,
                BQ_Status__c = STATUS_DRAFT,
                Order_Type__c = BQ_ORDER_TYPE_BRAND,
                Supplier_Name__c = assign.stlobj.Service_Ticket__r.Brand_Name__c,
                Supplier_Contact__c = assign.stlobj.Service_Ticket__r.Brand_Contact__c,
                // Supplier_License__c = stl.Service_Ticket__r.Licensed_Premise__c ,
                Customer_PO_or_Quote__c = assign.stlobj.Service_Ticket__r.Name+'-'+assign.stlobj.Name,
                Opportunity_Name__c  = assign.stlobj.Service_Ticket__r.Opportunity__c,
                Sales_Origin__c = BQ_SALES_ORIGIN_BRAND,
                Site__c = assign.stlobj.Service_Ticket__r.Opportunity__r.Site_Name__c,
                Ownership__c = assign.stlobj.Service_Ticket__r.Opportunity__r.Ownership__c,
                Requested_Transfer_Date__c = Date.valueOf(assign.stlobj.Service_Ticket__r.Request_Date_Time__c),
                Payment_Terms__c = assign.stlobj.Service_Ticket__r.Opportunity__r.Payment_Terms__c);
            List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
            if(defaultIDs.size() >0){
                if(defaultIDs[0].Default_Distributor__c != null)
                    newBQ.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
                newBQ.Receiver_Name__c  = defaultIDs[0].Default_Distributor__c;
                if(defaultIDs[0].Default_License__c != null)
                    newBQ.Distributor_License__c = defaultIDs[0].Default_License__c;
                newBQ.Receiver_License__c = defaultIDs[0].Default_License__c;
                if(defaultIDs[0].Default_Contact__c != null)
                    newBQ.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
            }
            newBQ.Service_Ticket_Line__c = assign.stlobj.Id;
            insert newBQ;
            assign.stlobj.Status__c = STL_STATUS_ACCEPTED;
            update assign.stlobj;
            
            Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                RecordTypeId =  assign.bliRecordTypeId,
                Brand_Quote_Number__c = newBQ.Id,
                Product_Name__c = assign.stlobj.New_Packaged_Product__c,
                Quantity_Cases__c = assign.stlobj.Total_Units__c  ,
                MOQ__c = 1,
                Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
            );
            for(PriceBookEntry pbe : [SELECT Id,Product2.Name,PriceBook2Id, UnitPrice FROM PriceBookEntry WHERE Product2Id = :assign.stlobj.New_Packaged_Product__c LIMIT 1]){
                bql.Price_Book__c = pbe.PriceBook2Id;
                bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
            }
            insert bql;
            message = ERR_MSG_APPROVED_BRAND_QUOTE;
            
        } else {
            Boolean statusBQ = assign.stlobj.Transfer_of_Custody__c;
            r.data.put('statusBQ',statusBQ);
            return r;
        }
        r.data.put('stlobj', assign.stlobj);
        r.data.put('BQs', BQs);
        return r; 
    }
    @AuraEnabled
    public static AuraResponse convertServiceQuote(String recordId){
        
        AuraResponse r = new AuraResponse('ConvertServiceTicketLineController.convertServiceQuote()');    
        ConvertServiceTicketLineController assignCS = new ConvertServiceTicketLineController();  
        
        assignCS.stlSEobj = new Service_Ticket_Line__c();
        
        List<Service_Ticket_Line__c> stllst   = [SELECT Id, Name,Brand_Quote__c/*,CRP_Required__c*/,Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                                                 Total_Label_Qty__c  , Package_Type__c,Status__c,Total_Converted_Cases__c ,Subtotal_Label_Qty__c,Service_Ticket__r.Request_Date_Time__c,
                                                 Per_Unit_Weight_g__c , Service_Ticket__c,Service_Ticket__r.Name,Service_Ticket__r.Opportunity__c,Service_Ticket__r.Licensed_Premise__c,
                                                 Service_Ticket__r.Opportunity__r.Site_Name__c,Service_Ticket__r.Opportunity__r.Ownership__c,Service_Ticket__r.Brand_Contact__c,Service_Ticket__r.Opportunity__r.AccountId,Service_Ticket__r.Opportunity__r.Payment_Terms__c,
                                                 New_Packaged_Product__c ,Qty_Per_Multi_Unit__c, Retail_Wholesale_Price__c,Spl_Packaging_Notes__c  ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                                                 Total_Desired_Retail_Ready_Form__c ,Total_Units__c ,UID__c,Converted_Single_Qty__c, /*Final_Total_Labels_Qty__c,*/Transfer_of_Custody__c, Tamper_Type__c,
                                                 Qty_Label_Large__c , Qty_Label_Medium__c  , Qty_Label_Small__c, Qty_of_Misc_Label__c, Total_Pre_Roll_Packs__c    
                                                 FROM Service_Ticket_Line__c WHERE Id =: recordId];
        
        if(stllst.size() > 0){
            assignCS.stlSEobj  = stllst[0];  
        }       
        assignCS.BQRecordTypeId =Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(TYPE_SERVICEQUOTE).getRecordTypeId();
        assignCS.bliRecordTypeId =Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get(BRANDQUOTELINERECORDTYPE_SERVICELINE).getRecordTypeId();
        
        List  <Brand_Quote__c>  BQsService = [SELECT Id,Service_Ticket_Line__c,RecordTypeId FROM Brand_Quote__c where Service_Ticket_Line__c = :recordId AND RecordTypeId =:assignCS.BQRecordTypeId ];
        
        if(BQsService.size()>0){
            r.data.put('BQsService', BQsService.size());
            return r;
        }
        Savepoint sp = Database.setSavepoint();
        try{
            Map<String,String> packageTypeConfigProductMap = new Map<String,String>();
            Map<String,Package_Type_Config__c> packageTypeConfigMap = Package_Type_Config__c.getAll();
            Set<String> serviceProducts = new Set<String>{PRODUCT_NAME_LABELING, PRODUCT_NAME_JARRING, PRODUCT_NAME_TESTING, PRODUCT_NAME_BAGGING, PRODUCT_NAME_PRE_ROLLING, PRODUCT_NAME_TAMPER_CLAMSHELL, PRODUCT_NAME_TAMPER_PROOF_LABEL, PRODUCT_NAME_TAMPER_SHRINK_BAND,PRODUCT_NAME_HEAT_SEAL, PRODUCT_NAME_LABEL_LARGE, PRODUCT_NAME_LABEL_MEDIUM, PRODUCT_NAME_LABEL_SMALL};
                for(String key: packageTypeConfigMap.keySet()){
                    serviceProducts.add(key);
                    Package_Type_Config__c PTC = packageTypeConfigMap.get(key);
                    packageTypeConfigProductMap.put(PTC.Package_Type__c+' '+PTC.Size__c,key);
                }    
            PriceBookEntry[] pbeList = [SELECT Id,Product2.Name,PriceBook2Id, UnitPrice FROM PriceBookEntry WHERE PriceBook2.Name =: FILIGREEN_ORIGINATED_SALES AND Product2.Name IN :serviceProducts];
            Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
            for(PriceBookEntry pbe: pbeList){
                pbeMap.put(pbe.Product2.Name,pbe);
            }
            Product2[] products = [SELECT Id, Name FROM Product2 WHERE Name IN :serviceProducts];
            Map<String,Product2> productMap = new Map<String,Product2>();
            for(Product2 p: Products){
                productMap.put(p.Name,p);
            }
            
            Brand_Quote_Line__c[] BQLines = new Brand_Quote_Line__c[]{};
                
                Brand_Quote__c newBQ = new Brand_Quote__c(
                    RecordTypeId =assignCS.BQRecordTypeId,
                    BQ_Status__c = STATUS_DRAFT,
                    Order_Type__c = BQ_ORDER_TYPE_BRAND,
                    Customer_PO_or_Quote__c = assignCS.stlSEobj.Service_Ticket__r.Name+'-'+assignCS.stlSEobj.Name,
                    Opportunity_Name__c  = assignCS.stlSEobj.Service_Ticket__r.Opportunity__c,
                    Receiver_Name__c  = assignCS.stlSEobj.Service_Ticket__r.Opportunity__r.AccountId,
                    Receiver_Contact__c = assignCS.stlSEobj.Service_Ticket__r.Brand_Contact__c,
                    Receiver_License__c  = assignCS.stlSEobj.Service_Ticket__r.Licensed_Premise__c,
                    Requested_Transfer_Date__c = Date.valueOf(assignCS.stlSEobj.Service_Ticket__r.Request_Date_Time__c),
                    Sales_Origin__c = BQ_SALES_ORIGIN_BRAND,
                    Site__c = assignCS.stlSEobj.Service_Ticket__r.Opportunity__r.Site_Name__c,
                    Payment_Terms__c = assignCS.stlSEobj.Service_Ticket__r.Opportunity__r.Payment_Terms__c);
            List<Company_Custom_Settings__c> defaultIDs = [select Default_Distributor__c,Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
            if(defaultIDs.size() >0)
            {
                if(defaultIDs[0].Default_Distributor__c != null){
                    newBQ.Distributor_Name__c = defaultIDs[0].Default_Distributor__c;
                    newBQ.Supplier_Name__c  = defaultIDs[0].Default_Distributor__c;
                    newBQ.Ownership__c = defaultIDs[0].Default_Distributor__c;
                }
                if(defaultIDs[0].Default_License__c != null){
                    newBQ.Distributor_License__c = defaultIDs[0].Default_License__c;
                    newBQ.Supplier_License__c  = defaultIDs[0].Default_License__c;
                }
                if(defaultIDs[0].Default_Contact__c != null)
                    newBQ.Distributor_Contact__c = defaultIDs[0].Default_Contact__c;
            }
            newBQ.Service_Ticket_Line__c = assignCS.stlSEobj.Id;
            insert newBQ;
            
            assignCS.stlSEobj.Status__c = STL_STATUS_ACCEPTED;
            update assignCS.stlSEobj;
            if(assignCS.stlSEobj.Tamper_Type__c != null && productMap.containsKey(assignCS.stlSEobj.Tamper_Type__c)){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = productMap.get(assignCS.stlSEobj.Tamper_Type__c).Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c,
                    MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                    bql.Quantity_Cases__c = assignCS.stlSEobj.Total_Pre_Roll_Packs__c;
                }
                if(pbeMap.containsKey(assignCS.stlSEobj.Tamper_Type__c)){
                    PriceBookEntry pbe = pbeMap.get(assignCS.stlSEobj.Tamper_Type__c);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
            }
            if(assignCS.stlSEobj.Qty_Label_Large__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_LARGE)){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_LARGE).Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c * assignCS.stlSEobj.Qty_Label_Large__c,
                    MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                    bql.Quantity_Cases__c = assignCS.stlSEobj.Total_Pre_Roll_Packs__c * assignCS.stlSEobj.Qty_Label_Large__c;
                }
                if(pbeMap.containsKey(PRODUCT_NAME_LABEL_LARGE)){
                    PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_LARGE);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
            }
            if(assignCS.stlSEobj.Qty_Label_Medium__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_MEDIUM).Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c * assignCS.stlSEobj.Qty_Label_Medium__c,
                    MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                    bql.Quantity_Cases__c = assignCS.stlSEobj.Total_Pre_Roll_Packs__c * assignCS.stlSEobj.Qty_Label_Medium__c;
                }
                if(pbeMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                    PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_MEDIUM);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
            }
            if(assignCS.stlSEobj.Qty_Label_Small__c > 0 && productMap.containsKey(PRODUCT_NAME_LABEL_SMALL)){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = productMap.get(PRODUCT_NAME_LABEL_SMALL).Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c * assignCS.stlSEobj.Qty_Label_Small__c,
                    MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                    bql.Quantity_Cases__c = assignCS.stlSEobj.Total_Pre_Roll_Packs__c * assignCS.stlSEobj.Qty_Label_Small__c;
                }
                if(pbeMap.containsKey(PRODUCT_NAME_LABEL_MEDIUM)){
                    PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABEL_SMALL);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
            }
            if(assignCS.stlSEobj.Qty_of_Misc_Label__c > 0 && productMap.containsKey(PRODUCT_NAME_LABELING)){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Product_Name__c = productMap.get(PRODUCT_NAME_LABELING).Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c * assignCS.stlSEobj.Qty_of_Misc_Label__c,
                    MOQ__c = 1,Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING || assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLL_PACKING){
                    bql.Quantity_Cases__c = assignCS.stlSEobj.Total_Pre_Roll_Packs__c * assignCS.stlSEobj.Qty_of_Misc_Label__c;
                }
                if(pbeMap.containsKey(PRODUCT_NAME_LABELING)){
                    PriceBookEntry pbe = pbeMap.get(PRODUCT_NAME_LABELING);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
                
            }
            if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_JARRING && (productMap.containsKey(PRODUCT_NAME_JARRING) || packageTypeConfigProductMap.containsKey(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c))){
                //stl.Total_Units__c*stl.Total_Label_Qty__c
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c,MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                String productName = '';
                if(packageTypeConfigProductMap.containsKey(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c)){
                    productName = packageTypeConfigProductMap.get(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c);
                    if(productMap.containsKey(productName)){
                        bql.Product_Name__c = productMap.get(productName).Id;
                    }
                }else if(productMap.containsKey(PRODUCT_NAME_JARRING)){
                    bql.Product_Name__c = productMap.get(PRODUCT_NAME_JARRING).Id;
                }
                if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_JARRING)){
                    PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_JARRING);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                
                BQLines.add(bql);
                
            }
            if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_BAGGING && (productMap.containsKey(PRODUCT_NAME_BAGGING) || packageTypeConfigProductMap.containsKey(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c))){
                //stl.Total_Units__c*stl.Total_Label_Qty__c
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c,MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                String productName = '';
                if(packageTypeConfigProductMap.containsKey(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c)){
                    productName = packageTypeConfigProductMap.get(assignCS.stlSEobj.Package_Type__c +' '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c);
                    if(productMap.containsKey(productName)){
                        bql.Product_Name__c = productMap.get(productName).Id;
                    }
                }else if(productMap.containsKey(PRODUCT_NAME_BAGGING)){
                    bql.Product_Name__c = productMap.get(PRODUCT_NAME_BAGGING).Id;
                }
                if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_BAGGING)){
                    PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_BAGGING);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
                
            }
            if(assignCS.stlSEobj.Package_Type__c == STL_PACKAGE_TYPE_PRE_ROLLING && (productMap.containsKey(PRODUCT_NAME_PRE_ROLLING) || packageTypeConfigProductMap.containsKey('Prerolling '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c))){
                //stl.Total_Units__c*stl.Total_Label_Qty__c
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c(
                    RecordTypeId =assignCS.bliRecordTypeId,
                    Brand_Quote_Number__c = newBQ.Id,
                    Quantity_Cases__c = assignCS.stlSEobj.Converted_Single_Qty__c,MOQ__c = 1,
                    Product_Title__c = BQL_PRODUCT_TITLE_DISTRIBUTOR
                );
                String productName = '';
                if(packageTypeConfigProductMap.containsKey('Prerolling '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c)){
                    productName = packageTypeConfigProductMap.get('Prerolling '+assignCS.stlSEobj.Desired_Retail_Ready_Form__c);
                    if(productMap.containsKey(productName)){
                        bql.Product_Name__c = productMap.get(productName).Id;
                    }
                }else if(productMap.containsKey(PRODUCT_NAME_PRE_ROLLING)){
                    bql.Product_Name__c = productMap.get(PRODUCT_NAME_PRE_ROLLING).Id;
                }
                if((String.isNotBlank(productName) && pbeMap.containsKey(productName)) || pbeMap.containsKey(PRODUCT_NAME_PRE_ROLLING)){
                    PriceBookEntry pbe = (String.isNotBlank(productName) && pbeMap.containsKey(productName))?pbeMap.get(productName):pbeMap.get(PRODUCT_NAME_PRE_ROLLING);
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    bql.Retail_Wholesale_Price__c = pbe.UnitPrice;
                }
                BQLines.add(bql);
            }
            if(!BQLines.isEmpty()){
                insert BQLines;
            }
        }      
        catch(Exception e){
            System.debug('###CSTLC Exception:'+e.getMessage());
            Database.rollback(sp);
            r.data.put('Exceptionmessage', e.getMessage());
            return r;
        }
        r.data.put('stlSEobj', assignCS.stlSEobj);
        return r;
    }
}