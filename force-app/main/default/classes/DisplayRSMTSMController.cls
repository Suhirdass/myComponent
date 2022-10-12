/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* DisplayRSMTSMController
*/
public with sharing class DisplayRSMTSMController
{
    
    public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }  
    public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transfer');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CCollection');
        }set;
    }
    public Static String SALES_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    public Static String PURCHASE_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_APPROVED) ? PURCHASE_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Approved');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
    public Static String SALES_ORDER_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SALES_ORDER_RECORDTYPE_TRANSFER) ? SALES_ORDER_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Transfer');
        }set;
    }
    public Static String SALES_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(SALES_ORDER_RECORDTYPE_PRODUCT) ? SALES_ORDER_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Product');
        }set;
    }
    Public Static String message{
        get{
            return String.isNotBlank(message) ? message : Label.Select_Vehicle;
        }set;
    } 
    public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    } 
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STRING_PUBLISHED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STRING_PUBLISHED) ? SHIPPING_MANIFEST_STRING_PUBLISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_String_Published');
        }set;
    }

    private Id rsmRecordTypeId;
    private Id rsmTransferRecordTypeId;
    private Id rsmCashCollectionRecordTypeId;
    private Id tsmRecordTypeId;
    private Id poProductRecordTypeId;
    private Id soProductRecordTypeId;
    private Id soTransferRecordTypeId;
    
    public Date dat {get;set;}
    public Date datTwo {get; set;}

    @AuraEnabled 
    public List<rsmRecordWrapper> setRsmList {get; set;}
    
    @AuraEnabled 
    public List<tsmRecordWrapper> setTsmList {get; set;}
    
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public class rsmRecordWrapper{
        @AuraEnabled public Id siteId{get;set;}
        @AuraEnabled public String siteName{get;set;}
        @AuraEnabled public Date shipDate{get;set;} 
        @AuraEnabled public string status{get;set;} 
        @AuraEnabled public string metrc{get;set;}
        @AuraEnabled public Id soId{get;set;}
        @AuraEnabled public string soName{get;set;}
        @AuraEnabled public Id smId{get;set;} 
        @AuraEnabled public string smName{get;set;}
        @AuraEnabled public Id oppId{get;set;} 
        @AuraEnabled public string oppName{get;set;} 
        @AuraEnabled public Id vehicleId{get;set;}
        @AuraEnabled public string vehicleName{get;set;}
        @AuraEnabled public Id driverId{get;set;}
        @AuraEnabled public string driverName{get;set;}
        @AuraEnabled public string recieverName{get;set;}
        @AuraEnabled public Time windowStart{get;set;}
        @AuraEnabled public Time windowEnd{get;set;}
        @AuraEnabled public string recordTypeId{get;set;}
        @AuraEnabled public string recordTypeName{get;set;}
        @AuraEnabled public string baseUrl{get;set;}
    }
    
    public class tsmRecordWrapper{
        @AuraEnabled public Id siteId{get;set;}
        @AuraEnabled public String siteName{get;set;}
        @AuraEnabled public Date shipDate{get;set;} 
        @AuraEnabled public string status{get;set;} 
        @AuraEnabled public Id poId{get;set;}
        @AuraEnabled public string poName{get;set;}
        @AuraEnabled public Id smId{get;set;} 
        @AuraEnabled public string smName{get;set;}
        @AuraEnabled public Id oppId{get;set;} 
        @AuraEnabled public string oppName{get;set;} 
        @AuraEnabled public Id vehicleId{get;set;}
        @AuraEnabled public string vehicleName{get;set;}
        @AuraEnabled public Id driverId{get;set;}
        @AuraEnabled public string driverName{get;set;}
        @AuraEnabled public string priority{get;set;}
        @AuraEnabled public string recordTypeId{get;set;}
        @AuraEnabled public string recordTypeName{get;set;}
        @AuraEnabled public string baseUrl{get;set;}
    }
    // Constructor - Initialize the values
    public DisplayRSMTSMController(){
        dat = date.today().addDays(-3);
        datTwo = date.today().addDays(4);
        
        setRsmList = new List<rsmRecordWrapper>();
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        rsmTransferRecordTypeId = ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER);
        rsmCashCollectionRecordTypeId = ShippinManifestSupport.getCashCollectionRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION);
        poProductRecordTypeId = ShippinManifestSupport.getPOProductRecordTypeId(PURCHASE_ORDER_RECORDTYPE_PRODUCT);
        soProductRecordTypeId = ShippinManifestSupport.getSOProductRecordTypeId(SALES_ORDER_RECORDTYPE_PRODUCT);
        soTransferRecordTypeId = ShippinManifestSupport.getSOTransferRecordTypeId(SALES_ORDER_RECORDTYPE_TRANSFER);
    }   
    
    @AuraEnabled
    public static AuraResponse displayRSMTSM(){
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.displayRSMTSM()');
        DisplayRSMTSMController displayRsmTsm = new DisplayRSMTSMController();
        displayRsmTsm.retreiveTSMRSM();
        r.data.put('dat',displayRsmTsm.dat);
        r.data.put('datTwo',displayRsmTsm.datTwo);
        r.data.put('setRsmList',displayRsmTsm.setRsmList);
        r.data.put('setTsmList',displayRsmTsm.setTsmList);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRSMTSM(Date fromDate, Date toDate){
        
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.getRSMTSM()');
        DisplayRSMTSMController displayRsmTsm = new DisplayRSMTSMController();
        displayRsmTsm.dat = fromDate;
        displayRsmTsm.datTwo = toDate;
        displayRsmTsm.retreiveTSMRSM();
        r.data.put('dat',displayRsmTsm.dat);
        r.data.put('datTwo',displayRsmTsm.datTwo);
        r.data.put('setRsmList',displayRsmTsm.setRsmList);
        r.data.put('setTsmList',displayRsmTsm.setTsmList);
        
        return r;  
    }
    
    public void retreiveTSMRSM(){
        List<rsmRecordWrapper> lstRsm = new List<rsmRecordWrapper>();
        Map<Id,Shipping_Manifest__c> smMap = new Map<Id,Shipping_Manifest__c>();
        Map<Id,Shipping_Manifest__c> smMapTsm = new Map<Id,Shipping_Manifest__c>();
        List<String> status = new List<String>();
        status.add(SHIPPING_MANIFEST_STATUS_PENDING);
        status.add(SHIPPING_MANIFEST_STATUS_DRAFT);
        List<String> recordtypeCheck = new List<String>();
        recordtypeCheck.add(rsmRecordTypeId);
        recordtypeCheck.add(rsmCashCollectionRecordTypeId);
        recordtypeCheck.add(rsmTransferRecordTypeId);    
        List<String> soRecordType = new List<String>();
        soRecordType.add(soProductRecordTypeId);
        soRecordType.add(soTransferRecordTypeId);  
        String baseSUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        
        List<Sales_Order__c>  soList = [SELECT Id, name, Site__c, Planned_Ship_Date__c, SO_Status__c, Receiver_DBA__c,Site__r.Name, Opportunity_Name__r.Name, Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c, Vehicle__r.Name,Window_Start__c, Window_End__c,
                                        (SELECT Id, Name, Site__c, Site__r.Name, Sales_Order__c, Receiver_DBA__c,  Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c 
                                         FROM  Shipping_Manifests__r 
                                         WHERE (Planned_Ship_Transfer_Date__c <=: datTwo AND Planned_Ship_Transfer_Date__c >=: dat))
                                        FROM  Sales_Order__c WHERE SO_Status__c =: SALES_ORDER_STATUS_APPROVED AND (Planned_Ship_Date__c <=: datTwo AND Planned_Ship_Date__c >=: dat) order by Planned_Ship_Date__c]; 
      
      
                    Id SMRecordTypeID   = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION).getRecordTypeId();

        List<Shipping_Manifest__c> smlst =new list<Shipping_Manifest__c>();
        set<id> smids = new set<id>();
       
         for(Shipping_Manifest__c sm: [SELECT Id, Name, Site__c, Site__r.Name, Sales_Order__c, Receiver_DBA__c,  Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c 
                                         FROM  Shipping_Manifest__c
                                         WHERE (Planned_Ship_Transfer_Date__c <=: datTwo AND Planned_Ship_Transfer_Date__c >=: dat) AND RecordTypeId =: SMRecordTypeID order by RecordType.Name DESC ])
                { 
                smids.add(sm.Id);
           
                }
        List<Shipping_Manifest__c> smrec= [SELECT Id, Window_End__c,Window_Start__c,Name, Site__c, Site__r.Name, Sales_Order__c, Receiver_DBA__c,  Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c 
                                         FROM  Shipping_Manifest__c where (Planned_Ship_Transfer_Date__c <=: datTwo AND Planned_Ship_Transfer_Date__c >=: dat) AND RecordTypeId =: SMRecordTypeID AND Status__c NOT IN (:SHIPPING_MANIFEST_STATUS_REJECTED,:SHIPPING_MANIFEST_STATUS_CANCELLED,:SHIPPING_MANIFEST_STATUS_COMPLETE,:SHIPPING_MANIFEST_STATUS_INTRANSIT) ];
                                         
                
       for(Shipping_Manifest__c sm:smrec )
                 {
                    rsmRecordWrapper objWrapper = new rsmRecordWrapper();
                   objWrapper.siteId = sm.Site__c;
                    objWrapper.siteName = sm.Site__r.Name;
                    objWrapper.shipDate = sm.Planned_Ship_Transfer_Date__c;
                    objWrapper.status = sm.Status__c;
                    objWrapper.metrc = sm.Metrc_Manifest__c;
                    objWrapper.smId = sm.Id;
                    objWrapper.smName = sm.Name;
                    objWrapper.oppId = sm.Opportunity_Name__c;
                    objWrapper.oppName = sm.Opportunity_Name__r.Name;
                    objWrapper.vehicleId = sm.Vehicle__c;
                    objWrapper.vehicleName = sm.Vehicle__r.Name;
                    objWrapper.driverId = sm.Driver__c;
                    objWrapper.driverName = sm.Driver__r.Name;
                    objWrapper.recieverName = sm.Receiver_DBA__c;
                    objWrapper.windowStart = sm.Window_Start__c;
                   objWrapper.windowEnd = sm.Window_End__c;
                    objWrapper.recordTypeId = sm.RecordTypeId;
                    objWrapper.recordTypeName = sm.RecordType.Name;
                    objWrapper.baseUrl = baseSUrl;
                   lstRsm.add(objWrapper);
                 }
        
        
      
        for(Sales_Order__c so:soList)
        { 
            if(so.Shipping_Manifests__r.size()>0){
                 for(Shipping_Manifest__c sm:so.Shipping_Manifests__r )
                 {
                  if(soRecordType.contains(so.RecordTypeId) && recordtypeCheck.contains(sm.RecordTypeId) && status.contains(sm.Status__c)) 
                   {
                    rsmRecordWrapper objWrapper = new rsmRecordWrapper();
                    objWrapper.siteId = so.Site__c;
                    objWrapper.siteName = so.Site__r.Name;
                    objWrapper.shipDate = sm.Planned_Ship_Transfer_Date__c;
                    objWrapper.status = sm.Status__c;
                    objWrapper.metrc = sm.Metrc_Manifest__c;
                    objWrapper.soId = so.Id;
                    objWrapper.soName = so.Name;
                    objWrapper.smId = sm.Id;
                    objWrapper.smName = sm.Name;
                    objWrapper.oppId = sm.Opportunity_Name__c;
                    objWrapper.oppName = sm.Opportunity_Name__r.Name;
                    objWrapper.vehicleId = sm.Vehicle__c;
                    objWrapper.vehicleName = sm.Vehicle__r.Name;
                    objWrapper.driverId = sm.Driver__c;
                    objWrapper.driverName = sm.Driver__r.Name;
                    objWrapper.recieverName = so.Receiver_DBA__c;
                    objWrapper.windowStart = so.Window_Start__c;
                    objWrapper.windowEnd = so.Window_End__c;
                    objWrapper.recordTypeId = sm.RecordTypeId;
                    objWrapper.recordTypeName = sm.RecordType.Name;
                    objWrapper.baseUrl = baseSUrl;
                    lstRsm.add(objWrapper);
                 }
                 }
               
            }
            else if(soRecordType.contains(so.RecordTypeId)){
                rsmRecordWrapper objWrapper = new rsmRecordWrapper();
                objWrapper.siteId = so.Site__c;
                objWrapper.siteName = so.Site__r.Name;
                objWrapper.shipDate = so.Planned_Ship_Date__c;
                objWrapper.status = null;
                objWrapper.metrc = null;
                objWrapper.soId = so.Id;
                objWrapper.soName = so.Name;
                objWrapper.smId = null;
                objWrapper.smName = null;
                objWrapper.oppId = so.Opportunity_Name__c;
                objWrapper.oppName = so.Opportunity_Name__r.Name;
                objWrapper.vehicleId = so.Vehicle__c;
                objWrapper.vehicleName = so.Vehicle__r.Name;
                objWrapper.driverId = so.Driver__c;
                objWrapper.driverName = so.Driver__r.Name;
                objWrapper.recieverName = so.Receiver_DBA__c;
                objWrapper.windowStart = so.Window_Start__c;
                objWrapper.windowEnd = so.Window_End__c;
                objWrapper.recordTypeId = so.RecordTypeId;
                objWrapper.recordTypeName = so.RecordType.Name;
                objWrapper.baseUrl = baseSUrl;
                lstRsm.add(objWrapper);
            }
        }
        setRsmList = lstRsm;
        
        List<tsmRecordWrapper> lstTsm = new List<tsmRecordWrapper>();
        
        List<Purchase_Order__c>  purchaseOrderList=[select Id, Name, Site__c, Planned_Ship_Transfer_Date__c, Site__r.Name, Opportunity_Name__r.Name, Site__r.Id, 
                                                    Driver__c, Driver__r.Name, PO_Status__c, RecordTypeId, RecordType.Name, Vehicle__c, Vehicle__r.Name,
                                                    (SELECT Id, Name, Site__c, Purchase_Order__c,  Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, 
                                                     Opportunity_Name__c, Opportunity_Name__r.Name, Status__c, Priority__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name
                                                     FROM  Shipping_Manifests__r where (Planned_Ship_Transfer_Date__c <=: datTwo AND Planned_Ship_Transfer_Date__c >=: dat)) 
                                                    FROM Purchase_Order__c where PO_Status__c =: PURCHASE_ORDER_STATUS_APPROVED AND (Planned_Ship_Transfer_Date__c <=: datTwo AND Planned_Ship_Transfer_Date__c >=: dat)];
        
        for(Purchase_Order__c po: purchaseOrderList){
            if(po.Shipping_Manifests__r.size()>0){
                for(Shipping_Manifest__c sm : po.Shipping_Manifests__r){
                     if(po.RecordTypeId == poProductRecordTypeId && sm.RecordTypeId == tsmRecordTypeId && status.contains(sm.Status__c)) 
                   {
                    tsmRecordWrapper objWrapper = new tsmRecordWrapper();
                    objWrapper.siteId = po.Site__c;
                    objWrapper.siteName = po.Site__r.Name;
                    objWrapper.shipDate = sm.Planned_Ship_Transfer_Date__c;
                    objWrapper.status = sm.Status__c;objWrapper.poId = po.Id;
                    objWrapper.poName = po.Name; objWrapper.smId = sm.Id;
                    objWrapper.smName = sm.Name;objWrapper.oppId = sm.Opportunity_Name__c;objWrapper.oppName = sm.Opportunity_Name__r.Name;
                    objWrapper.vehicleId = sm.Vehicle__c; objWrapper.vehicleName = sm.Vehicle__r.Name;
                       if(sm.Driver__c != null)
                       {
                          objWrapper.driverId = sm.Driver__c;
                    objWrapper.driverName = sm.Driver__r.Name;  
                       }
                       else{
                    objWrapper.driverName = 'None';  
                       }
                    objWrapper.priority  = sm.Priority__c;objWrapper.recordTypeId = sm.RecordTypeId;
                    objWrapper.recordTypeName = sm.RecordType.Name;objWrapper.baseUrl = baseSUrl;
                    lstTsm.add(objWrapper);
                   }
                }  
            }else if(po.RecordTypeId == poProductRecordTypeId){
                tsmRecordWrapper objWrapper = new tsmRecordWrapper();
                objWrapper.siteId = po.Site__c;
                objWrapper.siteName = po.Site__r.Name;
                objWrapper.shipDate = po.Planned_Ship_Transfer_Date__c;
                objWrapper.status = null;
                objWrapper.poId = po.Id;
                objWrapper.poName = po.Name;  objWrapper.smId = null; objWrapper.smName = null; objWrapper.oppId = po.Opportunity_Name__c;  objWrapper.oppName = po.Opportunity_Name__r.Name;
                objWrapper.vehicleId = po.Vehicle__c; objWrapper.vehicleName = po.Vehicle__r.Name;
                if(po.Driver__c!= null)
                {
                    objWrapper.driverId = po.Driver__c;objWrapper.driverName = po.Driver__r.Name;
                }
                else{
                 
                    objWrapper.driverName = 'None';  
                }
                
                objWrapper.recordTypeId = po.RecordTypeId; objWrapper.recordTypeName = po.RecordType.Name; objWrapper.baseUrl = baseSUrl; lstTsm.add(objWrapper);
            }         
        }
        
        setTsmList = lstTsm;
        
    }
    
    @AuraEnabled
    public static AuraResponse getActiveDrivers(){
        List<Drivers__c> lstDrivers= [select Id, name From Drivers__c  where Active__c =true AND Expiration_Date__c >=TODAY order by name];
    
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.getActiveDrivers()');
        r.data.put('activeDrivers',lstDrivers);
        return r; 
    }
    
    @AuraEnabled
    public static AuraResponse getActiveVechile(){
        List<Vehicles__c> lstVehicles= [select Id, name,Refrigerated__c From Vehicles__c where Vehicle_in_Use__c = true AND Tag_Expiration_Date__c >=TODAY order by name];
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.getActiveVechile()');
        r.data.put('activeVehicles',lstVehicles);
        return r; 
    }
    
    @AuraEnabled
    public static AuraResponse updateSMData(String totalSMRecord, String totalPORecord, String totalSORecord){ 
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.updateSMData()');
        List<Object> smList = new List<Object>();
        List<Object> soList = new List<Object>(); 
        List<Object> poList = new List<Object>();
       
        List<Shipping_Manifest__c> updateList = new List<Shipping_Manifest__c>();
        List<Sales_Order__c> soUpdateList = new List<Sales_Order__c>();
        List<Purchase_Order__c> poUpdateList = new List<Purchase_Order__c>();
        smList = (List<Object>) JSON.deserializeUntyped(totalSMRecord);
        poList = (List<Object>) JSON.deserializeUntyped(totalPORecord);
        soList = (List<Object>) JSON.deserializeUntyped(totalSORecord);

        if(smList.size()>0){
            Id driverIds = null;
            for(Object  obj:smList){
                Map<String,Object> respMap= (Map<String,Object>)obj;
                Shipping_Manifest__c smobj = new Shipping_Manifest__c();
                smobj.Id = (String)respMap.get('smId');
                if((String)respMap.get('shipDate')!=''){
                    Date convertDate = Date.valueOf((String)respMap.get('shipDate'));
                    smobj.Planned_Ship_Transfer_Date__c = convertDate;  
                }
                if((String)respMap.get('driverId')!=''){
                    smobj.Driver__c = (String)respMap.get('driverId');  
                }else{
                   string driversmname = (String)respMap.get('driverName');smobj.Driver__c = driverIds;
                      
                }
                if((String)respMap.get('metrc')!=''){
                    smobj.Metrc_Manifest__c = (String)respMap.get('metrc');
                }
                if((String)respMap.get('vehicleId')!='')
                {
                    smobj.Vehicle__c = (String)respMap.get('vehicleId');
                }else{ smobj.Vehicle__c = driverIds;   
                }
                 if(respMap.containsKey('windowStart'))
                {
                    String startTime = (String)respMap.get('windowStart');
                    String[] strTimeSplit = startTime.split(':');
                    Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0,0);
                    smobj.Window_Start__c = timeChange;
                }
                if(respMap.containsKey('windowEnd')) {  String startTime = (String)respMap.get('windowEnd');
                    String[] strTimeSplit = startTime.split(':');
                    Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0,0);
                    smobj.Window_End__c = timeChange;
                }
                
                updateList.add(smobj);
            }
            update updateList; 
         
        }
        if(poList.size()>0){ Id driverIds = null;
            for(Object  obj:poList){
                Map<String,Object> respMap= (Map<String,Object>)obj;
                Purchase_Order__c pobj = new Purchase_Order__c();
                pobj.Id = (String)respMap.get('poId');
                if((String)respMap.get('shipDate')!=''){  Date convertDate = Date.valueOf((String)respMap.get('shipDate'));
                    pobj.Planned_Ship_Transfer_Date__c =  convertDate;
                }
                if((String)respMap.get('driverId')!=''){  pobj.Driver__c = (String)respMap.get('driverId');  
                }else{
                 pobj.Driver__c = driverIds;   
                }
                if((String)respMap.get('vehicleId')!='') {  pobj.Vehicle__c = (String)respMap.get('vehicleId');
                }else{
                 pobj.Vehicle__c = driverIds;   
                }
                poUpdateList.add(pobj);
            }
            update poUpdateList; 
        }
        if(soList.size()>0){
              Id driverIds = null;
            for(Object  obj:soList){
                Map<String,Object> respMap= (Map<String,Object>)obj;
                Sales_Order__c sobj = new Sales_Order__c();
                sobj.Id = (String)respMap.get('soId');
                if((String)respMap.get('shipDate')!=''){
                    Date convertDate = Date.valueOf((String)respMap.get('shipDate'));
                    sobj.Planned_Ship_Date__c = convertDate;  
                }
                if((String)respMap.get('driverId')!=''){
                    sobj.Driver__c = (String)respMap.get('driverId');  
                }else{
                 sobj.Driver__c = driverIds;   
                }
                
                if(respMap.containsKey('windowStart'))
                {
                    String startTime = (String)respMap.get('windowStart');
                    String[] strTimeSplit = startTime.split(':');
                    Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0,0);
                    sobj.Window_Start__c = timeChange;
                }
                if(respMap.containsKey('windowEnd')) {  String startTime = (String)respMap.get('windowEnd');
                    String[] strTimeSplit = startTime.split(':');
                    Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0,0);
                    sobj.Window_End__c = timeChange;
                }
                if((String)respMap.get('vehicleId')!='')
                {
                    sobj.Vehicle__c = (String)respMap.get('vehicleId');
                }else{
                 sobj.Vehicle__c = driverIds;   
                }
                if(sobj.Id!=NULL){
                     soUpdateList.add(sobj); 
                }
               
            }
            if(soUpdateList.size() > 0){
                update soUpdateList; 
            }
            
            
        }
        return r;
    }
    
    
    
    // New Route schedule
   
     /** Method to return data to component **/
    
            @AuraEnabled 
    public List<Route_Schedule__c> setRouteData {get; set;}
    
         @AuraEnabled 
    public List<Route_Schedule__c> setShipLines {get; set;}
    
    public Route_Schedule__c setRouteSchedule {get; set;}
    public List<Route_Schedule_Line__c> setRsLines {get; set;}
    
    
    @AuraEnabled
    public static AuraResponse getRouteSchedule(String selectedDays){
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.getRouteSchedule()');
        DisplayRSMTSMController assign = new DisplayRSMTSMController();
        Date newDate = Date.valueOf(selectedDays); 
        DateTime dt = (DateTime)Cache.Session.get('datetime');
        r.data.put('dt',dt);
        assign.setRouteData = getRouteScheduleData(newDate);
        r.data.put('setShipLines', assign.setRouteData);
        return r;
    }  
    
    @AuraEnabled  
    public static List<Route_Schedule__c> getRouteScheduleData(Date selectedDay) { 
        
        Date newDate = Date.valueOf(selectedDay); system.debug('selectedDay>>'+selectedDay);
        List<Route_Schedule__c> res = new LIST<Route_Schedule__c>();  
        res = [SELECT Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Site__c,Site__r.Name,VehicleId__c FROM Route_Schedule__c WHERE Route_Date__c=:newDate ];
        return res;
    }
    

    
    
     /*** 
    
    **/ 
    
    @AuraEnabled
    public static AuraResponse getDataLight(String recordId){
        
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.getDataLight()');
        DisplayRSMTSMController assign = new DisplayRSMTSMController();
                Route_Schedule__c routeRes = [Select Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Address__c  From Route_Schedule__c where Id =: recordId  Limit 1];

        assign.setRouteSchedule = getRouteInfo(recordId);
        assign.setRsLines = getRouteScheduleLineData(recordId);
               r.data.put('assignedVehicleId', routeRes.Vehicle__c); 
        r.data.put('assignedDriverId', routeRes.Driver__c); 
        r.data.put('setRouteSchedule', assign.setRouteSchedule);
        r.data.put('setRsmLines', assign.setRsLines); 
      
        return r;
    }
    
        
      public static Route_Schedule__c getRouteInfo(String recordId){
        
        Route_Schedule__c routeRes = [Select Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Address__c,Route_Name__c,Site__c,Site__r.Name,VehicleId__c  From Route_Schedule__c where Id =: recordId  Limit 1];
        return routeRes;
    }
    
    
    @AuraEnabled  
    public static List<Route_Schedule_Line__c> getRouteScheduleLineData(String recordId) { 
        
        List<Route_Schedule_Line__c> res = new LIST<Route_Schedule_Line__c>();  
        res = [SELECT Id, Name,Window_Start__c,Window_End__c,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,Purchase_Order__r.Name,Shipping_Manifest__c,Shipping_Manifest__r.Name,Planned_Arrival_Time__c,Planned_Departure_Time__c,Route_Schedule__r.Address__c,Delivery_Address__c,Schedule_sequence__c,Route_Schedule__r.Site__c,Route_Schedule__r.Site__r.Name FROM Route_Schedule_Line__c WHERE Route_Schedule__c=:recordId ORDER BY Schedule_sequence__c,Planned_Arrival_Time__c ASC ];
        return res;
    }
    
    @AuraEnabled
    public static AuraResponse assignDriverVehicle(Id recordId, Id driverId, Id vehicleId, Date shmainDate){
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.assignDriverVehicle()'); 
        system.debug('shmainDate>>'+shmainDate);
        List<Route_Schedule__c> updateRoute = [SELECT Id,Driver__c,Vehicle__c  FROM Route_Schedule__c WHERE Id =: recordId];
        
        for(Route_Schedule__c res : updateRoute){
            res.Driver__c = driverId;
            res.Vehicle__c = vehicleId;
        }
        
        try {
            if(updateRoute.size() > 0) 
            {
                update updateRoute;
            } 
            
        } catch (Exception ex){
            ErrorLogs.log('DisplayRSMTSMController:assignDriver()', ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); message = String.valueOf(msg); r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }
    
     @AuraEnabled
    public static AuraResponse publishRoute(Id recordId){
        AuraResponse r = new AuraResponse('DisplayRSMTSMController.assignDriverVehicle()'); 
        
        List<Route_Schedule__c> updateRoute = [SELECT Id,Status__c  FROM Route_Schedule__c WHERE Id =: recordId];
        
        for(Route_Schedule__c res : updateRoute){
            res.Status__c = SHIPPING_MANIFEST_STRING_PUBLISHED;
        }
        
        try {
            if(updateRoute.size() > 0) 
            {
                update updateRoute;
            } 
            
        } catch (Exception ex){
            ErrorLogs.log('DisplayRSMTSMController:assignDriver()',  ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); message = String.valueOf(msg); r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }
   
}