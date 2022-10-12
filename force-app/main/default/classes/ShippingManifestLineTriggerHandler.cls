//CancelRSMLineControllerTest
public class ShippingManifestLineTriggerHandler {
    
    public static Boolean isSMCancelled = false;
    public static Boolean isSmlineRejToSmComple = false;
     public static Boolean isSmlinePartialFromSmComple = false;
    public static Boolean isSmlineRejectFromSmComple = false;
      public static Boolean clonedLinestatus = false;
    public Static String SHIPPING_MANIFEST_RECORDTYPE_DELIVERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_DELIVERED) ? SHIPPING_MANIFEST_RECORDTYPE_DELIVERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Delivered');
        }set;
    }
    public static void cancel(){
        isSMCancelled = true;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    
    Public Static String SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE) ? SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Shipment_Complet');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
    
    public static void updateSmlineStatus(List<Shipping_Manifest_Line__c> lines, Map<Id, Shipping_Manifest_Line__c> oldMap){
        Set<Id> soLineIds = new Set<Id>();
        List<Shipping_Manifest_Line__c> shippingMLineList = new List<Shipping_Manifest_Line__c>();
        List<Shipping_Manifest__c> manifestsToUpdate = new List<Shipping_Manifest__c>();
        Map<Id, Sales_Order_Line__c> SOLToUpdate = new Map<Id, Sales_Order_Line__c>();
         List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
         Set<Id> smIds = new Set<Id>();
       
        Decimal qty;
        Decimal acqty;
        Decimal oldqty;
        Decimal invQty;
 
        for(Shipping_Manifest_Line__c sml : lines){ 
            Shipping_Manifest_Line__c smLine = new Shipping_Manifest_Line__c();
            if(sml.SMLine_Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && oldMap.get(sml.Id).SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED ){
                isSmlineRejToSmComple = True;
                smIds.add(sml.Id);  
                soLineIds.add(sml.Sales_Order_Line__c);  
                Sales_Order_Line__c soLine = SOLToUpdate.get(sml.Sales_Order_Line__c);
                qty = sml.Qty_Received__c != null ? sml.Qty_Received__c : 0.0;
                soLine = new Sales_Order_Line__c(Id = sml.Sales_Order_Line__c, Qty_Ordered__c = qty,Status__c= SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE); 
                SOLToUpdate.put(sml.Sales_Order_Line__c, soLine);
            }
            if(sml.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED && oldMap.get(sml.Id).SMLine_Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE ){
                isSmlineRejectFromSmComple = True;
                smIds.add(sml.Id);  
                soLineIds.add(sml.Sales_Order_Line__c);  
                Sales_Order_Line__c soLine = SOLToUpdate.get(sml.Sales_Order_Line__c);
                qty = sml.Qty_Received__c != null ? sml.Qty_Received__c : 0.0;
                acqty = sml.Actual_Shipment_Qty__c;
                soLine = new Sales_Order_Line__c(Id = sml.Sales_Order_Line__c, Qty_Ordered__c = qty,Status__c= SHIPPING_MANIFEST_LINE_STATUS_REJECTED); 
                SOLToUpdate.put(sml.Sales_Order_Line__c, soLine);
            }

            if(sml.Qty_Received__c != oldMap.get(sml.Id).Qty_Received__c  && sml.SMLine_Status__c == oldMap.get(sml.Id).SMLine_Status__c){
                smIds.add(sml.Id);  
                soLineIds.add(sml.Sales_Order_Line__c);  
                isSmlinePartialFromSmComple = True;
                Sales_Order_Line__c soLine = SOLToUpdate.get(sml.Sales_Order_Line__c);
                qty = sml.Qty_Received__c != null ? sml.Qty_Received__c : 0.0;
                if(soLine == null){
                    soLine = new Sales_Order_Line__c(Id = sml.Sales_Order_Line__c, Qty_Ordered__c = qty);
                }else{
                    soLine.Qty_Ordered__c += qty;
                }
                SOLToUpdate.put(sml.Sales_Order_Line__c, soLine);
                
            }
        }
      
        
        if(isSmlineRejToSmComple==True){
            ShippingManifestHandler.updateInvoiceLineStatus(smIds);
        }
        
        List<Shipping_Manifest_Line__c> smline = [SElECT id,Sales_Order_Line__c,Qty_Ordered__c FROM Shipping_Manifest_Line__c WHERE Sales_Order_Line__c=:soLineIds AND SMLine_Status__c=:SHIPPING_MANIFEST_STATUS_COMPLETE];
        Map<Id,Sales_Order_Line__c> soLineMap = new Map<Id,Sales_Order_Line__c>();
        if(smline.size() >= 1 && ShippingManifestHandler.internsmStatusRejectedToComplete==False && isSmlinePartialFromSmComple==False)
        {
             Sales_Order_Line__c soLines = [SElECT Id,Status__c,Qty_Ordered__c,Qty_Allocated__c  FROM Sales_Order_Line__c WHERE Id IN:soLineIds];
            if(soLines.Qty_Allocated__c!=0)
            {
                if(isSmlineRejToSmComple==True){
                    soLines.Qty_Ordered__c = qty + soLines.Qty_Ordered__c;
                    soLines.Status__c=SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE;
                }else if(isSmlineRejectFromSmComple== true){
                    soLines.Qty_Ordered__c =soLines.Qty_Ordered__c - acqty;
                    invQty=soLines.Qty_Ordered__c - acqty;
                }
                   update soLines;   
             }
            
        }else{
            
            if(!SOLToUpdate.isEmpty()){
                if(ShippingManifestHandler.internsmStatusRejectedToComplete == false)
                {
                   update SOLToUpdate.values();
                }
            }
            
        }
        

               List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [ SELECT ID, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Purchase_Order_Line__c,
                                                                     Product_Description__c,Producer_Name__c,Retail_Wholesale_Price__c,Actual_Shipment_Qty__c,
                                                                     Shipment_Qty__c,Rejection_Reason__c, Qty_Received__c,
                                                                     Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c,
                                                                     SMLine_Status__c,Product_Name__c,Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                     Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,Picklist_Line__r.Pack_out_UID__c,Qty_Ordered__c,
                                                                     Unit_Cost__c FROM Shipping_Manifest_Line__c 
                                                                      WHERE Id IN:smIds ];
        if(isSmlineRejectFromSmComple== True || isSmlineRejToSmComple== True || isSmlinePartialFromSmComple==True){
            RSMSupport.updateInvPositionsAndSOLines(ShippingManifestLineValue,true,true);
        }
        invPositions = ShipConfirmController.setInvPositionToDelivered(ShippingManifestLineValue, SHIPPING_MANIFEST_RECORDTYPE_DELIVERED);
        upsert invPositions;

    }
    
    public static void onAfterUpdate(List<Shipping_Manifest_Line__c> lines, Map<Id, Shipping_Manifest_Line__c> oldMap){
        Map<Id, Sales_Order_Line__c> SOLToUpdate = new Map<Id, Sales_Order_Line__c>();
        List<Shipping_Manifest__c> manifestsToUpdate = new List<Shipping_Manifest__c>();
        Map<Id,Boolean> manifestStatus = new Map<Id,Boolean>();
        Set<Id> smIds = new Set<Id>();
        Set<Id> SMLNotShippedIds = new Set<Id>();
        Decimal qty;
        for(Shipping_Manifest_Line__c sml : lines){ 
          
            if(isSmlineRejectFromSmComple == False){
                
            if((sml.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_CANCELLED && oldMap.get(sml.Id).SMLine_Status__c != sml.SMLine_Status__c) && isSmlineRejToSmComple== False){
                smIds.add(sml.Shipping_Manifest__c);    
            }
            if(sml.Sales_Order_Line__c != null && (oldMap.get(sml.Id).SMLine_Status__c != sml.SMLine_Status__c || oldMap.get(sml.Id).Qty_Received__c != sml.Qty_Received__c)){
                if(sml.SMLine_Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && isSmlineRejToSmComple== False){
                    Sales_Order_Line__c soLine = SOLToUpdate.get(sml.Sales_Order_Line__c);
                    qty = sml.Qty_Received__c != null ? sml.Qty_Received__c : 0.0;
                    if(soLine == null){
                        soLine = new Sales_Order_Line__c(Id = sml.Sales_Order_Line__c, Qty_Ordered__c = qty);
                    }else{
                        soLine.Qty_Ordered__c += qty;
                    }
                    SOLToUpdate.put(sml.Sales_Order_Line__c, soLine);
                }
                
            }
        }
       
        }
        
        
         if(!SOLToUpdate.isEmpty()){
            update SOLToUpdate.values();
        }
        if(!smIds.isEmpty()){
            for(Shipping_Manifest__c sm : [Select Id, (SELECT Id FROM Shipping_Manifest_Lines__r Where SMLine_Status__c !=:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) from Shipping_Manifest__c Where Id IN : smIds]){
                if(sm.Shipping_Manifest_Lines__r.isEmpty() ){
                    manifestsToUpdate.add(new Shipping_Manifest__c(Id = sm.Id, Status__c = SHIPPING_MANIFEST_LINE_STATUS_CANCELLED));
                }
            }
            if(!manifestsToUpdate.isEmpty()){
                update manifestsToUpdate;
                SMCancelAllRelatedItems.getRelatedItems(manifestsToUpdate);
            }
            
        }
       
    }
    
}