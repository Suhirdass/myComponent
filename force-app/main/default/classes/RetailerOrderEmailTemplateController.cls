public class RetailerOrderEmailTemplateController {
    public String orderId{set;get;}
    public Order__c Order{set;get;}
    public Boolean isSampleAndThirdParty {set;get;}
    Public static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    
    public Order_Line_Item__c[] getOrderLineItems(){
        isSampleAndThirdParty = false;
        Order = new Order__c();
        if(orderId != '' && orderId != null){
            Order =[SELECT id,Sample_Order__c,Retailer__r.Third_Party_Scheduler__c,isPreapproved__c FROM Order__c WHERE id=:orderId] ;
            if(!Order.Sample_Order__c && !Order.Retailer__r.Third_Party_Scheduler__c){
                isSampleAndThirdParty = true;
            }
            system.debug('##Order : '+Order);
        }
        List<Order_Line_Item__c> discountOLIList = new List<Order_Line_Item__c>();
        List<Order_Line_Item__c> oliList = new List<Order_Line_Item__c>();
        
        for(Order_Line_Item__c oli : [SELECT Id, Name, Product__r.Name,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Description,UnitPrice__c,Quantity_Cases__c,
                                      MOQ__c,Line_Total_Qty__c,Product__r.Brand_Name__c,Product__r.RecordType.Name,Order__r.Retailer__r.Third_Party_Scheduler__c,
                                      Unit_Excise_Tax__c,Line_Total_Excise_Tax__c,Total__c ,Line_Total_Cost__c,IsPromo__c,Is_Sample__c
                                      FROM  Order_Line_Item__c
                                      WHERE Order__c = :orderId]){
                                          if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT) {
                                              discountOLIList.add(oli);
                                          }else{
                                              oliList.add(oli);
                                          } 
                                          
                                      }
        if(discountOLIList.size() > 0){
            oliList.addAll(discountOLIList);
        }
        return oliList;
    }
}