global class Metrc_MockUIDHttpResponseTest implements HttpCalloutMock {
    /**************************************************************************************
    Method name        : respond
    Version            : 1.0
    Created Date       : JAN 09 2019
    Function           : to generate response for prospectShortlistQuery  
    *******************************************************************************/
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        //res.setBody('[{"Status":"Success","Id":12345}]');
        res.setBody('{"Id": 2933156,"Name":"1A4FF0300000029000000085","Quantity":0,"LabTestingState":"NotSubmitted","FinishedDate":"2020-11-12"}');
        system.assert(true);
        return res;
    }
}