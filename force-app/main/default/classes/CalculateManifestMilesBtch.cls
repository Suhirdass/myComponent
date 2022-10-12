global class CalculateManifestMilesBtch implements Database.batchable<Shipping_Manifest__c>,Database.AllowsCallouts{
    public List<Shipping_Manifest__c> manifestList;
    public CalculateManifestMilesBtch(List<Shipping_Manifest__c> manifestList){
        this.manifestList = manifestList;
    }
    global Iterable<Shipping_Manifest__c> start(Database.BatchableContext info){
        return new List<Shipping_Manifest__c>(manifestList);
    }
    global void execute(Database.BatchableContext info, List<Shipping_Manifest__c> scope){
        List<Shipping_Manifest__c> toUpdate = new List<Shipping_Manifest__c>();
        for(Shipping_Manifest__c obj : scope){
            if(String.isNotBlank(obj.Receiver_Address__c) &&
               String.isNotBlank(obj.Receiver_City_State_Zip__c)){
                   String origin = '';
                   String destination = obj.Receiver_Address__c +','+obj.Receiver_City_State_Zip__c;
                   if(obj.RecordType.DeveloperName == 'Product_TSM' && 
                      String.isNotBlank(obj.Supplier_Address__c) &&
                      String.isNotBlank(obj.Supplier_City_State_Zip__c)){
                          origin = obj.Supplier_Address__c +','+obj.Supplier_City_State_Zip__c;
                      }else if(String.isNotBlank(obj.Distributor_Address__c) &&
                               String.isNotBlank(obj.Distributor_City_State_Zip__c)){
                                   origin = obj.Distributor_Address__c +','+obj.Distributor_City_State_Zip__c;
                               }
                   if(String.isNotBlank(origin) && String.isNotBlank(destination)){
                       Map<String,String> result = getDistance(origin,destination);
                       if(result.get('status') == 'OK'){
                           Decimal distance = Decimal.valueOf(result.get('distance'));
                           obj.Total_Route_Miles__c  = distance;
                           obj.Geocode_Error__c  = '';
                       }else{
                           obj.Total_Route_Miles__c  = null;
                           obj.Geocode_Error__c  = result.get('status');
                       }
                       toUpdate.add(obj);
                   }
                   
               }
        }
        update toUpdate;
    }
    
    global void finish(Database.BatchableContext info){
        
    }
    
    public static Map<String,String> getDistance(String origin, String destination){
        Map<String,String> finalRequestResult = new Map<String,String>();
        String url = 'https://maps.googleapis.com/maps/api/directions/json?';
        url += 'origin=' + EncodingUtil.urlEncode(origin,'UTF-8')+'&destination='+EncodingUtil.urlEncode(destination,'UTF-8');
        url += '&key='+Label.Google_Map_API_Key;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Content-type', 'application/x-www-form-urlencoded'); 
        request.setHeader('Content-length', '0');
        HttpResponse response = http.send(request);
        try{
            CalculateDistanceManifest c = CalculateDistanceManifest.parse(response.getBody());
            if(c.status == 'OK'){
                List<CalculateDistanceManifest.cls_routes> routes = c.routes;
                List<CalculateDistanceManifest.cls_legs> legs = routes[0].legs;
                List<String> tempDis = legs[0].distance.text.split(' ');
                finalRequestResult.put('distance', tempDis[0]);
                finalRequestResult.put('status', 'OK');
            }else{
                finalRequestResult.put('status', c.status);
            }
        }catch(Exception ex){
            finalRequestResult.put('status', ex.getMessage());
        }
        return finalRequestResult; 
        
        
    }
}