global class QuickBookConnection_MockTest implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/xml');
        res.setStatusCode(200);
      res.setBody('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><IntuitResponse xmlns="http://schema.intuit.com/finance/v3" time="2021-11-19T06:50:17.150-08:00"><Customer domain="QBO"sparse="false"><Id>186</Id><SyncToken>0</SyncToken><MetaData><CreateTime>2021-11-18T02:09:33-08:00</CreateTime><LastUpdatedTime>2021-11-18T02:09:33-08:00</LastUpdatedTime></MetaData><FullyQualifiedName>Patient 2 Patient Inc._c</FullyQualifiedName><CompanyName>Patient 2 Patient Inc.</CompanyName><DisplayName>Patient 2 Patient Inc._c</DisplayName><PrintOnCheckName>Patient 2 Patient Inc.</PrintOnCheckName><Active>true</Active><PrimaryPhone><FreeFormNumber>7149480880</FreeFormNumber></PrimaryPhone><DefaultTaxCodeRef>2</DefaultTaxCodeRef><Taxable>true</Taxable><BillAddr><Id>274</Id><Line1>Woven Trail</Line1><City>Lewisville</City><Country>United States</Country><CountrySubDivisionCode>TX</CountrySubDivisionCode><PostalCode>75067</PostalCode></BillAddr><Job>false</Job><BillWithParent>false</BillWithParent><Balance>0</Balance><BalanceWithJobs>0</BalanceWithJobs><CurrencyRef name="United States Dollar">USD</CurrencyRef><PreferredDeliveryMethod>Print</PreferredDeliveryMethod><IsProject>false</IsProject></Customer></IntuitResponse>');
        system.assert(true);
       return res;
  }
}