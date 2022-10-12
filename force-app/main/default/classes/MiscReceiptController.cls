/**************************************************************************************
Apex Class Name    : MiscReceiptController 
Test Class Name    :MiscReceiptControllerTest
VF Page Ref         :MiscReceipt VF
Version            : 1.0
Created Date       : July 12 2018
Function           : Used for MiscReceipt VF page.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  07/12/2018              Original Version
*******************************************************************************/

public class MiscReceiptController{
    
    Public Product2 prod {get; set;}
    Public List<Inventory_Position__c> invPositionList {get; set;}
    Public String recordID {get; set;}
    Public Double totalInventory {get; set;}
    Public Inventory_Position__c invPositionRec { get; set;}
    Public Inventory_Perpetual_Adjustment__c invPerAdj { get; set;}
    
    public MiscReceiptController(ApexPages.StandardController controller) {
        invPositionRec  = new Inventory_Position__c();
        invPerAdj = new Inventory_Perpetual_Adjustment__c();
        List<Product2> prodList = new List<Product2>();
        totalInventory=0.0;
        recordID =ApexPages.currentPage().getParameters().get('Id');
        if(recordID!=null){
            prodList =[Select ID,name,Producer_Name__c,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,Strain__c,Strain_Type__c,MOQ__c,
                       (Select id,Name,Site__c,Product_Name__c,Inventory_Location__c,Inventory_Location__r.Name,Rack__c,
                        Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Rack_Level__c,
                        Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Qty_Allocated__c,
                        Harvest_Batch_or_Lot_Code__c,Lab_Test_Status__c,UID__c,UID_New__c,UID_New__r.Name,
                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name  
                        from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true) from Product2 where ID=:recordID ];
            if(prodList.size()>0){
                prod=prodList[0];
                invPositionList =prod.Inventory_Positions__r;
                for(Inventory_Position__c invPosRec :invPositionList){
                    if(invPosRec.Qty_On_Hand__c !=null){
                        totalInventory=totalInventory + invPosRec.Qty_On_Hand__c;
                    }
                    if(invPosRec.Qty_Allocated__c!=null){
                        totalInventory=totalInventory + invPosRec.Qty_Allocated__c;
                    }
                }
            }
        }
    }
    
    public MiscReceiptController(){}
    
    @AuraEnabled
    public static AuraResponse miscReceiptLightningLoad(String recId){
        AuraResponse r = new AuraResponse('MiscReceiptController.miscReceiptLightningLoad()');
        
        MiscReceiptController misc = new MiscReceiptController();
        misc.invPositionRec  = new Inventory_Position__c();
        misc.invPerAdj = new Inventory_Perpetual_Adjustment__c();
        List<Product2> prodList = new List<Product2>();
        misc.totalInventory=0.0;
        if(recId != null){
            prodList =[Select Id,Name,Producer_Name__c,Producer_Name__r.Name,Description ,Brand_Name__c,TotalCannabisWeight__c,Total_Inventory__c,ItemToPutAway__c,
                       Allocated_Inventory__c,Inventory_On_Hold_Qty__c,Available_Inventory__c,Total_Order_Qty__c,Available_Qty__c,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,
                       Quantity_Type__c ,Supplier_UOM__c,Strain__c,Strain__r.Name,Strain_Type__c,MOQ__c,
                       (Select id,Name,Site__c,Product_Name__c,Inventory_Location__c,Inventory_Location__r.Name,Rack__c,
                        Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Rack_Level__c,
                        Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Qty_Allocated__c,
                        Harvest_Batch_or_Lot_Code__c,Lab_Test_Status__c,UID__c,UID_New__c,UID_New__r.Name,
                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name  
                        from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true) from Product2 where ID=:recId ];
            if(prodList.size()>0){
                misc.prod = prodList[0];
                misc.invPositionList = misc.prod.Inventory_Positions__r;
                for(Inventory_Position__c invPosRec : misc.invPositionList){
                    if(invPosRec.Qty_On_Hand__c !=null){
                        misc.totalInventory = misc.totalInventory + invPosRec.Qty_On_Hand__c;
                    }
                    if(invPosRec.Qty_Allocated__c!=null){
                        misc.totalInventory = misc.totalInventory + invPosRec.Qty_Allocated__c;
                    }
                }
            }
        }
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('Inventory_Perpetual_Adjustment__c');
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get('Type__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        List<CustomSelectOptions> typeOptions = new List<CustomSelectOptions>();
        typeOptions.add(new CustomSelectOptions('', Label.NONE_VALUE));
        
        for( Schema.PicklistEntry pickListVal : ple){
        	typeOptions.add(new CustomSelectOptions(pickListVal.getLabel(),pickListVal.getLabel()));    
        }
        
        r.data.put('prod', misc.prod);
        r.data.put('totalInventory', misc.totalInventory);
        r.data.put('invPositionRec', misc.invPositionRec);
        r.data.put('invPerAdj', misc.invPerAdj);
        r.data.put('typeOptions', typeOptions);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse saveRecordLightning(String recordID,Inventory_Position__c invPositionRec,Inventory_Perpetual_Adjustment__c invPerAdj){
    	AuraResponse r = new AuraResponse('MiscReceiptController.saveRecordLightning()');   
        List <Site__c> siteList =[select ID,(select ID,Default_for_Site__c from Inventory_Locations__r where Default_for_Site__c= TRUE) from Site__c where ID=:invPositionRec.Site__c];
        invPositionRec.Product_Name__c = recordID ;
        if(siteList != null && siteList.size() == 1 && siteList[0].Inventory_Locations__r.size() == 1){
            invPositionRec.Inventory_Location__c =siteList[0].Inventory_Locations__r[0].Id;
            system.debug('Condition 1...');
        }
        if(invPositionRec != null){
            invPositionRec.Lab_Test_Status__c = 'Not Tested';
        	insert invPositionRec;
            system.debug('Condition 2...');
        	createInventoryPerpetualAdjustment(invPositionRec,invPerAdj); 
            
        }
        system.debug('invPerAdj values in Save...'+invPerAdj);
        return r;
    }
    
    public PageReference cancelRedirect() {
        PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+recordID );
        //pageRef.getParameters().put('searchPageRender2', 'true');
        pageRef.getParameters().put('searchPageRender2', 'false');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference SaveRecord(){
        List <Site__c> siteList =[select ID,(select ID,Default_for_Site__c from Inventory_Locations__r where Default_for_Site__c= TRUE) from Site__c where ID=:invPositionRec.Site__c];
        invPositionRec.Product_Name__c=recordID ;
        if(siteList != null && siteList.size() == 1 && siteList[0].Inventory_Locations__r.size() == 1){
            invPositionRec.Inventory_Location__c =siteList[0].Inventory_Locations__r[0].Id;
        }
        insert invPositionRec;
        createInventoryPerpetualAdjustment(invPositionRec,invPerAdj);
        PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+recordID );
        pageRef.getParameters().put('searchPageRender2', 'true');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public static void createInventoryPerpetualAdjustment(Inventory_Position__c invPositionRec,Inventory_Perpetual_Adjustment__c invPerAdj){
        Inventory_Perpetual_Adjustment__c rec= new Inventory_Perpetual_Adjustment__c();
        system.debug('Insert Reason...'+invPerAdj.Reason_for_Adjustments__c);
        rec.Inventory_Position__c=invPositionRec.Id;
        rec.Product__c=invPositionRec.Product_Name__c;
        rec.Type__c=invPerAdj.Type__c;
        rec.Quantity__c=invPositionRec.Qty_On_Hand__c;
        rec.New_balance_Qty__c=invPositionRec.Qty_On_Hand__c;
        rec.Reason_for_Adjustments__c=invPerAdj.Reason_for_Adjustments__c;
        rec.Ownership__c=invPositionRec.Ownership__c;
        rec.Site__c=invPositionRec.Site__c;
        rec.Inventory_Location__c=invPositionRec.Inventory_Location__c; //need to add some logic here
        //rec.Adjustment_Date__c=system.today();
        rec.Adjustment_Date__c=System.now();
        rec.Rack__c=invPositionRec.Rack__c;
        rec.Rack_Level__c=invPositionRec.Rack_Level__c;
        rec.Bin_Location__c=invPositionRec.Bin_Location__c;
        rec.Harvest_Batch_Code__c = invPositionRec.Harvest_Batch_Code__c;
        rec.UID_New__c = invPositionRec.UID_New__c;
        system.debug('Insert Reason...'+invPerAdj);
        
        insert rec;
    }
    
    public class CustomSelectOptions{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
        
        public CustomSelectOptions() {
            this.label = '';
            this.value = '';
        }
        
        public CustomSelectOptions(String lab, String val) {
            this.label = lab;
            this.value = val;
        }
    }
}