public without sharing class NotifyAfter24HoursRDT {
    
    @InvocableMethod 
    public static void notifyOnNewRDTAfter24Hours(List<Id> orderIds){
        //List<Id>transferOrderIdList = new List<Id>(); 
        List<Id>brandOrderIdList = new List<Id>();
        for(Order__c ord : [select id,recordType.Name from order__c where id IN: orderIds]){
        	/*if(ord.recordType.Name == 'Transfer')
                transferOrderIdList.add(ord.id);
            else if(ord.recordType.Name == 'Brand')*/
                brandOrderIdList.add(ord.id);
        }
        /*if(transferOrderIdList.size() > 0)
            NotifyOnNewRDT.notifyOnNewRetailerDiliveryTicket(transferOrderIdList, Label.SendTransferOrderDetailsToRetailerContactAfter24Hours_Email_Template);*/
        if(brandOrderIdList.size() > 0)
        	NotifyOnNewRDT.notifyOnNewRetailerDiliveryTicket(brandOrderIdList, Label.SendOrderDetailsToRetailerContactAfter24Hours_Email_Template);
    }
}