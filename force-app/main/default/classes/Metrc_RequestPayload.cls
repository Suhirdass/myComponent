/**************************************************************************************
Apex Class Name    : Metrc_RequestPayload
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : To generate the request JSON for API call
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
public class Metrc_RequestPayload
{ 

    public static string  StraindataREQJSONUpdate(List<TTGS_Strain__c> TTGSstrain,String eventType,string TTGSName,string strainids){
        TTGS_Strain__c  strain = Metrc_SOQLDML_Handler.getTTGSStrains(TTGSName);   JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();gen.writeStartObject();if(eventType == 'UPDATE' && strainids!=null){gen.writeStringField('Id',strainids);   
        }
        gen.writeStringField('Name',strain.Strain__r.Name);          
        gen.writeStringField('TestingStatus','None');
        if(strain.THC_Level__c !=null){  gen.writeNumberField('ThcLevel',strain.THC_Level__c);  }else gen.writeNumberField('ThcLevel',0);
        if(strain.CBD_Level__c !=null){gen.writeNumberField('CbdLevel',strain.CBD_Level__c);}else gen.writeNumberField('CbdLevel',0);	
        if(strain.Indica_Percentage__c !=null){ gen.writeNumberField('IndicaPercentage',strain.Indica_Percentage__c);}else gen.writeNumberField('IndicaPercentage',0);
        if(strain.Sativa_Percentage__c !=null){ gen.writeNumberField('SativaPercentage',strain.Sativa_Percentage__c);}else gen.writeNumberField('SativaPercentage',0);
        gen.writeEndObject();  gen.writeEndArray();String requestjson = gen.getAsString();  return requestjson;
    }
    
   
    
     public static string  ItemTTGdataREQJSONUpdate(List<TTGS_Item__c> TTGSstrain,String eventType,string TTGSName,string strainids){
        TTGS_Item__c  item = Metrc_SOQLDML_Handler.getTTGSItems(TTGSName);Map<String,Object> metrc_WeightUOM_Mapping = (Map<String,Object>) JSON.deserializeUntyped(system.label.Metrc_WeightUOM_Mapping);

system.debug('item>>>'+item);        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray(); gen.writeStartObject();
            if(eventType == 'UPDATE'){  gen.writeStringField('Id',strainids);   
        }
         if(item.TTGS_ItemID__c !=null && eventType == 'UPDATE'){gen.writeStringField('Id',item.TTGS_ItemID__c);
        } 
        gen.writeStringField('ItemCategory',item.Category__c);  
        gen.writeStringField('Name',item.Product_Name__r.Name);  
        gen.writeStringField('UnitOfMeasure',item.Metrc_UOM__c);
        gen.writeStringField('UnitWeightUnitOfMeasure',item.Unit_UOM__c);
        gen.writeStringField('Strain',item.Strain__c);       
        gen.writeStringField('TestingStatus','None');
        if(item.Unit_Weight__c !=null){gen.writeNumberField('UnitWeight',item.Unit_Weight__c); }else gen.writeNumberField('UnitWeight',item.Unit_Weight__c);
        gen.writeEndObject();  gen.writeEndArray();
        String requestjson = gen.getAsString();return requestjson;
    }
      
    
    
    
    public static string  Straindata_REQJSON(List<TTGS_Strain__c> TTGSstrain,String eventType,string TTGSName,string strainids){
        TTGS_Strain__c  strain = Metrc_SOQLDML_Handler.getTTGSStrains(TTGSName);
        system.debug('strain>>>'+strain);        
        string metrcids ;
        if(strainids != null){ metrcids=strainids;
        }else{
            metrcids=strain.TTGS_StrainID__c;
        }
        
        system.debug('metrcids++++++++++++++++'+metrcids);
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        gen.writeStartObject();
        if(strain.TTGS_StrainID__c!=null && eventType == 'UPDATE'){gen.writeStringField('Id',metrcids);
        } if(strainids !=null){gen.writeStringField('Id',metrcids);   
        }
        gen.writeStringField('Name',strain.Strain__r.Name);          
        gen.writeStringField('TestingStatus','None');
        if(strain.THC_Level__c !=null){ gen.writeNumberField('ThcLevel',strain.THC_Level__c); }else gen.writeNumberField('ThcLevel',0);
        if(strain.CBD_Level__c !=null){gen.writeNumberField('CbdLevel',strain.CBD_Level__c); }else gen.writeNumberField('CbdLevel',0);
        if(strain.Indica_Percentage__c !=null){gen.writeNumberField('IndicaPercentage',strain.Indica_Percentage__c);}else gen.writeNumberField('IndicaPercentage',0);
        if(strain.Sativa_Percentage__c !=null){gen.writeNumberField('SativaPercentage',strain.Sativa_Percentage__c);  }else gen.writeNumberField('SativaPercentage',0);
        gen.writeEndObject();
        gen.writeEndArray();
        String requestjson = gen.getAsString();
        return requestjson;
    }
    
    
    
    //Method for creating the request payload for Strain create/update
    public static String createStrain_RequestJSON(String sfdc_strainID,String eventType)
    {   

        //Query the object & genarate the JSON
        Strain__c  strain = Metrc_SOQLDML_Handler.getStrains(sfdc_strainID);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        gen.writeStartObject();
        if(eventType == 'UPDATE'){ gen.writeStringField('Id',strain.Metrc_StrainID__c);
        }  
        gen.writeStringField('Name',strain.Name);          
        gen.writeStringField('TestingStatus','None');
        if(strain.ThcLevel__c !=null){
            gen.writeNumberField('ThcLevel',strain.ThcLevel__c);  }else gen.writeNumberField('ThcLevel',0);
        if(strain.CbdLevel__c !=null){
            gen.writeNumberField('CbdLevel',strain.CbdLevel__c);}else gen.writeNumberField('CbdLevel',0);
        if(strain.IndicaPercentage__c !=null){
        gen.writeNumberField('IndicaPercentage',strain.IndicaPercentage__c); }else gen.writeNumberField('IndicaPercentage',0);
        if(strain.SativaPercentage__c !=null){
        gen.writeNumberField('SativaPercentage',strain.SativaPercentage__c); }else gen.writeNumberField('SativaPercentage',0);
        gen.writeEndObject();
        gen.writeEndArray();
        String requestjson = gen.getAsString(); 
        return requestjson;
    }
    
    
    
    
  
    //Method for creating the request payload for Product2/Items create/update
   public static string  Itemsdata_REQJSON(List<TTGS_Item__c> TTGSItems,String eventType,string TTGIName,string strainids){
        TTGS_Item__c  item = Metrc_SOQLDML_Handler.getTTGSItems(TTGIName); JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        gen.writeStartObject();
          if(item.TTGS_ItemID__c !=null && eventType == 'UPDATE'){gen.writeStringField('Id',item.TTGS_ItemID__c);
        } 
        gen.writeStringField('ItemCategory',item.Category__c);   gen.writeStringField('Name',item.Product_Name__r.Name);  
         gen.writeStringField('UnitOfMeasure',item.Metrc_UOM__c);
        gen.writeStringField('UnitWeightUnitOfMeasure',item.Unit_UOM__c);
        gen.writeStringField('Strain',item.Strain__c);       
        gen.writeStringField('TestingStatus','None');
        gen.writeNumberField('UnitWeight',item.Unit_Weight__c); 
        gen.writeEndObject(); gen.writeEndArray();
        String requestjson = gen.getAsString(); return requestjson;
    }
  public static String createProduct_RequestJSON(String sfdc_ProductID,String eventType)
    {   
        //Query the object & genarate the JSON
        Product2  prodObj = Metrc_SOQLDML_Handler.getProduct(sfdc_ProductID);
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();	
        gen.writeStartObject();
        if(eventType == 'UPDATE'){ gen.writeStringField('Id',prodObj.Metrc_ItemID__c);
        }  
        gen.writeStringField('ItemCategory',prodObj.Track_Trace_Category__c);          
        gen.writeStringField('Name',prodObj.Name);
        gen.writeStringField('UnitOfMeasure',prodObj.Metrc_UOM__c);
        gen.writeStringField('Strain',prodObj.Strain__r.Name);
        gen.writeStringField('UnitThcContentUnitOfMeasure',prodObj.Metrc_UOM__c);
        if(prodObj.Unit_Net_Weight__c == null){prodObj.Unit_Net_Weight__c =1;}
        
        if(prodObj.Unit_Net_Weight__c != null && (prodObj.Unit_Of_Measure__c=='Liters'||prodObj.Unit_Of_Measure__c=='Gallons'||prodObj.Unit_Of_Measure__c=='Fluid Ounces'||prodObj.Unit_Of_Measure__c=='Milliliters'||prodObj.Unit_Of_Measure__c=='Pints'||prodObj.Unit_Of_Measure__c=='Quarts')){ gen.writeNumberField('UnitVolume',prodObj.Unit_Net_Weight__c); gen.writeStringField('UnitVolumeUnitOfMeasure',prodObj.Unit_Of_Measure__c);
        }
        if(prodObj.Unit_Net_Weight__c != null &&(prodObj.Unit_Of_Measure__c=='Grams'||prodObj.Unit_Of_Measure__c=='Kilograms'||prodObj.Unit_Of_Measure__c=='Milligrams'||prodObj.Unit_Of_Measure__c=='Pounds'||prodObj.Unit_Of_Measure__c=='Ounces')){
            gen.writeNumberField('UnitWeight',prodObj.Unit_Net_Weight__c);gen.writeStringField('UnitWeightUnitOfMeasure',prodObj.Unit_Of_Measure__c);
        }
        
        gen.writeNumberField('ServingSize',0);
        gen.writeBooleanField('IsUsed',true);
        gen.writeEndObject();
        gen.writeEndArray();
        String requestjson = gen.getAsString(); 
        return requestjson;
    }
    //Method for creating the request payload for Packages/Picklist_Line__c create
    public static String createPicklistLine_RequestJSON(List<Picklist_Line__c> objList,Map<ID,String> packoutUIDMap)
    {   
        Decimal Qty_to_Pick = 0.0;
        Map<String,Picklist_Line__c> objNewMap= new Map<String,Picklist_Line__c>();
        Map<String,Decimal> IDQtyMap= new Map<String,Decimal> ();

        for(Picklist_Line__c var: objList){
        if(var.Product_Name__r.Family != 'Accessories'){
        String recKey =var.Product_Name__c+'-'+var.UID__c+'-'+var.Harvest_Batch_or_Lot_Code__c;
            if(var.Product_Name__r.Metrc_UOM__c == 'Grams'){if(var.Product_Name__r.Unit_Net_Weight__c != null){ Qty_to_Pick = var.Product_Name__r.Unit_Net_Weight__c * var.Qty_to_Pick__c;
                }else{
                 Qty_to_Pick = var.Qty_to_Pick__c;
                }
            }else Qty_to_Pick = var.Qty_to_Pick__c;
        
            if(objNewMap.containsKey(recKey)){ IDQtyMap.put(recKey,IDQtyMap.get(recKey)+ Qty_to_Pick );
            }else {
            
            objNewMap.put(recKey,var);
            IDQtyMap.put(recKey,Qty_to_Pick );
            }
          //  UIDList.add(var.UID__c);
        }
        }
        //Map<ID,String> UIDMap = Metrc_SOQLDML_Handler.getUIDTagMap(UIDList);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for(Picklist_Line__c obj: objNewMap.values()){
        String recKey =obj.Product_Name__c+'-'+obj.UID__c+'-'+obj.Harvest_Batch_or_Lot_Code__c;
            gen.writeStartObject();
            gen.writeStringField('Tag',packoutUIDMap.get(obj.Pack_out_UID__c));
            gen.writeStringField('Room','');
            gen.writeStringField('Item',obj.Product_Name__r.Name);   
            gen.writeNumberField('Quantity',IDQtyMap.get(recKey));
            if(obj.Product_Name__r.Metrc_UOM__c !=null){
            gen.writeStringField('UnitOfMeasure',obj.Product_Name__r.Metrc_UOM__c); }else{ gen.writeStringField('UnitOfMeasure','');
            }
           // gen.writeStringField('PatientLicenseNumber',obj.Product_Name__r.Metrc_UOM__c);   //Not required**
            gen.writeStringField('Note','This is a note.');
            gen.writeBooleanField('IsProductionBatch',false);
            gen.writeStringField('ProductionBatchNumber',obj.Harvest_Batch_or_Lot_Code__c);
            gen.writeBooleanField('ProductRequiresRemediation',false);
            gen.writeStringField('ActualDate',Datetime.now().format('yyyy-MM-dd')); 
            //if(obj.UID__c != null && obj.UID__c !='N/A'){
                gen.writeFieldName('Ingredients'); // "Ingredients": [{...},{...}]
                gen.writeStartArray();
                    gen.writeStartObject();
                    if(obj.UID__c !=null && obj.UID__c !='N/A'){
                        gen.writeStringField('Package',obj.UID__c);     } else gen.writeStringField('Package','');
                        gen.writeNumberField('Quantity',IDQtyMap.get(recKey));
                        gen.writeStringField('UnitOfMeasure',obj.Product_Name__r.Metrc_UOM__c);
                    gen.writeEndObject();
                gen.writeEndArray();
           // }
            gen.writeEndObject();
        }
        gen.writeEndArray();
        
        String requestjson = gen.getAsString(); 
        return requestjson;
    }
     
 //Method for creating the request payload for Shipping_Manifest__c/Transfer
    public static String createShippingManifest_RequestJSON(Shipping_Manifest__c obj, String route)
    {  
        //Prepare the line item data here.
        List<Shipping_Manifest_Line__c> childObjList = obj.Shipping_Manifest_Lines__r;  Map<String,Decimal> shippingManifestLineKey_QtyMap= new Map<String,Decimal> ();
        Map<String,Decimal> shippingManifestLineKey_WholesalePriceMap= new Map<String,Decimal> (); Map<String,Shipping_Manifest_Line__c> childObjMap= new Map<String,Shipping_Manifest_Line__c>();
         
        for(Shipping_Manifest_Line__c var: childObjList){   String recKey =var.Product_Name__c+'-'+var.UID_1__c;   if(childObjMap.containsKey(recKey)){ shippingManifestLineKey_QtyMap.put(recKey,shippingManifestLineKey_QtyMap.get(recKey)+var.Shipment_Qty__c );
                shippingManifestLineKey_WholesalePriceMap.put(recKey,shippingManifestLineKey_QtyMap.get(recKey)+var.Retail_Wholesale_Price__c );
            }else {
            childObjMap.put(recKey,var);shippingManifestLineKey_QtyMap.put(recKey,var.Shipment_Qty__c );  shippingManifestLineKey_WholesalePriceMap.put(recKey,var.Retail_Wholesale_Price__c );
            
            }
        }
        Datetime output = obj.Planned_Ship_Transfer_Date__c; String convertedDate = output.addHours(12).format('yyyy-MM-dd');
        Company_Custom_Settings__c cs = [select Second_Warehouse_Id__c, Default_Distributor__c from Company_Custom_Settings__c];
        String melRose = cs.Second_Warehouse_Id__c; Boolean checkWholeSale = false;  String filligreen = cs.Default_Distributor__c;

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
            gen.writeStartObject();

            gen.writeStringField('Name',obj.Name);
        	gen.writeStringField('TransporterFacilityLicenseNumber',obj.Distributor_License_Number__c);
            gen.writeStringField('DriverOccupationalLicenseNumber',obj.Driver_License_Number__c);
            gen.writeStringField('DriverName',obj.Driver__r.name);
            gen.writeStringField('DriverLicenseNumber',obj.Driver_License_Number__c);
            gen.writeStringField('PhoneNumberForQuestions',''); //Need some change here.
            gen.writeStringField('VehicleMake',obj.Vehicle__r.Vehicle_Make__c);
            gen.writeStringField('VehicleModel',obj.Vehicle_Model__c);
            gen.writeStringField('VehicleLicensePlateNumber',obj.vehicle__r.Vehicle_License_Plate_Number__c);
            
            gen.writeFieldName('Destinations'); // "Destinations": [{[{.}],[{}]}....]
            gen.writeStartArray();
                gen.writeStartObject();
                    gen.writeStringField('RecipientLicenseNumber',obj.Receiver_License_Number__c);
                    if(obj.Receiver_Name__c == melRose || obj.Receiver_Name__c == filligreen){ gen.writeStringField('TransferTypeName',Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_TRANSFERNAME_TRANSFER); 
                    }
                    else{
                        checkWholeSale = true; gen.writeStringField('TransferTypeName',Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_TRANSFERNAME_WHOLESALE);
                    }
                    gen.writeStringField('PlannedRoute',route);//'I will drive down the road to the place.'
                    gen.writeStringField('EstimatedDepartureDateTime',convertedDate+ ' ' + Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_PLANNED_SHIP_DATE_8AM);
                    gen.writeStringField('EstimatedArrivalDateTime',convertedDate + ' ' + Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_PLANNED_SHIP_DATE_6PM);
                    
                gen.writeFieldName('Transporters'); 
                    gen.writeStartArray();gen.writeStartObject();
                        gen.writeStringField('TransporterFacilityLicenseNumber',obj.Distributor_License_Number__c);
                        gen.writeStringField('DriverOccupationalLicenseNumber',obj.Driver_License_Number__c); 
                        gen.writeStringField('DriverName',obj.Driver__r.name);
                        gen.writeStringField('DriverLicenseNumber',obj.Driver_License_Number__c);
                        gen.writeStringField('PhoneNumberForQuestions',''); //Need some change here.
                        gen.writeStringField('VehicleMake',obj.Vehicle__r.Vehicle_Make__c);
                        gen.writeStringField('VehicleModel',obj.Vehicle_Model__c);
                        gen.writeStringField('VehicleLicensePlateNumber',obj.vehicle__r.Vehicle_License_Plate_Number__c);
                        gen.writeBooleanField('IsLayover',false);
        				gen.writeStringField('EstimatedDepartureDateTime',convertedDate + ' ' + Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_PLANNED_SHIP_DATE_8AM);
                    	gen.writeStringField('EstimatedArrivalDateTime',convertedDate + ' ' + Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_PLANNED_SHIP_DATE_6PM);
                        gen.writeNullField('TransporterDetails');
                    gen.writeEndObject();gen.writeEndArray();//EOD of "Transporters"node
                gen.writeFieldName('Packages'); 
                    gen.writeStartArray();
                        if(checkWholeSale){ for(Shipping_Manifest_Line__c childObj: childObjList){
                                gen.writeStartObject();   gen.writeStringField('PackageLabel',childObj.UID_1__c);
                                gen.writeNumberField('WholesalePrice',childObj.Line_Total_Price__c);gen.writeEndObject();  
                            }
                        }else
                        {
                             for(Shipping_Manifest_Line__c childObj: childObjMap.values()){ String recKey =childObj.Product_Name__c+'-'+childObj.UID_1__c;
                                gen.writeStartObject();   gen.writeStringField('PackageLabel',childObj.UID_1__c);
                                gen.writeNumberField('WholesalePrice',shippingManifestLineKey_WholesalePriceMap.get(recKey)); gen.writeEndObject();
                            } 
                        }
                    gen.writeEndArray();//EOD of "Packages" node
            gen.writeEndObject();gen.writeEndArray();   //EOD of "Destinations" node
            gen.writeEndObject(); gen.writeEndArray(); //End of Main node.
        
        String requestjson = gen.getAsString();  return requestjson;
    }
    
    //Method for creating the package finish JSON
    public static String createPackageFinish_RequestJSON(String Name, String ActualDate)
    {   

        //Query the object & genarate the JSON
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        gen.writeStartObject();

        gen.writeStringField('Label',Name);
        gen.writeStringField('ActualDate',ActualDate);
        
        gen.writeEndObject();
        gen.writeEndArray();
        String requestjson = gen.getAsString(); 
        return requestjson;
    }
    
    public static String createBatchFinish_RequestJSON(list<UID__c> sf_UIDList )
    {   
		String requestjson ='';
        JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartArray();
            for(UID__c uid: sf_UIDList)    {DateTime actualDate = Datetime.now(); String dateOutput = actualDate.format('yyyy-MM-dd');
                    gen.writeStartObject();	  gen.writeStringField('Label',uid.Name);
                    gen.writeStringField('ActualDate',dateOutput); gen.writeEndObject();  
              }

            gen.writeEndArray();
            requestjson = gen.getAsString();
        return requestjson;
    }
 }