/********************************************************************
* Project           : Filigreen
*
* Apex name         : BQCloneController.apxc
*
* Test Class name   : BQCloneControllerTest.apxc
*
* Author            : Vijay Salem
*
* Date created      : 7/24/2019
*
* Purpose           : Apex Controller for BrandQuoteClone.cmp
*
* Revision History  :
*
* Date        Author      		Ref    Revision (Date in YYYYMMDD format) 
* 7/24/2019    Vijay Salem       1      Apex created for VF. 
* 7/20/2020    Praveen Ayyanar   2      Apex modified for Lightning component.
*
**********************************************************************/

public class BQCloneController {
    @testVisible
    private static final String BQ_STATUS_DRAFT = 'Draft'; 
    private static final String BQ_LINE_STATUS_REJECTED = 'Rejected';
    private static final String BQ_LINE_STATUS_CANCELLED = 'Cancelled';
    private static final String EXPIRED = 'Expired';
    public Brand_Quote__c bq{set;get;}
    public BrandQuoteLine[] brandQuoteLines{set;get;}
    public List<BrandQuoteLineWrapper> setBQLines {get; set;}
    public Boolean hasBQLines {get; set;}
    public Boolean DLisExpired {get; set;}
    public Boolean SLisExpired {get; set;}
    public Boolean RLisExpired {get; set;}
    public String redirectId;
    public BQCloneController(ApexPages.StandardController sc){
        bq = (Brand_Quote__c) sc.getRecord();
        brandQuoteLines = new BrandQuoteLine[] {};
        bq = [SELECT Id, Name ,BQ_Status__c,Ownership__c,Collection_Status__c,Last_Payment_Date__c,
              Opportunity_Name__c, Customer_PO_or_Quote__c , Sales_Origin__c  ,Distributor_Name__c ,
              Supplier_Name__c , Ownership__r.Name,Planned_Ship_Date__c ,Payment_Terms__c , 
              Receiver_Acceptance_Date__c, Receiver_Name__c,Receiver_Name__r.Name,Site__c,
              Distributor_License__r.License_Status__c ,Distributor_Contact__c,Distributor_Contact__r.AccountID,Receiver_Contact__c,Receiver_Contact__r.AccountId,
              Supplier_Contact__c,Supplier_Contact__r.AccountId,Supplier_License__r.License_Status__c,Receiver_License__r.License_Status__c ,
              (SELECT Id, Name, Brand_Name__c , Cannabis_Weight__c , Cannabis_Weight_UOM__c , 
               MOQ__c ,Opportunity_Name__c ,Product_Name__c, Product_Description__c , Product_Title__c , 
               Apply_Excise_Tax__c  , Line_Total_Qty__c ,Quantity_Cases__c ,Line_Total_Cost__c   
               FROM Brand_Quote_Lines__r) 
              FROM  Brand_Quote__c 
              WHERE Id =:bq.Id ];
        if(bq.Brand_Quote_Lines__r.size() > 0){
            for(Brand_Quote_Line__c bql : bq.Brand_Quote_Lines__r){
                brandQuoteLines.add(new BrandQuoteLine(bql));
            } 
        }
    }
    
    public BQCloneController(){}
    
    @AuraEnabled
    public static AuraResponse cloneBQ(String recordId){
    AuraResponse r = new AuraResponse('BQCloneController.cloneBQ()');
        
        BQCloneController assign = new BQCloneController();
        
        assign.bq = getBQ(recordId);
        assign.setBQLines = getBQLines(recordId);
        assign.hasBQLines = false;
        assign.DLisExpired = false;
        assign.SLisExpired = false;
        assign.RLisExpired = false;
        
        if(assign.setBQLines != null && assign.setBQLines.size() > 0) 
            {
              assign.hasBQLines = true;
            }
     
        if(assign.bq.Distributor_License__r.License_Status__c == EXPIRED){
            assign.DLisExpired = true;
        }
        if(assign.bq.Supplier_License__r.License_Status__c == EXPIRED){
            assign.SLisExpired = true;
        }
        if(assign.bq.Receiver_License__r.License_Status__c == EXPIRED){
            assign.RLisExpired = true;
        }
     
    r.data.put('bq', assign.bq);
    r.data.put('setBQLines', assign.setBQLines);
    r.data.put('hasBQLines', assign.hasBQLines);
    r.data.put('DLhasExpired', assign.DLisExpired);
    r.data.put('SLhasExpired', assign.SLisExpired);
    r.data.put('RLhasExpired', assign.RLisExpired);

    return r;
    }
    
    public static Brand_Quote__c getBQ(String bqId){
        Brand_Quote__c bq;
        if(bqId != null){
            bq = [select Id, Name ,BQ_Status__c,Ownership__c,Collection_Status__c,Last_Payment_Date__c,
              Opportunity_Name__c,Opportunity_Name__r.Name, Customer_PO_or_Quote__c , Sales_Origin__c  ,Distributor_Name__c , Distributor_Name__r.Name,
              Supplier_Name__c, Supplier_Name__r.Name , Ownership__r.Name,Planned_Ship_Date__c ,Payment_Terms__c , 
              Receiver_Acceptance_Date__c, Receiver_Name__c,Receiver_Name__r.Name,Site__c, RecordTypeId,
              Distributor_License_Number__c, Distributor_License_Type__c, Distributor_License__r.Name,Distributor_DBA__c, Distributor_License__c, Distributor_License__r.License_Status__c ,Distributor_Contact__c,Distributor_Contact__r.AccountID,Receiver_Contact__c,Receiver_Contact__r.AccountId,
              Supplier_License_Number__c, Supplier_License_Type__c, Supplier_Contact__c,Supplier_Contact__r.AccountId,Supplier_License__r.License_Status__c, Supplier_DBA__c, Supplier_License__r.Name, Supplier_License__c,
              Receiver_License_Number__c, Receiver_License_Type__c, Receiver_License__r.License_Status__c,Receiver_DBA__c, Receiver_License__c, Receiver_License__r.Name, Site__r.Warehouse_Name__c, 
              Site__r.Name from Brand_Quote__c where Id =: bqId];
        }
        return bq;
    }
    
    public static List<BrandQuoteLineWrapper> getBQLines(String bqId){
          List<BrandQuoteLineWrapper> bqWrapper = new List<BrandQuoteLineWrapper>();
        
          List <Brand_Quote_Line__c> bqLine = [SELECT Id, Name, Brand_Name__c , Cannabis_Weight__c , Cannabis_Weight_UOM__c , RecordTypeId,
               MOQ__c ,Opportunity_Name__c ,Product_Name__c, Product_Name__r.Name, Product_Description__c , Product_Title__c , Ownership_Code__r.DBA__c, 
               Apply_Excise_Tax__c  , Line_Total_Qty__c ,Quantity_Cases__c ,Line_Total_Cost__c ,  Ownership_Code__r.Name, Ownership_Code__c, 
               Is_Sample__c ,Retail_Wholesale_Price__c,Disty_Margin__c,Disty_Discount_Per_Unit__c, Price_Book__c, Status__c
               FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c =: bqId ORDER BY Name];
        
        for(Brand_Quote_Line__c brandQuoteLineBQ : bqLine){
            BrandQuoteLineWrapper bqLineWrapper = new BrandQuoteLineWrapper(brandQuoteLineBQ);
            
            if(brandQuoteLineBQ.Status__c != BQ_LINE_STATUS_REJECTED) {
                if(brandQuoteLineBQ.Status__c != BQ_LINE_STATUS_CANCELLED){
            bqWrapper.add(bqLineWrapper);
                }
            }
        }
        return bqWrapper;
    } 
    
    @AuraEnabled
    public static AuraResponse cloneBrandQuoteLight(Brand_Quote__c bq, List<BrandQuoteLineWrapper> setBQLines){
        System.debug('******** '+bq);
        AuraResponse r = new AuraResponse('BQCloneController.cloneBrandQuoteLight()');
        
        BQCloneController assign = new BQCloneController();
        
        List<Brand_Quote_Line__c> bqls = new List<Brand_Quote_Line__c>();
        
        for(BrandQuoteLineWrapper bqLineWrapper : setBQLines){
              
            if(bqLineWrapper.isSelected){ 
               bqls.add(bqLineWrapper.brandQuoteLineBQ);
            }
        }
    
        		if(bq.Distributor_Contact__c != null && bq.Distributor_Contact__r.AccountId != bq.Distributor_Name__c){
                    String message = 'Distributer Contact should match with Distributer';
                    r.data.put('Error', message);
                	return r;
                }
                if(bq.Receiver_Contact__c != null && bq.Receiver_Contact__r.AccountId != bq.Receiver_Name__c){
                    String message = 'Receiver Contact should match with Distributer';
                    r.data.put('Error', message);
                	return r;
                }
                if(bq.Supplier_Contact__c != null && bq.Supplier_Contact__r.AccountId != bq.Supplier_Name__c){
                    String message = 'Supplier Contact should match with Distributer';
                    r.data.put('Error', message);
                	return r;
                }
                if( bq.Supplier_License__r.License_Status__c != null && bq.Supplier_License__r.License_Status__c != 'Active'){
                    String message = 'Supplier License is Expired';
                    r.data.put('Error', message);
                	return r;
                }
                if(bq.Receiver_License__r.License_Status__c != null && bq.Receiver_License__r.License_Status__c != 'Active'){
                    String message = 'Receiver License is Expired';
                    r.data.put('Error', message);
                	return r;
                }
                if(bq.Distributor_License__r.License_Status__c != null && bq.Distributor_License__r.License_Status__c != 'Active'){
                    String message = 'Distributer License is Expired';
                    r.data.put('Error', message);
                	return r;
                }
   
        		Brand_Quote__c cloneBQ = bq.clone();
        		cloneBQ.RecordTypeId = bq.RecordTypeId;
                cloneBQ.BQ_Status__c = BQ_STATUS_DRAFT;
                cloneBQ.KP_Ready_for_Delivery__c = false;
                cloneBQ.Kushy_Punch_Order_Number__c = null;
                cloneBQ.Receiver_Acceptance_Date__c = null;
                cloneBQ.Planned_Ship_Date__c = null;
                cloneBQ.Collection_Status__c = null;
                cloneBQ.Last_Payment_Date__c = null;
                cloneBQ.Site__c = bq.Site__c;
                insert cloneBQ;
        
        		List<Brand_Quote_Line__c> BQLIs = new List<Brand_Quote_Line__c>();
        		for(Brand_Quote_Line__c bql:bqls){
                    Brand_Quote_Line__c bqli = bql.clone();
                    bqli.Brand_Quote_Number__c = cloneBQ.Id;
                    BQLIs.add(bqli);
                }
        		insert BQLIs;

     assign.redirectId  = cloneBQ.Id;	
     r.data.put('redirectId', assign.redirectId);
     return r;
    }
    
    public PageReference cloneBrandQuote(){
        PageReference pg;
        Savepoint sp = Database.setSavepoint();
        try{
            Brand_Quote_Line__c[] bqls = new Brand_Quote_Line__c[]{};
            if(!brandQuoteLines.isEmpty()){
                for(BrandQuoteLine bl: brandQuoteLines){
                    if(bl.isSelected){
                        bqls.add(bl.bql);
                    }
                }
                if(bq.Distributor_Contact__c != null && bq.Distributor_Contact__r.AccountId != bq.Distributor_Name__c){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Distributer Contact should match with Distributer'));
                    return pg;
                }
                if(bq.Receiver_Contact__c != null && bq.Receiver_Contact__r.AccountId != bq.Receiver_Name__c){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Receiver Contact should match with Distributer'));
                    return pg;
                }
                if(bq.Supplier_Contact__c != null && bq.Supplier_Contact__r.AccountId != bq.Supplier_Name__c){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Supplier Contact should match with Distributer'));
                    return pg;
                }

                if(bq.Supplier_License__r.License_Status__c != 'Active'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Supplier License should be Active'));
                    return pg;
                }
                if(bq.Receiver_License__r.License_Status__c != 'Active'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Receiver License should be Active'));
                    return pg;
                }
                if(bqls.isEmpty()){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please selected at least one Brand Quote Line to clone.'));
                    return pg;
                }
                if(bq.Distributor_License__r.License_Status__c != null && bq.Distributor_License__r.License_Status__c != 'Active'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Distributer License should be Active'));
                    return pg;
                }                
                Brand_Quote__c cloneBQ = bq.clone();
                cloneBQ.BQ_Status__c = BQ_STATUS_DRAFT;
                cloneBQ.Site__c = bq.Site__c;
                cloneBQ.KP_Ready_for_Delivery__c = false;
                cloneBQ.Kushy_Punch_Order_Number__c = null;
                cloneBQ.Receiver_Acceptance_Date__c = null;
                cloneBQ.Planned_Ship_Date__c = null;
                cloneBQ.Collection_Status__c = null;
                cloneBQ.Last_Payment_Date__c = null;
                insert cloneBQ;
                Brand_Quote_Line__c[] BQLIs = new Brand_Quote_Line__c[]{};
                for(Brand_Quote_Line__c bql:bqls){
                    Brand_Quote_Line__c bqli = bql.clone();
                    bqli.Brand_Quote_Number__c = cloneBQ.Id;
                    BQLIs.add(bqli);
                }
                insert BQLIs;
                return new PageReference('/'+cloneBQ.Id);
            }
            
        }catch(DmlException e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return pg;
    }
    
    public class BrandQuoteLine{
        public Boolean isSelected{set;get;}
        public Brand_Quote_Line__c bql{set;get;}
        public BrandQuoteLine(Brand_Quote_Line__c bql){
            this.bql = bql;
            isSelected = Test.isRunningTest();
        }
    }
    public class BrandQuoteLineWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public Brand_Quote_Line__c brandQuoteLineBQ {get; set;}
        
        public BrandQuoteLineWrapper(Brand_Quote_Line__c brandQuoteLineBQ){
            this.isSelected = false;
            this.brandQuoteLineBQ = brandQuoteLineBQ;
        }
        public BrandQuoteLineWrapper(){
            this.isSelected = false;
            this.brandQuoteLineBQ = brandQuoteLineBQ;
        }
    }
}