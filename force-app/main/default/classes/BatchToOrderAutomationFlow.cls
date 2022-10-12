global class BatchToOrderAutomationFlow implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    public static Boolean isBatchFinished = true;
    private Static String ORDER_TYPE_BRAND {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Brand');
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
    private static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    private static String SO_STATUS_DRAFT{
        get{
            return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private static String DL_ASR{
        get{
            return String.isNotBlank(DL_ASR) ? DL_ASR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
    private static String Org_Base_URL{
        get{
            return String.isNotBlank(Org_Base_URL) ? Org_Base_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Org_Base_URL');
        }set;
    }
    private static String SOLI_STATUS_BACKORDERED{
        get{
            return String.isNotBlank(SOLI_STATUS_BACKORDERED) ? SOLI_STATUS_BACKORDERED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Back_Ordered');
        }set;
    }
    private static String SOLI_STATUS_PARTIALLY_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_PARTIALLY_ALLOCATED) ? SOLI_STATUS_PARTIALLY_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Partially_Allocated');
        }set;
    }
    global Set<Id> orderIds ;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        isBatchFinished = false;
        return Database.getQueryLocator([SELECT id,Name,Order__c,Order__r.State_License__r.License_Name__c,Order__r.Retailer__c,Order__r.Retailer_Contact__r.AccountId,RecordType.DeveloperName FROM Opportunity WHERE Order__r.Order_Type__c = :ORDER_TYPE_BRAND AND Order__c IN : orderIds AND Order__r.Retailer__r.Auto_Order_Flow__c = true AND Order__r.Retailer__r.Hold__c = false]);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> records){
        if(records.size() > 0){
            Savepoint sp = Database.setSavepoint();
            Set<Id> oppIds = new Set<Id>();                        
            for(Opportunity opp : records){
                oppIds.add(opp.Id);
                AuraResponse r = SplitBQByProducerNameCtlr.splitBQByProducerName(opp.id,'');
                List<SplitBQByProducerNameCtlr.ProducerWrpr> wrp = (list<SplitBQByProducerNameCtlr.ProducerWrpr>) r.data.get('records');
                if(wrp != Null && wrp.size() > 0){
                    AuraResponse r1 = SplitBQByProducerNameCtlr.createQuoteRec(opp,wrp,False,'');
                }
                
            }
            if(oppIds.size()>0){
                List<Brand_Quote__c> bqList = [SELECT id,OwnerId,Supplier_Name__c,Opportunity_Name__r.Order__c,Supplier_License__c,Distributor_Contact__c,Distributor_Name__c,Ownership__r.Type FROM Brand_Quote__c WHERE Opportunity_Name__c IN : oppIds];
                System.debug('##bq'+bqList );
                if(bqList.size() > 0){
                    Set<Id> bqIds = new Set<Id>();
                    Set<string> recordTypeNames = new Set<string>();
                    Set<Id> distributorIds = new Set<Id>();  
                    Set<Id> supplierIds = new Set<Id>();
                    Map<String,String> odrIds = new Map<String,String>(); 
                    for(Brand_Quote__c bq : bqList){
                        bqIds.add(bq.Id);
                        recordTypeNames.add(bq.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE);
                        supplierIds.add(bq.Supplier_Name__c);
                        distributorIds.add(bq.Distributor_Name__c);
                        odrIds.put(bq.Supplier_Name__c,bq.Opportunity_Name__r.Order__c);
                    }
                    system.debug('##supplierIds:'+supplierIds);
                    System.debug('##recordTypeNames:'+recordTypeNames);
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
                    Set<Id> orderIds = new Set<Id>();
                    if(!statelicenses.isEmpty()){
                        for(Brand_Quote__c bq : bqList){
                            if(bq.Supplier_License__c == NULL && statelicenses.containsKey(bq.Supplier_Name__c)){
                                System.debug('##statelicenses'+statelicenses.get(bq.Supplier_Name__c)[0].id );
                                	bq.Supplier_License__c = statelicenses.get(bq.Supplier_Name__c)[0].id;
                            }else{
                                orderIds.add(odrIds.get(bq.Supplier_Name__c));
                            }
                         }
                    }else{
                        for(Brand_Quote__c bq : bqList){
                            orderIds.add(odrIds.get(bq.Supplier_Name__c));
                        }
                    }
                    if(!distributorContacts.isEmpty()){
                        for(Brand_Quote__c bq : bqList){
                            if(bq.Distributor_Contact__c == NULL){
                                System.debug('##Distributor_Contact__c'+distributorContacts.get(bq.Distributor_Name__c)[0].id );
                                bq.Distributor_Contact__c = distributorContacts.get(bq.Distributor_Name__c)[0].id;
                            }
                        }
                    }
                    if(!statelicenses.isEmpty() || !distributorContacts.isEmpty()){
                        try{
                            update bqList;
                            
                            for(Brand_Quote__c bq : bqList){
                                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();          
                                req.setComments('Submitting BQ Approval Request'); 
                                req.setObjectId(bq.id);  
                                req.setSubmitterId(bq.OwnerId); 
                                Approval.ProcessResult result = Approval.process(req);
                                System.debug('##BQ result :'+result);
                                if(result.isSuccess()){
                                    CreateSOfromQuote.createOrder(bq.id);
                                }
                            }
                            
                            boolean isDoneSOAllocationProcess = false;
                            for(Sales_Order__c so : [SELECT Id FROM Sales_Order__c WHERE Opportunity_Name__c IN :oppIds]){
                                AllocationProcessForSO.AllocationProcess(so.id);
                                isDoneSOAllocationProcess = true;
                            }
                            if(isDoneSOAllocationProcess){
                                submitForApproval(oppIds);
                            }
                        }catch(exception e){
                            Error_Log__c errorLog = ErrorLogs.AutomationFailedLog('OrderHelper', e.getStackTraceString(), e.getMessage());
                            if(orderIds.size()>0)
                            	sendAutomationFailedEmail(orderIds,errorLog);
                        }
                    }
                }
            }
            
        }
    }
    
    global void finish(Database.BatchableContext bc){
        isBatchFinished = true;
        for(CronTrigger c:[SELECT NextFireTime, CronJobDetail.Name, Id, State, StartTime, EndTime, CronExpression, TimesTriggered FROM CronTrigger WHERE TimesTriggered >= 1 AND CronJobDetail.Name LIKE 'ScheduledJob%']){
            System.abortJob(c.Id);
        }
    } 
    
    global void execute(SchedulableContext sc){}
    
    public static void submitForApproval(Set<Id> oppIds){ 
        
        List<Sales_Order__c> soList = [SELECT Id,BOPA__c,Name,Brand_Quote__r.OwnerId,Opportunity_Name__r.Order__c,
                                   (Select Id,Name,Status__c,
                                           RecordType.Name
                                    From Sales_Order_Lines__r) FROM Sales_Order__c WHERE Opportunity_Name__c IN :oppIds];
        if(soList.size() > 0 ){
            List<Sales_Order__c> BOPA_SOList = new List<Sales_Order__c>();
            Set<Id> False_BOPA_SOIds = new Set<Id>();
           Set<Id> Order_Ids = new Set<Id>();
            for(Sales_Order__c so : soList){
                Boolean isBOPA = false;
                for(Sales_Order_Line__c SOLI : so.Sales_Order_Lines__r){
                    if(SOLI.Status__c == SOLI_STATUS_BACKORDERED || SOLI.Status__c == SOLI_STATUS_PARTIALLY_ALLOCATED){
                       
                        isBOPA =true; 
                    }
                }
                
                
                if(isBOPA){
                    so.BOPA__c = true;
                    so.SO_Status__c =SO_STATUS_DRAFT;
                    BOPA_SOList.add(so);
                    Order_Ids.add(so.Opportunity_Name__r.Order__c);
                }else{
                    False_BOPA_SOIds.add(so.id);
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();          
                    req.setComments('Submitting SO Approval Request'); 
                    req.setObjectId(so.id);  
                    req.setSubmitterId(so.Brand_Quote__r.OwnerId); 
                    Approval.ProcessResult result = Approval.process(req);
                    System.debug('##SO result :'+result);
                }
                
            }
            if(BOPA_SOList.size()>0){
                update BOPA_SOList;
                Error_Log__c errorlog = ErrorLogs.AutomationFailedLog('OrderHelper', 'Order is partially allocated or back ordered', 'Order is partially allocated or back ordered');
                if(Order_Ids.size()>0)
                	sendAutomationFailedEmail(Order_Ids,errorlog);
            }
            if(False_BOPA_SOIds.size() >0 ){
                CreateInvoiceForSO(False_BOPA_SOIds);
            }
        }
    } 
    
    public static void CreateInvoiceForSO(Set<Id> False_BOPA_SOIds){
        List<Sales_Order__c> False_BOPA_SOList = [SELECT Id,BOPA__c,Name,
                                   Brand_Quote__c,Brand_Quote__r.OwnerId,
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
                                   Total_Weight_Fee__c , Supplier_Name__r.Service_Type__c,
                                     Total_Mileage_Fee__c  ,Ship_Confirmation_Date__c, 
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,RecordType.Name,
                                   Factoring_Assignee__c,Factoring_Contact__c,
                                   Factoring_Rate__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c,
                                   (Select Id,Name,Status__c,
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
                                           Is_Sample__c,
                                           Ownership_Code__c
                                    	   ,Pick_Pack_Fee__c,
                                    		QA_Review_Fee__c, Total_Weight_lbs__c,RecordType.Name,IsPromo__c
                                    From Sales_Order_Lines__r) FROM Sales_Order__c WHERE Id IN :False_BOPA_SOIds];
        if(False_BOPA_SOList.size() >0 ){
                for(Sales_Order__c so : False_BOPA_SOList){
                    List<CreateInvoiceController.SalesOrderLineWrapper> SOLI_Wrapper_List = new List<CreateInvoiceController.SalesOrderLineWrapper>();
                    for(Sales_Order_Line__c SOLI : so.Sales_Order_Lines__r){
                        CreateInvoiceController.SalesOrderLineWrapper soliWrapper = new CreateInvoiceController.SalesOrderLineWrapper(SOLI);
                        soliWrapper.isSelected =true;
                        soliWrapper.qtyToBill = SOLI.Qty_To_Invoiced__c;
                        SOLI_Wrapper_List.add(soliWrapper);
                    }
                    if(SOLI_Wrapper_List.size() >0){
                        CreateInvoiceController.createInvoiceAndLinesLight(so,SOLI_Wrapper_List);
                        if(so.Supplier_Name__r.Service_Type__c != 'Buy/Sell')
                        	FullfullmentServiceInvoiceController.createServiceInvoice(so.Id,false);
                    }
                }
            }
    }
    public static void sendAutomationFailedEmail(Set<Id> orderIds,Error_Log__c errorLog){
        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Order__c ord : [SELECT Id,Name,Request_Ship_Date__c,Requested_Delivery_Earliest_Time__c,Retailer_DBA__c,Account_DBA__c,Requested_Delivery_Latest_Time__c,Retailer__r.DBA__c,Retailer__r.ShippingAddress,Retailer_PO__c,Total_Product_Price__c,Total__c,Payment_Terms__c,Total_Excise_Tax_Amount__c,
                            Retailer_Contact__c,Retailer_Contact__r.email,Retailer_Contact__r.FirstName
                            FROM Order__c WHERE Id IN : orderIds]){
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setSubject('Order '+ord.Name +' from automation failed');
                                String htmlBody ='Order number:&nbsp;<b>'+ord.Name+'</b><br/>';
                                String Brand_DBA =ord.Account_DBA__c==null?'':ord.Account_DBA__c;
                                htmlBody +='Brand DBA:&nbsp;<b>'+Brand_DBA+'</b><br/>';
                               	htmlBody +='Receiver DBA:&nbsp;<b>'+ord.Retailer_DBA__c+'</b><br/>';
                                htmlBody +='Order amount:&nbsp;<b>$'+ord.Total__c+'</b><br/><br/>';
                                
                                htmlBody +='Error details:&nbsp;<b>'+errorLog.Additional_Information__c+'</b><br/><br/>';
                                htmlBody +='Error link:&nbsp;'+'<a href="'+Org_Base_URL+'/' + errorLog.Id +'" target="_blank">'+Org_Base_URL + '/' + ord.id +'</a>'+'<br/><br/>';
                                 
                                
                                htmlBody +='Order link:&nbsp;'+'<a href="'+Org_Base_URL+ '/' + ord.id +'" target="_blank">'+Org_Base_URL+ '/' + ord.id +'</a>'+'<br/><br/>';
                               
                                List<String> listOfToAddresses = new List<String>();
                                //listOfToAddresses.add(ord.Retailer_Contact__r.email);
                                if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                mail.setHtmlBody(htmlBody);
                                List<String> ccEmails = DL_ASR.split(',');//label.DL_ASR
                                //mail.setCcAddresses(ccEmails); 
                                mail.setSaveAsActivity(false);
                                mail.setToAddresses(ccEmails); 
                                mails.add(mail);  
                            }
        if(mails.size() > 0 && !test.isRunningTest()){
            Messaging.sendEmail(mails);
        }
    }
}