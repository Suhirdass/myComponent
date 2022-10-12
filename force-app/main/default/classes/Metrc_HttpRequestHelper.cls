/**********************************************************************************************************
Apex Class Name    : Metrc_HttpRequestHelper
Test Class Name    : Metrc_HttpRequestHelperTest
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
Modification Log   : Used for calling the HTTP callouts to Metrc
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/
public with sharing class Metrc_HttpRequestHelper 
{
    private Integer requestTimeout = 50000;               // Timeout in milliseconds for the request
    private String endpointURL ;
    private String requestBody;
    private Map<String, String> requestHeaders=null;
    
    public Integer Timeout
    {
        get { return requestTimeout ; }
        set { requestTimeout = value; }
    }
    
    public String Endpoint 
    {
        get { return endpointURL; }
        set { endpointURL = value; }
    }
    
    public String Body
    {
        get { return requestBody; }
        set { requestBody = value; }
    }
    
    public Map<String, String> Headers
    {
        get { return requestHeaders; }
        set { requestHeaders = value; }
    }
    
    /**************************************************************************************
    Method Name        : setRequestHeaders  
    Version            : 1.0
    Function           : to set RequestHeaders for HttpRequest
    *******************************************************************************/
    public void setRequestHeaders(HttpRequest pHttpRequest)
    {

         if(requestHeaders !=null){
            for(String headerKey :requestHeaders.keySet())
            {
                pHttpRequest.setHeader(headerKey, requestHeaders.get(headerKey));
            }       
        }

    }
    
    
    /**************************************************************************************
    Method Name        : createHttpPostRequest  
    Version            : 1.0
    Function           : POST request creation
    *******************************************************************************/   
    public  void createHttpPostRequest(HttpRequest pHttpRequest)   
    {

            String post='POST';
            pHttpRequest.setTimeout(requestTimeout);
            pHttpRequest.setEndpoint(endpointURL);
            SetRequestHeaders(pHttpRequest);
            pHttpRequest.setMethod(post);
            pHttpRequest.setBody(requestBody);            

    }
    
    
    /**************************************************************************************
    Method Name        : createHttpGetRequest  
    Version            : 1.0
    Function           : GET request creation
    *******************************************************************************/
    public  void createHttpGetRequest(HttpRequest pHttpRequest)
    {

            String get='GET';
            pHttpRequest.setTimeout(requestTimeout);
            pHttpRequest.setEndpoint(endpointURL);
            SetRequestHeaders(pHttpRequest);
            pHttpRequest.setMethod(get);
            //pHttpRequest.setBody(requestBody);

    }
    
    /**************************************************************************************
    Method Name        : createHttpGetRequest  
    Version            : 1.0
    Function           : PUT request creation
    *******************************************************************************/
    public  void createHttpPutRequest(HttpRequest pHttpRequest)
    {

            String put='PUT';
            pHttpRequest.setTimeout(requestTimeout);
            pHttpRequest.setEndpoint(endpointURL);
            SetRequestHeaders(pHttpRequest);
            pHttpRequest.setMethod(put);
            pHttpRequest.setBody(requestBody);

    }
     /**************************************************************************************
    Method Name        : createHttpGetRequest  
    Version            : 1.0
    Function           : GET request creation
    *******************************************************************************/
    public  void createHttpDeleteRequest(HttpRequest pHttpRequest)
    {

            String get='DELETE';
            pHttpRequest.setTimeout(requestTimeout);
            pHttpRequest.setEndpoint(endpointURL);
            SetRequestHeaders(pHttpRequest);
            pHttpRequest.setMethod(get);
            //pHttpRequest.setBody(requestBody);

    }
}