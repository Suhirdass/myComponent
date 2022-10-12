global class Metrc_MockUIDHttpRespTest implements HttpCalloutMock {
    /**************************************************************************************
    Method name        : respond
    Version            : 1.0
    Created Date       : JAN 09 2019
    Function           : to generate response for PackageHttp request API  
    *******************************************************************************/
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"Status":"Success","Id":12345,"Label":"1GGG60300005F51000003345"}');
        system.assert(true);
        return res;
    }
}