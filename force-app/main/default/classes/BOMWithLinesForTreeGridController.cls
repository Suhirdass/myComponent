public class BOMWithLinesForTreeGridController {
	
    @AuraEnabled
    public static List<Items> bomLinesForMakeProductType(String recordId){
        Bill_of_Materials__c bomRec = new Bill_of_Materials__c();
        bomRec = [SELECT Id,Name,(SELECT ID,Name,Product_Type__c,Level__c,Product__r.Name,Product_Description__c,Product__c,
                               Qty_Per__c,UOM__c,Sequence__c,Available_Inventory__c FROM BOM_Lines__r ORDER BY Product_Type__c)
               FROM Bill_of_Materials__c WHERE Id =: recordId LIMIT 1];
        
        List<Items> bmLines = new List<Items>();
		List<Bom> lstBOM = new List<Bom>();
        
        Bom bm = new Bom();
        bm.id = '/'+bomRec.Id;
        bm.name = bomRec.Name;
        
        // Second Level
        Bill_of_Materials__c bom2 = new Bill_of_Materials__c();
        Map<Id,Id> productsBlineMap2 = new Map<Id,Id>();
        for(BOM_Lines__c bLine : bomRec.BOM_Lines__r){
            if(bLine.Product_Type__c == 'Make' && bLine.Product__c != null){
                productsBlineMap2.put(bLine.Id,bLine.Product__c);
            }
        }
        if(productsBlineMap2.size() > 0) bom2 = getBomRecord(productsBlineMap2);
        
        //Third Level
        Bill_of_Materials__c bom3 = new Bill_of_Materials__c();
        Map<Id,Id> productsBlineMap3 = new Map<Id,Id>();
        for(BOM_Lines__c bLine : bom2.BOM_Lines__r){
            if(bLine.Product_Type__c == 'Make' && bLine.Product__c != null){
                productsBlineMap3.put(bLine.Id,bLine.Product__c);
            }
        }
        if(productsBlineMap3.size() > 0) bom3 = getBomRecord(productsBlineMap3);
        
        //Forth Level
        Bill_of_Materials__c bom4 = new Bill_of_Materials__c();
        Map<Id,Id> productsBlineMap4 = new Map<Id,Id>();
        for(BOM_Lines__c bLine : bom3.BOM_Lines__r){
            if(bLine.Product_Type__c == 'Make' && bLine.Product__c != null){
                productsBlineMap4.put(bLine.Id,bLine.Product__c);
            }
        }
        if(productsBlineMap4.size() > 0) bom4 = getBomRecord(productsBlineMap4);
        
        //Fifth Level
        Bill_of_Materials__c bom5 = new Bill_of_Materials__c();
        Map<Id,Id> productsBlineMap5 = new Map<Id,Id>();
        for(BOM_Lines__c bLine : bom4.BOM_Lines__r){
            if(bLine.Product_Type__c == 'Make' && bLine.Product__c != null){
                productsBlineMap5.put(bLine.Id,bLine.Product__c);
            }
        }
        if(productsBlineMap5.size() > 0) bom5 = getBomRecord(productsBlineMap5);
        
        
        for(BOM_Lines__c bLine : bomRec.BOM_Lines__r){
            Items itmLine1 = new Items(bLine);
            List<Items> itemLst = new List<Items>();
            //Second Level
            if(productsBlineMap2.containsKey(bLine.Id) && bom2.BOM_Lines__r.size() > 0){
                Items itmBm2 = new Items(bom2);
                List<Items> itemLst2 = new List<Items>();
                
                for(BOM_Lines__c bLine2 : bom2.BOM_Lines__r){
                	Items itmLine2 = new Items(bLine2);
                    List<Items> itemn2 = new List<Items>();
                    //Third Level
                    if(productsBlineMap3.containsKey(bLine2.Id) && bom3.BOM_Lines__r.size() > 0){
                        Items itmBm3 = new Items(bom3);
                		List<Items> itemLst3 = new List<Items>();
                        
                        for(BOM_Lines__c bLine3 : bom3.BOM_Lines__r){
                            Items itmLine3 = new Items(bLine3);
                            List<Items> itemn3 = new List<Items>();
                            //Forth Level
                            if(productsBlineMap4.containsKey(bLine3.Id) && bom4.BOM_Lines__r.size() > 0){
                                Items itmBm4 = new Items(bom4);
                                List<Items> itemLst4 = new List<Items>();
                                for(BOM_Lines__c bLine4 : bom4.BOM_Lines__r){
                                    Items itmLine4 = new Items(bLine4);
                                    List<Items> itemn4 = new List<Items>();
                                    //Fifth Level
                                    if(productsBlineMap5.containsKey(bLine4.Id) && bom5.BOM_Lines__r.size() > 0){
                                        Items itmBm5 = new Items(bom4);
                                        List<Items> itemLst5 = new List<Items>();
                                        for(BOM_Lines__c bLine5 : bom5.BOM_Lines__r){
                                            Items itmLine5 = new Items(bLine4);
                                            List<Items> itemn5 = new List<Items>();
                                            itmLine5.items = itemn5;
                                            itemn4.add(itmLine5);
                                        }
                                        /*itmBm5.items = itemLst5;
                                        itemn4.add(itmBm5);*/
                                    }
                                    itmLine4.items = itemn4;
                                    itemn3.add(itmLine4);
                                    //itemLst4.add(itmLine4);
                                }
                                /*itmBm4.items = itemLst4;
                                itemn3.add(itmBm4);*/
                            }
                            itmLine3.items = itemn3;
                            itemn2.add(itmLine3);
                            //itemLst3.add(itmLine3);
                        }
                        /*itmBm3.items = itemLst3;
                		itemn2.add(itmBm3);*/
                    }
                    itmLine2.items = itemn2;
                    //itemLst2.add(itmLine2);
                    itemLst.add(itmLine2);
                }
                /*itmBm2.items = itemLst2;
                itemLst.add(itmBm2);*/
            }
            itmLine1.items = itemLst;
            bmLines.add(itmLine1);
        }
        bm.items = bmLines;
        lstBOM.add(bm);
        //r.data.put('bom', lstBOM);    
        return bmLines;
    }
    
    public static Bill_of_Materials__c getBomRecord(Map<Id,Id> productIdsMap){
        Bill_of_Materials__c bom = new Bill_of_Materials__c();
        Set<Id> blIds = new Set<Id>();
        for(Product2 pro : [SELECT Id,Name,(SELECT Id FROM Bill_of_Materials__r) FROM Product2 WHERE Id IN :productIdsMap.values()]){
            for(Bill_of_Materials__c bl : pro.Bill_of_Materials__r){
                blIds.add(bl.Id);
            }
        }
        if(blIds.size() > 0){
            bom = [SELECT Id,Name,(SELECT ID,Name,Product_Type__c,Level__c,Product__r.Name,Product_Description__c,Product__c,
                               Qty_Per__c,UOM__c,Sequence__c,Available_Inventory__c FROM BOM_Lines__r ORDER BY Product_Type__c)
               FROM Bill_of_Materials__c WHERE Id In :blIds LIMIT 1];
        }
        return bom;
    }
    
    public Class Bom{
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public List<Items> items {get;set;}
    }
    
    public Class Items{
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String productId {get;set;}
        @AuraEnabled
        public String productName {get;set;}
        @AuraEnabled
        public String productDesc {get;set;}
        @AuraEnabled
        public String productType {get;set;}
        @AuraEnabled
        public String uom {get;set;}
        @AuraEnabled
        public Decimal levelF {get;set;}
        @AuraEnabled
        public Decimal sequence {get;set;}
        @AuraEnabled
        public Decimal availableInventory {get;set;}
        @AuraEnabled
        public Decimal qtyPer {get;set;}
        @AuraEnabled
        public List<Items> items {get;set;}
        
        public Items(Bill_of_Materials__c bom){
            this.name = bom.Name ;
            this.id = '/'+bom.Id;
        }
        
        public Items(BOM_Lines__c bLine){
            this.name = bLine.Name ;
            this.id = '/'+bLine.Id;
            this.productType = bLine.Product_Type__c;
            this.levelF = bLine.Level__c;
            this.productId = '/'+bLine.Product__c;
            this.productName = bLine.Product__r.Name;
            this.productDesc = bLine.Product_Description__c;
            this.qtyPer = bLine.Qty_Per__c;
            this.uom = bLine.UOM__c;
            this.sequence = bLine.Sequence__c;
            this.availableInventory = bLine.Available_Inventory__c;
        }
    }
}