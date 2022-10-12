global class BatchStateLicenseToTotalMiles implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    Set<Id> staterecordIDs = new Set<Id>();
    
    global BatchStateLicenseToTotalMiles(){  
    }
    
	global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Default_Warehouse__r.License_ID__r.License_City__c, ' +
            'Default_Warehouse__r.License_ID__r.License_State__c, ' +
            'Default_Warehouse__r.License_ID__r.License_Address__c, ' + 
            'Default_Warehouse__r.License_ID__r.License_Country__c, ' + 
            'Default_Warehouse__r.License_ID__r.License_Zip__c,License_Name__c, ' + 
            'License_City__c, License_Address__c, License_State__c, License_Country__c, ' + 
            'License_Zip__c,id from State_Licenses__c ' + 
            'WHERE Default_Warehouse__c != NULL AND Total_Miles__c = NULL'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<State_Licenses__c> stAddresses){
        if(stAddresses.size() > 0) {
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
                        if(reponse.rows[0].elements != null && reponse.rows[0].elements[0].distance != null){
                            distVal = reponse.rows[0].elements[0].distance.value;
                            distVal = distVal * 0.00062137;
                            lstState.add(new State_Licenses__c(Id = st.Id,Total_Miles__c =  distVal));
                        }
                    }
                    
                    
                }
            }
            if(lstState.size() > 0){
                update lstState;    
            }
        }
    } 
    
    global void finish(Database.BatchableContext bc){} 
    
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
}