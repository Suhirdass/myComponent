@isTest
public class CalculateManifestMilesMockResponse implements HttpCalloutMock {
	public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String responseBody = '{"routes":[{"legs":[{"distance":{"text":"6.2 mi","value":9948}}]}],"status":"OK"}';
        res.setBody(responseBody);
        res.setStatusCode(200);
        res.setStatus('OK');
        return res;
    }
}