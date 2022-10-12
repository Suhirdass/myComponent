global class BatchToUpdateLicenceRecords implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([select Default_Warehouse__r.License_ID__r.License_City__c,
                                              Default_Warehouse__r.License_ID__r.License_State__c, 
                                              Default_Warehouse__r.License_ID__r.License_Address__c,
                                              Default_Warehouse__r.License_ID__r.License_Country__c,
                                              Default_Warehouse__r.License_ID__r.License_Zip__c,License_Name__c, 
                                              License_City__c, License_Address__c, License_State__c, License_Country__c,Total_Miles__c, 
                                              License_Zip__c,License_Location__Latitude__s,License_Location__Longitude__s, Id FROM State_Licenses__c]);   
    }
    
    global void execute(Database.BatchableContext bc, List<State_Licenses__c> records){
        
        for(State_Licenses__c sl : records){
        	sl =  getMiles(sl); 
            sl =  getGeoCodes(sl); 
        }
		update records;       
    }
    
    private static State_Licenses__c getGeoCodes(State_Licenses__c sl){
        String url = Google_Distance_Matrix_API__c.getValues('Geocode_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'address=' +sl.License_Address__c +','+ sl.License_City__c +','+ sl.License_Country__c +','+ sl.License_State__c +','+ sl.License_Zip__c;
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
            sl.License_Location__Latitude__s = lat;
            sl.License_Location__Longitude__s = lon;
        }
        return sl;
    }
    
    private static State_Licenses__c getMiles(State_Licenses__c sl){
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + sl.Default_Warehouse__r.License_ID__r.License_Address__c +','+ sl.Default_Warehouse__r.License_ID__r.License_City__c +','+ sl.Default_Warehouse__r.License_ID__r.License_Country__c + ','+sl.Default_Warehouse__r.License_ID__r.License_State__c +','+ sl.Default_Warehouse__r.License_ID__r.License_Zip__c+ '&destinations=' + sl.License_Address__c +','+ sl.License_City__c +','+ sl.License_Country__c +','+ sl.License_State__c +','+ sl.License_Zip__c;
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
            StateLicenseTotalMilesTriggerHelper.DistanceResponse reponse = (StateLicenseTotalMilesTriggerHelper.DistanceResponse) JSON.deserialize(response.getBody(), StateLicenseTotalMilesTriggerHelper.DistanceResponse.class); 
            if(reponse != null && reponse.rows != null){
                if(reponse.rows[0].elements != null){
                    if(reponse.rows[0].elements[0].distance != null && reponse.rows[0].elements[0].distance.value != null){
                        distVal = reponse.rows[0].elements[0].distance.value;
                        distVal = distVal * 0.00062137;
                    }
                }
            }
            sl.Total_Miles__c =  distVal;
        }
        return sl;
    }
    
    global void finish(Database.BatchableContext bc){} 
}