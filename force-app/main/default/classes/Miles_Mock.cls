global class Miles_Mock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"destination_addresses" : [ "770 Edgewater Dr #149, Oakland, CA 94621, USA" ],"origin_addresses" : [ "7027 Eton Ave, Canoga Park, CA 91303, USA" ],"rows" : [{"elements" : [{"distance" : {"text" : "574 km","value" : 574268},"duration" : {"text" : "5 hours 31 mins","value" : 19882},"status" : "OK"}]}],"status" : "OK"}');
        system.assert(true);
        return res;
    }
	
}