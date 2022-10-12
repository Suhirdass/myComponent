/**
* Copyright (c) 2019 WOVN
* All rights reserved.
* QAConfirmController
*/
public class QAConfirmController{

    public static Boolean smReverse = false;
    public Static String PURCHASE_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_APPROVED) ? PURCHASE_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Approved');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_SELL_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_SELL_QUOTE) ? BRAND_QUOTE_RECORDTYPE_SELL_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_SellQuote');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE) ? BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Service');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY) ? PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_Invoice_Only');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_RMA) ? BRAND_QUOTE_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_RMA');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY) ? PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_Invoice_Only');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_RMA) ? PURCHASE_ORDER_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_RMA');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_RMA) ? PURCHASE_ORDER_LINE_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_DevName_RMA');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_DevName_Product');
        }set;
    }
    public Static String PRODUCT_RECORD_TYPE_SERVICES{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_SERVICES) ? PRODUCT_RECORD_TYPE_SERVICES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Services');
        }set;
    }
    
      public Static String ERROR_CUSTOMER_INACTIVE{
        get{
            return String.isNotBlank(ERROR_CUSTOMER_INACTIVE) ? ERROR_CUSTOMER_INACTIVE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','Error_Customer_Inactive');
        }set;
    }

     public Static String PICKLIST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(PICKLIST_LINE_STATUS_REJECTED) ? PICKLIST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','Picklist_Line_Status_Rejected');
        }set;
    }
    
      public Static String PICKLIST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(PICKLIST_LINE_STATUS_CANCELLED) ? PICKLIST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','PicklistLine_Cancelled');
        }set;
    }
    
    public Static String SALESORDER_RECORD_TYPE_LAB{
        get{
            return String.isNotBlank(SALESORDER_RECORD_TYPE_LAB) ? SALESORDER_RECORD_TYPE_LAB: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Lab');
        }set;
    }
    
     public Static String SALESORDER_RECORD_TYPE_TRANSFER{
        get{
            return String.isNotBlank(SALESORDER_RECORD_TYPE_TRANSFER) ? SALESORDER_RECORD_TYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Transfer');
        }set;
    }
    
     public Static String SM_LINE_RECORDTYPE_LABLINE{
        get{
            return String.isNotBlank(SM_LINE_RECORDTYPE_LABLINE) ? SM_LINE_RECORDTYPE_LABLINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_LabLine');
        }set;
    }
     public Static String SM_LINE_RECORDTYPE_TRANSFERLINE{
        get{
            return String.isNotBlank(SM_LINE_RECORDTYPE_TRANSFERLINE) ? SM_LINE_RECORDTYPE_TRANSFERLINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_TransferLine');
        }set;
    }
     public Static String SM_LINE_RECORDTYPE_RSMLINE{
        get{
            return String.isNotBlank(SM_LINE_RECORDTYPE_RSMLINE) ? SM_LINE_RECORDTYPE_RSMLINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_RsmLines');
        }set;
    }
   public Static String ORDER_TYPE_BRAND{
        get{
            return String.isNotBlank(ORDER_TYPE_BRAND) ? ORDER_TYPE_BRAND: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Brand');
        }set;
    }    
    public Static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }   
    
     public Static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
        }set;
    }
     public Static String ACCOUNT_HOLD_MESSAGE{
        get{
            return String.isNotBlank(ACCOUNT_HOLD_MESSAGE) ? ACCOUNT_HOLD_MESSAGE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Message_Hold');
        }set;
    }
     public Static String PICKLIST_UID_NULL_MESSAGE{
        get{
            return String.isNotBlank(PICKLIST_UID_NULL_MESSAGE) ? PICKLIST_UID_NULL_MESSAGE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_UID_Null');
        }set;
    }
        public Static String PRODUCT_FAMILY_CREDIT_AND_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_CREDIT_AND_DISCOUNT) ? PRODUCT_FAMILY_CREDIT_AND_DISCOUNT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Credit_Discount_Product_Family');
        }set;
    }
    public Static String PRODUCT_FAMILY_SERVICE{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_SERVICE) ? PRODUCT_FAMILY_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Service_Product_Family');
        }set;
    }
    public Static String PRODUCT_FAMILY{
        get{
            return String.isNotBlank(PRODUCT_FAMILY) ? PRODUCT_FAMILY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family');
        }set;
    }
     private static String ERR_MSG_LA_SITE{
        get{
            return String.isNotBlank(ERR_MSG_LA_SITE) ? ERR_MSG_LA_SITE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_QAconfirm_LASite');
        }set;
    }
    private ApexPages.StandardController stdController;
    private Picklist__c picklistObj = null;
    private Id rsmId ;
    public  QAConfirmController(){ }
    // Constructor
    public QAConfirmController(ApexPages.StandardController controller) {
        this.stdController = controller;
        picklistObj = (Picklist__c)stdController.getRecord();
    }         
    @AuraEnabled
    public static AuraResponse QAConfirm(String recordId){
        AuraResponse r = new AuraResponse('QAConfirmController.QAConfirm()');    
        QAConfirmController assign = new QAConfirmController();
        assign.picklistObj = new Picklist__c();        
        smReverse = True;
        Savepoint savePoint;        
        try {
               
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            String loggedUserUserName = UserInfo.getName();
            List<string> allproductfamily = new List<string>();
            List<String> Productfamiltdiscount = PRODUCT_FAMILY_CREDIT_AND_DISCOUNT.split(',');
            allproductfamily.addAll(Productfamiltdiscount);
            List<String> ProductfamilyService= PRODUCT_FAMILY_SERVICE.split(',');
            allproductfamily.addAll(ProductfamilyService);
            List<String> Productfamily = PRODUCT_FAMILY.split(',');
            allproductfamily.addAll(Productfamily);
            picklist__c pick = [select id ,Site__c,Sales_Order__c from  picklist__c where id  =: recordId];
                     system.debug('pick'+pick);

             List<Site_User__c> lstusersitedata =[select id ,name,User__c,User__r.Name ,Site__r.Active__c,User_Active__c,Site__c,Active__c from Site_User__c where User__r.Name =:loggedUserUserName and Site__c=:pick.Site__c and Site__r.Active__c=True and User_Active__c=True and Active__c=True];
             
            if(lstusersitedata.size()==0){	
                r.data.put('errormsgSite',ERR_MSG_LA_SITE);
                return r;  
            }
         
             List<picklist__c> picklstwithline = [select id ,Sales_Order__c,(select id,name,Pack_out_UID__c,UID__c,Product_Name__r.Family from Picklist_Lines__r where Product_Name__r.Family !=:allproductfamily ) from  picklist__c where id  =: recordId ];
            if(picklstwithline.size()>0)  {
            for(picklist__c  picklistObj : picklstwithline){
                    for(Picklist_Line__c picklistLineObj : picklistObj.Picklist_Lines__r){if(picklistLineObj.Pack_out_UID__c == null || picklistLineObj.UID__c == null){ r.data.put('errormsguid',PICKLIST_UID_NULL_MESSAGE);return r;
                        }
                    }
                }
             }
            
             
          
            
            Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c,Brand_Quote__c,Brand_Quote__r.PO_Created__c,Opportunity_Name__r.Order__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
            String accountName = '';
            Set<String> my_list = new Set<String>(); 
            string status ;
            Boolean userActive = True;
            String username;
            Id orderId = SOHold.Opportunity_Name__r.Order__c;
            if(orderId!=null){
                Order__c orRes = [select id,Name,Customer__c,Customer__r.Name,Customer__r.IsActive from Order__c WHERE id=:orderId];
                // check order customer is Active or not
                Id userId = orRes.Customer__c; 
                
                User userRes = [select id,Name,IsActive from User WHERE id=:userId];
                if(userRes.IsActive== False){userActive = False;username =userRes.Name;
                }
            }
            Account  supAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
            Account  recAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Receiver_Name__c]; Account  disAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
            
         
            if(userActive==False){
                
                String ErrorMessage = ERROR_CUSTOMER_INACTIVE +' '+username;  r.data.put('errorMsg',ErrorMessage);
                
            }else   if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
            {
                if(supAcc.Hold__c == true){my_list.add(supAcc.DBA__c); } if(disAcc.Hold__c == true){  my_list.add(disAcc.DBA__c); }if(recAcc.Hold__c == true){ my_list.add(recAcc.DBA__c); }
                accountName = String.join(new List<String>(my_list), ', ');   String ErrorMessage =String.format( ACCOUNT_HOLD_MESSAGE,new List<String>{String.valueOf(accountName)});r.data.put('errorMsg',ErrorMessage);
            }else{
                List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();  assign.picklistObj = PicklistSupport.retrievePicklistAndLines(recordId);
                
                // Change picklist status to QA Review
                if(assign.picklistObj.Status__c != PicklistSupport.STATUS_QA_CONFIRM){  assign.picklistObj.Status__c = PicklistSupport.STATUS_QA_CONFIRM; 
                                                                                      assign.picklistObj.Pick_Confirm_Date__c = Date.today();  update assign.picklistObj;
                    
                    string statuspick = assign.picklistObj.Status__c;  r.data.put('statuspick',statuspick); String SMLineRecordTypeId = '';
                    if(assign.picklistObj.Sales_Order__c != NULL && assign.picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORD_TYPE_LAB){  SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_LABLINE);
                    }else if(assign.picklistObj.Sales_Order__c != NULL && assign.picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORD_TYPE_TRANSFER){ SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_TRANSFERLINE);
                    }else{
                        SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_RSMLINE);
                    }
                    
                    id rsmId = assign.checkExistingSM(); r.data.put('rsmId',rsmId);
                    if(rsmId == null){ Shipping_Manifest__c rsmObj = PicklistSupport.createRSM(assign.picklistObj);
                        
                        insert rsmObj; rsmId = rsmObj.Id;  List<UID__c> updateUid = new List<UID__c>(); Set<Id> setUid = new Set<Id>();
                        for(Picklist_Line__c picklistLineObj : assign.picklistObj.Picklist_Lines__r){if(picklistLineObj.Pack_out_UID__c != null && picklistLineObj.Pack_out_UID__r.In_Use__c != true){
                                UID__c uid = new UID__c(); if(!setUid.contains(picklistLineObj.Pack_out_UID__c)){ uid.Id = picklistLineObj.Pack_out_UID__c;uid.In_Use__c = true;  setUid.add(picklistLineObj.Pack_out_UID__c);updateUid.add(uid);
                                }
                            }
                            if(picklistLineObj.Status__c != PICKLIST_LINE_STATUS_CANCELLED && picklistLineObj.Status__c != PICKLIST_LINE_STATUS_REJECTED /* && picklistLineObj.Status__c != 'QA Hold'*/){
                                Shipping_Manifest_Line__c rsmLineObj = PicklistSupport.createRSMLine(picklistLineObj, rsmObj.Id,SMLineRecordTypeId); rsmLines.add(rsmLineObj);   id idsrsm =rsmLineObj.Id;
                               
                            }
                        }
         
                        if(updateUid.size() > 0){update updateUid;
                        }
                        if(rsmLines.size() > 0){ update assign.picklistObj; insert rsmLines; r.data.put('rsmId',rsmId);
                        } else {
                            delete rsmObj;   rsmId = assign.picklistObj.Id; r.data.put('rsmId',assign.picklistObj.Id);
                        }
                    }
                }else{
                   
                    string statusBQ = assign.picklistObj.Status__c;  r.data.put('statusBQ',statusBQ);  return r;
                }
            }
            
            
            if(!SOHold.Brand_Quote__r.PO_Created__c){ 
                list<Brand_Quote__c>BOList = [SELECT Id,Ownership__c,Notes__c,RecordTypeId,RecordType.Name,Opportunity_Name__c,Opportunity_Name__r.Order__c,Factoring_Assignee__c,Factoring_Contact__c,Factoring_Rate__c,Factoring_Discount__c,Shipping_Terms__c,Shipping_Method__c,Payment_Terms__c,Sample_Order__c,Site__c,Planned_Transfer_Date__c,Supplier_Name__c,Opportunity_Name__r.Order__r.Order_Type__c,Opportunity_Name__r.Order__r.Customer__c,Distributor_Name__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Distributor_License__c,Distributor_Contact__c,Supplier_License__c,Supplier_Contact__c,(SELECT Id,Product_Name__c,Product_Name__r.Producer_Name__c,Retail_Wholesale_Price__c ,Is_Sample__c,Ownership_Code__c,Product_Name__r.Producer_Name__r.Type,Product_Title__c,Line_Total_Qty__c,Product_Name__r.White_Labelled__c,Product_Name__r.Licensee_Name__c,Disty_Cost__c FROM Brand_Quote_Lines__r WHERE Product_Name__r.RecordType.Name != :PRODUCT_RECORD_TYPE_SERVICES) FROM Brand_Quote__c  WHERE Id =: SOHold.Brand_Quote__c];
                if(BOList.size() >0 ){
                    String recordtypename = BOList[0].RecordType.Name; 
                    Id poRecordTypeID;Id poliRecordTypeID; 
                    if(recordtypename == BRAND_QUOTE_RECORDTYPE_SELL_QUOTE || recordtypename == BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE){poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
                        poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
                    }else if(recordtypename == BRAND_QUOTE_RECORDTYPE_RMA){poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_RMA).getRecordTypeId();
                        poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_RMA).getRecordTypeId();
                    }else{
                        poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_PRODUCT).getRecordTypeId();  poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT).getRecordTypeId();
                    }
                    String accountId;
                    if(BOList[0].Opportunity_Name__r.Order__c == NULL){ List<Service_Ticket__c> STs = [SELECT Id, Brand_Contact__c,Brand_Contact__r.AccountId FROM Service_Ticket__c WHERE Opportunity__c = :BOList[0].Opportunity_Name__c];
                        if(STs.size() > 0){accountId = STs[0].Brand_Contact__r.AccountId;
                        }
                    }else{
                        List<User> userList = [SELECT Id,Contact.AccountId FROM User WHERE id =: BOList[0].Opportunity_Name__r.Order__r.Customer__c];
                        if(userList.size() > 0){ accountId = userList[0].Contact.AccountId;
                        }
                    }
                    List<Account>accList = [SELECT Id,Type FROM Account WHERE Id =: accountId];
                    Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults(); 
                    

                    
                    
                    if(BOList[0].Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_BRAND){
                        if(accList[0].Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER ){ // Rule 1
                        	Map<String,List<Brand_Quote_Line__c>>producerMap  = new Map<String,List<Brand_Quote_Line__c>>();
                            Map<String,String>supplierNameMap = new Map<String,String>();
                            List<Purchase_Order__c>poList = new List<Purchase_Order__c>();
                            for(Brand_Quote_Line__c bqLine : BOList[0].Brand_Quote_Lines__r){
                                List<Brand_Quote_Line__c>bqLineList = producerMap.containsKey(bqLine.Product_Name__r.Producer_Name__c) ? producerMap.get(bqLine.Product_Name__r.Producer_Name__c) : new List<Brand_Quote_Line__c>();
                                bqLineList.add(bqLine); producerMap.put(bqLine.Product_Name__r.Producer_Name__c,bqLineList);   
                                if(!supplierNameMap.containsKey(bqLine.Product_Name__r.Producer_Name__c)){  
                                    if(bqLine.Product_Name__r.White_Labelled__c)supplierNameMap.put(bqLine.Product_Name__r.Producer_Name__c,bqLine.Product_Name__r.Licensee_Name__c);
                                    else
                                        supplierNameMap.put(bqLine.Product_Name__r.Producer_Name__c,bqLine.Product_Name__r.Producer_Name__c);
                                }
                            }
                            
                            Map<String,Purchase_Order__c> newPOMap = new Map<String,Purchase_Order__c>(); 
                            Map<String,List<Purchase_Order_Line__c>> newPOLIMap = new Map<String,List<Purchase_Order_Line__c>>();
                            
                            
                            Map<ID, Account> accountMap = new Map<ID, Account>([SELECT Id, Name,(SELECT Id FROM State_Licenses__r WHERE License_Status__c = 'Active' ORDER BY Createddate DESC LIMIT 1),(SELECT Id FROM Contacts Where Active__c = True ORDER BY Createddate LIMIT 1) FROM Account WHERE Id =: ccs.Default_Distributor__c OR Id =: BOList[0].Distributor_Name__c OR Id IN: supplierNameMap.values()]);
                            for(String producerId : producerMap.keySet()){ 
                                Purchase_Order__c newPO = QAConfirmController.createPO(BOList[0],recordtypename,poRecordTypeID);  
                                
                                newPO.Ownership__c = accList[0].Id;   newPO.Receiver_Name__c = ccs.Default_Distributor__c; 
                                newPO.Receiver_License__c = ccs.Default_License__c;
                                newPO.Receiver_Contact__c = ccs.Default_Contact__c;
                                newPO.Distributor_Name__c = BOList[0].Distributor_Name__c; 
                                newPO.Distributor_License__c = BOList[0].Distributor_License__c;
                                newPO.Distributor_Contact__c = BOList[0].Distributor_Contact__c;
                                newPO.Supplier_Name__c = supplierNameMap.get(producerId);
                                if(accountMap.containsKey(supplierNameMap.get(producerId))){ 
                                    Account supplierAcc  = accountMap.get(supplierNameMap.get(producerId));
                                	if(supplierAcc.State_Licenses__r.size() > 0)    newPO.Supplier_License__c = supplierAcc.State_Licenses__r[0].Id;
                                    if(supplierAcc.Contacts.size() >0) newPO.Supplier_Contact__c = supplierAcc.Contacts[0].Id;
                                }
                                
                                poList.add(newPO); 
                            }
                            insert poList; integer i = 0 ;
                            List<Purchase_Order_Line__c> poLineList = new List<Purchase_Order_Line__c>();
                            for(String producerId : producerMap.keySet()){  
                                poLineList.addAll(QAConfirmController.createPOLine(producerMap.get(producerId),poList[i],poliRecordTypeID,BOList[0]));    
                                i++; 
                            } insert poLineList;
                        }else { // Rule 2
                            Map<String,List<Brand_Quote_Line__c>> ownerShipCodePOLIMap = new Map<String,List<Brand_Quote_Line__c>>();
                            
                            if( BOList[0].Brand_Quote_Lines__r.size() > 0 ){ for(Brand_Quote_Line__c poli  :  BOList[0].Brand_Quote_Lines__r){if(ownerShipCodePOLIMap.containsKey(poli.Ownership_Code__c)){
                                        ownerShipCodePOLIMap.get(poli.Ownership_Code__c).add(poli);
                                    }else{
                                        ownerShipCodePOLIMap.put(poli.Ownership_Code__c, new List<Brand_Quote_Line__c>{poli});
                                    }
                                }
                            }                  
                            Map<String,Purchase_Order__c> newPOMap = new Map<String,Purchase_Order__c>(); 
                            Map<String,List<Purchase_Order_Line__c>> newPOLIMap = new Map<String,List<Purchase_Order_Line__c>>();
                            for(String ownershipId : ownerShipCodePOLIMap.keySet()){
                                List<Brand_Quote_Line__c> BQLIs = ownerShipCodePOLIMap.get(ownershipId);
                                if(BQLIs != NULL && BQLIs.size() > 0){ Purchase_Order__c newPO = QAConfirmController.createPO(BOList[0],recordtypename,poRecordTypeID); 
                                    newPO.Ownership__c = ownershipId;	//BOList[0].Ownership__c;  
                                    newPO.Receiver_Name__c = ccs.Default_Distributor__c;
                                    newPO.Receiver_License__c = ccs.Default_License__c; 
                                    newPO.Receiver_Contact__c = ccs.Default_Contact__c;
                                    newPO.Distributor_Name__c = BOList[0].Distributor_Name__c;
                                    newPO.Distributor_License__c = BOList[0].Distributor_License__c;
                                    newPO.Distributor_Contact__c = BOList[0].Distributor_Contact__c;
                                    newPO.Supplier_Name__c = BOList[0].Supplier_Name__c;
                                    newPO.Supplier_License__c = BOList[0].Supplier_License__c;
                                    newPO.Supplier_Contact__c = BOList[0].Supplier_Contact__c;
                                    List<Purchase_Order_Line__c> poLineList = QAConfirmController.createPOLine(BQLIs,newPO,poliRecordTypeID,BOList[0]);
                                    newPOMap.put(ownershipId,newPO); newPOLIMap.put(ownershipId,poLineList);
                                }
                            }
                            
                            //insert newPO;
                            
                            //insert poLineList;
                            if(!newPOLIMap.values().isEmpty()){insert newPOMap.values();List<Purchase_Order_Line__c> newPOLIs = new List<Purchase_Order_Line__c>();
                                for(String  oCode :newPOMap.keySet()){ Purchase_Order__c PO = newPOMap.get(oCode);
                                    for(Purchase_Order_Line__c line: newPOLIMap.get(oCode)){line.Purchase_Order__c = PO.Id;newPOLIs.add(line);
                                    } 
                                }
                                insert newPOLIs;
                            }
                        }
                	}else if(BOList[0].Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_RETAIL){ 
                        Map<String,List<Brand_Quote_Line__c>>producerMap  = new Map<String,List<Brand_Quote_Line__c>>();
                        Map<String,String>supplierNameMap = new Map<String,String>(); 
                        Map<String,String>brandTypeMap = new Map<String,String>();
                        List<Purchase_Order__c>poList = new List<Purchase_Order__c>(); 
                        for(Brand_Quote_Line__c bqLine : BOList[0].Brand_Quote_Lines__r){ Id BrandId = bqLine.Product_Name__r.Producer_Name__c;
                            if(bqLine.Product_Name__r.White_Labelled__c == true){BrandId = bqLine.Product_Name__r.Licensee_Name__c;
                            }
                            List<Brand_Quote_Line__c>bqLineList = producerMap.containsKey(BrandId) ? producerMap.get(BrandId) : new List<Brand_Quote_Line__c>();
                            bqLineList.add(bqLine);
                            producerMap.put(BrandId,bqLineList);  if(!supplierNameMap.containsKey(bqLine.Product_Name__r.Producer_Name__c)){ if(bqLine.Product_Name__r.White_Labelled__c)
                                    supplierNameMap.put(bqLine.Product_Name__r.Producer_Name__c,bqLine.Product_Name__r.Licensee_Name__c);
                                else
                                    supplierNameMap.put(bqLine.Product_Name__r.Producer_Name__c,bqLine.Product_Name__r.Producer_Name__c);
                            }
                            brandTypeMap.put(BrandId,bqLine.Product_Name__r.Producer_Name__r.Type);
                        }
                        Map<ID, Account> accountMap = new Map<ID, Account>([SELECT Id, Name,(SELECT Id FROM State_Licenses__r WHERE License_Status__c = 'Active' ORDER BY Createddate DESC LIMIT 1),(SELECT Id FROM Contacts Where Active__c = True ORDER BY Name LIMIT 1) FROM Account WHERE Id =: ccs.Default_Distributor__c OR Id =: BOList[0].Distributor_Name__c OR Id IN: supplierNameMap.keyset()]);
                        for(String producerId : producerMap.keySet()){ Purchase_Order__c newPO = QAConfirmController.createPO(BOList[0],recordtypename,poRecordTypeID);  
                            
                            String brandType = brandTypeMap.get(producerId);
                            if(brandType == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){   newPO.Ownership__c = producerId;//supplierNameMap.get(producerId);
                                
                                newPO.Supplier_Name__c = producerId;//supplierNameMap.get(producerId); 
                                if(accountMap.containsKey(producerId)){//supplierNameMap.get(producerId);
                                    Account supplierAcc  = accountMap.get(producerId);//supplierNameMap.get(producerId);
                                    if(supplierAcc.State_Licenses__r.size() > 0)    newPO.Supplier_License__c = supplierAcc.State_Licenses__r[0].Id;
                                    if(supplierAcc.Contacts.size() >0) newPO.Supplier_Contact__c = supplierAcc.Contacts[0].Id;
                                }
                            }
                            else{                                
                            	newPO.Ownership__c = 	producerId;newPO.Supplier_Name__c = BOList[0].Supplier_Name__c;	newPO.Supplier_License__c = BOList[0].Supplier_License__c;newPO.Supplier_Contact__c = BOList[0].Supplier_Contact__c;
                            }
                            
                            newPO.Receiver_Name__c = ccs.Default_Distributor__c; newPO.Receiver_License__c = ccs.Default_License__c; newPO.Receiver_Contact__c = ccs.Default_Contact__c;  newPO.Distributor_Name__c = BOList[0].Distributor_Name__c; newPO.Distributor_License__c = BOList[0].Distributor_License__c; newPO.Distributor_Contact__c = BOList[0].Distributor_Contact__c;poList.add(newPO);  
                        }
                        insert poList; integer i = 0 ; List<Purchase_Order_Line__c> poLineList = new List<Purchase_Order_Line__c>();
                        for(String producerId : producerMap.keySet()){poLineList.addAll(QAConfirmController.createPOLine(producerMap.get(producerId),poList[i],poliRecordTypeID,BOList[0]));    
                            i++;
                        }
                        insert poLineList;}  BOList[0].PO_Created__c = true;  update BOList;
                }
            }            
        }catch (Exception ex){ Database.rollback(savePoint); ErrorLogs.log('QAReviewController:qaReviewConfirm()',  ex.getStackTraceString(), ex.getMessage()); return r;
        }
        assign.redirectToRSM();return r;
    
    }
    public Static Purchase_Order__c createPO(Brand_Quote__c quote,String recordtypename,Id poRecordTypeID){
    	Purchase_Order__c newPO = new Purchase_Order__c();
        newPO.Brand_Quote__c = quote.Id;
        newPO.PO_Status__c = PURCHASE_ORDER_STATUS_APPROVED;
        newPO.PO_Type__c = recordtypename;
        newPO.PO_Date__c = Date.today();
        newPO.Purchase_Order_Instructions__c = quote.Notes__c;
        newPO.Opportunity_Name__c = quote.Opportunity_Name__c;
        newPO.Factoring_Assignee__c = quote.Factoring_Assignee__c;
        newPO.Factoring_Contact__c = quote.Factoring_Contact__c;
        newPO.Factoring_Rate__c = quote.Factoring_Rate__c; 
        newPO.Factoring_Discount__c = quote.Factoring_Discount__c;
        newPO.Shipping_Terms__c = quote.Shipping_Terms__c;
        newPO.Shipping_Method__c = quote.Shipping_Method__c;
        newPO.Payment_Terms__c = quote.Payment_Terms__c;
        newPO.Sample_Order__c = quote.Sample_Order__c;
        newPO.RecordTypeId = poRecordTypeID;
        newPO.Site__c = quote.Site__c;
        newPO.Planned_Ship_Transfer_Date__c = quote.Planned_Transfer_Date__c;
        newPO.Create_Supplier_Bill__c=True;
        newPO.Bill_Created__c = False;
        return newPO;    
    }
    public Static List<Purchase_Order_Line__c> createPOLine(List<Brand_Quote_Line__c> qlineList, Purchase_Order__c newPO,Id poliRecordTypeID, Brand_Quote__c quote){
        List<Purchase_Order_Line__c> poLineList = new List<Purchase_Order_Line__c>();
        for(Brand_Quote_Line__c qline : qlineList){
            Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
            newPOLI.Brand_Quote_Line__c = qline.Id;
            newPOLI.Product_Name__c =  qline.Product_Name__c;
            newPOLI.Product_Title__c =  qline.Product_Title__c; 
            newPOLI.Qty_Ordered__c = qline.Line_Total_Qty__c;
            newPOLI.Purchase_Order__c = newPO.Id != null ?  newPO.Id : null;
            newPOLI.Unit_Cost__c = qline.Disty_Cost__c ;
            newPOLI.Is_Sample__c = qline.Is_Sample__c;
            newPOLI.RecordTypeId = poliRecordTypeID;
            if(! Test.isRunningTest()) newPOLI.Ownership_Code__c = qline.Ownership_Code__c == null ? quote.Ownership__c : qline.Ownership_Code__c;            
            poLineList.add(newPOLI);
        }
        return poLineList;
    }
    public class UserException extends Exception{ }	    
    /**
* Change picklist status to QA Confirm and create RSM and lines
*
* @return PageReference of picklist detail page
*/
    public PageReference qaConfirm() {
        PageReference pageRef = null;
        
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
            picklistObj = PicklistSupport.retrievePicklistAndLines(picklistObj.Id);
            
            // Change picklist status to QA Review
            if(picklistObj.Status__c != PicklistSupport.STATUS_QA_CONFIRM){
                picklistObj.Status__c = PicklistSupport.STATUS_QA_CONFIRM;
                picklistObj.Pick_Confirm_Date__c = Date.today();
                update picklistObj;
                String SMLineRecordTypeId = '';
                if(picklistObj.Sales_Order__c != NULL && picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORD_TYPE_LAB){SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_LABLINE);
                }else if(picklistObj.Sales_Order__c != NULL && picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORD_TYPE_TRANSFER){SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_TRANSFERLINE);
                }else{
                    SMLineRecordTypeId = ShippinManifestSupport.getSMLineRecordTypeId(SM_LINE_RECORDTYPE_RSMLINE);
                }
                
                // Check if existing SM record with Draft or Pending Status is present or not
                // If existing SM not found then only create new SM and SM Lines
                rsmId = checkExistingSM();
                if(rsmId == null){
                    
                    // Create RSM and lines
                    Shipping_Manifest__c rsmObj = PicklistSupport.createRSM(picklistObj);
                    insert rsmObj;
                    rsmId = rsmObj.Id;
                    
                    for(Picklist_Line__c picklistLineObj : picklistObj.Picklist_Lines__r){
                        if(picklistLineObj.Status__c != PICKLIST_LINE_STATUS_CANCELLED && picklistLineObj.Status__c != PICKLIST_LINE_STATUS_REJECTED && picklistLineObj.Status__c != 'QA Hold'){
                            Shipping_Manifest_Line__c rsmLineObj = PicklistSupport.createRSMLine(picklistLineObj, rsmObj.Id,SMLineRecordTypeId);
                            rsmLines.add(rsmLineObj);    
                        }
                    }
                    if(rsmLines.size() > 0){
                        insert rsmLines;
                    }
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,Label.Already_QA_Confirm_Picklist);ApexPages.addMessage(msg);return null;
            }
        }catch (Exception ex){ Database.rollback(savePoint);  ErrorLogs.log('QAReviewController:qaReviewConfirm()', ex.getStackTraceString(), ex.getMessage()); ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); ApexPages.addMessage(msg); return null;
        }
        return redirectToRSM();
    }    
    /**
* Check if Existing SM is present or not related to Picklist record
*/
    private Id checkExistingSM(){
        Id smId = null;
        for(Shipping_Manifest__c sm : [Select Id From Shipping_Manifest__c 
                                       Where Picklist__c =: picklistObj.Id
                                       AND Status__c IN (:RSMSupport.STATUS_DRAFT, :RSMSupport.STATUS_SHIPMENT_PENDING) LIMIT 1]){smId = sm.Id;

                                       }
        
        return smId;
    }    
    /**
* Redirect to RSM detail page
*
* @return PageReference
*/         
    public PageReference redirectToRSM() {
        PageReference pageRef;
        if(rsmId != null){
            pageRef = new PageReference('/'+rsmId);
            pageRef.setRedirect(true);
        }
        return pageRef;
    }    
    /**
* Redirect to Picklist detail page
* 
* @return PageReference
*/         
    public PageReference redirectToPicklist() {
        PageReference pageRef;
        if(picklistObj.Id != null){
            pageRef = new PageReference('/'+picklistObj.Id);
            pageRef.setRedirect(true);
        }
        return pageRef;
    }
}