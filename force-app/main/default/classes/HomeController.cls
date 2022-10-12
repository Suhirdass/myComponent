public without sharing class HomeController {
    private static Integer LIMIT_25 = 25;
    private static Integer LIMIT_10 = 10;    
    private static String ASC_DIRECTION{
        get{
            return String.isNotBlank(ASC_DIRECTION) ? ASC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','ASC_Direction');
        }set;
    }
    private static String DESC_DIRECTION{
        get{
            return String.isNotBlank(DESC_DIRECTION) ? DESC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','DESC_Direction');
        }set;
    }    
    private static String Order_Status_Draft{
        get{
            return String.isNotBlank(Order_Status_Draft) ? Order_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
        }set;
    }
    private static String Order_Status_Pending{
        get{
            return String.isNotBlank(Order_Status_Pending) ? Order_Status_Pending : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    private static String Order_Status_Shipped{
        get{
            return String.isNotBlank(Order_Status_Shipped) ? Order_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    private static String Order_Status_Delivered{
        get{
            return String.isNotBlank(Order_Status_Delivered) ? Order_Status_Delivered : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Delivered');
        }set;
    }
    private static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    private static String Invoice_Record_Type_Product{
        get{
            return String.isNotBlank(Invoice_Record_Type_Product) ? Invoice_Record_Type_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    private static String SM_Line_Status_Shipment_Complete{
        get{
            return String.isNotBlank(SM_Line_Status_Shipment_Complete) ? SM_Line_Status_Shipment_Complete : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_Status_Shipment_Complete');
        }set;
    }
    private static String Shipping_Manifest_RecordType_RSM{
        get{
            return String.isNotBlank(Shipping_Manifest_RecordType_RSM) ? Shipping_Manifest_RecordType_RSM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_RSM');
        }set;
    }
    private static String Not_Include_Location{
        get{
            return String.isNotBlank(Not_Include_Location) ? Not_Include_Location : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Not_Include_Location');
        }set;
    }
    private static String Not_Include_Location_For_Aging_Chart{
        get{
            return String.isNotBlank(Not_Include_Location_For_Aging_Chart) ? Not_Include_Location_For_Aging_Chart : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Not_Include_Location_For_Aging_Chart');
        }set;
    }
    private static String Invoice_Line_Status_Rejected{
        get{
            return String.isNotBlank(Invoice_Line_Status_Rejected) ? Invoice_Line_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Rejected');
        }set;
    }
    private static String Invoice_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Invoice_Line_Status_Cancelled) ? Invoice_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Cancelled');
        }set;
    }
    private static String Excluded_Warehouse_DBA{
        get{
            return String.isNotBlank(Excluded_Warehouse_DBA) ? Excluded_Warehouse_DBA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Excluded_Warehouse_DBA');
        }set;
    }
    private static String INVESTOR_DASHBOARD_ID{
        get{
            return String.isNotBlank(INVESTOR_DASHBOARD_ID) ? INVESTOR_DASHBOARD_ID : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Dashboard','Investor_Dashboard_Id');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_TRANSFER{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_TRANSFER) ? ORDER_RECORD_TYPE_NAME_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    }
	@AuraEnabled
    public static AuraResponse getHomePageData(){        
    	AuraResponse r = new AuraResponse('HomeController.getHomePageData()');
        Boolean isBrand = ProductsCtlr.isBrand;
        Id brandId = Utility.loggedInUser.AccountId;
        r.data.put('isBrand', isBrand);
        r.data.put('isLimited', ProductsCtlr.isLimited);
        r.data.put('baseUrl', Site.getBaseUrl());
        r.data.put('INVESTOR_DASHBOARD_ID', INVESTOR_DASHBOARD_ID);
        r = HomeController.getNewsAndAnnouncemnets(r,isBrand);
        if(isBrand){
            r = HomeController.getOrders(r,brandId);
            r = HomeController.getNewAccounts(r);
            r = HomeController.getColdAccounts(r);
            r = HomeController.getTopSellingProducts(r);     
            r = HomeController.getTopBuyingRetailers(r);   
            r = HomeController.getMGMData(r);   
            r = HomeController.getAgingInvnetoryData(r,brandId);
        }   
        return r;
    }
    private static AuraResponse getNewsAndAnnouncemnets(AuraResponse r,Boolean isBrand){
        string usrId = userinfo.getUserId();
        list<user> usrList = [select id from user where id =: usrId AND Don_t_Show_News_Again__c = false];
        if(usrList.size() > 0){
            String newsType = isBrand ? 'Brand' : 'Retailer';
            dateTime sysNow = system.now();
            List<MP_News_Announcements__c>newsList = [select id,News_Details__c from MP_News_Announcements__c where (Type__c = 'Both' OR Type__c =: newsType) AND Active__c = true AND Start_Date_Time__c <=: sysNow AND End_Date_Time__c >=: sysNow ORDER BY News_Order__c];  
            r.data.put('hasNewsAndAnnouncemnets', newsList.size() > 0);   
            r.data.put('newsAndAnnouncemnets', newsList); 
        }else
            r.data.put('hasNewsAndAnnouncemnets', false); 
        return r;
    }
    @AuraEnabled
    public static AuraResponse dontShowAgain(){
        AuraResponse r = new AuraResponse('HomeController.dontShowAgain()');
        User usr = new User();
        usr.Don_t_Show_News_Again__c = true;
        usr.Id = userInfo.getUserId();
        update usr;
        return r;
    } 
    private static AuraResponse getOrders(AuraResponse r,Id brandId){        
        Id currentUserId = Userinfo.getUserId();
        List<Order__c> recentOrdersList = new List<Order__c>();        
        String query = 'SELECT Id,Name,Total__c,Status__c,Retailer__c,Total_Product_Price__c,Retailer__r.DBA__c,';
        query += 'Retailer__r.BillingCity,Retailer_DBA__c,createddate,Billing_City__c,Request_Ship_Date__c FROM Order__c';
        Account[] accs = [SELECT Id,ParentId FROM Account WHERE Id =: brandId];
        if(!accs.isEmpty() && accs[0].ParentId != NULL){
            query += ' WHERE (Customer__c = :currentUserId OR Retailer__c =: brandId)';
        }else{
            query += ' WHERE Customer__c = :currentUserId ';
        }
        query += 'AND Status__c !=:Order_Status_Draft  AND Status__c !=:Order_Status_Pending AND Order_Type__c !=:ORDER_RECORD_TYPE_NAME_TRANSFER  Order by createddate DESC limit 5';
        recentOrdersList = Database.query(query);
        r.data.put('recentOrdersList',recentOrdersList);       
    	return r;   
    }
    private static AuraResponse getNewAccounts(AuraResponse r){
        Set<String>orderIdSet = new Set<String>();
        Map<String,Line_Card__c>retailersMap = new Map<String,Line_Card__c>();
        Id brandId = Utility.loggedInUser.AccountId;
        List<String>ExcludedWarehouseDBAList = Excluded_Warehouse_DBA != null ? Excluded_Warehouse_DBA.split(';') : new List<String>();
        for(Line_Card__c lineCard: [select id,Retailer_Name__c,Retailer_Name__r.Name,Retailer_Name__r.DBA__c,Retailer_Name__r.BillingCity from Line_Card__c where Brand_Name__c = :brandId AND Retailer_Name__c != null AND Retailer_Name__r.DBA__c NOT IN: ExcludedWarehouseDBAList]){
            retailersMap.put(lineCard.Retailer_Name__c,lineCard);
        }
        Map<Id,Id> retailerRecentOrderMap = new Map<Id,Id>();
        for(Order_Line_Item__c OLI : [select Id,Order__c,Order__r.Retailer__c,Product__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c from Order_Line_Item__c where Order__r.Retailer__c IN: retailersMap.keySet() AND (Order__r.Order_Date__c = LAST_N_Months:2 OR Order__r.Order_Date__c = THIS_MONTH)  AND  Order__r.Status__c =: Order_Status_Shipped AND ((Product__r.Producer_Name__c = :brandId AND Product__r.White_Labelled__c = false ) OR(Product__r.Licensee_Name__c = :brandId AND Product__r.White_Labelled__c = true)) ORDER By Order__r.Order_Date__c DESC]){
            if(orderIdSet.size() == LIMIT_25) 
                break;
            if(retailerRecentOrderMap.containsKey(OLI.Order__r.Retailer__c) == false){
                retailerRecentOrderMap.put(OLI.Order__r.Retailer__c,OLI.Order__c);
            	orderIdSet.add(OLI.Order__c);   
            }
        }
        list<Order__c>newAccountOrdersList = [select id,Retailer__c,Retailer__r.DBA__c,Retailer__r.BillingCity,
				Total_Product_Price__c,Retailer_DBA__c,Billing_City__c,Request_Ship_Date__c,Order_Date__c,Total__c,
				State_License__r.License_City__c from Order__c Where Id IN: orderIdSet ORDER BY Order_Date__c DESC];
        r.data.put('newAccountOrdersList', newAccountOrdersList);  
        return r;
    }
    private static AuraResponse getColdAccounts(AuraResponse r){
        Set<Id>orderIdSet = new Set<Id>();
        Map<String,Line_Card__c>retailersMap = new Map<String,Line_Card__c>();
        Id brandId = Utility.loggedInUser.AccountId;
        List<String>ExcludedWarehouseDBAList = Excluded_Warehouse_DBA != null ? Excluded_Warehouse_DBA.split(';') : new List<String>();
        for(Line_Card__c lineCard: [select id,Retailer_Name__c,Retailer_Name__r.Name,Retailer_Name__r.DBA__c,Retailer_Name__r.BillingCity from Line_Card__c where Brand_Name__c = :brandId AND Retailer_Name__c != null AND Retailer_Name__r.DBA__c NOT IN: ExcludedWarehouseDBAList]){
            retailersMap.put(lineCard.Retailer_Name__c,lineCard);
        }       
        Set<Id> retailersOrderedInLast3Months = new Set<Id>();
        for(Order_Line_Item__c OLI : [select Id,Order__c,Order__r.Retailer__c from Order_Line_Item__c where Order__r.Retailer__c IN: retailersMap.keySet() AND (Order__r.Order_Date__c = LAST_N_Months:2 OR Order__r.Order_Date__c = THIS_MONTH)  AND  Order__r.Status__c =: Order_Status_Shipped AND ((Product__r.Producer_Name__c = :brandId AND Product__r.White_Labelled__c = false ) OR(Product__r.Licensee_Name__c = :brandId AND Product__r.White_Labelled__c = true))]){
            retailersOrderedInLast3Months.add(OLI.Order__r.Retailer__c);
        }
        Map<Id,Id> retailerRecentOrderMap = new Map<Id,Id>();
        for(Order_Line_Item__c OLI : [select Id,Order__c,Order__r.Retailer__c,Product__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c from Order_Line_Item__c where Order__r.Retailer__c IN: retailersMap.keySet() AND Order__r.Order_Date__c < LAST_N_Months:3 AND Order__r.Retailer__c NOT IN :retailersOrderedInLast3Months  AND  Order__r.Status__c =: Order_Status_Shipped AND ((Product__r.Producer_Name__c = :brandId AND Product__r.White_Labelled__c = false ) OR(Product__r.Licensee_Name__c = :brandId AND Product__r.White_Labelled__c = true)) ORDER By Order__r.Order_Date__c DESC]){
            if(retailerRecentOrderMap.size() == 25) 
                    break;
            if(retailerRecentOrderMap.containsKey(OLI.Order__r.Retailer__c) == false){
                retailerRecentOrderMap.put(OLI.Order__r.Retailer__c,OLI.Order__c);
                orderIdSet.add(OLI.Order__c); 
            }
        }        
        list<Order__c>coldAccountsList = [select id,Order_Date__c,Retailer__c,Total_Product_Price__c,Retailer__r.DBA__c,
			Retailer__r.BillingCity,Retailer_DBA__c,Billing_City__c,Request_Ship_Date__c,Total__c from Order__c Where Id IN: orderIdSet ORDER BY Order_Date__c DESC];
        r.data.put('coldAccountsList', coldAccountsList);  
        return r;
    }    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getAllColdAccountIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('HomeController.getexistingAccountOrderIds()');
        Set<Id> setIds = new Set<Id>();
        date ThreeMonthPastDate = system.today().addMonths(-3);
        
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }   
        
        Set<Id>orderIdSet = new Set<Id>();
        Map<String,Line_Card__c>retailersMap = new Map<String,Line_Card__c>();
        Id brandId = Utility.loggedInUser.AccountId;
        List<String>ExcludedWarehouseDBAList = Excluded_Warehouse_DBA != null ? Excluded_Warehouse_DBA.split(';') : new List<String>();
        for(Line_Card__c lineCard: [select id,Retailer_Name__c,Retailer_Name__r.Name,Retailer_Name__r.DBA__c,Retailer_Name__r.BillingCity from Line_Card__c where Brand_Name__c = :brandId AND Retailer_Name__c != null AND Retailer_Name__r.DBA__c NOT IN: ExcludedWarehouseDBAList]){
            retailersMap.put(lineCard.Retailer_Name__c,lineCard);
        }       
        Set<Id> retailersOrderedInLast3Months = new Set<Id>();
        for(Order_Line_Item__c OLI : [select Id,Order__c,Order__r.Retailer__c from Order_Line_Item__c where Order__r.Retailer__c IN: retailersMap.keySet() AND (Order__r.Order_Date__c = LAST_N_Months:2 OR Order__r.Order_Date__c = THIS_MONTH)  AND  Order__r.Status__c =: Order_Status_Shipped AND ((Product__r.Producer_Name__c = :brandId AND Product__r.White_Labelled__c = false ) OR(Product__r.Licensee_Name__c = :brandId AND Product__r.White_Labelled__c = true))]){
            retailersOrderedInLast3Months.add(OLI.Order__r.Retailer__c);
        }
        set<String>retailersIdSet = retailersMap.keySet();
        Map<Id,Id> retailerRecentOrderMap = new Map<Id,Id>();
        String queryStr = 'select Id,Order__c,Order__r.Retailer__c from Order_Line_Item__c where Order__r.Retailer__c IN: retailersIdSet  AND Order__r.Order_Date__c < LAST_N_Months:3 AND Order__r.Retailer__c NOT IN :retailersOrderedInLast3Months  AND  Order__r.Status__c =: Order_Status_Shipped AND ((Product__r.Producer_Name__c = :brandId AND Product__r.White_Labelled__c = false ) OR(Product__r.Licensee_Name__c = :brandId AND Product__r.White_Labelled__c = true))';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy); 
        system.debug('queryStr '+queryStr);
        for(Order_Line_Item__c OLI : database.query(queryStr)){
            if(retailerRecentOrderMap.containsKey(OLI.Order__r.Retailer__c) == false){
                retailerRecentOrderMap.put(OLI.Order__r.Retailer__c,OLI.Order__c);
                orderIdSet.add(OLI.Order__c); 
            }
        }        
        r.data.put('ids', orderIdSet);
        return r;
    }    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getAllColdAccounts(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('HomeController.getexistingAccountOrderRecords()');        
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                orderByField = orderByField.replace('Order__r.', '');
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }      
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }        
        string queryStr = 'SELECT Id,Order_Date__c,Retailer__c,Retailer__r.DBA__c,Retailer__r.BillingCity,Retailer_DBA__c,';
        queryStr += 'Total_Product_Price__c,Billing_City__c,Request_Ship_Date__c,Total__c from Order__c WHERE ID In : ids';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        system.debug('queryStr '+queryStr);
        list<Order__c>coldAccountsList = Database.query(queryStr);
        r.data.put('coldAccountsList', coldAccountsList);
        return r;
    }    
    private static AuraResponse getTopSellingProducts(AuraResponse r){
        list<TopSellingProducts>topSellingProductList = new list<TopSellingProducts>();
        Id brandId = Utility.loggedInUser.AccountId;
        Map<ID, Product2> productMap = new Map<ID, Product2>();
        Id priceBookId1 = (Utility.loggedInUser.Contact.Account.Community_Price_Book__c != null? Utility.loggedInUser.Contact.Account.Community_Price_Book__c: null);
        for(Product2 pdt: [SELECT Id,Product_Short_Description__c, Name,Family,(select id from PricebookEntries where Pricebook2Id =: priceBookId1 limit 1) FROM Product2]){
            productMap.put(pdt.id,pdt);
        }
        AggregateResult[] groupedResults = [select Product_Name__c,sum(Line_Total_Invoice_Amount__c),sum(Invoice_Qty__c) from Invoice_Line__c where Invoice__r.RecordType.Name =: Invoice_Record_Type_Product AND Invoice__r.AR_Status__c =: Invoice_Ar_Status_Shipped  AND InvoiceLine_Status__c !=: Invoice_Line_Status_Cancelled AND InvoiceLine_Status__c !=: Invoice_Line_Status_Rejected AND Invoice__r.Invoice_Due_Date__c = LAST_N_Months:3 AND Invoice__r.Sales_Order__r.Opportunity_Name__r.Order__r.Account__c =: brandId AND OwnershipCode__c =: brandId GROUP BY Product_Name__c order by sum(Line_Total_Invoice_Amount__c) desc];
        for (AggregateResult ar : groupedResults)  {
            string productId = ''+ar.get('Product_Name__c');
            decimal price = ar.get('expr0') != null ? decimal.valueof(''+ar.get('expr0')) : 0;
            decimal quantity = ar.get('expr1') != null ? decimal.valueof(''+ar.get('expr1')) : 0;
            if(productMap.containsKey(productId)){
                if(topSellingProductList.size() == LIMIT_10)
                    break;
                string productName = productMap.get(productId).Product_Short_Description__c;
                string priceBookId = productMap.get(productId).PricebookEntries.size() > 0 ? productMap.get(productId).PricebookEntries[0].id : '';
                topSellingProductList.add(new TopSellingProducts(priceBookId,productName,productMap.get(productId).Family,quantity,price));   
            }
        }
        r.data.put('topSellingProductList', topSellingProductList);  
        return r;
    }
    private static AuraResponse getTopBuyingRetailers(AuraResponse r){
        list<TopBuyingRetailer>topBuyingRetailers = new list<TopBuyingRetailer>();
        Id brandId = Utility.loggedInUser.AccountId;
        Map<String,Line_Card__c>retailersMap = new Map<String,Line_Card__c>();
        List<String>ExcludedWarehouseDBAList = Excluded_Warehouse_DBA != null ? Excluded_Warehouse_DBA.split(';') : new List<String>();
        for(Line_Card__c lineCard: [select id,Retailer_Name__c,Retailer_Name__r.Name,Retailer_Name__r.DBA__c,Retailer_Name__r.BillingCity from Line_Card__c where Brand_Name__c = :brandId AND Retailer_Name__c != null AND Retailer_Name__r.DBA__c NOT IN: ExcludedWarehouseDBAList]){
            retailersMap.put(lineCard.Retailer_Name__c,lineCard);
        }
        if(retailersMap.size() > 0){
            AggregateResult[] groupedResults = [select Shipping_Manifest__r.Order_Number__r.Retailer__c retailer,sum(Line_Total_Price__c) from Shipping_Manifest_Line__c where Shipping_Manifest__r.RecordType.Name =: Shipping_Manifest_RecordType_RSM AND SMLine_Status__c =: SM_Line_Status_Shipment_Complete AND Shipping_Manifest__r.Ship_Confirmation_Date__c = LAST_N_Months:3 AND Shipping_Manifest__r.Order_Number__r.Retailer__c IN: retailersMap.keyset() AND Ownership_Code__c =: brandId  GROUP BY Shipping_Manifest__r.Order_Number__r.Retailer__c order by sum(Line_Total_Price__c) desc];		
            for (AggregateResult ar : groupedResults)  {
            	if(topBuyingRetailers.size() == LIMIT_25)
                    break;
                string retailerId = ''+ar.get('retailer');
                decimal price = decimal.valueof(''+ar.get('expr0'));
                topBuyingRetailers.add(new TopBuyingRetailer(retailerId,retailersMap.get(retailerId).Retailer_Name__r.DBA__c,retailersMap.get(retailerId).Retailer_Name__r.BillingCity,price)); 
            }
        }
        r.data.put('topBuyingRetailers', topBuyingRetailers);  
        return r;
    }
    private static AuraResponse getMGMData(AuraResponse r){        
        Id brandId = Utility.loggedInUser.AccountId;
        map<Integer,String>monthMap = new Map<Integer,String>{1 => 'Jan',2 => 'Feb',3 => 'Mar',4 => 'Apr',5 => 'May',6 => 'June',7 => 'July',8 => 'Aug',9 => 'Sep',10 => 'Oct',11 => 'Nov',12 => 'Dec'};
        Map<Integer,Decimal>MGMDataMap = new Map<Integer,Decimal>();
        //for(Shipping_Manifest_Line__c SMLine : [select id,Line_Total_Price__c,Line_Total_Cost__c,Shipping_Manifest__r.Ship_Confirmation_Date__c,Product_Name__c,Product_Name__r.Family from Shipping_Manifest_Line__c where SMLine_Status__c =: SM_Line_Status_Shipment_Complete AND Shipping_Manifest__r.Ship_Confirmation_Date__c = LAST_N_Months:6 AND Shipping_Manifest__r.Order_Number__r.Account__c =: brandId order by Shipping_Manifest__r.Ship_Confirmation_Date__c]){
        for(Invoice__c inv : [SELECT Id,Total_Product_Price__c,Ship_Confirmation_Date__c FROM Invoice__c WHERE (Ship_Confirmation_Date__c = LAST_N_Months:6 OR Ship_Confirmation_Date__c = THIS_MONTH) AND Is_Brand_Product__c = TRUE AND AR_Status__c =: Invoice_Ar_Status_Shipped AND RecordType.Name =: Invoice_Record_Type_Product  ORDER BY Ship_Confirmation_Date__c]){
        	integer monthNo = inv.Ship_Confirmation_Date__c.month(); 
            decimal price = MGMDataMap.containsKey(monthNo) ? MGMDataMap.get(monthNo) : 0;
            price += inv.Total_Product_Price__c;
            MGMDataMap.put(monthNo,price);
        }
        
        List<String>monthNameList = new List<String>();
        List<Decimal>MGMDataList = new List<Decimal>();
        Integer startMonth = system.today().addmonths(-5).month();
        Integer endMonth = startMonth + 6;
        Boolean hasValues = false;
        for(;startMonth<endMonth;startMonth++){
            Integer monthNo = startMonth <=12 ? startMonth : startMonth - 12;
        	monthNameList.add(monthMap.get(monthNo));  
            if(MGMDataMap.containsKey(monthNo)){
                hasValues = true;
                MGMDataList.add(MGMDataMap.get(monthNo));
            }else
                MGMDataList.add(0);
        }
        r.data.put('hasValues',hasValues);
        r.data.put('MGMData',MGMDataList);
        r.data.put('monthNameList',monthNameList);
        return r;
    }
    private static AuraResponse getAgingInvnetoryData(AuraResponse r,String brandId){
        Set<String>siteNameSet = New Set<String>();
        Map<String,List<Decimal>>agingInventoryDataMap = new Map<String,List<Decimal>>();
        Map<String,Decimal>inventoryMap = new Map<String,Decimal>();
        List<String>agedBucketList = New List<String>{'30 or Less Days', '31 to 60 Days', '61 to 90 Days', '91 to 120 Days', '121 to 150 Days', '151 to 180 Days', '181 or More Days'};
        List<String>Not_Include_LocationList = Not_Include_Location != Null && Not_Include_Location != '' ? Not_Include_Location.split(',') : new List<String>();
        if(Not_Include_Location_For_Aging_Chart != Null && Not_Include_Location_For_Aging_Chart != '')
        	Not_Include_LocationList.addAll(Not_Include_Location_For_Aging_Chart.split(','));
		for(Inventory_Position__c invPos : [SELECT Id,Days_in_Inventory__c,Site__c,Site__r.Name,Inventory_Qty__c FROM 
			Inventory_Position__c WHERE Site__c != NULL AND Inventory_Location__r.Name NOT IN: Not_Include_LocationList AND  
			Is_Brand_Product__c = TRUE AND (( Product_Name__r.Producer_Name__c =: brandId AND Product_Name__r.White_Labelled__c = false) OR (Product_Name__r.Licensee_Name__c = :brandId AND Product_Name__r.White_Labelled__c = true)) Order by Site__r.Name]){
        	
            String agedBucketStr = HomeController.getAgedBucketStr(invPos.Days_in_Inventory__c);                  
            siteNameSet.add(invPos.Site__r.Name);
            String mapKey = agedBucketStr + invPos.Site__r.Name;
            Decimal qty = inventoryMap.containsKey(mapKey) ? inventoryMap.get(mapKey) : 0;
            qty += invPos.Inventory_Qty__c;
            inventoryMap.put(mapKey,qty);  
		}
        for(String siteName : siteNameSet){
            List<Decimal>inventoryQtyList = new List<Decimal>();
            for(String agedBucket : agedBucketList){
                String mapKey = agedBucket + siteName;
                Decimal qty = inventoryMap.containsKey(mapKey) ? inventoryMap.get(mapKey) : 0;
                inventoryQtyList.add(qty);
            }
            agingInventoryDataMap.put(siteName,inventoryQtyList);  
        }
        List<String>colorCodeList = new List<String>{'#518397', '#D1E0E6'};/*'#C7F296', '#94E7A9'*/
        r.data.put('agingInventoryData', agingInventoryDataMap);
        r.data.put('agedBucketList',agedBucketList);
        r.data.put('agingColorCodeList',colorCodeList);
        return r;
    }
    private Static String getAgedBucketStr(Decimal inventoryDays){
    	String agedBucketStr = '';
        if(inventoryDays == null || inventoryDays <= 30)
            agedBucketStr = '30 or Less Days';
        else if(inventoryDays > 30 && inventoryDays < = 60)
            agedBucketStr = '31 to 60 Days';
        else if(inventoryDays > 60 && inventoryDays < = 90)
            agedBucketStr = '61 to 90 Days';
        else if(inventoryDays > 90 && inventoryDays < = 120)
            agedBucketStr = '91 to 120 Days';
        else if(inventoryDays > 120 && inventoryDays < = 150)
            agedBucketStr = '121 to 150 Days';
        else if(inventoryDays > 150 && inventoryDays < = 180)
            agedBucketStr = '151 to 180 Days';
        else if(inventoryDays > 180)
            agedBucketStr = '181 or More Days';
        return agedBucketStr;
    }
    public class TopBuyingRetailer{
    	@AuraEnabled public string retailerId;
        @AuraEnabled public string retailerDba;
        @AuraEnabled public string retailercity;
        @AuraEnabled public decimal totalPrice;
        public TopBuyingRetailer(string rid,string rDba,string rCity,decimal tPrice){
        	retailerId = rid;
            retailerDba = rDba;
            retailercity = rCity;
            totalPrice = tPrice;
        }
    }
    public class TopSellingProducts{
        @AuraEnabled public string priceBookEntryId;
        @AuraEnabled public string productName;
        @AuraEnabled public string productFamily;
        @AuraEnabled public decimal Quantity;
        @AuraEnabled public decimal totalPrice;
        public TopSellingProducts(string pbeId,string pName,string pFmly,decimal qty,decimal tPrice){
        	priceBookEntryId = pbeId;
            productName =pName;
            productFamily = pFmly;
            Quantity = qty;
            totalPrice =tPrice;
        }
    }
}