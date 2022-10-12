public class CancelledPickListCtrl {
    private Static String STATUS_CANCELLED{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','PicklistLine_Cancelled');
        }set;
    }
    private Static String STATUS_QAREVIEW{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_QAReveiew');
        }set;
    }
    private Static String STATUS_OPEN{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_Open');
        }set;
    }
    
    private Static String STATUS_SALESORDERLINECANCELLED{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SalesOrderLines_Cancelled');
        }set;
    }
    public Static String STATUS_ORDERCANCELLEDBYFILIGREEN{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    public Static String STATUS_SALESORDERCANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERCANCELLED) ? STATUS_SALESORDERCANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SalesOrder_Cancelled');
        }set;
    }
    public Static String STATUS_BRANDQUOTECANCELLED{
        get{
            return String.isNotBlank(STATUS_BRANDQUOTECANCELLED) ? STATUS_BRANDQUOTECANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Cancelled');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private Static String PRODUCT_NAME_MILEAGE_FEE{
        get{
            return String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_WEIGHT_FEE{
        get{
            return String.isNotBlank(PRODUCT_NAME_WEIGHT_FEE) ? PRODUCT_NAME_WEIGHT_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Weight_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_STAGE_MANIFEST{
        get{
            return String.isNotBlank(PRODUCT_NAME_STAGE_MANIFEST) ? PRODUCT_NAME_STAGE_MANIFEST: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Stage_Manifest');
        }set;
    }
    public static String SOLI_STATUS_OPEN{
        get{
            return String.isNotBlank(SOLI_STATUS_OPEN) ? SOLI_STATUS_OPEN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Open');
        }set;
    }
    public static String Receiving_Inspection{
        get{
            return String.isNotBlank(Receiving_Inspection) ? Receiving_Inspection : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Receiving_Inspection');
        }set;
    }
    public static String Invoice_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Invoice_Line_Status_Cancelled) ? Invoice_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Cancelled');
        }set;
    }
    public Static String PRODUCT_RECORDTYPE_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORDTYPE_DISCOUNT) ? PRODUCT_RECORDTYPE_DISCOUNT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    public Static String PRODUCT_RECORDTYPE_MOV_FEE{
        get{
            return String.isNotBlank(PRODUCT_RECORDTYPE_MOV_FEE) ? PRODUCT_RECORDTYPE_MOV_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_MOV_Fee');
        }set;
    }
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }
    private static String FULFILLMENT_SERVICE_CHANGE_FEE{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_CHANGE_FEE) ? FULFILLMENT_SERVICE_CHANGE_FEE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Change_Fee');
        }set;
    }
    private static String Invoice_Record_Type_Product{
        get{
            return String.isNotBlank(Invoice_Record_Type_Product) ? Invoice_Record_Type_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    private static String Invoice_Record_Type_Service{
        get{
            return String.isNotBlank(Invoice_Record_Type_Service) ? Invoice_Record_Type_Service : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Service');
        }set;
    }
     private static String ERR_MSG_LA_SITE{
        get{
            return String.isNotBlank(ERR_MSG_LA_SITE) ? ERR_MSG_LA_SITE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_Cancel_PL_LASite');
        }set;
    }
    private static final String SO_STATUS_DRAFT = SalesOrderSupport.SO_STATUS_DRAFT;
    private static final String SO_LINE_STATUS_OPEN = SalesOrderSupport.SO_LINE_STATUS_OPEN; 
    private static final String SO_LINE_STATUS_CANCELLED = SalesOrderSupport.SO_LINE_STATUS_CANCELLED; 
    public static boolean CANCELPICKLIST = False;    
    @Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.getRecordName()');
        String objName = recordId.getSObjectType().getDescribe().getName();
        String q = 'SELECT Name,Status__c FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            r.data.put('name', (String) (records[0].get('Name')));
            r.data.put('status', (String) (records[0].get('Status__c')));
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse cancelOrder(String PLId){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.cancelOrder()');
        CANCELPICKLIST = True;
        List<Picklist__c> lstPick = [SELECT Id,Status__c,Site__c,Sales_Order__c,Sales_Order__r.Id,Sales_Order__r.Opportunity_Name__c,Sales_Order__r.Opportunity_Name__r.Order__c,(SELECT id,Status__c FROM Picklist_Lines__r) FROM Picklist__c WHERE Id =: PLId];
        
        List<Brand_Quote__c> bqList = new List<Brand_Quote__c>();
        List<Brand_Quote_Line__c> bqLineList = new List<Brand_Quote_Line__c>();
        for(Brand_Quote__c bq : [SELECT id,BQ_Status__c,(SELECT Id,Status__c FROM Brand_Quote_Lines__r) FROM Brand_Quote__c WHERE Opportunity_Name__c =: lstPick[0].Sales_Order__r.Opportunity_Name__c ]){
            bq.BQ_Status__c =STATUS_BRANDQUOTECANCELLED;
            bqList.add(bq);
            for(Brand_Quote_Line__c bql : bq.Brand_Quote_Lines__r){
                bql.Status__c =STATUS_CANCELLED;
                bqLineList.add(bql);
            }
        }
        
        Sales_Order__c so = [SELECT Id,SO_Status__c,(Select Id,Sales_Order__c, Qty_Allocated__c, Status__c From Sales_Order_Lines__r)
                             FROM Sales_Order__c WHERE Id =: lstPick[0].Sales_Order__c LIMIT 1];
        so.SO_Status__c = STATUS_CANCELLED;
        
        Order__c odr =[SELECT Id,Status__c,(SELECT id,Status__c,OrderLine_Status__c FROM Order_Line_Items__r) FROM Order__c WHERE Id =: lstPick[0].Sales_Order__r.Opportunity_Name__r.Order__c LIMIT 1];
        odr.Status__c =STATUS_ORDERCANCELLEDBYFILIGREEN;
        
        List<Order_Line_Item__c> oliList = new List<Order_Line_Item__c>();
        for(Order_Line_Item__c oli : odr.Order_Line_Items__r){
            oli.Status__c=STATUS_CANCELLED;
            oli.OrderLine_Status__c =STATUS_ORDERCANCELLEDBYFILIGREEN;
        }
        
        
        List<Invoice__c> invList = new List<Invoice__c>();
        List<Invoice__c> InvDelList =new List<Invoice__c>();
        for(Invoice__c inv : [SELECT id,AR_Status__c,RecordType.Name FROM Invoice__c WHERE Opportunity_Name__c =:lstPick[0].Sales_Order__r.Opportunity_Name__c]){
            if(inv.RecordType.Name == Invoice_Record_Type_Product || inv.RecordType.Name == INVOICE_RECORDTYPE_SERVICE){
                InvDelList.add(inv);
            }else{
                inv.AR_Status__c =STATUS_CANCELLED;
                invList.add(inv);
            }
        }
        List<Sales_Order_Line__c> soLinesList = new List<Sales_Order_Line__c>();
        
        Set<Id> soLineIds = new Set<Id>();
        
        // Iterate on all SO lines
        for(Sales_Order_Line__c soLineObj: so.Sales_Order_Lines__r){
            soLineIds.add(soLineObj.Id);
          
            soLinesList.add(soLineObj);
        }
        if(soLineIds.size() >0){
            
            List<Inventory_Position__c> lstInv = [select Id,Name,Inventory_Location__c,Sales_Order_Line__c,Qty_Allocated__c,Rack__c,Rack_Level__c,Bin_Location__c from Inventory_Position__c where Sales_Order_Line__c IN: soLineIds];
            
            if(lstPick.size() > 0){
                List<Inventory_Location__c> lstInvLoc = [select Id,Name from Inventory_Location__c where Name =: Receiving_Inspection AND Site_Name__c = :lstPick[0].Site__c];
               
                // List of Inventory Positions to Update
                List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
                
                   
                    if(lstPick[0].Status__c == STATUS_QAREVIEW){
                        for(Inventory_Position__c inv : lstInv){
                            if(lstInvLoc.size() > 0)  inv.Inventory_Location__c = lstInvLoc[0].Id;
                            inv.Rack__c = null;
                            inv.Rack_Level__c = null;
                            inv.Bin_Location__c = null;
                            inv.Sales_Order_Line__c = null;
                            inv.Qty_On_Hand__c =inv.Qty_Allocated__c;
                            inv.Qty_Allocated__c = 0.0;
                        }
                    } else if(lstPick[0].Status__c == STATUS_OPEN){
                        for(Inventory_Position__c inv : lstInv){
                            
                            inv.Sales_Order_Line__c = null;
                            inv.Qty_On_Hand__c =inv.Qty_Allocated__c;
                            inv.Qty_Allocated__c = 0.0;
                        }
                    }
                
                if(lstInv.size() > 0){
                    update lstInv;
                }
                    // List of Inventory Position By Sales Order Line Id
                    Map<Id, List<Inventory_Position__c>> inventoryPositionsBySOLineId = new Map<Id, List<Inventory_Position__c>>();
                    
                    if(soLinesList.size() > 0){
                        // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
                        for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                                          Qty_On_Hand__c, 
                                                                          Qty_Allocated__c,
                                                                          Sales_Order_Line__c
                                                                          FROM Inventory_Position__c where Sales_Order_Line__c IN: soLineIds
                                                                          Order by Date_Received__c]){
                                                                              
                                                                              List<Inventory_Position__c> inventoryPositionsTemp = 
                                                                                  inventoryPositionsBySOLineId.get(inventoryPositionObj.Sales_Order_Line__c);
                                                                              
                                                                              if(inventoryPositionsTemp == null) {
                                                                                  inventoryPositionsTemp = new List<Inventory_Position__c>();
                                                                                  inventoryPositionsBySOLineId.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                                                                              }
                                                                              inventoryPositionsTemp.add(inventoryPositionObj);
                                                                          }
                        // Iterate on all SO lines
                        for(Sales_Order_Line__c soLineObj: soLinesList){
                            List<Inventory_Position__c> inventoryPositions = inventoryPositionsBySOLineId.get(soLineObj.Id);
                            if(inventoryPositions != null){
                                // Update Qty On Hand with Qty Allocated of Inventory Position
                                // Remove Sales Order Line from Inventory Position
                                for(Inventory_Position__c invPositionObj : inventoryPositions){
                                    invPositionObj.Qty_On_Hand__c = invPositionObj.Qty_Allocated__c;
                                    invPositionObj.Qty_Allocated__c = 0.0;
                                    invPositionObj.Sales_Order_Line__c = null;
                                    inventoryPositionsToUpdate.add(invPositionObj);
                                }
                            }
                            // Update SO line status and Qty to Allocated
                            soLineObj.Qty_Allocated__c = 0.0;
                            soLineObj.Status__c =STATUS_CANCELLED ;
                        }
                    }
                    
                   if(inventoryPositionsToUpdate.size() > 0) 
                    update inventoryPositionsToUpdate;
                
            }
            
        }
        if(InvDelList.size() >0){
            delete InvDelList;
        }
        if(invList.size() >0){
            update invList;
        } 
        if(lstPick.size() >0){
            lstPick[0].Status__c = STATUS_CANCELLED;
            List<Picklist_Line__c> lstPLI = new List<Picklist_Line__c>();
            for(Picklist_Line__c pli : lstPick[0].Picklist_Lines__r){
                pli.Status__c =STATUS_CANCELLED;
                lstPLI.add(pli);
            }
            if(lstPLI.size()>0) update lstPLI;
            update lstPick;
        }
        
        if(so != Null){
            if(soLinesList.size() >0) update soLinesList;
            update so;
        }
        if(bqList.size() >0){
            if(bqLineList.size()>0) 
                update bqLineList;
            
            update bqList;
        }
        
        if(odr != Null){
            if(oliList.size()>0)
                update oliList;
            update odr;
        }
     
        return r;
    }
    @AuraEnabled
    public static AuraResponse deletePicklistAndLines(String recId){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.deletePicklistAndLines()');
          String loggedUserUserName = UserInfo.getName();
            picklist__c pick = [select id ,Sales_Order__c,Site__c,Site__r.Name from  picklist__c where id  =: recId];
            List<Site_User__c> lstusersitedata =[select id ,name,User__c,User__r.Name ,User_Active__c,Site__c,Site__r.Active__c,Active__c from Site_User__c where User__r.Name =:loggedUserUserName and Site__c=:pick.Site__c and Site__r.Active__c=True and User_Active__c=True and Active__c=True];
            system.debug('usersite>>>>'+lstusersitedata); 
            system.debug('usersite>>>>'+lstusersitedata.size());
            
            if(lstusersitedata.size()==0){
                r.data.put('errormsgSite',ERR_MSG_LA_SITE);
                return r;  
            }
        
        
        List<Picklist__c> lstPick = [SELECT Sales_Order__c FROM Picklist__c WHERE Id =: recId];
        
        Sales_Order__c sOrder = new Sales_Order__c();
        List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
        
        sOrder = [Select Id,Ownership__c, Allocated__c,SO_Status__c,
                  (Select Id,Sales_Order__c, Qty_Allocated__c, Status__c From Sales_Order_Lines__r 
                   Where NOT Status__c IN (:SO_LINE_STATUS_OPEN,:SO_LINE_STATUS_CANCELLED))
                  From Sales_Order__c where Id =:lstPick[0].Sales_Order__c LIMIT 1];
        
        soLines = sOrder.Sales_Order_Lines__r;
        if(soLines != null){
            Set<Id> soLineIds = new Set<Id>();
            // Iterate on all SO lines
            for(Sales_Order_Line__c soLineObj: soLines){
                soLineIds.add(soLineObj.Id);
                soLineObj.Qty_Allocated__c = 0.0;
                soLineObj.Status__c = SO_LINE_STATUS_OPEN;
            }
            List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
            for(Inventory_Position__c ipObj : [SELECT Id, Qty_On_Hand__c, Qty_Allocated__c,Inventory_Location__c, Sales_Order_Line__c
                                               FROM Inventory_Position__c where Sales_Order_Line__c IN: soLineIds]){
                                                   ipObj.Sales_Order_Line__c = null;
                                                   ipObj.Qty_On_Hand__c = ipObj.Qty_Allocated__c;
                                                   ipObj.Qty_Allocated__c = 0.0;
                                                   inventoryPositionsToUpdate.add(ipObj);
                                               }
            if(inventoryPositionsToUpdate.size() > 0) update inventoryPositionsToUpdate;
        }
        // Change Allocated flag of SO
        sOrder.Allocated__c = false;
        sOrder.SO_Status__c = SO_STATUS_DRAFT;
        
        update sOrder;
        update soLines;
        delete lstPick;
        
        r.data.put('soID', (String) sOrder.Id);
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse deletePicklistAndUpdateSO(String recId){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.deletePicklistAndUpdateSO()');
        List<Picklist__c> lstPick = [SELECT Id,Sales_Order__c,Site__c FROM Picklist__c WHERE Id =: recId];
        Id soId = lstPick[0].Sales_Order__c;
        
        r.data.put('soID', (String) (lstPick[0].Sales_Order__c));
        
        Sales_Order__c sOrder = new Sales_Order__c();
        List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
        // List of Inventory Positions to Update
        List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
        
        sOrder = [Select Id,Ownership__c, Allocated__c,SO_Status__c,Supplier_Name__r.Membership_Level__c,Supplier_Name__c,
                  Receiver_Name__r.Membership_Level__c,Receiver_Name__c,Order_Type__c,
                  (Select Sales_Order__c,Total_QA_Revision__c,Total_QA_Change_fee__c, Qty_Allocated__c, Status__c From Sales_Order_Lines__r 
                   Where NOT Status__c IN (:SO_LINE_STATUS_OPEN,:SO_LINE_STATUS_CANCELLED))
                  From Sales_Order__c where Id =:lstPick[0].Sales_Order__c LIMIT 1];
        
        Set<String>membershipLevels = new Set<String>();
        if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
            membershipLevels.add(sOrder.Supplier_Name__r.Membership_Level__c);
        }else{
            membershipLevels.add(sOrder.Receiver_Name__r.Membership_Level__c);
        }

        Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
        
        Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                 FROM Fulfillment_Rates_Table__c 
                                                 WHERE Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c IN :membershipLevels
                                                 ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
        for(Fulfillment_Rates_Table__c FRT:FRTList){
            if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
            }else{
                serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
            }
        }
        
        soLines = sOrder.Sales_Order_Lines__r;
        if(soLines != null){
            Set<Id> soLineIds = new Set<Id>();
            
            // Iterate on all SO lines
            for(Sales_Order_Line__c soLineObj: soLines){
                soLineIds.add(soLineObj.Id);
                soLineObj.Qty_Allocated__c = 0.0;
                soLineObj.Status__c = SO_LINE_STATUS_OPEN;
                soLineObj.Total_QA_Revision__c = soLineObj.Total_QA_Revision__c != null ? soLineObj.Total_QA_Revision__c : 1;
                if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_CHANGE_FEE)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_CHANGE_FEE);
                    if(!FRTs.isEmpty()){
                        for(Fulfillment_Rates_Table__c FRT: FRTs){
                            soLineObj.Total_QA_Change_fee__c = FRT.Bracket_Price__c;
                            break;
                        }
                    }
                }
            }
            List<Inventory_Location__c> lstInvLoc = [select Id,Name from Inventory_Location__c where Name =: Receiving_Inspection AND Site_Name__c = :lstPick[0].Site__c];
                
            for(Inventory_Position__c ipObj : [SELECT Id, Qty_On_Hand__c, Qty_Allocated__c,Inventory_Location__c, Sales_Order_Line__c
                                               FROM Inventory_Position__c where Sales_Order_Line__c IN: soLineIds Order by Date_Received__c]){
                                                   if(lstInvLoc.size() > 0) ipObj.Inventory_Location__c = lstInvLoc[0].Id;  
                                                   ipObj.Rack__c = null;
                                                   ipObj.Rack_Level__c = null;
                                                   ipObj.Bin_Location__c = null;
                                                   ipObj.Sales_Order_Line__c = null;
                                                   ipObj.Qty_On_Hand__c = ipObj.Qty_Allocated__c;
                                                   ipObj.Qty_Allocated__c = 0.0;
                                                   inventoryPositionsToUpdate.add(ipObj);	                                       
                                               }
        }
        // Change Allocated flag of SO
        sOrder.Allocated__c = false;
        sOrder.SO_Status__c = SO_STATUS_DRAFT;
        
        update sOrder;
        
        if(soLines != null) update soLines;
        if(inventoryPositionsToUpdate.size() > 0) update inventoryPositionsToUpdate;
        
        List<Invoice__c> InvList =[SELECT id,Sales_Order__c FROM Invoice__c WHERE (RecordType.Name =:Invoice_Record_Type_Product OR RecordType.Name =:INVOICE_RECORDTYPE_SERVICE) AND Sales_Order__c =: lstPick[0].Sales_Order__c];
        delete InvList;
        
        delete lstPick;
        
        r.data.put('soID', (String) sOrder.Id);
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getPickListLineItems(String recId){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.getPickListLineItems()');
        
        List<SelectedLineItems> lstSelect = new List<SelectedLineItems>();
        
        Map<String,Decimal> PicklistLineQtyMap = new Map<String,Decimal>();
        Map<ID,String> PicklistLineKeyMap = new Map<ID,String>();
        List<PicklistLineWrapper> picklistLineList = new List<PicklistLineWrapper>();
        
        List<Picklist__c> picklist = [select id,Sales_Order__c,Sales_Order__r.Name,Status__c,Name,Assigned_To_Name__c,Scheduled_Pick_Date__c,
                                      Picklist_Lines__c,Receiver_DBA__c,Delivery_City__c,Planned_Ship_Date__c from Picklist__c where id = :recId];
        
        List<Picklist_Line__c> picklistLine2 =[SELECT id,Name,Product_Name__c,Product_Name__r.name,Harvest_Batch_or_Lot_Code__c,
                                               Product_Description__c,Producer_Name__c,Inventory_Location__c,Rack__c,Rack_Level__c,QA_Status__c,Status__c,
                                               Sales_Order_Line__c,Inventory_Position__c,Picklist__c,Pack_out_UID__c,
                                               Bin_Location__c,Purchase_Order__c,UID__c,Qty_to_Pick__c,Sales_Order_Line__r.Is_Sample__c,Is_Sample__c
                                               FROM Picklist_Line__c WHERE Picklist__c = :recId ORDER BY Product_Name__r.Name ASC];
        
        
        
        for(Picklist_Line__c var:picklistLine2){
            String mapKey = var.Product_Name__c+'-'+var.Producer_Name__c+'-'+var.Inventory_Location__c+'-'+var.UID__c+'-'+var.Harvest_Batch_or_Lot_Code__c;
            mapKey += var.Is_Sample__c;
            if(PicklistLineQtyMap.containskey(mapKey)){
                Decimal qty= PicklistLineQtyMap.get(mapKey);
                PicklistLineQtyMap.put(mapKey,qty+var.Qty_to_Pick__c);
            }else {
                PicklistLineKeyMap.put(var.ID,mapKey);
                PicklistLineQtyMap.put(mapKey,var.Qty_to_Pick__c);
            }
        }
        for(Picklist_Line__c var:picklistLine2){
            String mapKey = var.Product_Name__c+'-'+var.Producer_Name__c+'-'+var.Inventory_Location__c+'-'+var.UID__c+'-'+var.Harvest_Batch_or_Lot_Code__c;
            mapKey += var.Is_Sample__c;
            if(PicklistLineKeyMap.containskey(var.ID) && PicklistLineQtyMap.containskey(mapKey)){
                PicklistLineWrapper wrap= new PicklistLineWrapper(var,PicklistLineQtyMap.get(mapKey));
                lstSelect.add(new SelectedLineItems(false,wrap));
            }
        }
        
        list<Invoice__c>serviceInvoiceList = new List<Invoice__c>();
        serviceInvoiceList = [select id from invoice__c where Sales_Order__c =: picklist[0].Sales_Order__c AND recordType.Name =: INVOICE_RECORDTYPE_SERVICE];
        Boolean hasServiceInvoice = false;
        if(serviceInvoiceList.size()> 0){hasServiceInvoice = true;
        } 
        r.data.put('hasServiceInvoice', hasServiceInvoice);
        r.data.put('records', lstSelect);
        r.data.put('picRecords', pickList[0]);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse saveLineItems(String listToSaveString,Boolean isIncludeServiceInvoices){
        AuraResponse r = new AuraResponse('CancelledPickListCtrl.saveLineItems()'); 
        
        List<SelectedLineItems> listToSave = (List<SelectedLineItems>)JSON.deserialize(listToSaveString, List<SelectedLineItems>.class);
        
        if(listToSave.size() > 0){
            set<Id> setIds = new Set<Id>();
            set<Id> setInv = new Set<Id>(); 
            set<Id> setSoli= new Set<Id>(); 
            set<Id> setUID= new Set<Id>();
            
            List<Picklist_Line__c> lstPick = new List<Picklist_Line__c>();
            List<Picklist_Line__c> lstPick2 = new List<Picklist_Line__c>();
            Set<Id> cancelledPOLines = new Set<Id>();
            String pickLineNames = '';
            
            for(SelectedLineItems pick : listToSave){
                //lstPick2.add(pick.wrp.picklistLineObj);
                if(pick.isSelect == true){
                    setIds.add(pick.wrp.picklistLineObj.Picklist__c);
                    setInv.add(pick.wrp.picklistLineObj.Inventory_Position__c);
                    setSoli.add(pick.wrp.picklistLineObj.Sales_Order_Line__c);
                    pick.wrp.picklistLineObj.Status__c =STATUS_CANCELLED;
                    cancelledPOLines.add(pick.wrp.picklistLineObj.Id);
                    pickLineNames += pick.wrp.picklistLineObj.Name + ',';
                    if(pick.wrp.picklistLineObj.Pack_out_UID__c != null){  setUID.add(pick.wrp.picklistLineObj.Pack_out_UID__c);
                        pick.wrp.picklistLineObj.Pack_out_UID__c = null;     
                    }
                    lstPick.add(pick.wrp.picklistLineObj);    
                }    
            }
            
            List<Picklist__c> lstPickList = [select id,Name,Status__c,Sales_Order__r.Supplier_Name__r.Membership_Level__c,Sales_Order__r.Supplier_Name__c,
                                             Sales_Order__r.Receiver_Name__r.Membership_Level__c,Sales_Order__r.Receiver_Name__c,Sales_Order__r.Site__c,
                                             Sales_Order__r.Order_Type__c,Sales_Order__c,Site__c,Opportunity__c,Brand_Quote__c,Sales_Order__r.Opportunity_Name__r.Order__c,
                                             Sales_Order__r.Id, (select id,Status__c from Picklist_Lines__r) from Picklist__c where Id In :setIds];
            
            Set<String>membershipLevels = new Set<String>();
            
            for(Picklist__c pick : lstPickList){
                if(pick.Sales_Order__c != null){
                    if(pick.Sales_Order__r.Order_Type__c == SO_ORDER_TYPE_BRAND){
                        membershipLevels.add(pick.Sales_Order__r.Supplier_Name__r.Membership_Level__c);
                    }else{
                        membershipLevels.add(pick.Sales_Order__r.Receiver_Name__r.Membership_Level__c);
                    }
                }
            }
            
            Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
            
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c IN :membershipLevels
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            for(Fulfillment_Rates_Table__c FRT:FRTList){
                if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                    serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                }else{
                    serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                }
            }
            
            if(lstPick.size() > 0 ){
                List<Picklist_Line__c> relatedPLines =[SELECT id,Name,Product_Name__c,Product_Name__r.name,Harvest_Batch_or_Lot_Code__c,
                                                       Product_Description__c,Producer_Name__c,Inventory_Location__c,Rack__c,Rack_Level__c,QA_Status__c,Status__c,
                                                       Sales_Order_Line__c,Inventory_Position__c,Picklist__c,Pack_out_UID__c,
                                                       Bin_Location__c,Purchase_Order__c,UID__c,Qty_to_Pick__c,Sales_Order_Line__r.Is_Sample__c,Is_Sample__c
                                                       FROM Picklist_Line__c WHERE Sales_Order_Line__c IN : setSoli AND ID NOT IN : cancelledPOLines];
                for(Picklist_Line__c PL: relatedPLines){ PL.Status__c = STATUS_CANCELLED;
                    setInv.add(PL.Inventory_Position__c);
                    if(PL.Pack_out_UID__c != null){
                        setUID.add(PL.Pack_out_UID__c);
                        PL.Pack_out_UID__c = null;     
                    }
                    lstPick.add(PL);
                }
                update lstPick; 
                
            }
            List<UID__c> lstUid = [SELECT Id,In_Use__c FROM UID__c WHERE Id In : setUID];
            if(lstUid.size() > 0){
                for(UID__c uid : lstUid){  uid.In_Use__c = false;    
                }
                update lstUid;
            }
            
            List<Sales_Order_Line__c> lstSoli = [select id,Name,Total_QA_Revision__c,Total_QA_Change_fee__c,Qty_Allocated__c,Status__c,Product_Name__r.RecordType.Name,Product_Name__r.Name  FROM Sales_Order_Line__c where Id In : setSoli ];//OR (Product_Name__r.RecordType.Name =: PRODUCT_RECORDTYPE_DISCOUNT OR Product_Name__r.Name =: PRODUCT_RECORDTYPE_MOV_FEE )
            if(lstSoli.size() > 0){
                for(Sales_Order_Line__c soli : lstSoli){
                    soli.Status__c = STATUS_SALESORDERLINECANCELLED;
                    soli.Qty_Allocated__c = 0; 
                    soli.Total_QA_Revision__c = soli.Total_QA_Revision__c != null ? soli.Total_QA_Revision__c : 1;
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_CHANGE_FEE)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_CHANGE_FEE);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                soli.Total_QA_Change_fee__c = FRT.Bracket_Price__c;
                                break;
                            }
                        }
                    }
                }
                Sales_Order__c lstSo = [SELECT id,Name,Total_QA_Revision__c,Total_QA_Change_Fee__c,
                                          (SELECT id,Name,Total_QA_Revision__c,Total_QA_Change_fee__c,
                                           Qty_Allocated__c,Status__c FROM Sales_Order_Lines__r)
                                          FROM Sales_Order__c where Id =: lstPickList[0].Sales_Order__c LIMIT 1];
                Decimal totalQA = 0;
                Decimal totalQAFee = 0;
                for(Sales_Order_Line__c soli : lstSo.Sales_Order_Lines__r){
                    totalQA += soli.Total_QA_Revision__c != NULL ? soli.Total_QA_Revision__c : 0;
                    totalQAFee += soli.Total_QA_Change_fee__c != NULL ? soli.Total_QA_Change_fee__c : 0;
                }
                lstSo.Total_QA_Change_Fee__c = totalQAFee;
                lstSo.Total_QA_Revision__c = totalQA;
                update lstSoli;
            }
            
            
            List<Inventory_Position__c> lstInv = [select Id,Name,Inventory_Location__c,Sales_Order_Line__c,Qty_Allocated__c,Rack__c,Rack_Level__c,Bin_Location__c from Inventory_Position__c where Id In : setInv];
            
          
            if(lstPickList.size() > 0){
                List<Inventory_Location__c> lstInvLoc = [select Id,Name from Inventory_Location__c where Name =: Receiving_Inspection AND Site_Name__c = :lstPickList[0].Site__c];
                Set<Id> setSo = new Set<Id>();
                Set<Id> setOpp = new Set<Id>();
                
                // List of Inventory Positions to Update
                List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
                
                if(!lstPickList.isEmpty()){
                    Picklist__c pick =  lstPickList[0];
                    if(pick.Sales_Order__c != null) setSo.add(pick.Sales_Order__r.Id);
                    if(pick.Status__c == STATUS_QAREVIEW){
                        for(Inventory_Position__c inv : lstInv){
                            if(lstInvLoc.size() > 0)  inv.Inventory_Location__c = lstInvLoc[0].Id;
                            inv.Rack__c = null;
                            inv.Rack_Level__c = null;
                            inv.Bin_Location__c = null;
                            inv.Sales_Order_Line__c = null;
                            inv.Qty_Allocated__c = 0.0;
                        }
                    } else if(pick.Status__c == STATUS_OPEN){
                        for(Inventory_Position__c inv : lstInv){
                            
                            inv.Sales_Order_Line__c = null;
                            inv.Qty_Allocated__c = 0.0;
                        }
                    }
                    Set<Id> soLineIds = new Set<Id>();
                    // List of Inventory Position By Sales Order Line Id
                    Map<Id, List<Inventory_Position__c>> inventoryPositionsBySOLineId = new Map<Id, List<Inventory_Position__c>>();
                    
                    if(lstSoli.size() > 0){
                        // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
                        for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                                          Qty_On_Hand__c, 
                                                                          Qty_Allocated__c,
                                                                          Sales_Order_Line__c
                                                                          FROM Inventory_Position__c where Sales_Order_Line__c IN: setSoli
                                                                          Order by Date_Received__c]){
                                                                              
                                                                              List<Inventory_Position__c> inventoryPositionsTemp = 
                                                                                  inventoryPositionsBySOLineId.get(inventoryPositionObj.Sales_Order_Line__c);
                                                                              
                                                                              if(inventoryPositionsTemp == null) {
                                                                                  inventoryPositionsTemp = new List<Inventory_Position__c>();
                                                                                  inventoryPositionsBySOLineId.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                                                                              }
                                                                              inventoryPositionsTemp.add(inventoryPositionObj);
                                                                          }
                        // Iterate on all SO lines
                        for(Sales_Order_Line__c soLineObj: lstSoli){
                            List<Inventory_Position__c> inventoryPositions = inventoryPositionsBySOLineId.get(soLineObj.Id);
                            if(inventoryPositions != null){
                                // Update Qty On Hand with Qty Allocated of Inventory Position
                                // Remove Sales Order Line from Inventory Position
                                for(Inventory_Position__c invPositionObj : inventoryPositions){
                                    invPositionObj.Qty_On_Hand__c = invPositionObj.Qty_Allocated__c;
                                    invPositionObj.Qty_Allocated__c = 0.0;
                                    invPositionObj.Sales_Order_Line__c = null;
                                    inventoryPositionsToUpdate.add(invPositionObj);
                                }
                            }
                            // Update SO line status and Qty to Allocated
                            soLineObj.Qty_Allocated__c = 0.0;
                            soLineObj.Status__c =STATUS_SALESORDERLINECANCELLED ;
                        }
                    }
                    
                    Picklist_Line__c[] pLines = [SELECT Id FROM Picklist_Line__c WHERE Picklist__c = :lstPickList[0].Id AND Status__c !=: STATUS_CANCELLED];
                    if(pLines.isEmpty()){
                        pick.Status__c = STATUS_CANCELLED; 
                    }
                    update pick;
                }
                update lstSoli;
                if(inventoryPositionsToUpdate.size() > 0) 
                    update inventoryPositionsToUpdate;
                
                
                
                if(lstInv.size() > 0){
                    update lstInv;
                }
                
                Boolean allCancel = false;
                List<Sales_Order__c> lstSales = [select id,Name,Brand_Quote__c,SO_Status__c,Opportunity_Name__c,(SELECT Id, Status__c FROM Sales_Order_Lines__r WHERE Status__c !=:STATUS_SALESORDERLINECANCELLED) from Sales_Order__c where Id In :setSo];
                if(lstSales.size() > 0){
                    Set<Id> setBq = new Set<Id>();
                    for(Sales_Order__c sl : lstSales){
                        if(sl.Sales_Order_Lines__r.size() == 0){
                            allCancel = true;
                            sl.SO_Status__c = STATUS_SALESORDERCANCELLED;
                            if(sl.Brand_Quote__c != null) setBq.add(sl.Brand_Quote__c); 
                            if(sl.Opportunity_Name__c != null) setOpp.add(sl.Opportunity_Name__c);
                        }
                        
                    }
                    update lstSales;
                    
                    if(allCancel){
                        
                        List<Sales_Order_Line__c> lstDiscountSoli = [select id,Name,Qty_Allocated__c,Status__c,Product_Name__r.RecordType.Name,Product_Name__r.Name  FROM Sales_Order_Line__c where Id In : setSoli AND (Product_Name__r.RecordType.Name =: PRODUCT_RECORDTYPE_DISCOUNT OR Product_Name__r.Name =: PRODUCT_RECORDTYPE_MOV_FEE )];
                        if(lstDiscountSoli.size() > 0){
                            for(Sales_Order_Line__c soli : lstDiscountSoli){
                                soli.Status__c = STATUS_SALESORDERLINECANCELLED;
                                soli.Qty_Allocated__c = 0; 
                            }
                            update lstDiscountSoli;
                        }
                          // Cancel invoice and invoice Line item
                              Set<Id> invoiceIds = new Set<Id>();
                              List<Invoice__c> invoices = new List<Invoice__c>();
                              List<Invoice_Line__c> lines = new List<Invoice_Line__c>();
                              for(Invoice__c  invoiceObj : [SELECT Id FROM Invoice__c WHERE Sales_Order__c  IN :setSo AND AR_Status__c != 'Cancelled' AND RecordType.Name = 'Product']){
                                  invoices.add(new Invoice__c(Id = invoiceObj.Id,AR_Status__c = STATUS_CANCELLED
                                  ));
                                  invoiceIds.add(invoiceObj.Id);
                              }
                              for(Invoice_Line__c lineObj : [SELECT Id FROM Invoice_Line__c WHERE Invoice__c IN :invoiceIds AND InvoiceLine_Status__c != 'Cancelled']){
                                  lines.add(new Invoice_Line__c(Id = lineObj.Id, InvoiceLine_Status__c  = STATUS_CANCELLED
                                  ));
                              }
                              if(invoices.size() > 0) update invoices;
                              if(lines.size() > 0) update lines;
                        
                    }
                        
                    if(setBq.size() > 0){
                        List<Brand_Quote__c> lstBrand = [select id,Name,BQ_Status__c from Brand_Quote__c where Id In :setBq];  
                        for(Brand_Quote__c bq : lstBrand){ bq.BQ_Status__c = STATUS_BRANDQUOTECANCELLED ;
                        }
                        update lstBrand;
                    }
                    
                    if(setOpp.size() > 0){
                        List<Opportunity> lstOpp = [select Id,Name,Order__c from Opportunity where Id In :setOpp];
                        Set<Id> setOrd = new Set<Id>();
                        for(Opportunity opp : lstOpp){
                            if(opp.Order__c != null)  setOrd.add(opp.Order__c);   
                        }
                        
                        if(setOrd.size() > 0){
                            List<Order__c> lstOrd = [select id,Name,Status__c from Order__c where Id In :setOrd];  
                            for(Order__c order : lstOrd){ order.Status__c = STATUS_ORDERCANCELLEDBYFILIGREEN;
                            }
                            update lstOrd;   
                        }
                    }
                }
            }
            Decimal version = 1;
            List<Order_Revision__c> revisions = [SELECT Id, Change_Fee__c, Membership_Level__c, Revision_Reason__c,Sales_Order__c, Sales_Order_Line__c , Version__c FROM Order_Revision__c  WHERE Sales_Order__c = :lstPickList[0].Sales_Order__c ORDER BY Sales_Order__c, Version__c DESC];
            if(revisions.size() > 0){
                version = (revisions[0].Version__c != NULL ? revisions[0].Version__c+1 : 1);
            }
            
            Decimal changeFee = 0;
            if(lstPickList[0].Sales_Order__r.Supplier_Name__r.Membership_Level__c != NULL){
                Fulfillment_Rates_Table__c [] FRTListChFee = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                         FROM Fulfillment_Rates_Table__c 
                                                         WHERE Site__c = :lstPickList[0].Sales_Order__r.Site__c
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c = :lstPickList[0].Sales_Order__r.Supplier_Name__r.Membership_Level__c
                                                         AND Fulfillment_Services__c = :FULFILLMENT_SERVICE_CHANGE_FEE
                                                         ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                if(FRTListChFee.size() > 0){
                    changeFee = FRTListChFee[0].Bracket_Price__c;
                }
            }
            
            Order_Revision__c ordRev = new Order_Revision__c();
            ordRev.Sales_Order__c = lstPickList[0].Sales_Order__c;
            ordRev.Version__c = version;
            if(lstPickList[0].Sales_Order__r != null && 
               lstPickList[0].Sales_Order__r.Opportunity_Name__r != null && 
               lstPickList[0].Sales_Order__r.Opportunity_Name__r.Order__c != null){
                   ordRev.Order__c = lstPickList[0].Sales_Order__r.Opportunity_Name__r.Order__c;
            }
            ordRev.Change_Fee__c = changeFee;
            if(lstPickList[0].Sales_Order__r != null && 
               lstPickList[0].Sales_Order__r.Supplier_Name__r != null && 
               lstPickList[0].Sales_Order__r.Supplier_Name__r.Membership_Level__c != null){
                   ordRev.Membership_Level__c  = lstPickList[0].Sales_Order__r.Supplier_Name__r.Membership_Level__c;
            }
            ordRev.Revision_Reason__c = 'Picklist Name = ' + lstPickList[0].Name + ' AND Picklist Lines Name = '+pickLineNames;
            insert ordRev;
            
            if(isIncludeServiceInvoices == true){
                list<Invoice_Line__c>invoiceLineList = new list<Invoice_Line__c>();
                list<Invoice_Line__c>serviceInvoiceLineList=[SELECT Id,InvoiceLine_Status__c,Invoice_Qty__c FROM Invoice_Line__c WHERE Product_Name__r.NAME IN (:PRODUCT_NAME_MILEAGE_FEE ,:PRODUCT_NAME_WEIGHT_FEE,:PRODUCT_NAME_STAGE_MANIFEST) AND Invoice__r.Sales_Order__c =: lstPickList[0].Sales_Order__c AND Invoice__r.RecordType.Name = :INVOICE_RECORDTYPE_SERVICE];       
                for(Invoice_Line__c invLine : serviceInvoiceLineList){
                    invLine.InvoiceLine_Status__c = Invoice_Line_Status_Cancelled;
                    invLine.Invoice_Qty__c = 0;
                }
                update serviceInvoiceLineList;
            }
            
            r.data.put('recordIds', lstPickList[0].Id);
        }
        return r;
    }
    
    public class SelectedLineItems{
        @AuraEnabled public Boolean isSelect {get;set;}
        @AuraEnabled public PicklistLineWrapper wrp {get;set;}
         public SelectedLineItems(Boolean sele, PicklistLineWrapper itm){
            isSelect =  sele;
            wrp = itm;
        }
    }
}