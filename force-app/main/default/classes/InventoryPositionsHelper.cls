Public class InventoryPositionsHelper {
    
    private Static String INVENTORY_LOCATION_TRANSFERRED{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_TRANSFERRED) ? INVENTORY_LOCATION_TRANSFERRED :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Transferred');
        }set;
    }
    private Static String INVENTORY_LOCATION_TESTED_SAMPLED{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_TESTED_SAMPLED) ? INVENTORY_LOCATION_TESTED_SAMPLED :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Test_Sampled');
        }set;
    }
    private Static String INVENTORY_LOCATION_QUARANTINE{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_QUARANTINE) ? INVENTORY_LOCATION_QUARANTINE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Quarantine');
        }set;
    }
    private Static String INVENTORY_LOCATION_PACKAGED{  
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_PACKAGED) ? INVENTORY_LOCATION_PACKAGED :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Packaged');
        }set;
    }
    private Static String INVENTORY_LOCATION_DELIVERED{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_DELIVERED) ? INVENTORY_LOCATION_DELIVERED :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Delivered');
        }set;
    }
    private Static String INVENTORY_LOCATION_CANNA_WASTE{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_CANNA_WASTE) ? INVENTORY_LOCATION_CANNA_WASTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_CannaWaste');
        }set;
    }
    private static String EXCLUDE_INVENTORY_LOCATIONS{
        get{
            return String.isNotBlank(EXCLUDE_INVENTORY_LOCATIONS) ? EXCLUDE_INVENTORY_LOCATIONS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Exclude_Inventory_Locations');
        }set;
    }
    private Static String INVENTORY_LOCATION_CANNABIS_WASTE{ 
        get{
            return  String.isNotBlank(INVENTORY_LOCATION_CANNABIS_WASTE) ? INVENTORY_LOCATION_CANNABIS_WASTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Cannabis_Waste');
        }set;
    }
    private static String Receiving_Inspection{
        get{
            return String.isNotBlank(Receiving_Inspection) ? Receiving_Inspection : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Receiving_Inspection');
        }set;
    }
    private static String INVENTORY_LOCATION_WRITEOFF{
        get{
            return String.isNotBlank(INVENTORY_LOCATION_WRITEOFF) ? INVENTORY_LOCATION_WRITEOFF : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_WriteOff');
        }set;
    }
    private static String INVENTORY_LOCATION_INVENTORY_WRITEOFF{
        get{
            return String.isNotBlank(INVENTORY_LOCATION_INVENTORY_WRITEOFF) ? INVENTORY_LOCATION_INVENTORY_WRITEOFF : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Inventory_Write_Off');
        }set;
    }
    private static String INVENTORY_LOCATION_TEST_ROOM{
        get{
            return String.isNotBlank(INVENTORY_LOCATION_TEST_ROOM) ? INVENTORY_LOCATION_TEST_ROOM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Test_Room');
        }set;
    }
    private static String Order_Status_Approved{
        get{
            return String.isNotBlank(Order_Status_Approved) ? Order_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Approved');
        }set;
    }
    private static String Order_Status_Pending{
        get{
            return String.isNotBlank(Order_Status_Pending) ? Order_Status_Pending : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    private static String Order_Record_Type_Name_Transfer{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Transfer) ? Order_Record_Type_Name_Transfer : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    }
    private static String Order_Record_Type_Name_Brand{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Brand) ? Order_Record_Type_Name_Brand : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_ Brand');
        }set;
    }
    private static String Order_Record_Type_Name_Retailer{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Retailer) ? Order_Record_Type_Name_Retailer : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Retailer');
        }set;
    }
    private static String Sales_Order_Line_Status_Allocated{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Allocated) ? Sales_Order_Line_Status_Allocated : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Allocated');
        }set;
    }
    private static String Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Order_Line_Status_Cancelled) ? Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Cancelled');
        }set;
    }
    private static String Order_Line_Status_Rejected{
        get{
            return String.isNotBlank(Order_Line_Status_Rejected) ? Order_Line_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Rejected');
        }set;
    }
    
    public static Boolean invPositionTriggerExecuted = false;
    
    Public static void calculateRollupSummary(List<Inventory_Position__c> newList,List<Inventory_Position__c> oldList) {
        Double totalInventory=0.0 ;
        Double allocatedInventoryQty =0.0 ;
        Double availableInventoryQty=0.0 ;
        Double itemToPutAway =0.0 ;
        Double totalCannabisWeight=0.0 ;
        Double inventoryOnHoldQty=0.0 ;
        Decimal cannabisWeight = 0.0;
        List<Product2> prodListUpdate = new List<Product2>();
        List<Product2> prodList = new List<Product2>();
        List<ID> prodIdLsit = new List<ID>();
        Set<Id> binLocationIds = new Set<Id>();
        Set<Id> ILLocationIds = new Set<Id>();
        List<Inventory_Position__c> targetlist = new List<Inventory_Position__c>();
        if(oldList == null){
            targetlist= newList;
        }else targetlist =oldList;
        
        for(Inventory_Position__c invPos :targetlist){
            binLocationIds.add(invPos.Bin_Location__c);
            ILLocationIds.add(invPos.Inventory_Location__c);
            prodIdLsit.add(invPos.Product_Name__c);
        }
        prodList =[Select ID,Cannabis_Weight__c,Total_Inventory__c ,Available_Inventory__c ,Allocated_Inventory__c,TotalCannabisWeight__c,ItemToPutAway__c,Inventory_On_Hold_Qty__c ,
                   (Select id,Qty_On_Hand__c,Qty_Allocated__c,Inventory_Location__r.name,Sales_Order_Line__c,Hold__c
                    from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true) from Product2 where ID =:prodIdLsit ];
        if(prodList.size()>0){
            for(Product2 prod :prodList){
                //Below 5 lines is to update available inventory in Product page. DONOT delete/change without approval.
                totalInventory=0.0 ;
                allocatedInventoryQty =0.0 ;
                availableInventoryQty=0.0 ;
                itemToPutAway =0.0 ;
                totalCannabisWeight=0.0 ;
                cannabisWeight = 0.0;
                inventoryOnHoldQty = 0.0;
                if(prod.Inventory_Positions__r.size() >0){
                    for(Inventory_Position__c invPosRec :prod.Inventory_Positions__r){
                     
                        if(invPosRec.Qty_On_Hand__c !=null){
                            totalInventory=totalInventory + invPosRec.Qty_On_Hand__c;
                        }
                        if(invPosRec.Qty_Allocated__c!=null){
                            totalInventory=totalInventory + invPosRec.Qty_Allocated__c;
                        }
                        if(invPosRec.Hold__c == false){
                            
                            if(invPosRec.Inventory_Location__r.name != INVENTORY_LOCATION_DELIVERED && invPosRec.Inventory_Location__r.name != Receiving_Inspection && invPosRec.Inventory_Location__r.name != INVENTORY_LOCATION_CANNABIS_WASTE){
                                if(invPosRec.Qty_On_Hand__c !=null && invPosRec.Qty_Allocated__c != null && invPosRec.Sales_Order_Line__c !=null ){
                                    allocatedInventoryQty=allocatedInventoryQty + invPosRec.Qty_Allocated__c;
                                }
                                if(invPosRec.Qty_On_Hand__c !=null && invPosRec.Sales_Order_Line__c ==null ){
                                    availableInventoryQty=availableInventoryQty + invPosRec.Qty_On_Hand__c;
                                }
                            }else {
                                if(invPosRec.Qty_On_Hand__c !=null){
                                    itemToPutAway =itemToPutAway+invPosRec.Qty_On_Hand__c;
                                }
                            }
                        }else{
                            inventoryOnHoldQty += invPosRec.Qty_On_Hand__c !=null?invPosRec.Qty_On_Hand__c :0;
                        } 
                        cannabisWeight = prod.Cannabis_Weight__c != null ? prod.Cannabis_Weight__c : 0.0;
                        totalCannabisWeight = cannabisWeight * availableInventoryQty;
                         
                        //write it to Prod Obj..
                        prod.Total_Inventory__c =totalInventory;
                        prod.Available_Inventory__c =availableInventoryQty;
                        prod.Allocated_Inventory__c =allocatedInventoryQty;
                        prod.TotalCannabisWeight__c=totalCannabisWeight;
                        prod.ItemToPutAway__c =itemToPutAway;
                        prod.Inventory_On_Hold_Qty__c = inventoryOnHoldQty;
                    }
                    prodListUpdate.add(prod);
                }else {
                    prod.Total_Inventory__c =0.0;
                    prod.Available_Inventory__c =0.0;
                    prod.Allocated_Inventory__c =0.0;
                    prod.TotalCannabisWeight__c=0.0;
                    prod.ItemToPutAway__c =0.0;
                    prod.Inventory_On_Hold_Qty__c = 0.0;
                    prodListUpdate.add(prod);
                    
                }
            }
        }
        if(prodListUpdate.size() > 0) update prodListUpdate;
        if(prodIdLsit.size() > 0){
            updateAvailableQty(prodIdLsit);
        }
        if(binLocationIds.size()>0 && ILLocationIds.size() > 0){
            updateCubicVolumeUtilizaion(ILLocationIds,binLocationIds);
        }
    }
    //@future
    public static void updateCubicVolumeUtilizaion(Set<Id>ILLocationIds,Set<Id>binLocationIds){
        List<String> lstInvLocNames = EXCLUDE_INVENTORY_LOCATIONS.split(',');
        lstInvLocNames.add(INVENTORY_LOCATION_TEST_ROOM);
        Inventory_Position__c[] IPList = [SELECT Id, Name, Total_Product_Volume__c , Inventory_Location__c ,Bin_Location__c  
                                          FROM Inventory_Position__c WHERE Inventory_Location__c IN :ILLocationIds AND
                                          Inventory_Location__r.Name NOT IN :lstInvLocNames];
        Map<Id,Decimal> ILCubicVolumeMap = new Map<Id,Decimal>();
        Map<Id,Decimal> BLCubicVolumeMap = new Map<Id,Decimal>();
        for(Inventory_Position__c IP: IPList){
            Decimal totalVolumeIL = 0;
            Decimal totalVolumeBL = 0;
            if(ILCubicVolumeMap.containsKey(IP.Inventory_Location__c)){
                totalVolumeIL = ILCubicVolumeMap.get(IP.Inventory_Location__c);
            }
            totalVolumeIL += IP.Total_Product_Volume__c != NULL ? IP.Total_Product_Volume__c :0;
            if(IP.Inventory_Location__c != null)
            	ILCubicVolumeMap.put(IP.Inventory_Location__c,totalVolumeIL);
            
            if(BLCubicVolumeMap.containsKey(IP.Bin_Location__c)){
                totalVolumeBL = bLCubicVolumeMap.get(IP.Bin_Location__c);
            }
            totalVolumeBL += IP.Total_Product_Volume__c != NULL ? IP.Total_Product_Volume__c :0;
            if(IP.Bin_Location__c != null){
                BLCubicVolumeMap.put(IP.Bin_Location__c,totalVolumeBL);
            }
        }
        if(ILCubicVolumeMap.size() > 0){
            Inventory_Location__c[] inventoryLocations = new Inventory_Location__c[]{};
            
            for(Id ILId: ILCubicVolumeMap.keySet()){
                inventoryLocations.add(new Inventory_Location__c(Id = ILId,Cubic_Volume_Utilization__c = ILCubicVolumeMap.get(ILId)));
            }
            if(inventoryLocations.size() > 0){
                update inventoryLocations;
            }
            
        }   
        if(BLCubicVolumeMap.size() > 0){
            Bin_Location__c[] binLocations = new Bin_Location__c[]{};
            for(Id BLId: BLCubicVolumeMap.keySet()){
                binLocations.add(new Bin_Location__c(Id = BLId,Cubic_Volume_Utilization__c = BLCubicVolumeMap.get(BLId)));
            }
            if(binLocations.size() > 0){
                update binLocations;
            }
        }
    }
    
   
    public static void updateAvailableQty(List<Id> productIds){
        Sales_Order_Line__c[] SOLines =  [SELECT Id,Name, Sales_Order__c,Qty_Allocated__c , Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c,Product_Name__c  FROM Sales_Order_Line__c WHERE Status__c ='Allocated' AND Product_Name__c IN : productIds];
        Map<Id,Sales_Order_Line__c>SOLineMap = new Map<Id,Sales_Order_Line__c>(SOLines);
        Map<String,List<Id>> productAllocatedSOLMap = new Map<String,List<Id>>();
        for(Sales_Order_Line__c SOL: SOLines){
         
            String key = SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c + '-'+SOL.Product_Name__c;
           
            if(productAllocatedSOLMap.containsKey(key)){
                
                productAllocatedSOLMap.get(key).add(SOL.Id);
            }else{
                productAllocatedSOLMap.put(key, new List<Id>{SOL.Id});
            }
        }
      
        Order_Line_Item__c[] items = [SELECT Id, Order__c,Quantity_Cases__c,Is_Sample__c,Line_Total_Qty__c,Product__c FROM Order_Line_Item__c WHERE Product__c IN :productIds AND (OrderLine_Status__c =: '' OR OrderLine_Status__c =: null) AND ((Order__r.RecordType.Name =: Order_Record_Type_Name_Retailer AND Order__r.Status__c IN (:Order_Status_Pending,:Order_Status_Approved)) OR (Order__r.RecordType.Name IN (:Order_Record_Type_Name_Brand,:Order_Record_Type_Name_Transfer) AND Order__r.Status__c IN(:Order_Status_Approved,:Order_Status_Pending)))];
        Map<Id,Decimal> productTotalQtyMap = new Map<Id,Decimal>();
        Map<Id,Decimal> productTotalQtyAllocatedMap = new Map<Id,Decimal>();
        Set<String> orderProductKeys = new Set<String>();
        Map<String,List<Order_Line_Item__c>> orderProductOLIMap = new Map<String,List<Order_Line_Item__c>>();
        for(Order_Line_Item__c oli: items){
            String key = oli.Order__c + '-'+ oli.Product__c;
            orderProductKeys.add(key);
            if(orderProductOLIMap.containsKey(key)){
                orderProductOLIMap.get(key).add(oli);
            }else{
                orderProductOLIMap.put(key, new List<Order_Line_Item__c>{oli});
            }
        }
        for(String key: orderProductOLIMap.keySet()){
            List<Order_Line_Item__c> olis = orderProductOLIMap.get(key);
            
            Id [] tempSOLIds = productAllocatedSOLMap.get(key);
            if(olis !=NULL && olis.size() > 0){
                Id productId = items[0].Product__c;
                for(Order_Line_Item__c oli: olis){
                    Decimal totalQty = 0;
                    productId = oli.Product__c;
                    if(productTotalQtyMap.containsKey(oli.Product__c)){
                        totalQty = productTotalQtyMap.get(oli.Product__c);
                    }
                 
                    totalQty += oli.Line_Total_Qty__c;
                    
              
                    productTotalQtyMap.put(oli.Product__c,totalQty);
                }
                Decimal Qty_Allocated = 0;
                if(productTotalQtyAllocatedMap.containsKey(productId)){
                    Qty_Allocated = productTotalQtyAllocatedMap.get(productId);
                }
                
                
                if(tempSOLIds != null && tempSOLIds.size() > 0){
                    for(Id SOLId: tempSOLIds){
                        Sales_Order_Line__c SOL = SOLineMap.get(SOLId);
                        if(SOL != null){
                            Qty_Allocated += SOL.Qty_Allocated__c; 
                        }
                    }
                }
             
                productTotalQtyAllocatedMap.put(productId,Qty_Allocated);
            }
        }
        
        if(productTotalQtyMap.size() > 0){
            Map<Id,Product2> productsToUpdate = new Map<Id,Product2>();
            
            for(Id productId: productIds){
                if(productId != null){
                    if(productTotalQtyMap.containsKey(productId) && productTotalQtyAllocatedMap.containsKey(productId)){
                        Decimal TQty = productTotalQtyMap.get(productId);
                        Decimal AQty = productTotalQtyAllocatedMap.get(productId);
                        TQty = TQty - AQty; 
                        
                             productsToUpdate.put(productId,new Product2(Id = productId , Total_Order_Qty__c  = TQty));
                        
                       
                        
                    }else{
                        productsToUpdate.put(productId,new Product2(Id = productId , Total_Order_Qty__c  = 0));
                    }
                }
            }
            if(productsToUpdate.size() > 0){
                
                if(CancelRSMController.CANCELFROM_CANCELRSMCONTROLLER == False )
                        {
                update productsToUpdate.values();
                        }
            } 
        }
      
        
    }
    
    //update Received Qty field on Receiving line Object record.
    public static void updateQtytoReceive(List<Inventory_Position__c> newList,List<Inventory_Position__c> oldList){
        List<Inventory_Position__c> targetlist = new List<Inventory_Position__c>();
        if(oldList == null){
            targetlist= newList;
        } else{
        	targetlist =oldList;    
        } 
        
        newList = targetlist;
        if(newList.size() > 0){
            Set<Id> recieveIdSet = new Set<Id>();
            Set<Id> uidSet = new Set<Id>();
            
            for(Inventory_Position__c inv : newList){
                if(inv.Receiving_Line__c != null){
                	recieveIdSet.add(inv.Receiving_Line__c);	    
                } 
                if(inv.UID_New__c != null){
                	uidSet.add(inv.UID_New__c);    
                }
            }
            
            if(!uidSet.isEmpty()){
                List<String> lstInvLocNames = EXCLUDE_INVENTORY_LOCATIONS.split(',');
        		lstInvLocNames.add(INVENTORY_LOCATION_TEST_ROOM);
            	List<UID__c> lstUid = [select Id, Name,Received_Qty__c ,Available_Qty__c, (select Id,Harvest_Batch_Code__c,UID_New__c,Product_Name__c,Inventory_Qty__c,Inventory_Location__r.Name from Inventory_Positions__r WHERE Inventory_Location__r.Name NOT IN :lstInvLocNames) from UID__c where Id In : uidSet];   
                if(!lstUid.isEmpty()){
                    for(UID__c rec : lstUid){
                		List<Inventory_Position__c> lstInvPos = rec.Inventory_Positions__r; 
                        if(!lstInvPos.isEmpty()){
                        	Decimal recQty = 0;  
                            Decimal availabelQty = 0;  
                            for(Inventory_Position__c invPos : lstInvPos){
                                if(invPos.Inventory_Qty__c != null){
                                    recQty += invPos.Inventory_Qty__c;
                                    availabelQty += invPos.Inventory_Qty__c;
                                   
                                }
                            }
                            rec.Received_Qty__c  = recQty;
                            rec.Available_Qty__c = availabelQty;
                        } else {
                        	rec.Received_Qty__c  = 0;
                            rec.Available_Qty__c = 0;
                        }
                    }
                    update lstUid;
                }
            }
            
            if(!recieveIdSet.isEmpty()){
            	List<Receiving_Line__c> lstReceiving = [select Id, Name,UID_New__c,Total_Received_Qty__c ,Harvest_Batch_Code__c,Product_Name__c,(select Id,Harvest_Batch_Code__c,UID_New__c,Product_Name__c,Inventory_Qty__c,Inventory_Location__r.Name from Inventory_Positions__r) from Receiving_Line__c where Id In : recieveIdSet];
                if(!lstReceiving.isEmpty()){
                    for(Receiving_Line__c rec : lstReceiving){
                    	List<Inventory_Position__c> lstInvPos = rec.Inventory_Positions__r;
                        if(!lstInvPos.isEmpty()){
                            Decimal recQty = 0;
                            for(Inventory_Position__c invPos : lstInvPos){
                                if(rec.Product_Name__c == invPos.Product_Name__c){
                                    if(invPos.Inventory_Qty__c != null){
                                    	recQty += invPos.Inventory_Qty__c;    
                                    }
                                }   
                            }
                            rec.Total_Received_Qty__c  = recQty;
                        } else {
                        	rec.Total_Received_Qty__c  = 0;    
                        }
                    }
                    update lstReceiving;
                }
            }
        }		    
    }
    
    public static void updateIPHold(Boolean isInsert,List<Inventory_Position__c> newList,Map<Id,Inventory_Position__c> oldMap){
        Set<Id> ipIds = (new Map<Id,Inventory_Position__c>(newList)).keySet();
        List<Inventory_Position__c> lstToUpdate = new List<Inventory_Position__c>();
        for(Inventory_Position__c ip : [SELECT Inventory_Hold_Reason_Code__c,Hold__c,Inventory_Location__c,Inventory_Location__r.Auto_Hold__c,Harvest_Batch_Code__r.Batch_ID_Hold__c FROM Inventory_Position__c WHERE Id =: ipIds AND Hold__c = false]){
            Inventory_Position__c oldIp = new Inventory_Position__c();
            if(!isInsert) {
                oldIp = oldMap.get(ip.Id);
            }
            if((isInsert && ip.Inventory_Location__r.Auto_Hold__c || ip.Inventory_Location__r.Auto_Hold__c && ip.Inventory_Location__r.Auto_Hold__c != oldIp.Inventory_Location__r.Auto_Hold__c) || ip.Harvest_Batch_Code__r.Batch_ID_Hold__c == true){
                ip.Hold__c = true;
                lstToUpdate.add(ip);
            }                                
        }
        if(lstToUpdate.size() > 0) update lstToUpdate;
    }
    
    public static void updateTotalDaysAndLastMovementDate(Boolean isInsert,List<Inventory_Position__c> newList,Map<Id,Inventory_Position__c> oldMap){
        Set<Id> ipIds = (new Map<Id,Inventory_Position__c>(newList)).keySet();
        List<Inventory_Position__c> lstToUpdate = new List<Inventory_Position__c>();
        for(Inventory_Position__c ip : [SELECT Id,Name,Inventory_Location__c,Inventory_Location__r.Name,Total_Days_in_Inventory__c,
                                        Inventory_Last_Movement_date__c,Date_Received__c,CreatedDate,Sales_Order_Line__c,
                                        Sales_Order_Line__r.Sales_Order__c,
                                        Sales_Order_Line__r.Sales_Order__r.Ship_Confirmation_Date__c
                                        FROM Inventory_Position__c WHERE Id =: ipIds]){
            Inventory_Position__c oldIp = new Inventory_Position__c();
            if(!isInsert)  oldIp = oldMap.get(ip.Id);                            
                                            
            if(isInsert || ip.Inventory_Location__c != oldIp.Inventory_Location__c){
                
                if(ip.Inventory_Location__r.Name == INVENTORY_LOCATION_DELIVERED || ip.Inventory_Location__r.Name == INVENTORY_LOCATION_TRANSFERRED || ip.Inventory_Location__r.Name == INVENTORY_LOCATION_TESTED_SAMPLED){
                    if(ip.Sales_Order_Line__c != null && ip.Sales_Order_Line__r.Sales_Order__c != null && ip.Sales_Order_Line__r.Sales_Order__r.Ship_Confirmation_Date__c != null){
                        ip.Inventory_Last_Movement_date__c = ip.Sales_Order_Line__r.Sales_Order__r.Ship_Confirmation_Date__c;
                        
                        if(ip.Date_Received__c != null){
                            ip.Total_Days_in_Inventory__c = ip.Date_Received__c.date().daysBetween(ip.Sales_Order_Line__r.Sales_Order__r.Ship_Confirmation_Date__c) +1;
                        } else {
                            ip.Total_Days_in_Inventory__c = ip.CreatedDate.date().daysBetween(ip.Sales_Order_Line__r.Sales_Order__r.Ship_Confirmation_Date__c) +1;
                        }
                        lstToUpdate.add(ip);
                    }
                } else if(ip.Inventory_Location__r.Name == INVENTORY_LOCATION_PACKAGED || ip.Inventory_Location__r.Name == INVENTORY_LOCATION_CANNA_WASTE || ip.Inventory_Location__r.Name == INVENTORY_LOCATION_WRITEOFF || ip.Inventory_Location__r.Name == INVENTORY_LOCATION_INVENTORY_WRITEOFF){
                    if(ip.Date_Received__c != null){
                        ip.Total_Days_in_Inventory__c = ip.Date_Received__c.date().daysBetween(Date.today()) +1;
                    } else {
                        ip.Total_Days_in_Inventory__c = ip.CreatedDate.date().daysBetween(Date.today()) +1;
                    }
                    ip.Inventory_Last_Movement_date__c = Date.today();
                    lstToUpdate.add(ip);
                }
            }
            
        }
        if(lstToUpdate.size() > 0) update lstToUpdate; 
    }
    
    public static void updateLastIPLocation(List<Inventory_Position__c> newList,Map<Id,Inventory_Position__c> oldMap){
        Map<Id,Inventory_Position__c> newUpdatedIPMap = new Map<Id,Inventory_Position__c>();
        for(Inventory_Position__c IP: newList){
            if(IP.Inventory_Location__c != oldMap.get(IP.Id).Inventory_Location__c || 
               IP.Rack__c != oldMap.get(IP.Id).Rack__c  ||
               IP.Rack_Level__c != oldMap.get(IP.Id).Rack_Level__c ||
               IP.Bin_Location__c != oldMap.get(IP.Id).Bin_Location__c ){
                   newUpdatedIPMap.put(IP.Id,IP);
               }
        }
        system.debug('newUpdatedIPMap>'+newUpdatedIPMap);
        if(newUpdatedIPMap.size() > 0){
            List<Inventory_Position__c> oldIPData =[SELECT Id ,Inventory_Location__c,Rack__c,Rack_Level__c,Bin_Location__c,
                                                    Inventory_Location__r.Name, Rack__r.name , Rack_Level__r.Name, 
                                                    Bin_Location__r.Name ,Name 
                                                    FROM  Inventory_Position__c 
                                                    WHERE Id IN :newUpdatedIPMap.keySet()];
            for(Inventory_Position__c IP : oldIPData){
                Inventory_Position__c newIP = newUpdatedIPMap.get(IP.Id);
                if(newIP != NULL){
                    string LastIPLocation ;  
                    if(IP.Inventory_Location__r.Name !=null){
                        LastIPLocation =  IP.Inventory_Location__r.Name; 
                    }
                    if(IP.Rack__r.Name !=null){
                        LastIPLocation = LastIPLocation + '-' + IP.Rack__r.Name; 
                    }
                    
                    if(IP.Rack_Level__r.Name !=null){
                        LastIPLocation =  LastIPLocation + '-' + IP.Rack_Level__r.Name; 
                    }
                    if(IP.Bin_Location__r.Name !=null){
                        LastIPLocation =  LastIPLocation + '-' + IP.Bin_Location__r.Name; 
                    }
                    newIP.Last_IP_Location__c  = LastIPLocation ;          
                    
                }
            }
        }
         
    }
}