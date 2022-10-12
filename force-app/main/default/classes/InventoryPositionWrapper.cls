global Class InventoryPositionWrapper
{
    @AuraEnabled public boolean isSelected {get;set;}
    @AuraEnabled public Inventory_Position__c invPos {get;set;}
    @AuraEnabled Public Decimal qtyToAdjust{get; set;}
   
    public InventoryPositionWrapper(boolean isSelected, Inventory_Position__c invPosObj)
    {
        this.isSelected = isSelected;
        this.invPos = invPosObj;
        this.qtyToAdjust= 0;
    }
}