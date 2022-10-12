Public Class PicklistLineWrapper
{
    @AuraEnabled Public Picklist_Line__c picklistLineObj {get; set;}
    @AuraEnabled Public Decimal qtytoPick {get; set;}
    @AuraEnabled Public String uid {get; set;}
    @AuraEnabled Public String harvestBatchOrLotCode {get; set;}

   
    public PicklistLineWrapper(Picklist_Line__c picklistLineObj , Decimal qtytoPick)
    {
        this.picklistLineObj = picklistLineObj ;
        this.qtytoPick = qtytoPick;
        this.uid = splitLongWord(picklistLineObj.UID__c, 9);
        this.harvestBatchOrLotCode = splitLongWord(picklistLineObj.Harvest_Batch_or_Lot_Code__c, 9);

    }
    
    public String splitLongWord(String input, Integer lineLength){
        LineSplitter splitter = new LineSplitter();
        splitter.myInput = input;
        splitter.myLineLength = lineLength;
        return splitter.output;
    }
}