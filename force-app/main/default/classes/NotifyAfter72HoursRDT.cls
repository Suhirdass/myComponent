public without sharing class NotifyAfter72HoursRDT {
    
    @InvocableMethod 
    public static void notifyOnNewRDTAfter72Hours(List<Id> orderIds){
        NotifyOnNewRDT.notifyOnNewRetailerDiliveryTicket(orderIds, Label.SendOrderDetailsToRetailerContactAfter72Hours_Email_Template);
    }
}