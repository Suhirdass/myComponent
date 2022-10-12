/**************************************************************************************
Apex Class Name    : Metrc_SOQLDML_Handler
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : used for SOQL & DML operations
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
public class Metrc_SOQLDML_Handler
{
    
    private Static String PICKLIST_LINE_CANCELLED{
        get{
            return String.isNotBlank(PICKLIST_LINE_CANCELLED) ? PICKLIST_LINE_CANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','PicklistLine_Cancelled');
        }set;
    }
    
    public Static String UID_METRC_STATUS_UNFINISHED{
        get{
            return String.isNotBlank(UID_METRC_STATUS_UNFINISHED) ? UID_METRC_STATUS_UNFINISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Metrc_Status_UnFinished');
        }set;
    }
    
    public static Strain__C getStrains(String strainID){
        Strain__c  strain = [select id,Name,Strain_Type__c,Metrc_StrainID__c,Track_Trace_Sync__c ,isActive__c,CbdLevel__c,ThcLevel__c,IndicaPercentage__c,SativaPercentage__c  from Strain__c where id = :strainID];
        return strain;
    }
    public static List<Strain__C> getAllStrains(List<String> metrc_strainIDList){
        List<Strain__c>  strain = [select id,Name,Track_Trace_Sync__c ,Metrc_StrainID__c,CbdLevel__c,ThcLevel__c,IndicaPercentage__c,SativaPercentage__c from Strain__c where Metrc_StrainID__c = :metrc_strainIDList];
        return strain;
    }
    public static List<Strain__C> getAllStrains(){
        List<Strain__c>  strain = [select id,Name,Metrc_StrainID__c,CbdLevel__c,ThcLevel__c,IndicaPercentage__c,SativaPercentage__c,Track_Trace_Sync__c ,isActive__c,(select id,name,TTGS_Response__c,TTGS_StrainID__c from TTGS_Strains__r)  from Strain__c limit 500];
        return strain;
    }
    public static List<Strain__C> getAllStrainswithids(String strainID){
        List<Strain__c>  strain = [select id,Name,Metrc_StrainID__c,CbdLevel__c,ThcLevel__c,IndicaPercentage__c,SativaPercentage__c,Track_Trace_Sync__c ,isActive__c,(select id,name,TTGS_Response__c,TTGS_StrainID__c from TTGS_Strains__r)  from Strain__c  where id=:strainID];
        return strain;
    }
    // TTGS Strain 
     public static List<TTGS_Strain__c> getTTGSStrainswithids(String strainID){
        List<TTGS_Strain__c>  TTGSstrain = [select id,name,TTGS_Response__c,Strain__c,Site__c,Site__r.Name,Active__c,Strain__r.name,License_Number__c,TTGS_StrainID__c from TTGS_Strain__c  where Strain__c=:strainID];
        return TTGSstrain;
    }
    public static TTGS_Strain__c getTTGSStrains(String TTGSIds){
        TTGS_Strain__c  TTGStrain = [select id,name,TTGS_Response__c,License_Number__c,Strain__c,TTGS_StrainID__c,Strain__r.name,Active__c,THC_Level__c,CBD_Level__c,Indica_Percentage__c,Sativa_Percentage__c from TTGS_Strain__c  where id = :TTGSIds];
        return TTGStrain;
    }
    
      public static List<TTGS_Strain__c> getListTTGSStrains(){
        List<TTGS_Strain__c>  TTGStrain = [select id,name,TTGS_Response__c,Strain__c,License_Number__c,TTGS_StrainID__c,THC_Level__c,CBD_Level__c,Indica_Percentage__c,Sativa_Percentage__c from TTGS_Strain__c];
        return TTGStrain;
    }
    
    public static List<TTGS_Item__c> getTTGSItemswithids(String ProID){
        List<TTGS_Item__c>  TTGSItem = [select id,name,TTGS_Response__c,Strain__c,Category__c,Metrc_UOM__c,License_Number__c,Product_Name__r.Name,TTGS_ItemID__c,Product_Name__c from TTGS_Item__c  where Product_Name__c=:ProID];
        return TTGSItem;
    }
    public static TTGS_Item__c getTTGSItems(String TTGSIds){
        TTGS_Item__c  TTGSItem = [select id,name,TTGS_Response__c,Strain__c,Category__c,Metrc_UOM__c,License_Number__c,Product_Name__r.Name,TTGS_ItemID__c,Product_Name__c,Unit_UOM__c,Unit_Weight__c,UOM__c from TTGS_Item__c WHERE id =: TTGSIds ];
        return TTGSItem;
    }
     
   
    public static List<TTGS_Item__c> getListTTGSItems(){
        List<TTGS_Item__c>  TTGSItem = [select id,name,TTGS_Response__c,Strain__c,Category__c,Product_Name__r.Name,	License_Number__c,TTGS_ItemID__c,Product_Name__c,Unit_UOM__c,Unit_Weight__c,UOM__c from TTGS_Item__c  ];
        return TTGSItem;
    }
    public static List<Strain__c> getSingleStrain_metrcID(String metrc_strainID){
        List<Strain__c>  strain = [select id,Name,Track_Trace_Sync__c ,Metrc_StrainID__c,CbdLevel__c,ThcLevel__c,IndicaPercentage__c,SativaPercentage__c from Strain__c where Metrc_StrainID__c = :metrc_strainID limit 1];
        return strain;
    }
     public static List<TTGS_Strain__c> getTTGSStrain_metrcID(String metrc_strainID){
        List<TTGS_Strain__c>  TTGSstrain = [select id,name,TTGS_Response__c,Strain__c,License_Number__c,TTGS_StrainID__c,THC_Level__c,CBD_Level__c,Indica_Percentage__c,Sativa_Percentage__c from TTGS_Strain__c where TTGS_StrainID__c = :metrc_strainID];
        return TTGSstrain;
    }
    public static List<Product2> getAllProducts(){
        List<Product2>  prodList = [select id,Unit_Of_Measure__c,Track_Trace_Sync__c ,Metrc_HttpResponse__c,Track_Trace_Category__c,Name,Metrc_ItemID__c,Cannabis_Weight_UOM__c,Quantity_Type__c,Metrc_UOM__c,Unit_Net_Weight__c,Strain__r.Metrc_StrainID__c,Strain__r.Name,IsActive,Description,Product_Short_Description__c,Net_Weight_UOM__c from Product2  limit 49999];
        return prodList;
        
    }
    
    public static Product2 getProduct(String prodID){

        Product2  prod = [select id,Unit_Of_Measure__c,RecordTypeId,Track_Trace_Sync__c,Metrc_HttpResponse__c,Track_Trace_Category__c,Name,Metrc_ItemID__c,Cannabis_Weight_UOM__c,Quantity_Type__c,Metrc_UOM__c,Unit_Net_Weight__c,Strain__r.Metrc_StrainID__c,Strain__r.Name,IsActive,Description,Product_Short_Description__c,Net_Weight_UOM__c from Product2  where id = :prodID];
        return prod;
    }
    public static List<Product2> getAllProducts(List<String> metrc_recIDList){
        List<Product2>  prodList = [select id,Unit_Of_Measure__c,Track_Trace_Sync__c ,Metrc_HttpResponse__c,Track_Trace_Category__c,Name,Metrc_ItemID__c,Cannabis_Weight_UOM__c,Quantity_Type__c,Metrc_UOM__c,Unit_Net_Weight__c,Strain__r.Metrc_StrainID__c,Strain__r.Name,IsActive,Description,Product_Short_Description__c,Net_Weight_UOM__c from Product2  where Metrc_ItemID__c = :metrc_recIDList];
        return prodList;
        
    }
    
    public static Map<ID,String> getUIDTagMap(List<ID> sfdcRecID){
        Map<ID,String> UIDMap = new Map<ID,String>();
        List<UID__c> objList = [select id,Name from UID__c where id =:sfdcRecID];
        for(UID__c var:objList){
            UIDMap.put(var.ID,var.Name);
        }
        return UIDMap;
    }
    public static List<Picklist_Line__c> getPicklistLine(String sfdcRecID){
        List<Picklist_Line__c>  obj = [select id,UID__c,Pack_out_UID__c,Metrc_PackageID__c,Product_Name__r.Family,Product_Name__r.name,Qty_to_Pick__c ,Product_Name__r.Metrc_UOM__c,Product_Name__r.Unit_Net_Weight__c,Product_Name__r.Track_Trace_Category__c ,Harvest_Batch_or_Lot_Code__c ,Picklist__r.Track_Trace_Sync__c,Picklist__r.Status__c
                                       from Picklist_Line__c  where Picklist__c = :sfdcRecID];
        return obj;
    }
    public static List<Picklist_Line__c> getCancelledPicklistLine(String sfdcRecID){
        List<Picklist_Line__c>  obj = [select id,Pack_out_UID__c from Picklist_Line__c where Picklist__c = :sfdcRecID and Status__c =:PICKLIST_LINE_CANCELLED];
        return obj;
    }
    
    public static List<UID__c> getUIDTagList(List<String> sfdcRecID){
        
        List<UID__c> objList = [select id,Name,In_Use__c from UID__c where ID =:sfdcRecID];
        return objList ;
    }
    public static Shipping_Manifest__c getShippingManifest(String sfdcRecID){
        
       List<string> allproductfamily = new List<string>();
            List<String> Productfamiltdiscount = TransferPackage.PRODUCT_FAMILY_CREDIT_AND_DISCOUNT.split(','); allproductfamily.addAll(Productfamiltdiscount);
            List<String> ProductfamilyService= TransferPackage.PRODUCT_FAMILY_SERVICE.split(',');allproductfamily.addAll(ProductfamilyService);
            List<String> Productfamily = TransferPackage.PRODUCT_FAMILY.split(',');  allproductfamily.addAll(Productfamily);
        Shipping_Manifest__c  obj = [select id,Track_Trace_Sync__c,Name,Distributor_License_Number__c,Distributor_Name__r.name,Distributor_Contact__r.phone,Distributor_Address__c, Distributor_License__r.License_City__c,Distributor_License__r.License_State__c,Distributor_License__r.License_Zip__c,Receiver_Name__c,Receiver_License_Number__c,Actual_Departure_Date_Time__c,Driver_License_Number__c,Driver__r.name, Vehicle__r.name,  Vehicle_Model__c,Vehicle__r.Vehicle_Make__c,Vehicle__r.Vehicle_License_Plate_Number__c,Planned_Ship_Transfer_Date__c, EstimatedDeparture_DateTime__c,EstimatedArrival_DateTime__c,(Select id,Picklist_Line__r.Pack_out_UID__c,Product_Name__r.Family,Picklist_Line__r.Metrc_PackageID__c,Shipping_Manifest__r.Name,UID_1__c,Product_Name__r.name,Shipment_Qty__c,Product_Name__r.Metrc_UOM__c,Retail_Wholesale_Price__c,Harvest_Batch_Code__c,Line_Total_Price__c from Shipping_Manifest_Lines__r where  Product_Name__r.Family !=: allproductfamily) from Shipping_Manifest__c  where id = :sfdcRecID];
        return obj;
    } 
    
    public static List<Picklist__c> getPicklistDetails(String sfdcRecID){
        List<Picklist__c> obj = [select id,Track_Trace_Sync__c ,Status__c from Picklist__c where ID =: sfdcRecID];
        return obj;
    }
    public static List<UID__c> getAllUIDs(List<String> sfdcUID){
        List<UID__c>  uidList = [Select ID, Name from UID__c where Name = :sfdcUID and Available_Qty__c=0 and Received_Qty__c >0 and IRR_UID__c=TRUE and Active__c=TRUE];return uidList;
        
    }
    public static List<UID__c> getDailySynUIDs(){
        List<UID__c> uidList = [Select ID, Name, IRR_UID__c, METRC_Status__c, Active__c, Voided__c, In_Use__c 
                                FROM UID__c 
                                WHERE IRR_UID__c=TRUE AND Active__c=TRUE AND METRC_Status__c=:UID_METRC_STATUS_UNFINISHED AND Voided__c =FALSE AND In_Use__c=TRUE  AND Available_Qty_in_METRC__c > 0];
        return uidList;
        
    }
    
}