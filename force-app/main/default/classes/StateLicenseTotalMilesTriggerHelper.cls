public class StateLicenseTotalMilesTriggerHelper {
   
    public static void passSLId(State_Licenses__c[] newList, Map<Id,State_Licenses__c> oldMap){
        if(TestUtilData.skipTrigger) return;
        Set<Id> staterecordIDs = new Set<Id>();
        for(State_Licenses__c b: newList){
            if(Trigger.isInsert || (Trigger.isUpdate && (b.License_Address__c!= oldMap.get(b.Id).License_Address__c || 
                                                         b.License_City__c != oldMap.get(b.Id).License_City__c ||
                                                         b.License_State__c  != oldMap.get(b.Id).License_State__c ||
                                                         b.License_Country__c  != oldMap.get(b.Id).License_Country__c ||
                                                         b.License_Zip__c  != oldMap.get(b.Id).License_Zip__c ||
                                                         b.Default_Warehouse__c != oldMap.get(b.Id).Default_Warehouse__c ))){
                staterecordIDs.add(b.Id);
            }
        }
        System.debug('###staterecordIDs::'+staterecordIDs);
        if(staterecordIDs.size() > 0){
            getMiles(staterecordIDs);
            getGeoCodes(staterecordIDs);    
        }
    }
    
    @future (callout=true)   
    public static void getGeoCodes(Set<Id> staterecordIDs){ 
        if(TestUtilData.skipTrigger) return;
       List<State_Licenses__c> stAddresses =[select License_Name__c, 
                                              License_City__c, License_Address__c, License_State__c, License_Country__c, 
                                              License_Zip__c,   id from State_Licenses__c where id IN : staterecordIDs];
        if(stAddresses.size() >0) {
            List<State_Licenses__c> lstState = new List<State_Licenses__c>();
            for(State_Licenses__c st : stAddresses){
                String url = Google_Distance_Matrix_API__c.getValues('Geocode_Endpoint').Value__c;
                String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
                String parameters = 'address=' +st.License_Address__c +','+ st.License_City__c +','+ st.License_Country__c +','+ st.License_State__c +','+ st.License_Zip__c;
                String param2 =  '&language=en&key=';
                parameters = parameters.replace(' ','%20');
                url = url+parameters+param2+apiKey;
                url = url.replaceAll('#', '%20');
                url += '&sensor=false';
                System.debug('After... '+url);
                
                HTTP http = new HTTP();
                HTTPRequest request = new HTTPRequest();
                request.setEndpoint(url);
                request.setMethod('GET');
                HTTPResponse response = http.send(request);
                system.debug('response.getStatusCode()'+response.getStatusCode());
                System.debug('Respons..'+response.getBody());
                if(response.getStatusCode() == 200) {
                    JSONParser parser = JSON.createParser(response.getBody());
                    double lat = null;
                    double lon = null;
                    while (parser.nextToken() != null) {
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'location')){
                            parser.nextToken(); // object start
                            while (parser.nextToken() != JSONToken.END_OBJECT){    
                                String txt = parser.getText();
                                parser.nextToken();
                                if (txt == 'lat')
                                    lat = parser.getDoubleValue();
                                else if (txt == 'lng')
                                    lon = parser.getDoubleValue();
                             }
                        }
                    }
                    System.debug('Lat Long = '+lat+' , '+lon);
                    lstState.add(new State_Licenses__c(Id = st.Id,License_Location__Latitude__s = lat,License_Location__Longitude__s = lon));
                }
            }
            if(lstState.size() > 0){
                update lstState;    
            }
        }
    }
    
    @future (callout=true)   
    public static void getMiles(Set<Id> staterecordIDs){ 
        if(TestUtilData.skipTrigger) return;
        List<State_Licenses__c> stAddresses =[select Default_Warehouse__r.License_ID__r.License_City__c,
                                              Default_Warehouse__r.License_ID__r.License_State__c, 
                                              Default_Warehouse__r.License_ID__r.License_Address__c,
                                              Default_Warehouse__r.License_ID__r.License_Country__c,
                                              Default_Warehouse__r.License_ID__r.License_Zip__c,License_Name__c, 
                                              License_City__c, License_Address__c, License_State__c, License_Country__c, 
                                              License_Zip__c,   id from State_Licenses__c where id IN : staterecordIDs];
        
        system.debug('stAddress size'+stAddresses.size());
        
        if(stAddresses.size() >0) {
            List<State_Licenses__c> lstState = new List<State_Licenses__c>();
            
            for(State_Licenses__c st : stAddresses){
                String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
                String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
                String parameters = 'origins=' + st.Default_Warehouse__r.License_ID__r.License_Address__c +','+ st.Default_Warehouse__r.License_ID__r.License_City__c +','+ st.Default_Warehouse__r.License_ID__r.License_Country__c + ','+st.Default_Warehouse__r.License_ID__r.License_State__c +','+ st.Default_Warehouse__r.License_ID__r.License_Zip__c+ '&destinations=' + st.License_Address__c +','+ st.License_City__c +','+ st.License_Country__c +','+ st.License_State__c +','+ st.License_Zip__c;
                String param2 =  '&language=en&key=';
                parameters = parameters.replace(' ','%20');
                url = url+parameters+param2+apiKey;
                url = url.replaceAll('#', '%20');
                System.debug('After... '+url);
                
                HTTP http = new HTTP();
                HTTPRequest request = new HTTPRequest();
                request.setEndpoint(url);
                request.setMethod('GET');
                HTTPResponse response = http.send(request);
                system.debug('response.getStatusCode()'+response.getStatusCode());
                System.debug('Respons..'+response.getBody());
                if(response.getStatusCode() == 200) {
                    double distVal = 0;
                    DistanceResponse reponse = (DistanceResponse) JSON.deserialize(response.getBody(), DistanceResponse.class); 
                    if(reponse != null && reponse.rows != null){
                        if(reponse.rows[0].elements != null){
                            distVal = reponse.rows[0].elements[0].distance.value;
                            distVal = distVal * 0.00062137;
                        }
                    }
                    
                    lstState.add(new State_Licenses__c(Id = st.Id,Total_Miles__c =  distVal));
                }
            }
            if(lstState.size() > 0){
                update lstState;    
            }
        }
        
    }
    public class DistanceResponse{
        public DistanceRow[] rows{set;get;}
    }
    public class DistanceRow{
        public DistanceElement[] elements{set;get;}
    }
    public class DistanceElement{
        public Distance distance{set;get;}
    }
    public class Distance{
        public String text{set;get;}
        public Decimal value{set;get;}
    }
    
    //validation for dulplicate LicenseNumber  particular LicenseName
    public static void duplicateLicenseNumCheck(State_Licenses__c[] slList){
        
        if(TestUtilData.skipTrigger) return;
        set <string> oldLicenseNum = new set<string>();
        set<id> LicenseNameids = new set <id>();
        set<string> LicenseNumberids = new set <string>();
        set<id> LicenseSLID = new set<id>();
        set<id> Recordtypeids = new set <id>();
        for(State_Licenses__c SLobj: slList){ 
            LicenseNameIds.add(SLobj.License_Name__c);
            RecordTypeIds.add(SLobj.RecordTypeId);
            LicenseNumberIds.add(SLobj.License_Number__c);
            LicenseSLID.add(SLobj.id);
            
        } 
        
        List <State_Licenses__c> StateLicenseLst =[SELECT id,name,RecordTypeId,License_Name__c,License_Name__r.Name,License_Number__c FROM State_Licenses__c 
                                                   WHERE License_Name__c =:LicenseNameIds AND RecordTypeId =:RecordtypeIds];
        
        for(State_Licenses__c SL: StateLicenseLst){ 
            oldLicenseNum.add(SL.License_Number__c);
            
        } 
        if(Trigger.isInsert)
        {
            for(State_Licenses__c StateLicenses :slList)
            {
                if(oldLicenseNum.contains(StateLicenses.License_Number__c))
                {
                    StateLicenses.addError('Duplicate record  found for License Number ' + StateLicenses.License_Number__c);  
                    break;
                }
            }
            
        }
        if(Trigger.isUpdate) 
        {
            List <State_Licenses__c> StateLicenseupdateLst =[SELECT id,name,License_Name__c,RecordTypeId,License_Name__r.Name,License_Number__c FROM State_Licenses__c 
                                                             WHERE License_Name__c =:LicenseNameIds AND License_Number__c =:LicenseNumberIds AND id !=: LicenseSLID AND RecordTypeId =:RecordtypeIds];  
            for(State_Licenses__c StateLicensesupdate :slList)
            {
                if(StateLicenseupdateLst.size() >= 1 )
                {
                    StateLicensesupdate.addError('Duplicate record' + StateLicensesupdate.Name +   ' found for License   Number ' +StateLicensesupdate.License_Number__c);  
                }
            }
            
        }
    }
    
}