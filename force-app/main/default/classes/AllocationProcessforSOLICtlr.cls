public class AllocationProcessforSOLICtlr {
    private ApexPages.StandardController stdController;
    private Sales_Order_Line__c SOLI = null;
    private static String recordTypeName = '';
    public AllocationProcessforSOLICtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
        SOLI = ((Sales_Order_Line__c)stdController.getRecord());
    }
    
    public PageReference AllocationProcess() {
        PageReference retPage = null;
        try{
            retPage = AllocationProcess(SOLI.Id);
            if(retPage != null){
                retPage.setRedirect(true);
            }
        } 
        catch (Exception ex){
            ErrorLogs.log('AllocationProcessforSO:AllocationProcess()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
        //return null;
    }
    
    public static PageReference AllocationProcess(Id soliId){
        System.debug('soliId::'+soliId);
        PageReference retPage = null;
        ApexPages.Message message;
        Sales_Order_Line__c objSOLine = [SELECT Id
                                         , Name
                                         , Sales_Order__c
                                         , Qty_Ordered__c
                                         , Product_Name__c
                                         , Qty_Allocated__c
                                         , Balance_Qty_to_Allocate__c
                                         , Status__c
                                         , Product_Name__r.Auto_Allocation__c
                                         , Ownership_Code__c
                                         , recordTypeId
                                         , Sales_Order__r.Ownership__c
                                         , Sales_Order__r.Site__c
                                         FROM Sales_Order_Line__c WHERE Id=: soliId];
        recordTypeName = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosById().get(objSOLine.RecordTypeId).getname();
        if(recordtypename == 'Service'){
            message = new ApexPages.Message(ApexPages.Severity.ERROR,'Allocation not allowed for Service Items');
            ApexPages.addMessage(message);
            return null;
        }
        if(objSOline.Status__c != 'Open'){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.SO_Allocation_Warning_Message );
            ApexPages.addMessage(message);
            return null;
        }
        String ownership = '';
        if(objSOline.Ownership_Code__c != null){
            ownership = objSOline.Ownership_Code__c;
        }else{
            ownership = objSOline.Sales_Order__r.Ownership__c;
        }
        //String ownership = objSOline.Sales_Order__r.Ownership__c;
        String siteId = objSOline.Sales_Order__r.Site__c;
        Id productId = objSOline.Product_Name__c;
        List<Inventory_Position__c> inventoryPositions = new List<Inventory_Position__c>();
        String query = 'SELECT Id,Date_Received__c,Site__c,Receiving_Line__c,Inventory_Location__c,Qty_On_Hand__c,Sales_Order_Line__c,';
        query += 'Product_Name__c,Ownership__c,Rack__c ,Rack_Level__c,Bin_Location__c,Product_Title__c,Qty_Allocated__c,';
        query += ' Lab_Test_Status__c,Harvest_Batch_Code__c,UID_New__c,Harvest_Batch_or_Lot_Code__c,Inventory_Location__r.Default_for_Site__c,Inventory_Location__r.Available_for_Allocation__c,Inventory_Location__r.Available_for_Lab_Allocation__c ';
        query += ' FROM Inventory_Position__c where Product_Name__c =:productId';
        query += ' AND Ownership__c  = : ownership ';
        query += ' AND Qty_On_Hand__c != null';
        query += ' AND Site__c = :siteId';
        query += ' AND Inventory_Location__c != null ';
        
        query += ' AND Hold__c = false ';
        if(recordtypename.equalsIgnoreCase('Lab')){
            query += ' AND Inventory_Location__r.Available_for_Lab_Allocation__c = true';    
        }else{
            query += ' AND Inventory_Location__r.Available_for_Allocation__c = true';
        }
        query += ' Order by Date_Received__c';
        inventoryPositions = Database.query(query);
        Map<Id,List<Inventory_Position__c>> mapofIPsbyProducId = new Map<Id,List<Inventory_Position__c>> ();
        list<Inventory_Position__c> lstofIPneedsUpdate = new list<Inventory_Position__c>();
        for(Inventory_Position__c objIP : inventoryPositions){
            System.debug('Qty_On_Hand__c:'+objIP.Qty_On_Hand__c);
            if(mapofIPsbyProducId.containsKey(objIP.Product_Name__c)){
                List<Inventory_Position__c> tempIPlist = mapofIPsbyProducId.get(objIP.Product_Name__c);
                tempIPlist.add(objIP);
                mapofIPsbyProducId.put(objIP.Product_Name__c,tempIPlist);
            }else{
                mapofIPsbyProducId.put(objIP.Product_Name__c, new List<Inventory_Position__c> {objIP});
            }
        }
        Sales_order_Line__c soliToUpdate; 
        if(!mapofIPsbyProducId.keyset().contains(productId)){
            if( objSOline.Status__c == 'Open' && 
               objSOline.Qty_Ordered__c > 0 &&
               !objSOline.Product_Name__r.Auto_Allocation__c){
                   soliToUpdate = new Sales_order_Line__c(
                       Id=objSOline.Id,
                       Status__c = 'Back Ordered', 
                       Qty_Allocated__c = 0);
               }else{
                   soliToUpdate = new Sales_order_Line__c(
                       Id=objSOline.Id,
                       Status__c = 'Allocated', 
                       Qty_Allocated__c = objSOline.Qty_Ordered__c);
               }
        }
        Decimal sumofQtyinHand;
        if(mapofIPsbyProducId.keyset().contains(productId)){
            sumofQtyinHand = calTotalQtyinHand(mapofIPsbyProducId.get(productId));
            System.debug('sumofQtyinHand::'+sumofQtyinHand);
            if(objSOline.Balance_Qty_to_Allocate__c == sumofQtyinHand){
                lstofIPneedsUpdate = getIPsNeededtoUpdate(
                    mapofIPsbyProducId.get(productId), 
                    objSOline.Qty_Ordered__c, 
                    objSOline.Balance_Qty_to_Allocate__c,
                    objSOline.Id);
                Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, objSOline.id);
                soliToUpdate = new Sales_order_Line__c(
                    Id=objSOline.Id,
                    Status__c = 'Allocated', 
                    Qty_Allocated__c = totalQtyAllocated);
            }else if(objSOline.Balance_Qty_to_Allocate__c < sumofQtyinHand){
                lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                          objSOline.Qty_Ordered__c, 
                                                          objSOline.Balance_Qty_to_Allocate__c, 
                                                          objSOline.id);
                
                Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, objSOline.id);
                soliToUpdate = new Sales_Order_Line__c(
                    id = objSOline.Id, 
                    Status__c = 'Allocated', 
                    Qty_Allocated__c = totalQtyAllocated); 
            } else if(sumofQtyinHand == 0 && objSOline.Balance_Qty_to_Allocate__c > 0){
                
                Decimal totalQtyAllocated = calTotalQtyAllocated(mapofIPsbyProducId.get(productId), objSOline.id);
                
                soliToUpdate = new Sales_Order_Line__c(
                    id = objSOline.id, 
                    Status__c = 'Back Ordered', 
                    Qty_Allocated__c = totalQtyAllocated);
                
            } else if(objSOline.Balance_Qty_to_Allocate__c > sumofQtyinHand){
                
                
                lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                          objSOline.Qty_Ordered__c, 
                                                          objSOline.Balance_Qty_to_Allocate__c,
                                                          objSOline.id);
                Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, objSOline.Id);
                
                soliToUpdate  = new Sales_Order_Line__c(
                    id = objSOline.id, 
                    Status__c = 'Partially Allocated', 
                    Qty_Allocated__c = totalQtyAllocated);
                
                //setAllocatedFlag = false;
                
            }   
        }
        if(soliToUpdate != null){
            update soliToUpdate;  
            validateSOAllocation(objSOline.Sales_Order__c);
        } 
        upsert lstofIPneedsUpdate;
        
        retPage =new PageReference('/'+objSOline.Id);   
        return retPage; 
    }
    
    public static List<Inventory_Position__c> getIPsNeededtoUpdate(List<Inventory_Position__c> tempListIP,
                                                                   decimal tempQtyOrderd, decimal balanceQty,
                                                                   Id tempSoLineId){
        
        List<Inventory_Position__c> newIps = new List<Inventory_Position__c>();
        
        list<Inventory_Position__c> tempIPneedtoUpdate = new list<Inventory_Position__c>();
        boolean toexitfromLoop = false;
        decimal qtyorder = tempQtyOrderd;
        for(Inventory_Position__c objtempIp: tempListIP){
            
            if(!objtempIp.Inventory_Location__r.Default_for_Site__c) {
                //System.debug('objtempIp.Inventory_Location__r.Default_for_Site__c'+objtempIp.Inventory_Location__r.Default_for_Site__c); 
                if(!toexitfromLoop) {
                    if(objtempIp.Qty_On_Hand__c == balanceQty && objtempIp.Qty_On_Hand__c!= 0){
                        balanceQty = balanceQty - objtempIp.Qty_On_Hand__c;
                        objtempIp.Qty_Allocated__c = objtempIp.Qty_On_Hand__c;
                        objtempIp.Qty_On_Hand__c = 0;
                        objtempIp.Sales_Order_Line__c = tempSoLineId;
                        tempIPneedtoUpdate.add(objtempIp);                        
                    }else if(objtempIp.Qty_On_Hand__c > balanceQty && balanceQty != 0 && objtempIp.Qty_On_Hand__c!= 0){
                        Inventory_Position__c newObjIP = new Inventory_Position__c();
                        newObjIP = objtempIp.clone();
                        newObjIP.Qty_On_Hand__c = 0 ;
                        
                        newObjIP.Ownership__c = objtempIp.Ownership__c;
                        newObjIP.Rack__c = objtempIp.Rack__c;
                         
                        newObjIP.Harvest_Batch_Code__c =  objtempIp.Harvest_Batch_Code__c;
                        newObjIP.UID_New__c =  objtempIp.UID_New__c;
                        newObjIP.Rack_Level__c = objtempIp.Rack_Level__c;
                        newObjIP.Bin_Location__c = objtempIp.Bin_Location__c;
                        newObjIP.Product_Title__c = objtempIp.Product_Title__c; 
                        newObjIP.Sales_Order_Line__c = tempSoLineId;
                        if(recordTypeName.equalsIgnoreCase('Lab') && String.isNotBlank(objtempIp.Inventory_Location__c) 
                           && objtempIp.Inventory_Location__r.Available_for_Lab_Allocation__c){
                               newObjIP.Inventory_Location__c = objtempIp.Inventory_Location__c;   
                           }
                        newObjIP.Qty_Allocated__c = balanceQty;
                        balanceQty =  objtempIp.Qty_On_Hand__c - balanceQty;
                        
                        newIps.add(newObjIP);
                        objtempIp.Qty_On_Hand__c = balanceQty;
                        //objtempIp.Sales_Order_Line__c = tempSoLineId;
                        tempIPneedtoUpdate.add(objtempIp);
                        toexitfromLoop = true;
                    } else if(objtempIp.Qty_On_Hand__c < balanceQty && objtempIp.Qty_On_Hand__c!= 0){
                        balanceQty = balanceQty - objtempIp.Qty_On_Hand__c;
                        objtempIp.Qty_Allocated__c = objtempIp.Qty_On_Hand__c;
                        objtempIp.Qty_On_Hand__c = 0;
                        objtempIp.Sales_Order_Line__c = tempSoLineId;
                        tempIPneedtoUpdate.add(objtempIp);                        
                    }   
                }     
            }
        }   
        
        
        toexitfromLoop = false;
        
        tempIPneedtoUpdate.addAll(newIps);
        return tempIPneedtoUpdate;  
        
    }
    
    public static Decimal calTotalQtyinHand(List<Inventory_Position__c> listIPs){
        Decimal totalQty = 0.0;
        for(Inventory_Position__c objIP : listIPs){
            if(!objIP.Inventory_Location__r.Default_for_Site__c) {
                totalQty = totalQty + objIP.Qty_On_Hand__c;
            }
        }
        return totalQty ;
    }
    
    public static Decimal calTotalQtyAllocated(List<Inventory_Position__c> tempListIP, Id tempSoLineId){
        Decimal totalQtyAllocated = 0.0;
        for(Inventory_Position__c objtempIp : tempListIP){
            if(objtempIp.Sales_Order_Line__c == tempSoLineId) {  
                totalQtyAllocated = totalQtyAllocated + objtempIp.Qty_Allocated__c;
            }       
        }
        return totalQtyAllocated ;
    }
    
    public static void validateSOAllocation(Id soId){
        Sales_Order__c soObj ;
        for(Sales_Order__c order : [SELECT Id, (SELECT Id FROM Sales_Order_Lines__r Where Status__c NOT IN ('Cancelled','Allocated','Rejected')) FROM Sales_Order__c WHERE Id = :soId]){
            if(order.Sales_Order_Lines__r.isEmpty()){
                soObj = new Sales_Order__c(Id = order.Id, Allocated__c  = true);
            }
        }
        if(soObj != null){
            update soObj;
        }
    }
    
    public PageReference goBack() {
        return stdController.view().setRedirect(true);
    }
}