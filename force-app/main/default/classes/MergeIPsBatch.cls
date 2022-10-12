global class MergeIPsBatch implements Database.Batchable<Inventory_Location__c>,Schedulable {
     
    global Iterable<Inventory_Location__c> start(Database.BatchableContext bc) {
        // collect the batches of Inventory Locations to be passed to execute where Include_Auto_Merge_IP__c is checked.
        return [Select Id from Inventory_Location__c Where Include_Auto_Merge_IP__c = true];
    }
    
    global void execute(Database.BatchableContext bc, List<Inventory_Location__c> records){
        String inventoryLocationId = records[0].Id;
        Boolean isMerge = true;
        String mergeTo = '';
        Decimal totalQty = 0;
        Map<String,String> valueChecker = new Map<String,String>();
        List<Inventory_Position__c> ls = [SELECT Id,Qty_On_Hand__c,Qty_Allocated__c, Site__c ,Inventory_Location__c ,Rack__c, Rack_Level__c, Bin_Location__c,
                                          Ownership__c, Sales_Order_Line__c,Harvest_Batch_Code__c, UID__c,Receiving_Line__c,Hold__c,Product_Name__c,Product_Name__r.IsActive, 
                                          Lab_Test_Status__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c,Date_Received__c
                                          FROM Inventory_Position__c WHERE Inventory_Location__c = :inventoryLocationId AND Product_Name__r.IsActive =: true AND (Qty_Allocated__c =: 0 OR Qty_Allocated__c =: null OR Qty_Allocated__c =: 0.00) AND Sales_Order_Line__c =: null Order By CreatedDate Asc];
        Map<String,List<Inventory_Position__c>> data = new Map<String,List<Inventory_Position__c>>();
        System.debug('Hello = '+ls.size());
        for(Inventory_Position__c obj : ls){
            String combination = obj.Site__c+'_' + obj.Hold__c+'_';
            combination += obj.Rack__c+'_'+obj.Rack_Level__c+'_';
            combination += obj.Bin_Location__c+'_'+obj.Ownership__c+'_'+obj.Date_Received__c+'_';
            combination += obj.Harvest_Batch_Code__c+'_';
            combination += obj.UID__c+'_'+obj.Lab_Test_Status__c+'_'+obj.Receiving_Line__c;
            List<Inventory_Position__c> ips = new List<Inventory_Position__c>();
            
            if(data.containsKey(combination)) ips = data.get(combination);

            ips.add(obj);
            data.put(combination,ips);
        }  //end for
        Set<Id> toDelete = new Set<Id>();
        List<Inventory_Position__c> toUpdate = new List<Inventory_Position__c>();
        Set<String> nonDuplicate = new Set<String>();
        for(String cmb : data.keySet()){
            totalQty = 0;
            String mergeId = '';
            if(data.get(cmb).size() > 1){
                for(Inventory_Position__c ip : data.get(cmb)){
                    if(nonDuplicate.contains(cmb)){
                        toDelete.add(ip.Id);
                    }else{
                        nonDuplicate.add(cmb);
                        mergeId = ip.Id;
                    }
                    totalQty += ip.Qty_On_Hand__c != null ? ip.Qty_On_Hand__c : 0;
                    //totalQtyAllocated += ip.Qty_Allocated__c != null ? ip.Qty_Allocated__c : 0;
                }
                toUpdate.add(new Inventory_Position__c(Id = mergeId,Qty_On_Hand__c = totalQty));
            }
        }
        try{
            update toUpdate;
            DELETE [SELECT Id FROM Inventory_Position__c WHERE Id = :toDelete];
        }catch(Exception ex){
            return;
        }
    }
    global void execute(SchedulableContext sc){
        Database.executeBatch(new MergeIPsBatch(), 1);
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}