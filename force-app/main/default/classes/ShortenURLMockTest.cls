@isTest
public class ShortenURLMockTest implements HttpCalloutMock {
    /**************************************************************************************
        Method name        : respond
        Version            : 1.0
        Created Date       : JAN 09 2019
        Function           : to generate response for bccStatelicenseHttp request API  
        *******************************************************************************/
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"link": "www.google.com"}');
        system.assert(true);
        return res;
    }
}