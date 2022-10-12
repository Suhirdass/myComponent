@isTest
global class StateLicense_MockResponseTest implements HttpCalloutMock  {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{ "destination_addresses" : [ "46800 Winema Common, Fremont, CA 94539, USA" ], "origin_addresses" : [ "7027 Eton Ave, Canoga Park, CA 91303, USA" ],   "rows" : [      {         "elements" : [            {               "distance" : {                  "text" : "342 mi",                  "value" : 550482               },               "duration" : {                  "text" : "5 hours 24 mins",                  "value" : 19440               },               "status" : "OK"            }         ]      }   ],   "status" : "OK"}');
        system.assert(true);
        return res;
    }
}