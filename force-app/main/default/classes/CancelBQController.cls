/**
 * Copyright (c) 2018 WOVN
 * All rights reserved.
 * CancelBQController
 */ 
public class CancelBQController{

    private ApexPages.StandardController stdController;
    private Brand_Quote__c brandQuoteObj = null;
    private List<Sales_Order__c> soList;
    private List<Purchase_Order__c> poList;
    
    public Brand_Quote__c brandQuoteObjLight {get; set;}
    public List<Sales_Order__c> soListLight {get; set;}
    public List<Purchase_Order__c> poListLight {get; set;}
     public static boolean CANCELBQ = False; 
    public Static String SALES_ORDER_STATUS_APPROVED {		
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    public Static String PURCHASE_ORDER_STATUS_PARTIALLY_RECEIVED {		
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_PARTIALLY_RECEIVED) ? PURCHASE_ORDER_STATUS_PARTIALLY_RECEIVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase Order Status Partially Received');
        }set;
    }
    public Static String PURCHASE_ORDER_STATUS_CLOSED {		
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_CLOSED) ? PURCHASE_ORDER_STATUS_CLOSED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Closed');
        }set;
    }
    
    public Static String BRANDQUOTE_RECORD_TYPE_SELL_QUOTE {		
        get{
            return String.isNotBlank(BRANDQUOTE_RECORD_TYPE_SELL_QUOTE) ? BRANDQUOTE_RECORD_TYPE_SELL_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote Record Type Sell Quote');
        }set;
    }
    public Static String BRANDQUOTE_RECORD_TYPE_BUY_QUOTE {		
        get{
            return String.isNotBlank(BRANDQUOTE_RECORD_TYPE_BUY_QUOTE) ? BRANDQUOTE_RECORD_TYPE_BUY_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote Record Type Buy Quote');
        }set;
    }
    
    public Static String BRANDQUOTE_STRING_ERROR_ONE {		
        get{
            return String.isNotBlank(BRANDQUOTE_STRING_ERROR_ONE) ? BRANDQUOTE_STRING_ERROR_ONE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err Brandquote String Error1');
        }set;
    }
    
    public Static String BRANDQUOTE_STRING_ERROR_TWO {		
        get{
            return String.isNotBlank(BRANDQUOTE_STRING_ERROR_TWO) ? BRANDQUOTE_STRING_ERROR_TWO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err Brandquote String Error2');
        }set;
    }
    
    public Static String BRANDQUOTE_STRING_ERROR_THREE {		
        get{
            return String.isNotBlank(BRANDQUOTE_STRING_ERROR_THREE) ? BRANDQUOTE_STRING_ERROR_THREE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err Brandquote String Error3');
        }set;
    }
    
    public Static String BRANDQUOTE_STRING_ERROR_FOUR {		
        get{
            return String.isNotBlank(BRANDQUOTE_STRING_ERROR_FOUR) ? BRANDQUOTE_STRING_ERROR_FOUR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err Brandquote String Error4');
        }set;
    }
    public Static String BRANDQUOTE_STRING_ERROR_FIVE {		
        get{
            return String.isNotBlank(BRANDQUOTE_STRING_ERROR_FIVE) ? BRANDQUOTE_STRING_ERROR_FIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err Brandquote String Error5');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_CANCELLED) ? SALES_ORDER_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    Public Static String SALES_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_REJECTED) ? SALES_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Rejected');
        }set;
    }
    Public Static String PURCHASE_ORDER_STATUS_CANCELLED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_CANCELLED) ? PURCHASE_ORDER_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Cancelled');
        }set;
    }
    Public Static String PURCHASE_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_REJECTED) ? PURCHASE_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase Order Status Rejected');
        }set;
    }
    
        
    
    @testVisible
    private static final String BQ_STATUS_CANCELLED = RSMSupport.STATUS_CANCELLED; 
    @testVisible
    private static final String SO_STATUS_APPROVED = SALES_ORDER_STATUS_APPROVED; 
    @testVisible
    private static final String PO_STATUS_PARTIALLY_RECEIVED = PURCHASE_ORDER_STATUS_PARTIALLY_RECEIVED; 
    @testVisible
    private static final String PO_STATUS_CLOSED = PURCHASE_ORDER_STATUS_CLOSED; 
    
    // Constructor
    public CancelBQController(ApexPages.StandardController controller) {
        this.stdController = controller;
        brandQuoteObj = (Brand_Quote__c)stdController.getRecord();
        soList = new List<Sales_Order__c>();
        poList = new List<Purchase_Order__c>();
    }
    
    public class UserException extends Exception{ }
    
   
    public CancelBQController(){}  
    
    @AuraEnabled
    public static AuraResponse cancelBQLight(String recordId){
        AuraResponse r = new AuraResponse('CancelBQController.cancelBQLight()');
        
        CancelBQController assign = new CancelBQController();
        CANCELBQ = True;
        assign.brandQuoteObjLight = [Select BQ_Status__c, recordType.Name, (Select SO_Status__c From Sales_Orders__r), 
                                     (Select PO_Status__c From Purchase_Orders__r) From Brand_Quote__c Where Id =: recordId];
        assign.soListLight = assign.brandQuoteObjLight.Sales_Orders__r;
        assign.poListLight = assign.brandQuoteObjLight.Purchase_Orders__r;
        
        Boolean doNotCancelBQFlag;
        String BQerror;
        String retBQ;
        String soStatus;
        String poStatus;
        
        if(assign.soListLight.size() > 0 )
        {
            soStatus = assign.soListLight[0].SO_Status__c;
        }
        
        if(assign.poListLight.size() > 0) {poStatus = assign.poListLight[0].PO_Status__c;
                                          }
        if(assign.brandQuoteObjLight.BQ_Status__c == BQ_STATUS_CANCELLED){BQerror = BRANDQUOTE_STRING_ERROR_ONE; r.data.put('BQerror',BQerror);    return r;
                                                                         } else if( assign.soListLight.size() > 0  && (soStatus!= SALES_ORDER_STATUS_CANCELLED && soStatus!=SALES_ORDER_STATUS_REJECTED)){
                                                                             BQerror = BRANDQUOTE_STRING_ERROR_FOUR;
                                                                             r.data.put('BQerror',BQerror);
                                                                             return r;
                                                                         }
        else if(assign.poListLight.size() > 0 && (poStatus!= PURCHASE_ORDER_STATUS_CANCELLED && poStatus!= PURCHASE_ORDER_STATUS_REJECTED)){   BQerror = BRANDQUOTE_STRING_ERROR_FIVE;
                                                                                                  r.data.put('BQerror',BQerror); return r;
                                                                                                 }
        
        else {
            
            if(assign.brandQuoteObjLight.recordType.Name == BRANDQUOTE_RECORD_TYPE_SELL_QUOTE){  doNotCancelBQFlag = false;
                                                                                               if(assign.soListLight != null){
                                                                                                   for(Sales_Order__c soObj : assign.soListLight){
                                                                                                       if(soObj.SO_Status__c == SO_STATUS_APPROVED){doNotCancelBQFlag = true;
                                                                                                                                                    
                                                                                                                                                   }
                                                                                                   }
                                                                                               }
                                                                                               if(doNotCancelBQFlag){   BQerror = BRANDQUOTE_STRING_ERROR_TWO;
                                                                                                                     r.data.put('BQerror',BQerror); return r;
                                                                                                                    }
                                                                                              } else if(assign.brandQuoteObjLight.recordType.Name ==  BRANDQUOTE_RECORD_TYPE_BUY_QUOTE){ doNotCancelBQFlag = false;
                                                                                                                                                                                        if(assign.soListLight != null){  for(Purchase_Order__c poObj : assign.poListLight){
                                                                                                                                                                                            if(poObj.PO_Status__c == SO_STATUS_APPROVED || poObj.PO_Status__c == PO_STATUS_CLOSED || poObj.PO_Status__c == PO_STATUS_PARTIALLY_RECEIVED){
                                                                                                                                                                                                doNotCancelBQFlag = true;
                                                                                                                                                                                            }
                                                                                                                                                                                        }
                                                                                                                                                                                                                      }
                                                                                                                                                                                        if(doNotCancelBQFlag){BQerror = BRANDQUOTE_STRING_ERROR_THREE;  r.data.put('BQerror',BQerror);return r;
                                                                                                                                                                                                             }
                                                                                                                                                                                       } 
            updateBrandQuoteAndSalesOrdersLight(recordId);
            
            
            
        }
        
        
        
        return r;
    }
    
    
     public static string updateBrandQuoteAndSalesOrdersLight(Id bqId) {
        Brand_Quote__c brandQuoteBQ = new Brand_Quote__c(); brandQuoteBQ.Id = bqId;
        brandQuoteBQ.BQ_Status__c = BQ_STATUS_CANCELLED;update brandQuoteBQ;
         
		Brand_Quote__c bqListBQ = [Select BQ_Status__c, recordType.Name,Customer_PO_or_Quote__c, (Select SO_Status__c From Sales_Orders__r),  (Select PO_Status__c From Purchase_Orders__r) From Brand_Quote__c Where Id =: bqId];
  
         
        List <Sales_Order__c> soListSO = bqListBQ.Sales_Orders__r;
        if(soListSO != null){ Set<Id> soIds = new Set<Id>();
            List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
            
            // Update SO status as cancelled
            for(Sales_Order__c soObj : soListSO){
                soObj.SO_Status__c = BQ_STATUS_CANCELLED;soIds.add(soObj.Id);
            }
            
            // Update SO Line status as cancelled
            soLines = [Select Status__c from Sales_Order_Line__c Where Sales_Order__c IN: soIds];
            for(Sales_Order_Line__c soLineObj : soLines){ soLineObj.Status__c = BQ_STATUS_CANCELLED;
            }
            update soListSO;update soLines;
        } 
         if(soListSO.isEmpty() ){ List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
            bqLines = [Select Id,Status__c from Brand_Quote_Line__c Where Brand_Quote_Number__c =:bqId];
            if(bqLines.size() > 0 ){ for(Brand_Quote_Line__c res : bqLines){ res.Status__c = BQ_STATUS_CANCELLED;
                }
                update bqLines;
            }
        }
         
        List <Purchase_Order__c> poListPO = bqListBQ.Purchase_Orders__r;
         
         
        if(poListPO != null){
            Set<Id> poIds = new Set<Id>();  List<Purchase_Order_Line__c> poLines = new List<Purchase_Order_Line__c>();
            
            // Update PO status as cancelled
            for(Purchase_Order__c poObj : poListPO){ poObj.PO_Status__c = BQ_STATUS_CANCELLED;
                poIds.add(poObj.Id);
            }
            
            // Update PO Line status as cancelled
            poLines = [Select POLI_Status__c from Purchase_Order_Line__c Where Purchase_Order__c IN: poIds];
            for(Purchase_Order_Line__c poLineObj : poLines){poLineObj.POLI_Status__c = BQ_STATUS_CANCELLED;}
            update poListPO; update poLines;
        }
         if(bqListBQ != null){   order__c getOrderData = new order__c();
             order__c orderRes=[select Id, Name,Status__c from order__c where Name=: bqListBQ.Customer_PO_or_Quote__c];
             getOrderData.Id = orderRes.Id;getOrderData.Status__c ='Cancelled By Wovn';
             update getOrderData;
         }
         
        
     String retPage = brandQuoteBQ.Id; return retPage;
    }

    /**
     * Retrieve Brand Quote with related SOs
     *
     * @return The Brand Quote with related SOs
     */         
    public Brand_Quote__c retrieveBrandQuoteAndSalesOrders() {
        return  [Select BQ_Status__c, recordType.Name,(Select SO_Status__c From Sales_Orders__r),(Select PO_Status__c From Purchase_Orders__r)  From Brand_Quote__c  Where Id =: brandQuoteObj.Id];
    }
    
    /**
     * Change Status of BQ and SO as cancelled
     */         
    public void updateBrandQuoteAndSalesOrders() {
        
        // Update BQ status as cancelled 
        brandQuoteObj.BQ_Status__c = BQ_STATUS_CANCELLED;
        update brandQuoteObj;
        
        // Update related SO and lines
        if(soList != null){
            Set<Id> soIds = new Set<Id>();
            List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
            
            // Update SO status as cancelled
            for(Sales_Order__c soObj : soList){soObj.SO_Status__c = BQ_STATUS_CANCELLED;  soIds.add(soObj.Id);
            }
            
            // Update SO Line status as cancelled
            soLines = [Select Status__c from Sales_Order_Line__c Where Sales_Order__c IN: soIds];
            for(Sales_Order_Line__c soLineObj : soLines){soLineObj.Status__c = BQ_STATUS_CANCELLED;}
            update soList;
            update soLines;
        }
        
        // Update related PO and lines
        if(poList != null){
            Set<Id> poIds = new Set<Id>();
            List<Purchase_Order_Line__c> poLines = new List<Purchase_Order_Line__c>();
            
            // Update PO status as cancelled
            for(Purchase_Order__c poObj : poList){poObj.PO_Status__c = BQ_STATUS_CANCELLED;   poIds.add(poObj.Id);
            }
            
            // Update PO Line status as cancelled
            poLines = [Select POLI_Status__c from Purchase_Order_Line__c Where Purchase_Order__c IN: poIds];
            for(Purchase_Order_Line__c poLineObj : poLines){ poLineObj.POLI_Status__c = BQ_STATUS_CANCELLED; }
            update poList;
            update poLines;
        }
    }
    
    /**
     * Redirect to Brand Quote detail page
     *ø
     * @return PageReference
     */         
    public PageReference redirectToBrandQuote() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
     @Auraenabled
    public static String getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            return (String) (records[0].get('Name'));} return '';
    }
}