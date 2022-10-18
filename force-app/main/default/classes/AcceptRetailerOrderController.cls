
//created Date : XXXXXXX

public class AcceptRetailerOrderController {
    public boolean isOrderUpdated{set;get;}
    public String message{set;get;}
    public AcceptRetailerOrderController(){
        isOrderUpdated = false;
    }
    public void acceptOrder(){
        String orderId = ApexPages.currentPage().getParameters().get('id');
        String objPrefix = Schema.getGlobalDescribe().get('Order__c').getDescribe().getKeyPrefix();
        if(String.isBlank(orderId) || !orderId.startsWith(objPrefix)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Order Id is not correct'));
        }else{
            try{
                if([SELECT Id, Status__c FROM Order__c WHERE Id = :orderId AND Status__c  IN ('Approved','Shipped')].size() > 0){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Order is already Accepted.'));
                    return;
                }
                Order__c o = new Order__c(Id = orderId, Status__c  = 'Approved');
                update o;
                isOrderUpdated = true;
                message = 'Thanks for Approving the Order. To View Order Status and Shipment Tracking, log in to <a href="https://www.filigreen.com/b2b" target="_Blank">Filigreen</a>';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,message));
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
            }
        }
    }
}