/*
Copyright (c) 2018 Filigreen Distro
All rights reserved.
Test Class Name: AllocationProcessforSOTest
*/
public class AllocationProcessforSO{
    
    private ApexPages.StandardController stdController;
    private Sales_Order__c SO = null;
    private static final String PICKLIST_STATUS_CONFIRMED = 'Confirmed';
    private static final String SO_STATUS_CANCELLED = SalesOrderSupport.SO_STATUS_CANCELLED; 
    private static String SO_RecordType;
    public static String messageLight;
    public AllocationProcessforSO(ApexPages.StandardController controller) {
        this.stdController = controller;
        //System.debug('stdController'+stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        SO = ((Sales_Order__c)stdController.getRecord());
        System.assertNotEquals(null, SO, 'Sales Order record is null');
    }
    public class UserException extends Exception{ }
    
    public AllocationProcessforSO(){
        
    }

    public PageReference AllocationProcess() {
        PageReference retPage = null;
        try{ 
            retPage = AllocationProcess(SO.Id);
            if(retPage != null){
                retPage.setRedirect(true);
            }
        } 
        catch (Exception ex)
        {
            ErrorLogs.log('AllocationProcessforSO:AllocationProcess()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }
    
    public static PageReference AllocationProcess(Id soid)
    {
        PageReference retPage = null;
        ApexPages.Message message;
        ID sOrderId = soid;
        Sales_Order__c SOHold = [SELECT name, Customer_PO_or_Quote__c, Account_Hold_Exception__c, Supplier_Name__c, Receiver_Name__c, Distributor_Name__c,Id FROM Sales_Order__c where Id =:sOrderId];     
        
        Account  supAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
        Account  recAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
        Account  disAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Distributor_Name__c];

        String accountName = '';
		Set<String> my_list = new Set<String>();
        if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
        {
            if(supAcc.Hold__c == true){
                my_list.add(supAcc.DBA__c);
            }
            if(disAcc.Hold__c == true){
                 my_list.add(disAcc.DBA__c);
            }
            if(recAcc.Hold__c == true){
                 my_list.add(recAcc.DBA__c);
            }
            accountName = String.join(new List<String>(my_list), ', ');
            String ErrorMessage = 'Account: '+ accountName +' is on HOLD. Please check with Finance team.';
            message = new ApexPages.Message(ApexPages.Severity.ERROR, ErrorMessage);
            ApexPages.addMessage(message);
            return null;    
        }
        else{
        List<Sales_Order__c> SoList = [select id ,name,RecordTypeId,
                             RecordType.Name
                             ,SO_Status__c
                             ,Ownership__c
                             ,BOPA__c 
                             ,Site__c
                             ,Allocated__c, (select id
                                             ,name
                                             ,Sales_Order__c
                                             ,Qty_Ordered__c
                                             ,Product_Name__c
                                             ,Qty_Allocated__c
                                             ,Balance_Qty_to_Allocate__c
                                             ,Status__c
                                             ,Product_Name__r.Auto_Allocation__c
                                             , Ownership_Code__c 
                                             from Sales_Order_Lines__r )
                             from Sales_Order__c where id =: sOrderId AND Ownership__c  != null];
        Sales_Order__c So = new Sales_Order__c();
        if(SoList.isEmpty()){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 'Sales Order does not have Ownership Code');
            ApexPages.addMessage(message);
            return null;
        }else{
            So = SoList[0];
        }
        
        //where Balance_Qty_to_Allocate__c != 0 AND Status__c != 'Allocated' AND Status__c != 'Cancelled'
        //System.debug('So*******'+So);
        String recordtypename = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosById().get(So.RecordTypeId).getname();
        if(recordtypename == 'Service')
        {
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            'Allocation not allowed for Service Orders');
            ApexPages.addMessage(message);
            return null;
        }
        
        if(checkValidation(SO)){
            return null; 
        }
        
        System.debug('So.Sales_Order_Lines__r*******'+So.Sales_Order_Lines__r);
        map<ID,Sales_Order_Line__c> mapofSOlinebyProductID = new map<ID,Sales_Order_Line__c>();
        List<Sales_Order_Line__c> Soline  = So.Sales_Order_Lines__r;
        
        
        Set<Id> SOLineProductIds = new Set<Id>();
        Set<Id> ownerShipCodes = new Set<Id>();
        for(Sales_Order_Line__c objSOline : Soline){
            if(objSOline.Ownership_Code__c != null){
                ownerShipCodes.add(objSOline.Ownership_Code__c);
            }else{
                ownerShipCodes.add(So.Ownership__c);
            }
            if(objSOline.Status__c != 'Open'){
                message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.SO_Allocation_Warning_Message );
                ApexPages.addMessage(message);
                return null;
            }
            SOLineProductIds.add(objSOline.Product_Name__c);
            System.debug('objSOline.Id:'+objSOline.Id);
            mapofSOlinebyProductID.put(objSOline.Id,objSOline);
        }
        
        //List of Filtered IP's from SOLI Product.
        List<Inventory_Position__c> inventoryPositions = new List<Inventory_Position__c>();
        //Set Of Ownership_Code__c if lineitem Ownership_Code__c is blank then use Sales Order.Ownership_Code__c
        String ownership = SO.Ownership__c; 
        String siteId = SO.Site__c; 
         
        
        String query = 'SELECT Id,Date_Received__c,Site__c,Hold__c,Receiving_Line__c,Inventory_Location__c,Aged_Bucket__c,Qty_On_Hand__c,Sales_Order_Line__c,';
        query += 'Product_Name__c,Ownership__c,Rack__c ,Rack_Level__c,Bin_Location__c,Product_Title__c,Qty_Allocated__c,Inventory_Location__r.Auto_Hold__c,';
        query += ' Lab_Test_Status__c,Harvest_Batch_Code__c,UID_New__c,Inventory_Location__r.Default_for_Site__c,Inventory_Location__r.Available_for_Allocation__c,Inventory_Location__r.Available_for_Lab_Allocation__c ';
        query += ' FROM Inventory_Position__c where Product_Name__c =:SOLineProductIds';
        query += ' AND Ownership__c  IN : ownerShipCodes ';
        query += ' AND Qty_On_Hand__c != null';
        query += ' AND Site__c = :siteId';
        query += ' AND Inventory_Location__c != null ';
        
        SO_RecordType = SO.RecordType.Name;
        
        if(SO_RecordType.equalsIgnoreCase('Lab')){
            query += ' AND Inventory_Location__r.Available_for_Lab_Allocation__c = true'; 
            query += ' AND Inventory_Location__r.Auto_Hold__c = true'; 
            query += ' AND Hold__c = true';
        }else{
            query += ' AND Inventory_Location__r.Available_for_Allocation__c = true';
            query += ' AND Hold__c = false ';
        }
        query += ' Order by Date_Received__c';
        inventoryPositions = Database.query(query);
        
        System.debug('inventoryPositions::'+JSON.serialize(inventoryPositions));
        
        map<Id,List<Inventory_Position__c>> mapofIPsbyProducId = new map<Id,List<Inventory_Position__c>> ();
        
        for(Inventory_Position__c objIP : inventoryPositions){ 
            if(mapofIPsbyProducId.containsKey(objIP.Product_Name__c)){
                List<Inventory_Position__c> tempIPlist = mapofIPsbyProducId.get(objIP.Product_Name__c);
                tempIPlist.add(objIP);
                System.debug('objIP.Product_Name__c::'+objIP.Product_Name__c);
                System.debug('objIP.Sales_Order_Line__c::'+objIP.Sales_Order_Line__c);
                mapofIPsbyProducId.put(objIP.Product_Name__c,tempIPlist);
            }else{
                mapofIPsbyProducId.put(objIP.Product_Name__c, new List<Inventory_Position__c> {objIP});
            }
        }
        
        
        
        list<Sales_Order_Line__c> tempSOlines = new list<Sales_Order_Line__c>();
        Map<Id,Sales_Order_Line__c> tempSOlinesMap = new Map<Id,Sales_Order_Line__c>();
        list<Inventory_Position__c> lstofIPneedsUpdate = new list<Inventory_Position__c>();
        Boolean setAllocatedFlag = true;
        
        //Update SOLI's Status & Qty Allocated
        Map<Id,Decimal> availableForAllocation = new Map<Id,Decimal>();
        for(Id keyId: mapofSOlinebyProductID.Keyset()){
            //get Sales_Order_Line__c
            Sales_Order_Line__c soli = mapofSOlinebyProductID.get(keyId);
            Id productId = soli.Product_Name__c;
            if((!mapofIPsbyProducId.keyset().contains(productId)) && soli.Status__c == 'Open' && soli.Qty_Ordered__c > 0 && !soli.Product_Name__r.Auto_Allocation__c){ 
                   
                   tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                      Status__c = 'Back Ordered', 
                                                                      Qty_Allocated__c = 0));
                   setAllocatedFlag = false;         
               }else{ 
                   tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                      Status__c = 'Allocated', 
                                                                      Qty_Allocated__c = soli.Qty_Ordered__c));
               }
            
            if(mapofIPsbyProducId.keyset().contains(productId)){
                if(!availableForAllocation.containsKey(productId)){
                    Decimal sumofQtyinHandTemp = calTotalQtyinHand(mapofIPsbyProducId.get(productId));
                    availableForAllocation.put(productId,sumofQtyinHandTemp);
                }
                Decimal sumofQtyinHand = availableForAllocation.get(productId); 
                
                
                
                
                if(soli.Balance_Qty_to_Allocate__c == sumofQtyinHand){
                   
                    lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                              soli.Qty_Ordered__c, 
                                                              soli.Balance_Qty_to_Allocate__c,
                                                              soli.id,lstofIPneedsUpdate);
                    Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id);
                    
                    //system.debug('lstofIPneedsUpdate----'+lstofIPneedsUpdate);
                    
                    tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                       Status__c = 'Allocated', 
                                                                       Qty_Allocated__c = totalQtyAllocated));
                    availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                    //System.debug('totalQtyAllocated a.......'+totalQtyAllocated);
                    
                }   
                
                else if(soli.Balance_Qty_to_Allocate__c < sumofQtyinHand){
                    
                    
                    lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                              soli.Qty_Ordered__c, 
                                                              soli.Balance_Qty_to_Allocate__c, 
                                                              soli.id,lstofIPneedsUpdate);
                    System.debug('mapofIPsbyProducId.get(productId)----'+JSON.serialize(mapofIPsbyProducId.get(productId)));
                    //Decimal totalQtyAllocated = calTotalQtyAllocated(mapofIPsbyProducId.get(productId), soli.id);
                    Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id);
                    tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                       Status__c = 'Allocated', 
                                                                       Qty_Allocated__c = totalQtyAllocated)); 
                    availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                    //System.debug('totalQtyAllocated b.......'+totalQtyAllocated);
                    
                } else if(sumofQtyinHand == 0 && soli.Balance_Qty_to_Allocate__c > 0){
                    
                    Decimal totalQtyAllocated = calTotalQtyAllocated(mapofIPsbyProducId.get(productId), soli.id);
                    
                    tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                       Status__c = 'Back Ordered', 
                                                                       Qty_Allocated__c = totalQtyAllocated));
                    //System.debug('totalQtyAllocated c.......'+totalQtyAllocated);
                    //availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                    setAllocatedFlag = false;
                    
                } else if(soli.Balance_Qty_to_Allocate__c > sumofQtyinHand){
                    
                    
                    lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                              soli.Qty_Ordered__c, 
                                                              soli.Balance_Qty_to_Allocate__c,
                                                              soli.id,lstofIPneedsUpdate);
                    //system.debug('lstofIPneedsUpdate----'+lstofIPneedsUpdate);
                    Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id);
                    
                    tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                       Status__c = 'Partially Allocated', 
                                                                       Qty_Allocated__c = totalQtyAllocated));
                    availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                    //System.debug('totalQtyAllocated d.......'+totalQtyAllocated);
                    setAllocatedFlag = false;
                    
                }
                
            }
            
        }
        
        
        
        
        if(setAllocatedFlag){
            SO.Allocated__c = true; 
            update SO;
        }
        
        update tempSOlinesMap.values();

        upsert lstofIPneedsUpdate;

        retPage =new PageReference('/'+SO.Id);    
         return retPage;	 
        }
       
    }
    
    /* allocation process for lightning*/
    @Auraenabled
    public static  AuraResponse AllocationProcessLight(Id soid)
    {
        AuraResponse r = new AuraResponse('AllocationProcessforSO.AllocationProcessLight()');
        SavePoint savePoint;
        //AllocationProcessforSO ap = new AllocationProcessforSO();
        try{
            savePoint = Database.setSavepoint();
            ID sOrderId = soid;
            Sales_Order__c SOHold = [SELECT name, Customer_PO_or_Quote__c, Account_Hold_Exception__c, Supplier_Name__c, Receiver_Name__c, Distributor_Name__c,Id FROM Sales_Order__c where Id =:sOrderId];     
            
            Account  supAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
            Account  recAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
            Account  disAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
            
            String accountName = '';
            Set<String> my_list = new Set<String>();
            if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
            {
                if(supAcc.Hold__c == true){
                    my_list.add(supAcc.DBA__c);
                }
                if(disAcc.Hold__c == true){
                    my_list.add(disAcc.DBA__c);
                }
                if(recAcc.Hold__c == true){
                    my_list.add(recAcc.DBA__c);
                }
                accountName = String.join(new List<String>(my_list), ', ');
                String ErrorMessage = 'Account: '+ accountName +' is on HOLD. Please check with Finance team.';
                messageLight = ErrorMessage;
                r.data.put('message', messageLight);
                return r;    
            }
            else{
                List<Sales_Order__c> SoList = [select id ,name,RecordTypeId,
                                               RecordType.Name
                                               ,SO_Status__c
                                               ,Ownership__c
                                               ,BOPA__c
                                               ,Site__c
                                               ,Allocated__c, (select id
                                                               ,name
                                                               ,Sales_Order__c
                                                               ,Qty_Ordered__c
                                                               ,Product_Name__c
                                                               ,Qty_Allocated__c
                                                               ,Balance_Qty_to_Allocate__c
                                                               ,Status__c
                                                               ,Product_Name__r.Auto_Allocation__c
                                                               , Ownership_Code__c 
                                                               from Sales_Order_Lines__r WHERE Status__c = 'Open')
                                               from Sales_Order__c where id =: sOrderId AND Ownership__c  != null];
                Sales_Order__c So = new Sales_Order__c();
                if(SoList.isEmpty()){
                    messageLight = 'Sales Order does not have Ownership Code';
                    r.data.put('message', messageLight);
                    return r;
                }else{
                    So = SoList[0];
                }
                
                //where Balance_Qty_to_Allocate__c != 0 AND Status__c != 'Allocated' AND Status__c != 'Cancelled'
                //System.debug('So*******'+So);
                String recordtypename = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosById().get(So.RecordTypeId).getname();
                if(recordtypename == 'Service')
                {
                    messageLight = 'Allocation not allowed for Service Orders';
                    r.data.put('message', messageLight);
                    return r;
                }
                
                if(checkValidationLight(SO)){
                    r.data.put('message', messageLight);
                    return r;
                }
                
                System.debug('So.Sales_Order_Lines__r*******'+So.Sales_Order_Lines__r);
                map<ID,Sales_Order_Line__c> mapofSOlinebyProductID = new map<ID,Sales_Order_Line__c>();
                List<Sales_Order_Line__c> Soline  = So.Sales_Order_Lines__r;
                
                
                Set<Id> SOLineProductIds = new Set<Id>();
                Set<Id> ownerShipCodes = new Set<Id>();
                for(Sales_Order_Line__c objSOline : Soline){
                    if(objSOline.Ownership_Code__c != null){  ownerShipCodes.add(objSOline.Ownership_Code__c);
                       
                    }else{
                        ownerShipCodes.add(So.Ownership__c);
                    }
                    if(objSOline.Status__c != 'Open'){
                        messageLight = Label.SO_Allocation_Warning_Message;
                        r.data.put('message', messageLight);
                        return r;
                    }
                    SOLineProductIds.add(objSOline.Product_Name__c);
                    System.debug('objSOline.Id:'+objSOline.Id);
                    mapofSOlinebyProductID.put(objSOline.Id,objSOline);
                }
                
                //List of Filtered IP's from SOLI Product.
                List<Inventory_Position__c> inventoryPositions = new List<Inventory_Position__c>();
                //Set Of Ownership_Code__c if lineitem Ownership_Code__c is blank then use Sales Order.Ownership_Code__c
                String ownership = SO.Ownership__c;
                String siteId = SO.Site__c; 
                
                
                String query = 'SELECT Id,Date_Received__c,Site__c,Hold__c,Receiving_Line__c,Aged_Bucket__c,Inventory_Location__c,Qty_On_Hand__c,Sales_Order_Line__c,';
                query += 'Product_Name__c,Ownership__c,Inventory_Location__r.Auto_Hold__c,Rack__c ,Rack_Level__c,Bin_Location__c,Product_Title__c,Qty_Allocated__c,';
                query += ' Lab_Test_Status__c,Harvest_Batch_Code__c,UID_New__c,Inventory_Location__r.Default_for_Site__c,Inventory_Location__r.Available_for_Allocation__c,Inventory_Location__r.Available_for_Lab_Allocation__c ';
                query += ' FROM Inventory_Position__c where Product_Name__c =:SOLineProductIds';
                query += ' AND Ownership__c  IN : ownerShipCodes ';
                query += ' AND Qty_On_Hand__c != null';
                query += ' AND Site__c = :siteId';
                query += ' AND Inventory_Location__c != null ';
                
                SO_RecordType = SO.RecordType.Name;
                
                if(SO_RecordType.equalsIgnoreCase('Lab')){
                    query += ' AND Inventory_Location__r.Available_for_Lab_Allocation__c = true'; 
                    query += ' AND Inventory_Location__r.Auto_Hold__c = true'; 
                    query += ' AND Hold__c = true';
                }else{
                    query += ' AND Inventory_Location__r.Available_for_Allocation__c = true';
                    query += ' AND Hold__c = false ';
                }
                query += ' Order by Date_Received__c';
                inventoryPositions = Database.query(query);
                
                System.debug('inventoryPositions::'+JSON.serialize(inventoryPositions));
                
                map<Id,List<Inventory_Position__c>> mapofIPsbyProducId = new map<Id,List<Inventory_Position__c>> ();
                
                for(Inventory_Position__c objIP : inventoryPositions){
                    if(mapofIPsbyProducId.containsKey(objIP.Product_Name__c)){
                        List<Inventory_Position__c> tempIPlist = mapofIPsbyProducId.get(objIP.Product_Name__c);
                        tempIPlist.add(objIP);
                        System.debug('objIP.Product_Name__c::'+objIP.Product_Name__c);
                        System.debug('objIP.Sales_Order_Line__c::'+objIP.Sales_Order_Line__c);
                        mapofIPsbyProducId.put(objIP.Product_Name__c,tempIPlist);
                    }else{
                        mapofIPsbyProducId.put(objIP.Product_Name__c, new List<Inventory_Position__c> {objIP});
                    }
                }
                
                
                
                list<Sales_Order_Line__c> tempSOlines = new list<Sales_Order_Line__c>();
                Map<Id,Sales_Order_Line__c> tempSOlinesMap = new Map<Id,Sales_Order_Line__c>();
                list<Inventory_Position__c> lstofIPneedsUpdate = new list<Inventory_Position__c>();
                Boolean setAllocatedFlag = true;
                
                //Update SOLI's Status & Qty Allocated
                Map<Id,Decimal> availableForAllocation = new Map<Id,Decimal>(); 
                for(Id keyId: mapofSOlinebyProductID.Keyset()){
                    //get Sales_Order_Line__c
                    Sales_Order_Line__c soli = mapofSOlinebyProductID.get(keyId);
                    Id productId = soli.Product_Name__c;
                    if((!mapofIPsbyProducId.keyset().contains(productId)) && soli.Status__c == 'Open' && soli.Qty_Ordered__c > 0 && !soli.Product_Name__r.Auto_Allocation__c){ 
                           
                           tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                              Status__c = 'Back Ordered', 
                                                                              Qty_Allocated__c = 0));
                           setAllocatedFlag = false;         
                       }else{ 
                           tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                              Status__c = 'Allocated', 
                                                                              Qty_Allocated__c = soli.Qty_Ordered__c));
                       }
                    
                    if(mapofIPsbyProducId.keyset().contains(productId)){
                        if(!availableForAllocation.containsKey(productId)){
                            Decimal sumofQtyinHandTemp = calTotalQtyinHand(mapofIPsbyProducId.get(productId));
                            availableForAllocation.put(productId,sumofQtyinHandTemp);
                        }
                        Decimal sumofQtyinHand = availableForAllocation.get(productId); 
                        
                        
                        
                        
                        if(soli.Balance_Qty_to_Allocate__c == sumofQtyinHand){
                            
                            lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                                      soli.Qty_Ordered__c, 
                                                                      soli.Balance_Qty_to_Allocate__c,
                                                                       soli.id,lstofIPneedsUpdate);
                            Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id); 
                            
                            //system.debug('lstofIPneedsUpdate----'+lstofIPneedsUpdate);
                            
                            tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                               Status__c = 'Allocated', 
                                                                               Qty_Allocated__c = totalQtyAllocated));
                            availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                            //System.debug('totalQtyAllocated a.......'+totalQtyAllocated);
                            
                        }   
                        
                        else if(soli.Balance_Qty_to_Allocate__c < sumofQtyinHand){
                            
                            
                            lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                                      soli.Qty_Ordered__c, 
                                                                      soli.Balance_Qty_to_Allocate__c, 
                                                                      soli.id,lstofIPneedsUpdate);
                            System.debug('mapofIPsbyProducId.get(productId)----'+JSON.serialize(mapofIPsbyProducId.get(productId)));
                            //Decimal totalQtyAllocated = calTotalQtyAllocated(mapofIPsbyProducId.get(productId), soli.id);
                            Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id);
                            tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                               Status__c = 'Allocated', 
                                                                               Qty_Allocated__c = totalQtyAllocated)); 
                            availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                            //System.debug('totalQtyAllocated b.......'+totalQtyAllocated);
                            
                        } else if(sumofQtyinHand == 0 && soli.Balance_Qty_to_Allocate__c > 0){
                            
                            Decimal totalQtyAllocated = calTotalQtyAllocated(mapofIPsbyProducId.get(productId), soli.id);
                            
                            tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                               Status__c = 'Back Ordered', 
                                                                               Qty_Allocated__c = totalQtyAllocated));
                            //System.debug('totalQtyAllocated c.......'+totalQtyAllocated);
                            //availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                            setAllocatedFlag = false;
                            
                        } else if(soli.Balance_Qty_to_Allocate__c > sumofQtyinHand){
                            
                            
                            lstofIPneedsUpdate = getIPsNeededtoUpdate(mapofIPsbyProducId.get(productId), 
                                                                      soli.Qty_Ordered__c, 
                                                                      soli.Balance_Qty_to_Allocate__c,
                                                                      soli.id,lstofIPneedsUpdate);
                            //system.debug('lstofIPneedsUpdate----'+lstofIPneedsUpdate);
                            Decimal totalQtyAllocated = calTotalQtyAllocated(lstofIPneedsUpdate, soli.id);
                            
                            tempSOlinesMap.put(soli.id,new Sales_Order_Line__c(id = soli.id, 
                                                                               Status__c = 'Partially Allocated', 
                                                                               Qty_Allocated__c = totalQtyAllocated));
                            availableForAllocation.put(productId,(sumofQtyinHand - totalQtyAllocated));
                            //System.debug('totalQtyAllocated d.......'+totalQtyAllocated);
                            setAllocatedFlag = false;
                            
                        }
                        
                    }
                    
                }
                

                if(setAllocatedFlag){
                    SO.Allocated__c = true; 
                    SO.BOPA__c = false; 
                }else{
                    SO.BOPA__c = true;
                }
                update SO;
                
                update tempSOlinesMap.values();
                
                upsert lstofIPneedsUpdate;
                
                return r;	 
            }
        }
        catch(Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('AllocationProcessforSO:AllocationProcessLight()',ex.getStackTraceString(), ex.getMessage());
            messageLight = ex.getMessage();
            r.data.put('message', messageLight);
            return r;
        }
    }
    
    //Calculate Total Sum of Quanitity's in Hand for Filtered Inventory Positions.
    public static Decimal calTotalQtyinHand(List<Inventory_Position__c> listIPs){
        Decimal totalQty = 0.0;
        for(Inventory_Position__c objIP : listIPs){
            if(!objIP.Inventory_Location__r.Default_for_Site__c) {
                //System.debug('totalQty in calTotalQtyinHand'+totalQty);
                totalQty = totalQty + objIP.Qty_On_Hand__c;
            }
        }
        return totalQty ;
    }   
    
    
    //Calculate Total Sum of Quanitity'Allocated for Allocated SOLI's.
    public static Decimal calTotalQtyAllocated(List<Inventory_Position__c> tempListIP, Id tempSoLineId){
        Decimal totalQtyAllocated = 0.0;
        
        for(Inventory_Position__c objtempIp : tempListIP){
            if(objtempIp.Sales_Order_Line__c == tempSoLineId) {   totalQtyAllocated = totalQtyAllocated + objtempIp.Qty_Allocated__c;
               
               
            }       
        }
        System.debug('totalQtyAllocated::'+totalQtyAllocated);
        return totalQtyAllocated ;
    }   
    
    
    //Update Inventory Positions.  
    public static List<Inventory_Position__c> getIPsNeededtoUpdate(List<Inventory_Position__c> tempListIP,decimal tempQtyOrderd, decimal balanceQty, id tempSoLineId,List<Inventory_Position__c> lstofIPneedsUpdate){
        
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
                        objtempIp.Aged_Bucket__c = objtempIp.Aged_Bucket__c;
                        tempIPneedtoUpdate.add(objtempIp);                        
                    }else if(objtempIp.Qty_On_Hand__c > balanceQty && balanceQty != 0 && objtempIp.Qty_On_Hand__c!= 0){
                        Inventory_Position__c newObjIP = new Inventory_Position__c();
                        newObjIP = objtempIp.clone();
                        newObjIP.Qty_On_Hand__c = 0 ;
                        newObjIP.Ownership__c = objtempIp.Ownership__c;
                        newObjIP.Rack__c = objtempIp.Rack__c;
                        newObjIP.Rack_Level__c = objtempIp.Rack_Level__c; 
                        newObjIP.Bin_Location__c = objtempIp.Bin_Location__c;
                        newObjIP.Product_Title__c = objtempIp.Product_Title__c; 
                        newObjIP.Sales_Order_Line__c = tempSoLineId;
                      objtempIp.Aged_Bucket__c = objtempIp.Aged_Bucket__c;
                        if(SO_RecordType.equalsIgnoreCase('Lab') && String.isNotBlank(objtempIp.Inventory_Location__c) 
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
        if(lstofIPneedsUpdate.size() >0){
            Map<Id,Inventory_Position__c> existingIds = new Map<Id,Inventory_Position__c>();
            
            for(Inventory_Position__c existngIP : lstofIPneedsUpdate){
                if(existngIP.Id != NULL){
                    existingIds.put(existngIP.Id,existngIP);
                }else{  newIps.add(existngIP); 
                   
                }
            }
            
            
            List<Inventory_Position__c> existingIpsNeedsToUpdate = new List<Inventory_Position__c>();
            for(Inventory_Position__c currntIP : tempIPneedtoUpdate){
                if(currntIP.Id != NULL){
                    existingIds.put(currntIP.Id,currntIP);
                }
            }
            
            tempIPneedtoUpdate = new List<Inventory_Position__c>();
            if(!existingIds.isEmpty())
                tempIPneedtoUpdate.addAll(existingIds.values());
            
        }
        tempIPneedtoUpdate.addAll(newIps);
        return tempIPneedtoUpdate;  
        
    }
    
    /**
* Perform validation - SO cannot be cancelled
*
* @return Boolean flag to indicate if any validation fails
*/
    public static Boolean checkValidation(Sales_Order__c salesOrderObj){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        List<Picklist__c> pickLists = new List<Picklist__c>();
        pickLists = [Select Id From Picklist__c 
                     Where Sales_Order__c =: salesOrderObj.Id 
                     AND Status__c =: PICKLIST_STATUS_CONFIRMED LIMIT 1];
        
        if(salesOrderObj.SO_Status__c == SO_STATUS_CANCELLED || pickLists.size() == 1){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Allocation_For_Cancelled_SO);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }

	/* lightning check validation*/    
    public static Boolean checkValidationLight(Sales_Order__c salesOrderObj){
        
        Boolean hasValidationError = false;
        List<Picklist__c> pickLists = new List<Picklist__c>();
        pickLists = [Select Id From Picklist__c 
                     Where Sales_Order__c =: salesOrderObj.Id 
                     AND Status__c =: PICKLIST_STATUS_CONFIRMED LIMIT 1];
        
        if(salesOrderObj.SO_Status__c == SO_STATUS_CANCELLED || pickLists.size() == 1){
            hasValidationError = true;
             messageLight = Label.No_Allocation_For_Cancelled_SO;

        }
        return hasValidationError;
    }
    
    public PageReference goBack() {
        return stdController.view().setRedirect(true);
    }
    
}