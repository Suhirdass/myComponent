public with sharing class RSMController {
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE) ? SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_Status_Shipment_Complete');
        }set;
    }
    
    @AuraEnabled(cacheable=true)
    public static ShippingManifestDetailsWrapper getShippingDetails(Id recordId) {
        
        ShippingManifestDetailsWrapper shipDetalWrap = new ShippingManifestDetailsWrapper();
        List<Shipping_Manifest__c> shipManLines = [Select Sales_Order__c,Sales_Order__r.Name, Site__r.Name, Name, Payment_Terms__c, Window_Start_End__c, Priority__c, Receiver_Contact__r.Name,Receiver_Name__r.Name, Supplier_Name__c,Receiver_Name__c,Distributor_Name__r.Name,Distributor_Name__c,
                                                   Metrc_Manifest__c, Status__c,Customer_PO_or_Quote__c,Site__r.Id,Planned_Ship_Transfer_Date__c,Sales_Order__r.Id,RecordType.Name,Supplier_Name__r.Name,Supplier_Name__r.Id,Picklist__r.Name,Picklist__r.Id,Order_Number__r.Id,Supplier_Name__r.DBA__c,Receiver_Name__r.DBA__c,
                                                   Distributor_Name__r.DBA__c,Purchase_Order__r.Name,Purchase_Order__c,Brand_Quote__c,Brand_Quote__r.Name FROM Shipping_Manifest__c WHERE Id =: recordId];
        
        system.debug('getShippingDetails==>1'+ shipManLines);
        for(Shipping_Manifest__c eachItems: shipManLines) {
            shipDetalWrap = new ShippingManifestDetailsWrapper();
            shipDetalWrap.ShippingManifestName = eachItems.Name;
            shipDetalWrap.RecordType = eachItems.RecordType.Name;
            shipDetalWrap.Picklist = eachItems.Picklist__r.Name;
            shipDetalWrap.SalesOrder = eachItems.Sales_Order__r.Name;
            shipDetalWrap.Status = eachItems.Status__c;
            shipDetalWrap.OrderorService = eachItems.Customer_PO_or_Quote__c;
            shipDetalWrap.METRCManifest =  eachItems.Metrc_Manifest__c;
            shipDetalWrap.Site = eachItems.Site__r.Name;
            shipDetalWrap.DistributorName = eachItems.Distributor_Name__r.DBA__c;
            shipDetalWrap.SupplierName = eachItems.Supplier_Name__r.DBA__c;
            shipDetalWrap.ReceiverName = eachItems.Receiver_Name__r.DBA__c;
            shipDetalWrap.ReceiverContact = eachItems.Receiver_Contact__r.Name;
        }
        system.debug('getShippingDetails===>'+ shipDetalWrap);
        return shipDetalWrap;
    }
    public static List<Shipping_Manifest__c> updatestatusOnclickCancel(Id recordId) {
        List<Shipping_Manifest__c> shipManLines = [Select Sales_Order__c,Sales_Order__r.Name, Site__r.Name, Name, Payment_Terms__c, Window_Start_End__c, Priority__c, Receiver_Contact__r.Name,Receiver_Name__r.Name, Supplier_Name__c,Receiver_Name__c,Distributor_Name__r.Name,Distributor_Name__c,
                                                   Metrc_Manifest__c, Status__c,Customer_PO_or_Quote__c,Site__r.Id,Planned_Ship_Transfer_Date__c,Sales_Order__r.Id,RecordType.Name,Supplier_Name__r.Name,Supplier_Name__r.Id,Picklist__r.Name,Picklist__r.Id,Order_Number__r.Id,Supplier_Name__r.DBA__c,Receiver_Name__r.DBA__c,
                                                   Distributor_Name__r.DBA__c,Purchase_Order__r.Name,Purchase_Order__c,Brand_Quote__c,Brand_Quote__r.Name FROM Shipping_Manifest__c WHERE Id =: recordId];
        List<Shipping_Manifest__c> updateShipMan = new List<Shipping_Manifest__c>(); 
        for(Shipping_Manifest__c sm : shipManLines) {
            
            Shipping_Manifest__c upsm = new Shipping_Manifest__c();
            upsm.Status__c = 'Cancelled';
            updateShipMan.add(upsm);
            if(!updateShipMan.isEmpty())
            {
                update updateShipMan;
            }
        }
            return null;
        
    }
    
    //RSM Line Instance Wrapper Class
    @AuraEnabled(cacheable=true)
    public static List<RsmLinesWrapper>  getRsmLines(Id recordId){ 
        List<RsmLinesWrapper> rsmLnWrapper = new List<RsmLinesWrapper>();
        List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [SELECT Id, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Product_Description__c,Producer_Name__c,Product_Name__c,
                                                                     Retail_Wholesale_Price__c,Shipment_Qty__c,Rejection_Reason__c,Shipping_Manifest__r.Customer_PO_or_Quote__c,Shipping_Manifest__r.Status__c, Shipping_Manifest__r.Picklist__c,Shipping_Manifest__r.Site__c,
                                                                     Qty_Received__c,Picklist_Line__r.Name,Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Sales_Order_Line__c,
                                                                     Picklist_Line__r.Id,Picklist_Line__r.Inventory_Position__r.Site__c,Picklist_Line__r.Inventory_Position__r.Id,Sales_Order_Line__r.Name,Sales_Order_Line__r.Id,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                     Sales_Order_Line__r.Sales_Order__c,Sales_Order_Line__r.RecordTypeId,Picklist_Line__c,Sales_Order_Line__c,Line_Total_Price__c,SMLine_Status__c,RecordTypeId,Qty_Ordered__c,Line_Total_Cost__c,Purchase_Order_Line__c,Purchase_Order_Line__r.Name
                                                                     FROM Shipping_Manifest_Line__c WHERE (SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_REJECTED AND SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE ) AND Shipping_Manifest__c =:recordID]; 
                                                                     //WHERE (SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_REJECTED AND SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE ) AND Shipping_Manifest__c =:recordID];
        system.debug('ShippingManifestLineValue' + ShippingManifestLineValue);
        system.debug('ShippingManifestLineValue size' + ShippingManifestLineValue.size());
        for(Shipping_Manifest_Line__c rsmres : ShippingManifestLineValue){
            RsmLinesWrapper newrsmLnWrapper = new RsmLinesWrapper();
            newrsmLnWrapper.Id = rsmres.Id;
            newrsmLnWrapper.SMLine = rsmres.Name;
            newrsmLnWrapper.ProductName = rsmres.Product_Name__r.Name;
            newrsmLnWrapper.ProducerName = rsmres.Producer_Name__c;
            newrsmLnWrapper.ProductDescription = rsmres.Product_Description__c;
            newrsmLnWrapper.ShipmentQty = rsmres.Qty_Ordered__c;
            newrsmLnWrapper.RetailWholesalePrice = rsmres.Retail_Wholesale_Price__c;
            newrsmLnWrapper.QtyReceived = rsmres.Shipment_Qty__c;
            newrsmLnWrapper.LineTotalPrice = rsmres.Line_Total_Price__c;
            newrsmLnWrapper.PicklistLine = rsmres.Picklist_Line__r.Name;
            newrsmLnWrapper.SOLine = rsmres.Sales_Order_Line__r.Name;
            newrsmLnWrapper.RejectionReason = rsmres.Rejection_Reason__c;
            
            rsmLnWrapper.add(newrsmLnWrapper);
        }
        return rsmLnWrapper;
    }

    public class ShippingManifestDetailsWrapper {
        @AuraEnabled
        public String ShippingManifestName {get;set;}
        @AuraEnabled
        public String RecordType {get;set;}
        @AuraEnabled
        public String Picklist {get;set;}
        @AuraEnabled
        public String SalesOrder {get;set;} 
        @AuraEnabled
        public String Status {get;set;}
        @AuraEnabled
        public String OrderorService {get;set;}
        @AuraEnabled
        public String METRCManifest {get;set;}
        @AuraEnabled
        public String Site {get;set;}
        @AuraEnabled
        public String DistributorName {get;set;}
        @AuraEnabled
        public String SupplierName{get;set;}
        @AuraEnabled
        public String ReceiverName {get;set;}
        @AuraEnabled
        public String ReceiverContact {get;set;}
    }
    
    public class RsmLinesWrapper {
        @AuraEnabled
        public String Id {get;set;}
        @AuraEnabled
        public String SMLine {get;set;}
        @AuraEnabled
        public String ProductName {get;set;}
        @AuraEnabled
        public String ProducerName {get;set;}
        @AuraEnabled
        public String ProductDescription {get;set;} 
        @AuraEnabled
        public Decimal ShipmentQty {get;set;}
        @AuraEnabled
        public Decimal RetailWholesalePrice {get;set;}
        @AuraEnabled
        public Decimal QtyReceived {get;set;}
        @AuraEnabled
        public Decimal LineTotalPrice {get;set;}
        @AuraEnabled
        public String PicklistLine {get;set;}
        @AuraEnabled
        public String SOLine{get;set;}
        @AuraEnabled
        public String RejectionReason {get;set;}
    }
}