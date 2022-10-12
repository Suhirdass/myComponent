public class TransferPackage {
    public static boolean isUID = false;
        public static boolean isNotProductRec = false;

    public static Shipping_Manifest__c smObj;
    public Static String ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER) ? ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_ShipManifest_Assign_Driver');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE{
        get{
            return  String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE) ? ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE :FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_ShipManifest_Assign_Vehicle');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED) ? ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Template_Created');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING) ? SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    } 
    public Static String ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE) ? ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Driver_License');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME) ? ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Depart_Time');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_ARRAIVAL_TIME{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_ARRAIVAL_TIME) ? ERR_MSG_SHIPPING_MANIFEST_ARRAIVAL_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Arrival_Time');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE) ? ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Rec_License');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE) ? ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Dist_License');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE) ? ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_PlanShipDate');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS) ? ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Manifest_Change_Status');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_MANIFEST_LINE_CHANGE_STATUS{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_MANIFEST_LINE_CHANGE_STATUS) ? ERR_MSG_SHIPPING_MANIFEST_LINE_CHANGE_STATUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Err_Msg_SM_Line_Change_Status');
        }set;
    }
    public Static String ERR_MSG_ASSIGN_UID{
        get{
            return String.isNotBlank(ERR_MSG_ASSIGN_UID) ? ERR_MSG_ASSIGN_UID : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','Err_Msg_Assign_UID');
        }set;
    }
     public Static String ERR_MSG_NON_CANNABIS{
        get{
            return String.isNotBlank(ERR_MSG_NON_CANNABIS) ? ERR_MSG_NON_CANNABIS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Err_Msg_Non_Cannabis');
        }set;
    }
       public Static String PRODUCT_FAMILY_CREDIT_AND_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_CREDIT_AND_DISCOUNT) ? PRODUCT_FAMILY_CREDIT_AND_DISCOUNT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Credit_Discount_Product_Family');
        }set;
    }
    public Static String PRODUCT_FAMILY_SERVICE{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_SERVICE) ? PRODUCT_FAMILY_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Service_Product_Family');
        }set;
    }
    public Static String PRODUCT_FAMILY{
        get{
            return String.isNotBlank(PRODUCT_FAMILY) ? PRODUCT_FAMILY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family');
        }set;
    }
    
     public Static String PRODUCT_RECORD_TYPE{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE) ? PRODUCT_RECORD_TYPE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Developer_Name');
        }set;
    }
    @AuraEnabled
    public static AuraResponse TransferShipmanifest(String recordId){
        
        //String responseMessage = '';
        String errorMessage = '';
        Set<String> status = new Set<String>();
        status.add(SHIPPING_MANIFEST_STATUS_INTRANSIT);
        status.add(SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING);     
        AuraResponse r = new AuraResponse('TransferPackage.TransferShipmanifest()');
       
        List<Shipping_Manifest__c>  obj = [select id,Track_Trace_Sync__c,Metrc_Manifest__c,Name,RecordTypeId,Distributor_License_Number__c,Distributor_Name__r.name,Distributor_Contact__r.phone,Distributor_Address__c,
                                           Distributor_License__r.License_City__c,Distributor_License__r.License_State__c,Distributor_License__r.License_Zip__c,
                                           Receiver_License_Number__c,Actual_Departure_Date_Time__c,Driver_License_Number__c,Driver__r.name, Vehicle__r.name,  Vehicle_Model__c,Vehicle__r.Vehicle_Make__c,Vehicle__r.Vehicle_License_Plate_Number__c,Planned_Ship_Transfer_Date__c,
                                           EstimatedDeparture_DateTime__c,EstimatedArrival_DateTime__c,
                                           (Select id,Picklist_Line__r.Pack_out_UID__c,Product_Name__r.Family,Product_Name__r.RecordTypeId,Picklist_Line__r.Metrc_PackageID__c,Shipping_Manifest__r.Name,UID_1__c,Product_Name__r.name,Shipment_Qty__c,Product_Name__r.Metrc_UOM__c,Retail_Wholesale_Price__c,Harvest_Batch_Code__c 
                                            from Shipping_Manifest_Lines__r where SMLine_Status__c = null )
                                           from Shipping_Manifest__c  where id = :recordId and Status__c IN :status ];//('In-Transit' ,'Shipment Pending')];
        Set<String> my_list = new Set<String>();
        if(obj.size()>0){
            smObj =  obj[0];
            List<Shipping_Manifest_Line__c> childObjList1 = smObj.Shipping_Manifest_Lines__r;
            if(childObjList1.size()>0){
        Id productRecordTypeID   = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE).getRecordTypeId();
                for(Shipping_Manifest_Line__c var: childObjList1){
                 
                    if(var.UID_1__c== null){  isUID = true;
                    }
                    if(var.Product_Name__r.RecordTypeId != productRecordTypeID ){  isNotProductRec = false;
                          }else{
                           isNotProductRec = true;   
                          }
                } 
            }else{
                isUID = true;
            }
            
            if(smObj.Driver__c!= null && smObj.Vehicle__c!= null && smObj.Planned_Ship_Transfer_Date__c!= null && smObj.Driver_License_Number__c!= null && smObj.Distributor_License_Number__c!= null
               && smObj.EstimatedDeparture_DateTime__c!= null && smObj.EstimatedArrival_DateTime__c!= null && smObj.Receiver_License_Number__c!= null && smObj.Metrc_Manifest__c==null && isUID == false && isNotProductRec== true){
                     syncDataToMetrc(recordId,'INSERT');
               } else{
                   if(childObjList1.size()<=0){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_LINE_CHANGE_STATUS);}
                   else if(smObj.Driver__c== null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER); }
                   else if(smObj.Vehicle__c== null){my_list.add(ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE); }
                   else if(smObj.Planned_Ship_Transfer_Date__c == null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE);}
                   else if(smObj.Driver_License_Number__c == null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE);}
                   else if(smObj.Distributor_License_Number__c == null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE); }
                   else if(smObj.EstimatedDeparture_DateTime__c == null || smObj.EstimatedArrival_DateTime__c == null){my_list.add(ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME);}
                   else if(smObj.Receiver_License_Number__c == null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE);}
                   else if(smObj.Metrc_Manifest__c!=null){ my_list.add(ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED);}

                   else{
                      Id productRecordTypeID   = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE).getRecordTypeId();

                       for(Shipping_Manifest_Line__c var: childObjList1){
                                     
                           if(var.UID_1__c== null){ my_list.add(ERR_MSG_ASSIGN_UID);}
                           
                          if(var.Product_Name__r.RecordTypeId !=productRecordTypeID ){my_list.add(ERR_MSG_NON_CANNABIS);}

                       }
                   }
                   errorMessage = String.join(new List<String>(my_list), ', ');    
               } 
        }
        else{
            my_list.add(ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS);
            errorMessage = String.join(new List<String>(my_list), ', ');
        }
        r.data.put('errorMessage', errorMessage); 
        return r;
        
    }
    
    @future(callout=true)
   public static void syncDataToMetrc(ID objID,String eventType){
        Shipping_Manifest__c shippingManifestObj = Metrc_SOQLDML_Handler.getShippingManifest(objID);
        Shipping_Manifest__c sm= [select id, name, Receiver_License__r.License_Address__c, Receiver_License__r.License_City__c,Receiver_License__r.License_Zip__c,
        Receiver_License__r.Default_Warehouse__r.License_ID__r.License_Address__c,Receiver_License__r.Default_Warehouse__r.License_ID__r.License_City__c, 
        Receiver_License__r.Default_Warehouse__r.License_ID__r.License_Zip__c from Shipping_Manifest__c where id=:objID]; 
        String recLicenseAdd= sm.Receiver_License__r.License_Address__c;
        String recLicenseCity= sm.Receiver_License__r.License_City__c;
        String recLicenseZip= sm.Receiver_License__r.License_Zip__c;
        String recLicenseSiteAdd= sm.Receiver_License__r.Default_Warehouse__r.License_ID__r.License_Address__c;
        String recLicenseSiteCity= sm.Receiver_License__r.Default_Warehouse__r.License_ID__r.License_City__c;
        String recLicenseSiteZip= sm.Receiver_License__r.Default_Warehouse__r.License_ID__r.License_Zip__c;
        String origin = recLicenseSiteAdd + ',' + recLicenseSiteCity + ',' + recLicenseSiteZip;
        String destination = recLicenseAdd + ',' + recLicenseCity + ',' + recLicenseZip;
        String route = getRouteDirection(origin, destination);   
              system.debug('route>>>'+route);

        String message = Metrc_HttpCalloutHelper.createShippingManifest(shippingManifestObj,eventType,route);
       system.debug('message>>>'+message);
        //return message;
    }
    
    @Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
         AuraResponse r = new AuraResponse('TransferPackage.getRecordName()');
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
             r.data.put('name', (String) (records[0].get('Name')));
            return r;
        }
        return r;
    }
    public static String getRouteDirection(String org, String dest){
        String url = 'https://maps.googleapis.com/maps/api/directions/json?';
        string origin = org;//'2089 Ingalls%St, Unit 3,San Francisco,94124';
        string destination = dest; //'952 Mission St,San Francisco,94103';
        String finalRoute ='';
        url += 'origin=' + EncodingUtil.urlEncode(origin,'UTF-8')+'&destination='+EncodingUtil.urlEncode(destination,'UTF-8')+'&outputFormat=xml';
        url += '&key='+Label.Google_Map_API_Key;
        List<Object> responseList = new List<Object>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-type', 'application/x-www-form-urlencoded'); 
        request.setHeader('Content-length', '0');
        HttpResponse response1 = http.send(request);
        String response = response1.getBody();
        system.debug('response>'+response);
        if(response1.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(response);
            List<String> my_list = new List<String>();
            List<String> html_list = new List<String>();
            List<String> route_list = new List<String>();
            String dist = '';
            
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'distance')){
                    parser.nextToken();
                    while (parser.nextToken() != JSONToken.END_OBJECT){    
                        String txt = parser.getText();
                        parser.nextToken();
                        if (txt == 'text'){ dist = parser.getText();
                            my_list.add(dist);
                        }
                        
                    }
                }
                
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'html_instructions')){
                    parser.nextToken();  
                    String txt1 = parser.getText();
                    String changeText = txt1.replaceAll('<[^>]+>',' ');//replaceAll('<[/a-zAZ0-9]*>','');
                    html_list.add(changeText);
                }
                
            }
            if(my_list.size()>0){String removeDist = my_list.remove(0);
            }
            

            for(integer i =0; i <html_list.size(); i++){
                String routeData = html_list[i] + ':: ' + my_list[i];
                route_list.add(routeData);
            }
            finalRoute = String.join(new List<String>(route_list), '\n ');          
        }
        
        return finalRoute;
    }
}