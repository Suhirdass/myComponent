@isTest
/**********************************************************************************************************
Apex TestClass Name    : Metrc_MockHttpGetAllProductBatchTest 
Apex Class Name    : Metrc_Http**
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/
global class Metrc_MockHttpGetAllProductBatchTest implements HttpCalloutMock {
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
        res.setBody('[ {"Id": 355319,"Name": "TestMetrc1-updated","ProductCategoryName": "Pre-Roll Flower","UnitOfMeasureName": "Each","StrainId": 207092,"StrainName": "Garry","UnitVolume": null,"UnitVolumeUnitOfMeasureName": null,"UnitWeight": 1.0000,"UnitWeightUnitOfMeasureName": "Pounds","UnitQuantity": null,"UnitQuantityUnitOfMeasureName": null}]');
        system.assert(true);
        return res;
    }
}