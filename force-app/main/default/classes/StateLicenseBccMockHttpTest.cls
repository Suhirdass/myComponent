global class StateLicenseBccMockHttpTest implements HttpCalloutMock {
    /**************************************************************************************
    Method name        : respond
    Version            : 1.0
    Created Date       : JAN 09 2019
    Function           : to generate response for bccStatelicenseHttp request API  
    *******************************************************************************/
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('[{"licenseNumber": "CEO14-0000115-LIC","licenseType": "Cannabis - Event Organizer License","issuedDate": "12/20/2019","addressLine1": "","addressLine2": "","premiseCity": "OAKLAND","premiseState": "CA","premiseZip": "94608","premiseCounty": "ALAMEDA","licenseStatus": "Expired","businessStructure": "null","medicinal": "NO","adultUse": "NO","expiryDate": "12/19/2020","businessName": "AMENTA SYSTEMS RESEARCH AND DEVELOPMENT LLC","businessDBA": "","businessOwner": "Ronald Poole","website": "www.teststatelicense.com", "phone": "4478903032", "email": "test@gmail.state.com"}]');
        system.assert(true);
        return res;
    }
}