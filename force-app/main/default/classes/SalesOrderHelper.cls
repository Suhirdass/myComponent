/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SalesOrderHelper
 */
public class SalesOrderHelper{
    public static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    private static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    private static String TYPE_ADD_RETAIL_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_RETAIL_CONTACT) ? TYPE_ADD_RETAIL_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Retail_Contact');
        }set;
    }
    private static String DL_ASR{
        get{
            return String.isNotBlank(DL_ASR) ? DL_ASR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
    private Static String SALESORDER_RECORDTYPE_Transfer {		
        get{
              return String.isNotBlank(SALESORDER_RECORDTYPE_Transfer) ? SALESORDER_RECORDTYPE_Transfer: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    public Static String PRODUCT_NAME_MILEAGE_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    public Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public Static String PICKLIST_OPEN{
        get{
            return String.isNotBlank(PICKLIST_OPEN) ? PICKLIST_OPEN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_Open');
        }set;
    }
    
    private static final String PICKLIST_STATUS_OPEN = PICKLIST_OPEN;
    private static final String SO_STATUS_APPROVED = SalesOrderSupport.SO_STATUS_APPROVED;  
    
    /**
     * Create Picklist and line records for Sales Orders based on Status value as Approved
     *
     * @param salesOrders The list of Sales Orders
     * @param oldSalesOrderMap The old trigger map of Sales Order
     */
    public Static void createDeletePickListAndLines(List<Sales_Order__c> salesOrders,
                                                    Map<Id, Sales_Order__c> oldSalesOrderMap){
        
        Set<Id> soIds = new Set<Id>();
        
        for(Sales_Order__c salesOrderObj : salesOrders){
        
            Sales_Order__c oldSO = oldSalesOrderMap.get(salesOrderObj.Id);
            
            // Check old SO Status should not be Approved
            // if current SO Status equals Approved then create picklist and lines
			string recordtypename = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosById().get(salesOrderObj.RecordTypeId).getname();

            if(salesOrderObj.SO_Status__c == SO_STATUS_APPROVED && oldSO.SO_Status__c != SO_STATUS_APPROVED && recordtypename != 'Services'){
                soIds.add(salesOrderObj.Id);
            }
        }
        
        // Create picklist and lines
        if(soIds.size() > 0){
            
            // Check if existing picklist present then delete them
            deletePickListAndLines(soIds);
            createPickListAndLines(soIds);
        }
    }
    
    /**
     * Create Picklist and line records
     *
     * @param soIds The set of Sales Order Ids
     */
    public Static void createPickListAndLines(Set<Id> soIds){
        
        Set<Id> soLineIds = new Set<Id>();
        List<Sales_Order__c> salesOrderList = new List<Sales_Order__c>();
        List<Picklist__c> picklists = new List<Picklist__c>();
        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
        Map<Id, Id> picklistIdBySOId = new Map<Id, Id>();
        
        salesOrderList = [Select Site__c,Sales_Order_Instructions__c, 
                           (Select Sales_Order__c,Id,Product_Name__c
                            From Sales_Order_Lines__r Order By Id)
                     From Sales_Order__c where Id IN: soIds];
        
        Map<Id,Inventory_Position__c[]> salesOrderInventoryMap = new Map<Id,Inventory_Position__c[]>();
        
        for(Inventory_Position__c invPositionObj : [SELECT Sales_Order_Line__c,
                                                    Sales_Order_Line__r.IsPromo__c,
                                                         Sales_Order_Line__r.Sales_Order__c,
                                                         Sales_Order_Line__r.Ownership_Code__c,
                                                         Sales_Order_Line__r.Product_Name__c,
                                                    	 Sales_Order_Line__r.Is_Sample__c,Qty_Allocated__c
                                                     FROM Inventory_Position__c 
                                                     Where Sales_Order_Line__r.Sales_Order__c IN: soIds]){
            if(salesOrderInventoryMap.containsKey(invPositionObj.Sales_Order_Line__r.Sales_Order__c)){
                salesOrderInventoryMap.get(invPositionObj.Sales_Order_Line__r.Sales_Order__c).add(invPositionObj);
            }else{
                salesOrderInventoryMap.put(invPositionObj.Sales_Order_Line__r.Sales_Order__c,new Inventory_Position__c[]{invPositionObj});
            }
        		                                             
        }
            
        
        if(salesOrderInventoryMap.size() > 0){
            // Iterate on all Sales Orders and create picklist
            for(Sales_Order__c soObj : salesOrderList){
                if(salesOrderInventoryMap.containsKey(soObj.Id)){
                    Picklist__c picklistObj = createPicklist(soObj);
                    picklists.add(picklistObj);
                    // Add all SO line Ids
                    for(Sales_Order_Line__c soLineObj : soObj.Sales_Order_Lines__r){
                        soLineIds.add(soLineObj.Id);
                    }
                }
                
            }
            
            // Create picklists
            insert picklists;
            
            // Create map of picklist Id by SO Id
            for(Picklist__c picklistObj : picklists){
                picklistIdBySOId.put(picklistObj.Sales_Order__c, picklistObj.Id);
            }
            
            for (String salesOrderId : salesOrderInventoryMap.keySet()){
                Id picklistId = picklistIdBySOId.get(salesOrderId);
                Inventory_Position__c[] IPrecs = salesOrderInventoryMap.get(salesOrderId);
                if(!IPrecs.isEmpty()){
                    for(Inventory_Position__c IP: IPrecs){
                        Picklist_Line__c picklistLineObj = createPicklistLine(IP, picklistId);
                        picklistLines.add(picklistLineObj);
                    }
                }
                    
            }
            // Create picklist lines
            if(!picklistLines.isEmpty()) insert picklistLines; 
            
        }
    }
    
    public static void updateTotalMileageFeeOnSO(List<Sales_Order__c> salesOrders,Map<Id,Sales_Order__c>oldMap){
        Set<Sales_Order__c>SOSiteUpdated = new Set<Sales_Order__c>();
        for(Sales_Order__c SO: salesOrders){
            if(SO.Site__c != NULL && SO.Site__c != oldMap.get(SO.Id).Site__c){
                SOSiteUpdated.add(SO);
            }
        }
        if(SOSiteUpdated.size() > 0){
            for(Sales_Order__c SO: SOSiteUpdated){
                getTotalMilesAndUpdateSO(SO.Id);
            }
        }
    }
    @future(callout=true)
    public static void getTotalMilesAndUpdateSO(String SOId){
        Sales_Order__c SO = [SELECT Id, Name,Brand_Quote__c,Opportunity_Name__c,Opportunity_Name__r.Order__c, Site__c,Receiver_Name__c,Receiver_Name__r.Membership_Level__c, Receiver_License__c, Total_Mileage_Fee__c
                             FROM Sales_Order__c 
                             WHERE Id =: SOId];
        Invoice__c[] serviceInvoices = [SELECT Id, Total_Mileage_Fee__c, (SELECT Id,Retail_Wholesale_Price__c FROM Invoice_Lines__r WHERE Product_Name__r.Name = :PRODUCT_NAME_MILEAGE_FEE)
         FROM Invoice__c 
         WHERE RecordType.Name = :INVOICE_RECORDTYPE_SERVICE 
         AND Sales_Order__c = : SO.Id];
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                              	Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                 FROM Shipping_Rates_Table__c 
                                                 WHERE Site__c = :SO.Site__c
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = : SO.Receiver_Name__r.Membership_Level__c
                                                     Order By Mileage_Bracket__c];
        String siteId = SO.Site__c;
        String stateLicenseId = SO.Receiver_License__c;
        Site__c s = [SELECT Id,License_ID__r.License_Address__c ,License_ID__r.License_City__c ,License_ID__r.License_Country__c ,License_ID__r.License_State__c,License_ID__r.License_Zip__c FROM Site__c WHERE Id = :siteId];
        State_Licenses__c st = [SELECT Id,Default_Warehouse__r.License_ID__r.License_Address__c ,Default_Warehouse__r.License_ID__r.License_City__c , Default_Warehouse__r.License_ID__r.License_Country__c,Default_Warehouse__r.License_ID__r.License_State__c,Default_Warehouse__r.License_ID__r.License_Zip__c FROM State_Licenses__c WHERE Id =:stateLicenseId];
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + s.License_ID__r.License_Address__c +','+ s.License_ID__r.License_City__c +','+ s.License_ID__r.License_Country__c + ','+s.License_ID__r.License_State__c +','+ s.License_ID__r.License_Zip__c+ '&destinations=' + st.Default_Warehouse__r.License_ID__r.License_Address__c +','+ st.Default_Warehouse__r.License_ID__r.License_City__c +','+ st.Default_Warehouse__r.License_ID__r.License_Country__c + ','+st.Default_Warehouse__r.License_ID__r.License_State__c +','+ st.Default_Warehouse__r.License_ID__r.License_Zip__c;
        String param2 =  '&language=en&key=';
        parameters = parameters.replace(' ','%20');
        url = url+parameters+param2+apiKey;
        url = url.replaceAll('#', '%20');
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            double distVal = 0;
            StateLicenseTotalMilesTriggerHelper.DistanceResponse reponse = (StateLicenseTotalMilesTriggerHelper.DistanceResponse) JSON.deserialize(response.getBody(), StateLicenseTotalMilesTriggerHelper.DistanceResponse.class); 
            if(reponse != null && reponse.rows != null){
                if(reponse.rows[0].elements != null){
                    distVal = reponse.rows[0].elements[0].distance.value;
                    distVal = distVal * 0.00062137;
                }
            }
            //return distVal;
            Decimal totalMileageFee = 0;
            if(!mileageSRTList.isEmpty() && distVal != null){
                for(Shipping_Rates_Table__c SRT: mileageSRTList){
                    if(distVal <= SRT.Mileage_Bracket__c && SO.Site__c == SRT.Site__c && SO.Receiver_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                        if(SRT.Fixed_Mileage_Fee__c){
                            totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                        }else{
                            totalMileageFee = SRT.Mileage_Bracket_Price__c * distVal; 
                        }
                        break;
                    }
                }    
            }
            SO.Total_Mileage_Fee__c = totalMileageFee;
            update SO;
            if(SO.Brand_Quote__c != NULL){
                Brand_Quote__c BQ = new Brand_Quote__c(Id = SO.Brand_Quote__c,Total_Mileage_Fee__c = totalMileageFee,Site__c = SO.Site__c);
                update BQ;
            }
            if(SO.Opportunity_Name__c != NULL){
                Opportunity opp = new Opportunity(Id = SO.Opportunity_Name__c, Site_Name__c = SO.Site__c);
                update opp;
            }
            if(SO.Opportunity_Name__r.Order__c != NULL){
                Order__c odr = new Order__c(Id = SO.Opportunity_Name__r.Order__c,Total_Milage_Fee__c = totalMileageFee, Site__c = SO.Site__c);
                update odr;
            }
            if(serviceInvoices.size() > 0){
                List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
                for(Invoice__c inv: serviceInvoices){
                    if(inv.Invoice_Lines__r.size() > 0){
                        for(Invoice_Line__c line: inv.Invoice_Lines__r){
                            line.Retail_Wholesale_Price__c = totalMileageFee;
                            invoiceLines.add(line);
                        }
                    }
                }
                if(invoiceLines.size() > 0){
                    update invoiceLines;
                }
            }
        }
    }
    /**
     * Create Picklist instance
     *
     * @param salesOrderObj The instance of Sales Order record
     *
     * @return The instance of Picklist
     */
    public Static Picklist__c createPicklist(Sales_Order__c salesOrderObj){
        Picklist__c picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = salesOrderObj.Id;
        picklistObj.Site__c = salesOrderObj.Site__c;
        picklistObj.Special_Instructions__c = salesOrderObj.Sales_Order_Instructions__c;
        picklistObj.Status__c = PICKLIST_STATUS_OPEN;
        return picklistObj;
    }
    
    /**
     * Create Picklist line instance
     *
     * @param invPositionObj The instance of Inventory Position record
     * @param picklistId The picklist Id
     *
     * @return The instance of Picklist line
     */
    public Static Picklist_Line__c createPicklistLine(Inventory_Position__c invPositionObj, Id picklistId){
        Picklist_Line__c picklistLineObj = new Picklist_Line__c();
        picklistLineObj.Product_Name__c = invPositionObj.Sales_Order_Line__r.Product_Name__c;
        picklistLineObj.IsPromo__c = invPositionObj.Sales_Order_Line__r.IsPromo__c == null ? false :invPositionObj.Sales_Order_Line__r.IsPromo__c ;
        picklistLineObj.Sales_Order_Line__c = invPositionObj.Sales_Order_Line__c;
        picklistLineObj.Inventory_Position__c = invPositionObj.Id;
        picklistLineObj.Picklist__c = picklistId;
        picklistLineObj.Is_Sample__c = invPositionObj.Sales_Order_Line__r.Is_Sample__c;
        picklistLineObj.Ownership_Code__c = invPositionObj.Sales_Order_Line__r.Ownership_Code__c;
        picklistLineObj.Actual_Qty_to_Pick__c = invPositionObj.Qty_Allocated__c;
        return picklistLineObj;
    }
    
    /**
     * Delete Picklist and line records if Allocated equals false
     *
     * @param soIds The set of Sales Order Ids
     */
    public Static void deletePickListAndLines(Set<Id> soIds){
        
        List<Picklist__c> picklists = new List<Picklist__c>();
        picklists = [Select Id From Picklist__c Where Sales_Order__c IN: soIds];
        
        // Delete picklist and it will delete picklist lines because of master-detail relationship
        delete picklists;
    }
    
    /**
     * Update Site from Receiver License's Default Warehouse field
     *
     * @param Sales Order List and Sales Order oldMap
     */
    /*Commented Code because of Issue from FG-973
     * public static void updateSiteFromReceiverLicense(List<Sales_Order__c> salesOrders,Map<Id, Sales_Order__c> oldSalesOrderMap){
        Id rdtRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByName().get(SALESORDER_RECORDTYPE_Transfer).getRecordTypeId();
        Map<Id,Sales_Order__c[]> receiverLicenseSOMap = new Map<Id,Sales_Order__c[]>();
        for(Sales_Order__c SO: salesOrders){
            if(SO.RecordTypeId != rdtRecordTypeId && SO.Receiver_License__c != null &&(Trigger.isInsert || (Trigger.isUpdate && SO.Receiver_License__c != oldSalesOrderMap.get(SO.Id).Receiver_License__c )) ){
                if(receiverLicenseSOMap.containsKey(SO.Receiver_License__c)){
                    receiverLicenseSOMap.get(SO.Receiver_License__c).add(SO);
                }else{
                    receiverLicenseSOMap.put(SO.Receiver_License__c, new Sales_Order__c[]{SO});
                }
            }
        }
        if(!receiverLicenseSOMap.isEmpty()){
            State_Licenses__c[] receivingLicenses = [SELECT Id,Default_Warehouse__c  FROM State_Licenses__c WHERE Id IN:receiverLicenseSOMap.keySet()];
            for(State_Licenses__c SL: receivingLicenses){
                Sales_Order__c[] SOList = receiverLicenseSOMap.get(SL.Id);
                if(!SOList.isEmpty()){
                    for(Sales_Order__c SO: SOList){
                        SO.Site__c = SL.Default_Warehouse__c;
                    }
                }
            }
        }
    }*/
    
    public static void approvalHoldAccount(List<Sales_Order__c> newSOList, Map<Id, Sales_Order__c> oldSalesOrderMap){
        Map<Id,Set<Sales_Order__c>> accountSalesOrderMap = new Map<Id,Set<Sales_Order__c>>();
        for (Sales_Order__c SO :newSOList) { 
            if(SO.SO_Status__c == 'Approved' && SO.SO_Status__c != oldSalesOrderMap.get(SO.Id).SO_Status__c){
                if(accountSalesOrderMap.containsKey(SO.Supplier_Name__c)){
                    accountSalesOrderMap.get(SO.Supplier_Name__c).add(SO);
                }else{
                    accountSalesOrderMap.put(SO.Supplier_Name__c, new Set<Sales_Order__c>{SO});
                }
                if(accountSalesOrderMap.containsKey(SO.Receiver_Name__c)){
                    accountSalesOrderMap.get(SO.Receiver_Name__c).add(SO);
                }else{
                    accountSalesOrderMap.put(SO.Receiver_Name__c, new Set<Sales_Order__c>{SO});
                }
                if(accountSalesOrderMap.containsKey(SO.Distributor_Name__c)){
                    accountSalesOrderMap.get(SO.Distributor_Name__c).add(SO);
                }else{
                    accountSalesOrderMap.put(SO.Distributor_Name__c, new Set<Sales_Order__c>{SO});
                }
            }
        }
        if(accountSalesOrderMap.size() > 0){
            Boolean isHold = false;
            List<Account> accounts = [select id,Hold__c, DBA__c from  Account WHERE ID IN :accountSalesOrderMap.keySet()];
            for(Account acc: accounts){
                Set<Sales_Order__c> accountSOList = accountSalesOrderMap.get(acc.Id);
                if(accountSOList != null && accountSOList.size() > 0){
                    for(Sales_Order__c SO: accountSOList){
                        if(acc.Hold__c == true && SO.Account_Hold_Exception__c == false){
                            SO.addError('Account: '+ acc.DBA__c + ' is on HOLD. Please check with Finance team.');
                            isHold = true;
                            break;
                        }
                    }
                }
                if(isHold)break;
            }
        }
    }
    public static void updatePrePlannedDate(List<Sales_Order__c> newSOList, Map<Id, Sales_Order__c> oldSalesOrderMap)   {
        if(newSOList.size() > 0 ){
        for(Sales_Order__c so: newSOList){
            
            if(oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c != null && so.Planned_Ship_Date__c != oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c && so.Opportunity_Name__c != null ){
                so.Previous_Planned_Ship_Date__c = oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c != null ? oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c : null;
            }
        }
        }
    }
	
    public static void updateWinStartEnd(List<Sales_Order__c> newSOList, Map<Id, Sales_Order__c> oldSalesOrderMap)   {
        Set<Id> soIds = new Set<Id>();
        Map<Id,Sales_Order__c> oppIdsForOrder = new Map<Id,Sales_Order__c>();
        
        Map<Id,Sales_Order__c> oppMap = new Map<Id,Sales_Order__c>();
            for(Sales_Order__c so: newSOList){
                if(so.Planned_Ship_Date__c != oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c || so.Vehicle__c != oldSalesOrderMap.get(so.Id).Vehicle__c || so.Driver__c != oldSalesOrderMap.get(so.Id).Driver__c  || so.Window_Start__c != oldSalesOrderMap.get(so.Id).Window_Start__c || so.Window_End__c != oldSalesOrderMap.get(so.Id).Window_End__c || so.Priority__c != oldSalesOrderMap.get(so.Id).Priority__c ){
                   soIds.add(so.Id);                      
                }
                if((so.Window_Start__c != null && so.Window_Start__c != oldSalesOrderMap.get(so.Id).Window_Start__c )||(so.Window_End__c != null && so.Window_End__c != oldSalesOrderMap.get(so.Id).Window_End__c)){
                    oppIdsForOrder.put(so.Opportunity_Name__c,so);
                }
                if((so.Planned_Ship_Date__c != oldSalesOrderMap.get(so.Id).Planned_Ship_Date__c || (so.Window_Start__c != oldSalesOrderMap.get(so.Id).Window_Start__c || so.Window_End__c != oldSalesOrderMap.get(so.Id).Window_End__c) ) && so.Opportunity_Name__c != null){
                    
                    oppMap.put(so.Opportunity_Name__c,so);
                }
            }
        
        List<Sales_Order__c> soCheck = [select Id, Window_Start__c,Window_End__c,Priority__c,Planned_Ship_Date__c,Driver__c,Vehicle__c,(SELECT Id FROM Shipping_Manifests__r)FROM Sales_Order__c WHERE ID IN :soIds];
          List<Shipping_Manifest__c> updateList = new List<Shipping_Manifest__c>();
           if(soCheck.size()>0){
               for(Sales_Order__c so: soCheck){
                   for(Shipping_Manifest__c sm: so.Shipping_Manifests__r){
                       sm.Window_Start__c = so.Window_Start__c;
                       sm.Window_End__c = so.Window_End__c;
                       sm.Priority__c = so.Priority__c;
                       sm.Driver__c = so.Driver__c != null ? so.Driver__c : null ;
                       sm.Vehicle__c = so.Vehicle__c != null ? so.Vehicle__c : null;
                       sm.Planned_Ship_Transfer_Date__c = so.Planned_Ship_Date__c != null ? so.Planned_Ship_Date__c : null;
                       updateList.add(sm);
                   }
               }
               update updateList;
           }
        
        if(oppIdsForOrder.size() > 0 ){
            List<Order__c> OdrUpdateList = new List<Order__c>();
            List<Opportunity> oppList = [SELECT id,Order__c,Order__r.Planned_Ship_Date__c,Order__r.Previous_Planned_Ship_Date__c,Order__r.Retailer__r.Third_Party_Scheduler__c,Order__r.Request_Ship_Date__c,Order__r.Requested_Delivery_Earliest_Time__c,Order__r.Requested_Delivery_Latest_Time__c FROM Opportunity WHERE id IN : oppIdsForOrder.keySet()];
            for(Opportunity opp : oppList){
                if(opp.Order__r.Requested_Delivery_Earliest_Time__c != oppIdsForOrder.get(opp.id).Window_Start__c ||
                   opp.Order__r.Requested_Delivery_Latest_Time__c != oppIdsForOrder.get(opp.id).Window_End__c){
                       Order__c o = new Order__c(Id = opp.Order__c);
                       o.Requested_Delivery_Earliest_Time__c = oppIdsForOrder.get(opp.id).Window_Start__c;
                       o.Requested_Delivery_Latest_Time__c = oppIdsForOrder.get(opp.id).Window_End__c;
                       OdrUpdateList.add(o);
                   }
            }
            if(OdrUpdateList.size() > 0 ){
                update OdrUpdateList;
            }
        }
        
        if(oppMap.size() > 0){
            List<Brand_Quote__c> bqList = new List<Brand_Quote__c>();
            List<Shipping_Manifest__c> SMList = new List<Shipping_Manifest__c>();
            List<Opportunity> oppList = [SELECT id,Order__c,Order__r.Planned_Ship_Date__c,Order__r.Previous_Planned_Ship_Date__c,Order__r.Retailer__r.Third_Party_Scheduler__c,Order__r.Request_Ship_Date__c,(SELECT Id,Requested_Ship_Date__c,Previous_Planned_Ship_Date__c,Planned_Ship_Date__c FROM Quotes__r),(SELECT id,Previous_Planned_Ship_Date__c,Planned_Ship_Transfer_Date__c FROM Shipping_Manifests__r) FROM Opportunity WHERE id IN : oppMap.keySet()];
            List<Order__c> OdrList = new List<Order__c>();
            Set<id> PDandRDsameOrdIds = new Set<id>();
            Set<id> PDandRDNotSameOrdIds = new Set<id>();
            for(Opportunity opp : oppList){
                
                if(opp.Order__c != null && opp.Order__r.Planned_Ship_Date__c != oppMap.get(opp.Id).Planned_Ship_Date__c){
                    Order__c o = new Order__c(Id = opp.Order__c);
                    o.Planned_Ship_Date__c = oppMap.get(opp.Id).Planned_Ship_Date__c;
                    o.Previous_Planned_Ship_Date__c  =oppMap.get(opp.Id).Previous_Planned_Ship_Date__c;
                    OdrList.add(o);
                }
                if(opp.Quotes__r.size() > 0){
                        for(Brand_Quote__c bq : opp.Quotes__r){
                            bq.Planned_Ship_Date__c = oppMap.get(opp.id).Planned_Ship_Date__c != null ? oppMap.get(opp.id).Planned_Ship_Date__c : null;
                            bq.Previous_Planned_Ship_Date__c = oppMap.get(opp.Id).Previous_Planned_Ship_Date__c != null ? oppMap.get(opp.Id).Previous_Planned_Ship_Date__c : null;
                            bqList.add(bq);
                        }
                    }
                    if(opp.Shipping_Manifests__r.size() > 0){
                        for(Shipping_Manifest__c sm : opp.Shipping_Manifests__r){
                            sm.Previous_Planned_Ship_Date__c = oppMap.get(opp.Id).Previous_Planned_Ship_Date__c != null ? oppMap.get(opp.Id).Previous_Planned_Ship_Date__c : null;
                            sm.Planned_Ship_Transfer_Date__c =oppMap.get(opp.Id).Planned_Ship_Date__c;
                            SMList.add(sm);
                        }
                    }
                
            }
            if(OdrList.size() > 0){
                update OdrList;
            }
            if(bqList.size() > 0 ){
                update bqList;
            }
           
            if(SMList.size() > 0 ){
                update SMList;
            }
            
            for(Opportunity opp : oppList){
                if(((oppMap.get(opp.Id).Sample_Order__c || opp.Order__r.Retailer__r.Third_Party_Scheduler__c) && 
                    (oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Planned_Ship_Date__c != oppMap.get(opp.Id).Planned_Ship_Date__c 
                     || (oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Window_Start__c != oppMap.get(opp.Id).Window_Start__c 
                         || oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Window_End__c != oppMap.get(opp.Id).Window_End__c))
                   ) && oppMap.get(opp.Id).Planned_Ship_Date__c != null && oppMap.get(opp.Id).Window_Start__c != null && oppMap.get(opp.Id).Window_End__c != null && SMRescheduleController.isRescheduled == false){
                   
                    SMRescheduleController.sendEmailByWovn(opp.Order__c,oppMap.get(opp.Id).Planned_Ship_Date__c,null);
                }
                if(opp.Order__c != null && opp.Order__r.Request_Ship_Date__c != null && 
                   (oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Planned_Ship_Date__c != oppMap.get(opp.Id).Planned_Ship_Date__c 
                     || (oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Window_Start__c != oppMap.get(opp.Id).Window_Start__c 
                         || oldSalesOrderMap.get(oppMap.get(opp.Id).Id).Window_End__c != oppMap.get(opp.Id).Window_End__c))
                   && oppMap.get(opp.Id).Planned_Ship_Date__c != null && oppMap.get(opp.Id).Window_Start__c != null && oppMap.get(opp.Id).Window_End__c != null &&
                   (!oppMap.get(opp.Id).Sample_Order__c  && !opp.Order__r.Retailer__r.Third_Party_Scheduler__c)
                  ){
                    if(opp.Order__r.Request_Ship_Date__c == oppMap.get(opp.Id).Planned_Ship_Date__c && SMRescheduleController.isRescheduled == false) {
                       
                            SMRescheduleController.sendEmailByWovn(opp.Order__c,oppMap.get(opp.Id).Planned_Ship_Date__c,null);
                       
                        
                    }else if(opp.Order__r.Request_Ship_Date__c != oppMap.get(opp.Id).Planned_Ship_Date__c 
                              && SMRescheduleController.isRescheduled == false){
                        PDandRDNotSameOrdIds.add(opp.Order__c);
                    }
                }
            }
            if(PDandRDNotSameOrdIds.size() > 0){
                sendEmailToReceiver(PDandRDNotSameOrdIds);
            }   
            
        }
        
         
    } 
    public static void sendEmailToReceiver(Set<Id>ordIds){
        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        //Get your document from document Object
        List<Document> doc = new List<Document>();
            doc = [SELECT Id, Name, Body, ContentType, DeveloperName, Type FROM Document WHERE DeveloperName =: 'X8300'];
        List<Order__c> updateOrderForRescheduleAgain = new List<Order__c>();
        for(Order__c ord : [SELECT Id,Name,Request_Ship_Date__c,Account__c,Customer__c,Customer__r.Email,Requested_Delivery_Earliest_Time__c,Retailer_DBA__c,Account_DBA__c,Status__c,
                            Requested_Delivery_Latest_Time__c,Retailer__r.DBA__c,Retailer__r.ShippingAddress,Retailer_PO__c,Total_Product_Price__c,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Orders_Email_Opt_In__c,Sales_Person__r.Active__c,
                            Total__c,Payment_Terms__c,Total_Excise_Tax_Amount__c,State_License__r.License_Number__c,IsRescheduled__c,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,Previous_Planned_Ship_Date__c,
                            State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,Planned_Ship_Date__c,
                            Retailer_Contact__c,Retailer_Contact__r.email,Retailer_Contact__r.FirstName,(SELECT Id, Name, Product__r.Name,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Description,UnitPrice__c,Quantity_Cases__c,
                                      MOQ__c,Line_Total_Qty__c,Product__r.Brand_Name__c,Product__r.RecordType.Name,
                                      Unit_Excise_Tax__c,Line_Total_Excise_Tax__c,Total__c ,Line_Total_Cost__c,IsPromo__c,Is_Sample__c
                                                                                                         FROM  Order_Line_Items__r),(SELECT id,Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null)
                            FROM Order__c WHERE Id IN : ordIds]){
                                
                                String earTime='';
                                if(ord.Requested_Delivery_Earliest_Time__c != null){
                                String[] strTimeSplit = String.valueOf(ord.Requested_Delivery_Earliest_Time__c).split(':');
                                earTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' pm' : strTimeSplit[0]+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
                                }
                                String latTime='';
                                
                                if(ord.Requested_Delivery_Latest_Time__c != null){
                                String[] strTimelateSplit = String.valueOf(ord.Requested_Delivery_Latest_Time__c).split(':');
                                 latTime = Integer.valueOf(strTimelateSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimelateSplit[0]) - 12)+':'+strTimelateSplit[1]+' pm' : strTimelateSplit[0]+':'+strTimelateSplit[1]+(Integer.valueOf(strTimelateSplit[0]) == 12 ?' PM': ' AM');
                                }
                                
                                Datetime dt = DateTime.newInstance(ord.Request_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                String dayOfWeek=dt.format('EEEE');
                                
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                
                                if(ord.Previous_Planned_Ship_Date__c != null && ord.Previous_Planned_Ship_Date__c != ord.Planned_Ship_Date__c){
                                    mail.setSubject('Please Confirm Updated Delivery Date for Order '+ord.Name +' from '+ord.Account_DBA__c+' by WOVN');
                                }else if(ord.Request_Ship_Date__c != ord.Planned_Ship_Date__c){
                                    mail.setSubject('Please Confirm Delivery Date for Order '+ord.Name +' from '+ord.Account_DBA__c+' by WOVN');
                                    
                                }
                                
                                
                                
                                String htmlBody = 'Hello '+ord.Retailer_Contact__r.FirstName +',<br/><br/>'; 
                                
                                Datetime redt = DateTime.newInstance(ord.Planned_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                if(ord.Previous_Planned_Ship_Date__c != null && ord.Previous_Planned_Ship_Date__c != ord.Planned_Ship_Date__c){
                                    Datetime prePladt = DateTime.newInstance(ord.Previous_Planned_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                	htmlBody += 'There has been an update to your delivery date and time.  Your delivery was planned to ship on <br/> '+'<b>'+prePladt.format('EEEE, MM/dd/YYYY') +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b><br/><br/>';
                                }else if(ord.Request_Ship_Date__c != ord.Planned_Ship_Date__c){
                                     htmlBody += 'You previously requested a delivery on '+dt.format('EEEE, MM/dd/YYYY') +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'<br/><br/>';
                                }
                                htmlBody += 'Your delivery day and time has been updated to:<br/><br/>';
                                htmlBody += '<b>'+redt.format('EEEE, MM/dd/YYYY') +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b><br/><br/>';
                                htmlBody += '<b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true-a">PLEASE CLICK HERE TO APPROVE OR REQUEST A NEW DELIVERY DATE.</a>  </b><br/><br/>';
                                
                                
                                htmlBody +='<b>ORDER DETAILS</b><br/>';
                                htmlBody +='Retailer Name:&nbsp;'+ord.Retailer_DBA__c+'<br/>';
                                
                                String Retailer_PO =ord.Retailer_PO__c==null?'':ord.Retailer_PO__c;
                                htmlBody +='Retailer PO:&nbsp;'+Retailer_PO+'<br/>';
                                
                                
                                String add = '';
                                add += ord.State_License__r.License_Address__c != null ? ord.State_License__r.License_Address__c +' ':'';
                                add += ord.State_License__r.License_City__c != null ? ord.State_License__r.License_City__c +', ':'';
                                add += ord.State_License__r.License_State__c != null ? ord.State_License__r.License_State__c +' ':'';
                                add += ord.State_License__r.License_Zip__c != null ? ord.State_License__r.License_Zip__c +' ':'';
                                //add += ord.State_License__r.License_Country__c != null ? ord.State_License__r.License_Country__c +' ':'';
                                	
                                
                                htmlBody +='Total Product Price:&nbsp;$'+ord.Total_Product_Price__c+'<br/>';
                                htmlBody +='Total Excise Tax Amount:&nbsp;$'+ord.Total_Excise_Tax_Amount__c+' (Excise Tax is due COD at time of delivery.)<br/>';
                                htmlBody +='Total Order Price:&nbsp;$'+ord.Total__c+'<br/>';
                                htmlBody += '<b>Address:&nbsp;</b>'+add+'<br/>';
                                htmlBody +='<b>License Number:&nbsp;</b>'+ord.State_License__r.License_Number__c+'<br/>';
                                htmlBody +='<b>Payment Terms:&nbsp;</b>'+ord.Payment_Terms__c+'<br/><br/>';
                                
                                
                                List<Order_Line_Item__c> discountOLIList = new List<Order_Line_Item__c>();
                                List<Order_Line_Item__c> oliList = new List<Order_Line_Item__c>();
                                for(Order_Line_Item__c oli : ord.Order_Line_Items__r){
                                    if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT) {
                                        discountOLIList.add(oli);
                                    }else{
                                        oliList.add(oli);
                                    } 
                                }
                                if(discountOLIList.size() > 0){
                                    oliList.addAll(discountOLIList);
                                }
                                htmlBody += '<table cellspacing="0" style="border:1px solid #000">';
                                htmlBody += '<tr style="border:1px solid #000">';
                                htmlBody += '<th style="border:1px solid #000">Order Line ';
                                htmlBody += '</th><th style="border:1px solid #000">Product Name';
                                htmlBody += '</th><th style="border:1px solid #000">Product Description</th>';
                                htmlBody += '<th style="border:1px solid #000">Brand</th>';
                                htmlBody += '<th style="border:1px solid #000">Total Qty</th>';
                                htmlBody += '<th style="border:1px solid #000">Type</th>';
                                htmlBody += '<th style="border:1px solid #000">Unit Price</th>';
                                htmlBody += '<th style="border:1px solid #000">Unit Excise Tax</th>';
                                htmlBody += '<th style="border:1px solid #000">Product Price</th>';
                                htmlBody += '<th style="border:1px solid #000">Total Excise Tax</th>';
                                htmlBody += '<th style="border:1px solid #000">Total Quoted Price</th>';
                                htmlBody += '</tr> ';
                                if(oliList.size()>0){
                                    for(Order_Line_Item__c oli : oliList){
                                        htmlBody += '<tr style="border:1px solid #000">';
                                        htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Name+'</td>';
                                        htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Product_Short_Description__c+'</td>';
                                        htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Description+'</td>';    
                                        htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Brand_Name__c+'</td>';    
                                        htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Line_Total_Qty__c.setScale(2)+'</td>';    
                                        htmlBody += '<td style="border:1px solid #000;text-align: center;font-size: 11px;">';
                                        if(oli.IsPromo__c)
                                            htmlBody += 'Promo';
                                        if(oli.Is_Sample__c)
                                            htmlBody += 'Sample';
                                        if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += 'Discount';
                                        htmlBody += '</td>';
                                        htmlBody += '<td style="border:1px solid #000;text-align: left;font-size: 11px;">';
                                        
                                        if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+oli.UnitPrice__c.setScale(2)+')';
                                        else
                                            htmlBody += '$'+oli.UnitPrice__c.setScale(2);
                                        
                                        htmlBody += '</td>';    
                                        htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Unit_Excise_Tax__c.setScale(2)+'</td>';
                                        htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                                        if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+oli.Line_Total_Cost__c.setScale(2)+')';
                                        else
                                            htmlBody += '$'+oli.Line_Total_Cost__c.setScale(2);
                                        htmlBody += '</td>';
                                        htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Line_Total_Excise_Tax__c.setScale(2)+'</td>';
                                        htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                                        if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+oli.Total__c.setScale(2)+')';
                                        else
                                            htmlBody += '$'+oli.Total__c.setScale(2);
                                        htmlBody += '</td></tr>'; 
                                        
                                    }
                                    htmlBody += '</table>';
                                    htmlBody += '<br/><br/> Thank you, <br/><br/>';
                                    htmlBody += 'The WOVN Scheduling Team';
                                }
                                
                                
                                List<String> listOfToAddresses = new List<String>();
                                List<String> listOfBCCAddresses = new List<String>();
                                
                                listOfToAddresses.add(ord.Retailer_Contact__r.email);
                                if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                mail.setHtmlBody(htmlBody);
                                List<String> ccEmails = DL_ASR.split(',');//label.DL_ASR
                                for(Retailer_Related_Contact__c rrc: ord.Retailer_Related_Contacts__r){
                                  listOfToAddresses.add(rrc.Contact__r.Email);
                                }
                                if( ord.Customer__c != null && ord.Customer__r.Email != null){ 
                                    ccEmails.add(ord.Customer__r.Email);
                                }
                                if(ord.Additional_Brand_Contact__c != null){
                                    if(ord.Additional_Brand_Contact__r.Email != null) 
                                        ccEmails.add(ord.Additional_Brand_Contact__r.Email);
                                }
                                if(ord.Sales_Person__c  != null && ord.Sales_Person__r.Email != null && ord.Sales_Person__r.Orders_Email_Opt_In__c == true  && ord.Sales_Person__r.Active__c == true){
                                    ccEmails.add(ord.Sales_Person__r.Email);
                                }
                                ccEmails.addAll(Label.Orders_Filigreen_Email.split(','));
                                
                                mail.setCcAddresses(ccEmails); 
                                mail.setSaveAsActivity(false);
                                mail.setToAddresses(listOfToAddresses); 
                                mails.add(mail);
                                
                                
                            }
        if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }
    }
}