/**********************************************************************************************************
Apex Class Name    : Metrc_HttpCallout
Test Class Name    : Metrc_HttpCalloutTest
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
Modification Log   : Used for calling the HTTP callouts to Heroku
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

public with sharing class Metrc_HttpCallout 
{
    public Http http;                        // Class for initiating an HTTP request and response
    public HttpRequest httpRequest;          // Class to create HTTP request requests like GET, POST, PUT, and DELETE.
    
    public Metrc_HttpCallout() 
    {
        http = new Http();
        httpRequest = new HttpRequest();
    }   
    
    
    public HttpResponse SendRequest(String action, String restEndpointURL, String requestPayload, Map<String,String> requestHeaders)
    {
        HttpResponse httpResponse;
        
        Metrc_HttpRequestHelper httpCalloutHelperObj = new Metrc_HttpRequestHelper();
        httpCalloutHelperObj.Headers = RequestHeaders;
        httpCalloutHelperObj.Endpoint = restEndpointURL; //UpsertAccountEndpoint; 
        httpCalloutHelperObj.Body = RequestPayload;
       
         if (action.equalsIgnoreCase('POST'))
            httpCalloutHelperObj.createHttpPostRequest(httpRequest);
        else if (action.equalsIgnoreCase('PUT'))
            httpCalloutHelperObj.createHttpPutRequest(httpRequest);
        else if (action.equalsIgnoreCase('GET'))
        httpCalloutHelperObj.createHttpGetRequest(httpRequest);
        else if (action.equalsIgnoreCase('DELETE'))
        httpCalloutHelperObj.createHttpDeleteRequest(httpRequest);

        
        try
        {
            httpResponse = http.Send(httpRequest);
        }
        catch(Exception e)
        {
            httpResponse = new HttpResponse();
            httpResponse.setStatusCode(500);
            httpResponse.setStatus(e.getMessage());
        }
        
        return httpResponse;
    }
    
}