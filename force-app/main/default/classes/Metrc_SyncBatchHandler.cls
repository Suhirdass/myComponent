/**************************************************************************************
Apex Class Name    : Metrc_SyncBatchHandler 
Test Class Name    : Metrc_SyncBatchHandlerTest
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for nightly syncup the strain & Product from Metrc system.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar         01/Sep/2019              Original Version
* Kumaravendan              21/Apr/2021              Daily sync UID
*******************************************************************************/
public class Metrc_SyncBatchHandler {
    
    public Static String UID_METRC_STATUS_FINISHED{
        get{
            return String.isNotBlank(UID_METRC_STATUS_FINISHED) ? UID_METRC_STATUS_FINISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Metrc_Status_Finished');
        }set;
    }
    public Static String UID_METRC_STATUS_UNFINISHED{
        get{
            return String.isNotBlank(UID_METRC_STATUS_UNFINISHED) ? UID_METRC_STATUS_UNFINISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Metrc_Status_UnFinished');
        }set;
    }
    private Static String PRODUCT_FAMILY_TYPE{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_TYPE) ? PRODUCT_FAMILY_TYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family_Type');
        }set;
    }
    private Static String PRODUCT_QUANTITY_TYPE{
        get{
            return String.isNotBlank(PRODUCT_QUANTITY_TYPE) ? PRODUCT_QUANTITY_TYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Quantity_Type');
        }set;
    }
    public Static String PRODUCT_DEVELOPER_NAME{
        get{
            return String.isNotBlank(PRODUCT_DEVELOPER_NAME) ? PRODUCT_DEVELOPER_NAME :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Developer_Name');
        }set;
    }
    @future(callout=true)
    public static void Metrc_SyncStrainBatch() {
        List<String> metrc_strainIDList = new List<String>();
        List<String> metrc_strainID_newList = new List<String>(); 
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllStrains();
        Map<String,Strain__C> strianIDObjMap = new Map<String,Strain__C>();
        List<Strain__c> strainList = new List<Strain__c>();
        for(Object  obj : responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id')){
                metrc_strainIDList.add(string.valueof(respMap.get('Id')));
            }
        }
        List<Strain__C>  sf_StrainList= Metrc_SOQLDML_Handler.getAllStrains(metrc_strainIDList);
        for(Strain__C var:sf_StrainList){
            strianIDObjMap.put(var.Metrc_StrainID__c ,var);
        }
        for(Object  objVar:responseList){
            Map<String,Object> respMap= (Map<String,Object>)objVar;
            if(respMap.containsKey('Id') && strianIDObjMap.containsKey(string.valueof(respMap.get('Id'))) ){
                Strain__c strainObj = strianIDObjMap.get(string.valueof(respMap.get('Id')));
                strainObj.Name =string.valueof(respMap.get('Name'));
                if(respMap.get('ThcLevel') !=null){
                    strainObj.ThcLevel__c=Integer.valueof(respMap.get('ThcLevel'));
                }else strainObj.ThcLevel__c=0.0;
                if(respMap.get('CbdLevel') !=null){
                    strainObj.CbdLevel__c=Integer.valueof(respMap.get('CbdLevel'));
                }else strainObj.CbdLevel__c=0.0;
                if(respMap.get('IndicaPercentage') !=null){
                    strainObj.IndicaPercentage__c=Integer.valueof(respMap.get('IndicaPercentage'));
                }else strainObj.IndicaPercentage__c=0.0;
                if(respMap.get('SativaPercentage') !=null){
                    strainObj.SativaPercentage__c=Integer.valueof(respMap.get('SativaPercentage'));
                }else strainObj.SativaPercentage__c=0.0;
                strainList.add(strainObj);
            }else {
                Strain__c obj= new Strain__c();
                obj.Name =string.valueof(respMap.get('Name'));
                obj.Metrc_StrainID__c   =string.valueof(respMap.get('Id'));
                obj.Strain_Type__c='N/A';
                obj.Track_Trace_Sync__c= true;
                obj.isActive__c=true;
                if(respMap.get('ThcLevel') !=null){
                    obj.ThcLevel__c=Integer.valueof(respMap.get('ThcLevel'));
                }else obj.ThcLevel__c=0.0;
                if(respMap.get('CbdLevel') !=null){
                    obj.CbdLevel__c=Integer.valueof(respMap.get('CbdLevel'));
                }else obj.CbdLevel__c=0.0;
                if(respMap.get('IndicaPercentage') !=null){
                    obj.IndicaPercentage__c=Integer.valueof(respMap.get('IndicaPercentage'));
                }else obj.IndicaPercentage__c=0.0;
                if(respMap.get('SativaPercentage') !=null){
                    obj.SativaPercentage__c=Integer.valueof(respMap.get('SativaPercentage'));
                }else obj.SativaPercentage__c=0.0;
                strainList.add(obj);
                //create strain record here
                metrc_strainID_newList.add(string.valueof(respMap.get('Id')));
            }
        }
        Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        Database.upsert(strainList,true);
        
    }
    
    
    @future(callout=true)
    public static void Metrc_SyncItemsBatch() {
        List<String> metrc_ProductIDList = new List<String>();
        List<String> metrc_ProductID_newList = new List<String>();
        
        Map<String,Product2> ProductIDObjMap = new Map<String,Product2>();
        Map<String,ID> metrcIDStrainSFIDMap = new Map<String,ID>();
        List<Product2> ProductUpdateList = new List<Product2>();
        Recordtype recordtype =[select Id ,name from recordtype where DeveloperName =:PRODUCT_DEVELOPER_NAME  and SobjectType ='Product2' limit 1];
        
        //callout for synching the data.
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllProducts();
        
        for(Object  obj : responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id')){
                metrc_ProductIDList.add(string.valueof(respMap.get('Id')));
            }
        }
        List<Product2>  sf_ProductList= Metrc_SOQLDML_Handler.getAllProducts(metrc_ProductIDList);
        for(Product2 var:sf_ProductList){
            ProductIDObjMap.put(var.Metrc_ItemID__c,var);
        }
        List<Strain__C>  allStrainList= Metrc_SOQLDML_Handler.getAllStrains();
        for(Strain__C var2:allStrainList){
            metrcIDStrainSFIDMap.put(var2.Metrc_StrainID__c ,var2.ID);
        }
        Map<String,Object> metrc_WeightUOM_Mapping = (Map<String,Object>) JSON.deserializeUntyped(system.label.Metrc_WeightUOM_Mapping);
        
        for(Object  obj:responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id') && ProductIDObjMap.containsKey(string.valueof(respMap.get('Id'))) ){
                Product2 ProductObj = ProductIDObjMap.get(string.valueof(respMap.get('Id')));
                ProductObj.Name =string.valueof(respMap.get('Name'));
                ProductObj.Track_Trace_Category__c =string.valueof(respMap.get('ProductCategoryName'));
                if(metrc_WeightUOM_Mapping.containsKey(string.valueof(respMap.get('UnitOfMeasureName')))){
                    ProductObj.Net_Weight_UOM__c =string.valueof(metrc_WeightUOM_Mapping.get(string.valueof(respMap.get('UnitOfMeasureName')))); 
                }
                if(string.valueof(respMap.get('UnitVolumeUnitOfMeasureName')) != null){
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitVolumeUnitOfMeasureName'));
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitVolume'));
                }else if(string.valueof(respMap.get('UnitWeightUnitOfMeasureName')) != null){
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitWeight'));
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitWeightUnitOfMeasureName'));
                }
                if(metrcIDStrainSFIDMap.containsKey(string.valueof(respMap.get('StrainId')))){
                    ProductObj.Strain__c =metrcIDStrainSFIDMap.get(string.valueof(respMap.get('StrainId')));
                }
                
                ProductUpdateList.add(ProductObj);
            }else {
                Product2 ProductObj = new Product2();
                ProductObj.Name =string.valueof(respMap.get('Name'));
                ProductObj.Description=string.valueof(respMap.get('Name'));
                ProductObj.Product_Short_Description__c=string.valueof(respMap.get('Name'));
                ProductObj.Track_Trace_Category__c =string.valueof(respMap.get('ProductCategoryName'));
                if(metrc_WeightUOM_Mapping.containsKey(string.valueof(respMap.get('UnitOfMeasureName')))){
                    ProductObj.Net_Weight_UOM__c =string.valueof(metrc_WeightUOM_Mapping.get(string.valueof(respMap.get('UnitOfMeasureName')))); 
                }
                if(string.valueof(respMap.get('UnitVolumeUnitOfMeasureName')) != null){
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitVolumeUnitOfMeasureName'));
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitVolume'));
                }else if(string.valueof(respMap.get('UnitWeightUnitOfMeasureName')) != null){
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitWeight'));
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitWeightUnitOfMeasureName'));
                }
                ProductObj.IsActive =true;
                ProductObj.Track_Trace_Sync__c =true;
                if(metrcIDStrainSFIDMap.containsKey(string.valueof(respMap.get('StrainId')))){
                    ProductObj.Strain__c =metrcIDStrainSFIDMap.get(string.valueof(respMap.get('StrainId')));
                }
                ProductObj.Metrc_ItemID__c  =string.valueof(respMap.get('Id'));
                ProductObj.Quantity_Type__c=  PRODUCT_QUANTITY_TYPE;   //'Quantity'; // what will be the default value here.
                ProductObj.Family=  PRODUCT_FAMILY_TYPE; //'Flower'; // what will be the default value here.
                ProductObj.recordtypeID=recordtype.ID;    //is it always product record type ?
                metrc_ProductID_newList.add(string.valueof(respMap.get('Id')));
                ProductUpdateList.add(ProductObj);
            }
        }  
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED =FALSE;
        if(!Test.isRunningTest()) {
            Database.upsert(ProductUpdateList,true);
        }
    }
    //==============================Used for Onetime Batch Sync====================================//
    @future(callout=true)
    public static void Metrc_SyncStrainBatch_OneTime() {
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllStrains();
        Map<String,String> MetrcStrianName_IDMap = new Map<String,String>();
        List<Strain__c> strainList = new List<Strain__c>();
        for(Object  obj : responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id')){
                MetrcStrianName_IDMap.put(string.valueof(respMap.get('Name')),string.valueof(respMap.get('Id')));
            }
        }
        List<Strain__C>  sf_StrainList= Metrc_SOQLDML_Handler.getAllStrains();
        for(Strain__C  obj:sf_StrainList){
            if(MetrcStrianName_IDMap.containsKey(obj.Name)){
                obj.Metrc_StrainID__c =string.valueof(MetrcStrianName_IDMap.get(obj.Name));
                strainList.add(obj);
            }
        }
        Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        Database.update(strainList,true);
        
    }
    @future(callout=true)
    public static void Metrc_SyncProductBatch_OneTime() {
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllProducts();
        Map<String,String> MetrcProdName_IDMap = new Map<String,String>();
        List<Product2> prodUpdateList = new List<Product2>();
        for(Object  obj : responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id')){
                MetrcProdName_IDMap.put(string.valueof(respMap.get('Name')),string.valueof(respMap.get('Id')));
            }
        }
        List<Product2>  sf_ProdList= Metrc_SOQLDML_Handler.getAllProducts();
        for(Product2  obj:sf_ProdList){
            if(MetrcProdName_IDMap.containsKey(obj.Name)){
                obj.Metrc_ItemID__c =string.valueof(MetrcProdName_IDMap.get(obj.Name));
                prodUpdateList.add(obj);
            }
        }
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED =FALSE;
        Database.update(prodUpdateList,true);
    }
    //==================Batch for UID Sync=======================//
    @future(callout=true)
    public static void Metrc_SyncUIDBatch() {
        List<String> metrc_UIDList = new List<String>();
        List<String> metrc_PackageList = new List<String>();
        List<Integer> metrc_QunatityList = new List<Integer>();
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllPackages();
        Integer allPackageSize = responseList.size();
        Map<String,UID__c> UIDObjMap = new  Map<String,UID__c>();
        List<UID__c> sf_UIDList = new List<UID__c>(); 
        for(Object  obj: responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Id') && Integer.valueof(respMap.get('Quantity'))==0 && string.valueof(respMap.get('FinishedDate'))==null){
                metrc_UIDList.add(string.valueof(respMap.get('Label')));
            }
            if(respMap.containsKey('Id')){
                metrc_PackageList.add(string.valueof(respMap.get('Label')));
                metrc_QunatityList.add(Integer.valueof(respMap.get('Quantity')));
            }            
        }
        Integer metricTotal = metrc_UIDList.size();
        List<UID__c>  actualfilterList = [Select ID, Name, Available_Qty__c from UID__c where Name =: metrc_PackageList];
        if(metrc_UIDList.Size()>0){
            sf_UIDList= Metrc_SOQLDML_Handler.getAllUIDs(metrc_UIDList);
        }
        if(sf_UIDList.Size()>0){
            Metrc_HttpCalloutHelper.BatchPackageFinish(metrc_PackageList, metrc_UIDList, metrc_QunatityList, sf_UIDList,actualfilterList);
        }
        
    }
    /*daily batch for update data from metrc*/
    @future(callout=true)
    public static void Metrc_DataSyncDaily() {
        List<String> metrc_UIDList = new List<String>();
        List<Object> responseList = Metrc_HttpCalloutHelper.getAllPackages();
        List<UID__c> uidUpdateList = new List<UID__c>();
        List<UID__c>  sf_UIDList= Metrc_SOQLDML_Handler.getDailySynUIDs();
        for(Object  obj : responseList){
            Map<String,Object> respMap= (Map<String,Object>)obj;
            for(UID__c  uidObj:sf_UIDList){
                if(string.valueof(respMap.get('Label')) == uidObj.Name){
                    UID__c uidList = new UID__c();
                    uidList.Id = uidObj.ID;
                    uidList.Available_Qty_in_METRC__c = Integer.valueof(respMap.get('Quantity'));
                    uidList.METRC_Lab_Status__c = string.valueof(respMap.get('LabTestingState'));
                    uidList.Metrc_UOM__c = string.valueOf(respMap.get('UnitOfMeasureName'));
                    if(string.valueOf(respMap.get('Item'))!=null){
                        String item = JSON.serialize(respMap.get('Item'));
                        String itemName ='';
                        String itemCategoryName ='';
                        JSONParser parser = JSON.createParser(item);
                        while (parser.nextToken() != null) {
                            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() =='Name')){
                                parser.nextToken();
                                itemName = parser.getText();
                            }
                            
                            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'ProductCategoryName')){
                                parser.nextToken();  
                                itemCategoryName = parser.getText();
                            } 
                        } 
                        uidList.Metrc_Item__c = itemName;
                        uidList.Metrc_Category__c = itemCategoryName;  
                    } 
                    if(respMap.get('FinishedDate') !=null){
                        Date convertDate = Date.valueOf(string.valueof(respMap.get('FinishedDate')));
                        uidList.Finished_Date__c = convertDate;
                        uidList.METRC_Status__c = UID_METRC_STATUS_FINISHED;
                    }else{
                        uidList.METRC_Status__c = UID_METRC_STATUS_UNFINISHED;
                    }
                    uidUpdateList.add(uidList); 
                }
            }
        }
        if(uidUpdateList.size()>0){
            Database.update(uidUpdateList,true);
        }
        
    }
    
}