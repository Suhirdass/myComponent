public class cloneBOMController {
    
    private Static String BOM_STATUS_DRAFT{
        get{
            return String.isNotBlank(BOM_STATUS_DRAFT) ? BOM_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Bill of Materials','BOM_Status_Draft');
        }set;
    }
    
    public Bill_of_Materials__c bom{set;get;}
    public List<BOMLineWrapper> setBOMLines {get; set;}
    public Boolean hasBOMLines {get; set;}
    public String redirectId;
    
    public cloneBOMController(){}
    
    @AuraEnabled
    public static AuraResponse cloneBOM(String recordId){
    AuraResponse r = new AuraResponse('cloneBOMController.cloneBOM()');
        
        cloneBOMController assign = new cloneBOMController();
        
        assign.bom = getBOM(recordId);
        assign.setBOMLines = getBOMLines(recordId);
        
        if(assign.setBOMLines != null && assign.setBOMLines.size() > 0) 
            {
              assign.hasBOMLines = true;
            }

    r.data.put('setBom', assign.bom);
    r.data.put('setBOMLines', assign.setBOMLines);
    r.data.put('hasBOMLines', assign.hasBOMLines);

    return r;
    }
    
    public static Bill_of_Materials__c getBOM(String bomId){
        Bill_of_Materials__c bom;
        if(bomId != null){
            bom = [select Id, Name, BOM_Levels__c, BOM_Routing__r.Name, BOM_Routing__c , BOM_Type__c, Product__c, Product__r.Name, Status__c, Total_BOM_Cost__c, 
                   Revision__c, Phase__c from Bill_of_Materials__c where Id =: bomId];
        }
        return bom;
    }
    
    public static List<BOMLineWrapper> getBOMLines(String bomId){
          List<BOMLineWrapper> bomWrapper = new List<BOMLineWrapper>();
        
          List <BOM_Lines__c> bomLines = [SELECT Id, Name, Effective_From__c , Effective_To__c, Level__c, Ext_Cost__c, Producer_Name__c, Status__c,
                                        Product__c,  Sequence__c, Product__r.Name, Product_Description__c ,Product_Type__c, Qty_Per__c, 
                                        Required_Qty__c, UOM__c, Unit_Cost__c
               							FROM BOM_Lines__c WHERE Bill_of_Material__c =: bomId ORDER BY Name];
        
        for(BOM_Lines__c billofMaterialsLineBOM : bomLines){
            BOMLineWrapper bomLineWrapper = new BOMLineWrapper(billofMaterialsLineBOM);
            bomWrapper.add(bomLineWrapper);
        } 
        return bomWrapper;
    } 
    
    
        @AuraEnabled
    public static AuraResponse cloneBOMLight(Bill_of_Materials__c bom, List<BOMLineWrapper> setBOMLines){
        AuraResponse r = new AuraResponse('cloneBOMController.cloneBOMLight()');
        
        cloneBOMController assign = new cloneBOMController();
        
        List<BOM_Lines__c> bomls = new List<BOM_Lines__c>();
        
        for(BOMLineWrapper bomLineWrapper : setBOMLines){ 
            if(bomLineWrapper.isSelected){ 
               bomls.add(bomLineWrapper.billofMaterialsLineBOM);
            }
        }
    
   
        		Bill_of_Materials__c cloneBOM = bom.clone();
                cloneBOM.Status__c = BOM_STATUS_DRAFT;
                insert cloneBOM;
        
        		List<BOM_Lines__c> BOMLIs = new List<BOM_Lines__c>();
        		for(BOM_Lines__c boml:bomls){
                    BOM_Lines__c bomli = boml.clone();
                    bomli.Bill_of_Material__c = cloneBOM.Id;
                    BOMLIs.add(bomli);
                }
        		insert BOMLIs;

     assign.redirectId  = cloneBOM.Id;	
     r.data.put('redirectId', assign.redirectId); 
     return r;
    }
    
        public class BOMLineWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public BOM_Lines__c billofMaterialsLineBOM {get; set;}
        
        public BOMLineWrapper(BOM_Lines__c billofMaterialsLineBOM){
            this.isSelected = false;
            this.billofMaterialsLineBOM = billofMaterialsLineBOM;
        }
        public BOMLineWrapper(){
            this.isSelected = false;
            this.billofMaterialsLineBOM = billofMaterialsLineBOM;
        }
    }

}