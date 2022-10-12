trigger updateOrderStatusBQ on Order__c (after update) {
    
    /*
     /////  Trigger Code //////
    
  if(Trigger.isBefore){
        OrderHelper.updateOrderRequestShipDate(Trigger.New,Trigger.oldMap);
        OrderHelper.updateOrderSubmitDate(Trigger.New,Trigger.oldMap);
        OrderHelper.updateOrderStatusBQStatus(Trigger.New);
    }

*/
    
    /*
   public static string OBJECT_ORDER_STATUS{
        get{
            return string.isNotBlank(OBJECT_ORDER_STATUS) ? OBJECT_ORDER_STATUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Obj_Order_Status');
        }set;
    }
    
    public static string OBJECT_BQ_STATUS{
        get{
            return string.isNotBlank(OBJECT_BQ_STATUS) ? OBJECT_BQ_STATUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Object_BQ_Status');
        }set;
    }

*/
    
 /*
   public static void updateOrderStatusBQStatus(List<Order__c> newRecord){
        
    List<string> orderRecId = new List<string>();
    for(order__c ordRec : newRecord){
        if(ordRec.Status__c == OBJECT_ORDER_STATUS){ 
            orderRecId.add(ordRec.Name);
        }
    
    
  
    for(Brand_Quote__c rec :[SELECT Id,BQ_Status__c,Customer_PO_or_Quote__c FROM Brand_Quote__c WHERE Customer_PO_or_Quote__c IN :orderRecId]){  
    if(rec.BQ_Status__c != OBJECT_BQ_STATUS){
        ordRec.AddError('Oppty generated. Please cancel Oppty to cancel the order');
      //     newRecord.get(rec.get('BQ_Status__c')).addError('Oppty generated. Please cancel Oppty to cancel the order');
     }     
   }  
}     
 }
  */
    
}