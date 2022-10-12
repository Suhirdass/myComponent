/********************************************************************
* Project           : Filigreen
*
* Apex name         : QuickBookConncetion.apxc
* 
* Test Class name   : QuickBookConncetionTest.apxc,QuickBookConnection_MockTest
*
* Author            : saranya
*
* Date created      : 12/01/2021
*
* Purpose           :  push data from SF to QB  
**********************************************************************/
public class QuickBookConncetion {
   private static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
     private static String PRODUCT_RECORD_TYPE_NAME_SERVICE{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_SERVICE) ? PRODUCT_RECORD_TYPE_NAME_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Services');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_DISCOUNTS{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNTS) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    } 
    private static String QUICKBOOK_RECORD_TYPE_NAME_SERVICE{
        get{
            return String.isNotBlank(QUICKBOOK_RECORD_TYPE_NAME_SERVICE) ? QUICKBOOK_RECORD_TYPE_NAME_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QuickBook_Record_Type_Service');
        }set;
    }
    private static String QUICKBOOK_RECORD_TYPE_NAME_INVENTORY{
        get{
            return String.isNotBlank(QUICKBOOK_RECORD_TYPE_NAME_INVENTORY) ? QUICKBOOK_RECORD_TYPE_NAME_INVENTORY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QuickBook_Record_Type_Inventory');
        }set;
    }
    private static String QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY{
        get{
            return String.isNotBlank(QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY) ? QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QuickBook_Record_Type_NonInventory');
        }set;
    }
     private static String QUICKBOOK_PRODUCT_WITH_IDS_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_PRODUCT_WITH_IDS_ENDPOINTS) ? QUICKBOOK_PRODUCT_WITH_IDS_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_Product_Withids_SetEndPoint_URL');
        }set;
    }
     private static String QUICKBOOK_PRODUCT_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_PRODUCT_ENDPOINTS) ? QUICKBOOK_PRODUCT_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_Product_SetEndPoint_URL');
        }set;
    }
    private static String QUICKBOOK_CUSTOMER_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_CUSTOMER_ENDPOINTS) ? QUICKBOOK_CUSTOMER_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','QB_Customer_SetEndPoint_URL');
        }set;
    }
     private static String QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS) ? QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','QB_customer_Withids_SetEndPoint_URL');
        }set;
    }
     private static String QUICKBOOK_VENDOR_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_VENDOR_ENDPOINTS) ? QUICKBOOK_VENDOR_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','QB_Vendor_SetEndPoint_URL');
        }set;
    }
     private static String QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS) ? QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','QB_Vendor_Withids_SetEndPoint_URL');
        }set;
    }
     private static String ERROR_MSG_MISSING_BILLING_ADDRESS{
        get{
            return String.isNotBlank(ERROR_MSG_MISSING_BILLING_ADDRESS) ? ERROR_MSG_MISSING_BILLING_ADDRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Err_Msg_Missing_Billing_Address');
        }set;
    }
    private static String ERROR_MSG_QB_INACTIVE{
        get{
            return String.isNotBlank(ERROR_MSG_QB_INACTIVE) ? ERROR_MSG_QB_INACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Err_Msg_QB_Inactive');
        }set;
    }
    private static String ERROR_MSG_PRICEBOOK_INACTIVE{
        get{
            return String.isNotBlank(ERROR_MSG_PRICEBOOK_INACTIVE) ? ERROR_MSG_PRICEBOOK_INACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Err_Msg_Pricebook_Inactive');
        }set;
    }
      private static String QUICKBOOK_INCOMEACCOUNTREF_NAME{
        get{
            return String.isNotBlank(QUICKBOOK_INCOMEACCOUNTREF_NAME) ? QUICKBOOK_INCOMEACCOUNTREF_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_IncomeAccountref_Name');
        }set;
    }
     private static String QUICKBOOK_INCOMEACCOUNTREF_VALUES{
        get{
            return String.isNotBlank(QUICKBOOK_INCOMEACCOUNTREF_VALUES) ? QUICKBOOK_INCOMEACCOUNTREF_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_IncomeAccountref_Values');
        }set;
    }
    private static String QUICKBOOK_ASSETACCOUNTREF_NAME{
        get{
            return String.isNotBlank(QUICKBOOK_ASSETACCOUNTREF_NAME) ? QUICKBOOK_ASSETACCOUNTREF_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_AssetAccountRef_Name');
        }set;
    }
     private static String QUICKBOOK_ASSETACCOUNTREF_VALUES{
        get{
            return String.isNotBlank(QUICKBOOK_ASSETACCOUNTREF_VALUES) ? QUICKBOOK_ASSETACCOUNTREF_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_AssetAccountRef_Values');
        }set;
    }
    private static String QUICKBOOK_EXPENSEACCOUNTREF_NAME{
        get{
            return String.isNotBlank(QUICKBOOK_EXPENSEACCOUNTREF_NAME) ? QUICKBOOK_EXPENSEACCOUNTREF_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_ExpenseAccountRef_Name');
        }set;
    }
     private static String QUICKBOOK_EXPENSEACCOUNTREF_VALUES{
        get{
            return String.isNotBlank(QUICKBOOK_EXPENSEACCOUNTREF_VALUES) ? QUICKBOOK_EXPENSEACCOUNTREF_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','QB_ExpenseAccountRef_Values');
        }set;
    }
    
        private static String QUICKBOOK_CHARTACCOUNT_ENDPOINTS{
        get{
            return String.isNotBlank(QUICKBOOK_CHARTACCOUNT_ENDPOINTS) ? QUICKBOOK_CHARTACCOUNT_ENDPOINTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Chart_of_Account__c','QB_ChartofAccount_SetEndPoint_URL');
        }set;
    }

    private static String QB_CHARTACCOUNT_WITHIDS_ENDPOINT{
        get{
            return String.isNotBlank(QB_CHARTACCOUNT_WITHIDS_ENDPOINT) ? QB_CHARTACCOUNT_WITHIDS_ENDPOINT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Chart_of_Account__c','QB_chartAccount_Withids_SetEndPoint_URL');
        }set;
    }

    private static String ERR_MSG_MISSING_CHARTACCOUNT_NAME{
        get{
            return String.isNotBlank(ERR_MSG_MISSING_CHARTACCOUNT_NAME) ? ERR_MSG_MISSING_CHARTACCOUNT_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Chart_of_Account__c','Err_Msg_Missing_ChartAccount_Name');
        }set;
    }
	
	private static String ERR_MSG_QB_INACTIVE_CHARTACCOUNT{
        get{
            return String.isNotBlank(ERR_MSG_QB_INACTIVE_CHARTACCOUNT) ? ERR_MSG_QB_INACTIVE_CHARTACCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Chart_of_Account__c','Err_Msg_QB_Inactive_for_ChartAccount');
        }set;
    }
    
    /*
     *  This method push SF Account Records to QB As Customer   * */
   
    @AuraEnabled  
    public static AuraResponse  SyncAccountWithQuickBooksCutomer(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncAccountWithQuickBooksCutomer()');
        string status;
        Account  accObj = [select id, name,DBA__c,QB_Customer_ID__c,Phone,BillingCity,BillingStreet,BillingCountry,BillingState,BillingPostalCode from Account where id =:recordId];
        if(accObj.QB_Customer_ID__c == null )
        {
            if( accObj.BillingCity != null && accObj.BillingCountry != null && accObj.BillingPostalCode != null && accObj.BillingStreet !=null)
            {
                String requestjson ='';
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();	
                gen.writeStringField('DisplayName',accObj.Name +'_c');
                gen.writeStringField('CompanyName',accObj.DBA__c);
                gen.writeFieldName('PrimaryPhone');
                gen.writeStartObject();
                gen.writeStringField('FreeFormNumber',accObj.Phone);
                gen.writeEndObject();
                gen.writeFieldName('BillAddr');
                gen.writeStartObject();
                gen.writeStringField('Line1',accObj.BillingStreet);
                gen.writeStringField('City',accObj.BillingCity);
                gen.writeStringField('Country',accObj.BillingCountry);
                gen.writeStringField('PostalCode',accObj.BillingPostalCode);
                gen.writeStringField('CountrySubDivisionCode',accObj.BillingState); 
                gen.writeEndObject();
                gen.writeEndObject();
                requestjson = gen.getAsString();
                String requestPayload= requestjson;
                HttpRequest req = new HttpRequest();
                req.setEndpoint(QUICKBOOK_CUSTOMER_ENDPOINTS);
                req.setMethod('POST');
                req.setHeader('Content-Type','application/json');
                req.setBody(requestPayload);
                Http http = new Http();
                HttpResponse res = http.send(req);
                String response = res.getBody();
                Dom.Document doc = new Dom.Document();  
                doc.load(response);  
                List<Account> updateacc = new  List<Account>();
                Dom.XMLNode rootElement = doc.getRootElement();  
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName() == 'Id')
                    {
                        integer Ids = integer.valueOf(detailElement.getText());
                        Account ACC = new Account();
                        ACC.Id = recordId;
                        ACC.QB_Customer_ID__c =Ids;
                        updateacc.add(ACC);
                    }
                }  
                update updateacc;
                if(res.getstatuscode() == 200){
                    status ='Sucess';
                }else{
                    system.debug('error'+res);
                }  
            }else{
                r.data.put('message', ERROR_MSG_MISSING_BILLING_ADDRESS);    
                return r;
            }
        }else{
            Decimal  custid = accObj.QB_Customer_ID__c; 
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(custid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true')
            {
                if( accObj.BillingCity != null && accObj.BillingCountry != null && accObj.BillingPostalCode != null && accObj.BillingStreet !=null && accObj.BillingState !=null)
                {
                    String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    gen.writeStringField('DisplayName',accObj.Name+'_c');
                    gen.writeStringField('CompanyName',accObj.DBA__c);
                    gen.writeStringField('sparse','true');
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
                    gen.writeFieldName('PrimaryPhone');
                    gen.writeStartObject();
                    gen.writeStringField('FreeFormNumber',accObj.Phone);
                    gen.writeEndObject();
                    gen.writeFieldName('BillAddr');
                    gen.writeStartObject();
                    gen.writeStringField('Line1',accObj.BillingStreet);
                    gen.writeStringField('City',accObj.BillingCity);
                    gen.writeStringField('Country',accObj.BillingCountry);
                    gen.writeStringField('PostalCode',accObj.BillingPostalCode);
                    gen.writeStringField('CountrySubDivisionCode',accObj.BillingState);  
                    gen.writeEndObject();
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_CUSTOMER_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
                }else{
                    r.data.put('message', ERROR_MSG_MISSING_BILLING_ADDRESS);    
                    return r;    
                }
            }else{
                r.data.put('message', ERROR_MSG_QB_INACTIVE);    
                return r;     
            }       
        }
        return r;
    }   
     @AuraEnabled 
    public static AuraResponse checkRecordsContact(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncProductsWithQuickBooksdoint()');
        string status;
 Contact  ConObj = [select id ,FirstName,LastName,Account.Name,Account.QB_Customer_ID__c, Account.QB_VendorId__c, Email,  Salutation from contact   where id =:recordId];
        if(ConObj.Account.QB_Customer_ID__c != null)
        {
         Decimal  custid = ConObj.Account.QB_Customer_ID__c; 
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(custid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
              string Fname;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement>'+detailElement);
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                    if(detailElement.getName() == 'FamilyName')
                    {
                        Fname= detailElement.getText();  
                    }
				system.debug('Fname'+Fname);                     
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true' &&  Fname != Null)
            {
              r.data.put('messageactive',true);    
            return r;   
            }
           /* if( Fname != ConObj.LastName){
              r.data.put('messageactive',true);    
            return r;     
            }if( Fname == null){
              r.data.put('messagenew',true);    
            return r;     
            }*/
           
        }
            
        if(ConObj.Account.QB_VendorId__c != null)
        {
         Decimal  vendorid = ConObj.Account.QB_VendorId__c; 
            HttpRequest reqe = new HttpRequest();
 String Endpoints = String.format(QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(vendorid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
              string Fname;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement>'+detailElement);
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                    if(detailElement.getName() == 'FamilyName')
                    {
                        Fname= detailElement.getText();  
                    }
				system.debug('Fname'+Fname);                     
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true' &&  Fname != Null)
            {
              r.data.put('messageactive',true);    
            return r;   
            }
           
        }
              
        return r;
    }
     @AuraEnabled  
    public static AuraResponse  SyncAccountWithQuickBooksContact(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncAccountWithQuickBooksCutomer()');
        string status;
        Contact  ConObj = [select id ,FirstName,LastName,Account.Name,Account.QB_Customer_ID__c, Account.QB_VendorId__c, Email,  Salutation from contact   where id =:recordId];
          Decimal  vendorid = ConObj.Account.QB_VendorId__c; 
              Decimal  custid = ConObj.Account.QB_Customer_ID__c; 
        if(ConObj.Account.QB_Customer_ID__c == null && ConObj.Account.QB_VendorId__c== null )
        {
         r.data.put('NullQBIds',false);    
            return r;     
        }else{
           
            if(custid != null)
            {
                system.debug('custid');
              HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(custid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
              string Fname;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement>'+detailElement);
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                    if(detailElement.getName() == 'FamilyName')
                    {
                        Fname= detailElement.getText();  
                    }
				system.debug('Fname'+Fname);                     
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true' &&  (Fname == ConObj.LastName || Fname == null || Fname != null) )
            {
               if( ConObj.Salutation != null && ConObj.FirstName != null && ConObj.LastName != null && ConObj.Email !=null)
               { 

                    String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    //gen.writeStringField('MiddleName',ConObj.);
                   gen.writeStringField('Title',ConObj.Salutation);
                  gen.writeStringField('GivenName',ConObj.FirstName);
                  gen.writeStringField('FamilyName',ConObj.LastName);
                  gen.writeStringField('sparse','true');
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
                  gen.writeFieldName('PrimaryEmailAddr');
                    gen.writeStartObject();
                    gen.writeStringField('Address',ConObj.Email);
                    gen.writeEndObject();
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_CUSTOMER_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
               }else{
                   system.debug('else>>>>>>>>>>>>');
                  r.data.put('message', 'values missing in Salutation,FirstName,Email');    
                    return r;      
                   
               }
       
      
            }   
            } 
            if (vendorid != null)
            {
                system.debug('vendorid?????');
           //  Decimal  vendorid = ConObj.Account.QB_VendorId__c; 
            HttpRequest reqe = new HttpRequest();
             String Endpoints = String.format(QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(vendorid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
              string Fname;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement>'+detailElement);
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                    if(detailElement.getName() == 'FamilyName')
                    {
                        Fname= detailElement.getText();  
                    }
				system.debug('Fname'+Fname);                     
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true' &&  (Fname == ConObj.LastName || Fname == null || Fname != null) )
            {
               if( ConObj.Salutation != null && ConObj.FirstName != null && ConObj.LastName != null && ConObj.Email !=null)
               { 

                    String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    //gen.writeStringField('MiddleName',ConObj.);
                   gen.writeStringField('Title',ConObj.Salutation);
                  gen.writeStringField('GivenName',ConObj.FirstName);
                  gen.writeStringField('FamilyName',ConObj.LastName);
                  gen.writeStringField('sparse','true');
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
                  gen.writeFieldName('PrimaryEmailAddr');
                    gen.writeStartObject();
                    gen.writeStringField('Address',ConObj.Email);
                    gen.writeEndObject();
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_VENDOR_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
               }else{
                   system.debug('else>>>>>>>>>>>>');
                  r.data.put('message', 'values missing in Salutation,FirstName,Email');    
                    return r;      
                   
               }
            }
    
            }
           
            /*else{
             r.data.put('ExistingCon', True);    
                    return r;    
            }*/
            
        }
         return r;
    }
    @AuraEnabled  
    public static AuraResponse  SyncAccountWithQuickBooksvendorContact(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncAccountWithQuickBooksCutomer()');
        string status;
        Contact  ConObj = [select id ,FirstName,LastName,Account.Name,Account.QB_Customer_ID__c, Account.QB_VendorId__c, Email,  Salutation from contact   where id =:recordId];
        if(ConObj.Account.QB_VendorId__c == null)
        {
         r.data.put('NullQBIds',false);    
            return r;     
        }else{
              Decimal  vendorid = ConObj.Account.QB_VendorId__c; 
            HttpRequest reqe = new HttpRequest();
             String Endpoints = String.format(QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(vendorid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
              string Fname;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement>'+detailElement);
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                    if(detailElement.getName() == 'FamilyName')
                    {
                        Fname= detailElement.getText();  
                    }
				system.debug('Fname'+Fname);                     
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            }  
            if(activestatus == 'true' &&  (Fname == ConObj.LastName || Fname == null || Fname != null) )
            {
                if( ConObj.Salutation != null && ConObj.FirstName != null && ConObj.LastName != null && ConObj.Email !=null)
                { 
                    
                    String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    gen.writeStringField('Title',ConObj.Salutation);
                    gen.writeStringField('GivenName',ConObj.FirstName);
                    gen.writeStringField('FamilyName',ConObj.LastName);
                    gen.writeStringField('sparse','true');
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
                    gen.writeFieldName('PrimaryEmailAddr');
                    gen.writeStartObject();
                    gen.writeStringField('Address',ConObj.Email);
                    gen.writeEndObject();
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_VENDOR_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
                }else{
                    system.debug('else>>>>>>>>>>>>');
                    r.data.put('message', 'values missing in Salutation,FirstName,Email');    
                    return r;      
                    
                }
       
      
            }
           
            
        }
         return r;
    }
 /*
     *  This method push SF Account Records to QB As vendor 
     * 
     * 
     * */
    @AuraEnabled  
    public static AuraResponse  SyncAccountWithQuickBooksVendor(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncAccountWithQuickBooksVendor()');
        string status;
        Account  accObj = [select id, name,DBA__c,Phone,QB_Customer_ID__c,QB_VendorId__c,BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode from Account where id =:recordId];
        if(accObj.QB_VendorId__c == null)
        {
            if( accObj.BillingCity != null && accObj.BillingCountry != null && accObj.BillingPostalCode != null && accObj.BillingStreet !=null && accObj.BillingState !=null)
            {
                String requestjson ='';
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();	
                gen.writeStringField('DisplayName',accObj.name);
                gen.writeStringField('CompanyName',accObj.DBA__c);
                gen.writeFieldName('PrimaryPhone');
                gen.writeStartObject();
                gen.writeStringField('FreeFormNumber',accObj.Phone);
                gen.writeEndObject();
                gen.writeFieldName('BillAddr');
                gen.writeStartObject();
                gen.writeStringField('City',accObj.BillingCity);
                gen.writeStringField('Line1',accObj.BillingStreet);
                gen.writeStringField('Country',accObj.BillingCountry);
                gen.writeStringField('PostalCode',accObj.BillingPostalCode);
                gen.writeStringField('CountrySubDivisionCode',accObj.BillingState);  
                gen.writeEndObject();
                gen.writeEndObject();
                requestjson = gen.getAsString();
                String requestPayload= requestjson;
                HttpRequest req = new HttpRequest();
                req.setEndpoint(QUICKBOOK_VENDOR_ENDPOINTS);
                req.setMethod('POST');
                req.setHeader('Content-Type','application/json');
                req.setBody(requestPayload);
                Http http = new Http();
                HttpResponse res = http.send(req);
                String response = res.getBody();
                Dom.Document doc = new Dom.Document();  
                doc.load(response);  
                Dom.XMLNode rootElement = doc.getRootElement();  
                List<Account> updateacc = new  List<Account>();
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName() == 'Id')
                    {
                        integer Ids = integer.valueOf(detailElement.getText());
                        Account ACC = new Account();
                        ACC.Id = recordId;
                        ACC.QB_VendorId__c =Ids;
                        updateacc.add(ACC);
                    }
                }  
                update updateacc;
                if(res.getstatuscode() == 200){
                    system.debug('sucess'+res);  
                }else{
                    system.debug('error'+res);
                }    
            }else{
                r.data.put('message', ERROR_MSG_MISSING_BILLING_ADDRESS);    
                return r;
            }   
        }else{
            Decimal  vendorid = accObj.QB_VendorId__c; 
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QUICKBOOK_VENDOR_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(vendorid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus ;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                        
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Sucess';
            }else{
                system.debug('error'+ress);
            } 
            if(activestatus == 'true')
            {
                if( accObj.BillingCity != null && accObj.BillingCountry != null && accObj.BillingPostalCode != null && accObj.BillingStreet !=null && accObj.BillingState !=null)
                {
                    String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    gen.writeStringField('DisplayName',accObj.Name);
                    gen.writeStringField('CompanyName',accObj.DBA__c);
                    gen.writeStringField('sparse','true');
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
                    gen.writeFieldName('PrimaryPhone');
                    gen.writeStartObject();
                    gen.writeStringField('FreeFormNumber',accObj.Phone);
                    gen.writeEndObject();
                    gen.writeFieldName('BillAddr');
                    gen.writeStartObject();
                    gen.writeStringField('City',accObj.BillingCity);
                    gen.writeStringField('Line1',accObj.BillingStreet);
                    gen.writeStringField('Country',accObj.BillingCountry); 
                    gen.writeStringField('PostalCode',accObj.BillingPostalCode);
                    gen.writeStringField('CountrySubDivisionCode',accObj.BillingState);  
                    gen.writeEndObject();
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_VENDOR_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
                    if(ress.getstatuscode() == 200){
                        system.debug('sucess'+ress);  
                    }else{
                        system.debug('error'+ress);
                    }  
                }else{
                    r.data.put('message', ERROR_MSG_MISSING_BILLING_ADDRESS);    
                    return r;    
                } }else{
                    r.data.put('message', ERROR_MSG_QB_INACTIVE);    
                    return r;     
                }        
        }
        r.data.put('status',status);  
        return r;
    }  
    /** checking Product is Active Or not if not showing validation **/

     @AuraEnabled 
    public static AuraResponse checkRecordsActive(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncProductsWithQuickBooksdoint()');
        Product2  proObj = [select id, name,Available_Inventory__c,QB_Id__c,IsActive,Apply_Excise_Tax__c,RecordType.name, Available_Qty__c, Family,RecordTypeId, LastReferencedDate from Product2  where id =:recordId];
        if(proObj.IsActive == false){
            r.data.put('messageactive',true);    
            return r;      
        }
        return r;
    }
    
     /** Push Sf product records to push into QB  **/
   @AuraEnabled
    public static AuraResponse SyncProductsWithQuickBooks(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncProductsWithQuickBooks()');
        String responseMessage = '';
        Product2  proObj = [select id, name,Available_Inventory__c,QB_Id__c,IsActive,Apply_Excise_Tax__c,RecordType.name, Available_Qty__c, Family,RecordTypeId, LastReferencedDate from Product2  where id =:recordId];
        Id proid= proObj.id; 
        List<PricebookEntry> Pbs =[select id , name,Product2Id ,IsActive,Pricebook2.Name ,UnitPrice from PricebookEntry  where Pricebook2.IsStandard =true and Product2Id =:proid Limit 1];
        PricebookEntry Pb = new PricebookEntry();
        if(Pbs.size()>0)
        {
          Pb =[select id , name,Product2Id ,IsActive,Pricebook2.Name ,UnitPrice from PricebookEntry  where Pricebook2.IsStandard =true and Product2Id =:proid];
   
        }
        if(Pb.IsActive == false)
        {
            r.data.put('message', ERROR_MSG_PRICEBOOK_INACTIVE);    
            return r;     
        }
        if(proObj.QB_Id__c == null  )
        {
           
            string types;    
            String recordtypename = Schema.SObjectType.Product2.getRecordTypeInfosById().get(proObj.RecordTypeId).getname();
            Boolean TQH; 
            if(recordtypename == PRODUCT_RECORD_TYPE_NAME_PRODUCT)
            {
                types = QUICKBOOK_RECORD_TYPE_NAME_INVENTORY; 
                TQH= true;
            }else if(recordtypename == PRODUCT_RECORD_TYPE_NAME_SERVICE){
                types = QUICKBOOK_RECORD_TYPE_NAME_SERVICE;
                TQH= false;
            }else if(recordtypename == PRODUCT_RECORD_TYPE_NAME_DISCOUNTS){
                types = QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY;
                TQH=false ;
            }

        string tax = proObj.Apply_Excise_Tax__c;
        Boolean Taxable; 
        if(tax == 'No')
        {
          Taxable = false;  
              }else{
                Taxable = true;     
              }
            String requestjson ='';
            String Name = proObj.Name;
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();	
            gen.writeBooleanField('TrackQtyOnHand',TQH);
            gen.writeStringField('FullyQualifiedName',proObj.Name);
            gen.writeStringField('Name',proObj.Name);
            gen.writeNumberField('QtyOnHand',proObj.Available_Inventory__c);
            gen.writeNumberField('UnitPrice',Pb.UnitPrice);
            gen.writeNumberField('PurchaseCost',Pb.UnitPrice);
            gen.writeBooleanField('Taxable',Taxable);
            gen.writeBooleanField('Active',true);
            gen.writeFieldName('IncomeAccountRef');
            gen.writeStartObject();
            gen.writeStringField('name',QUICKBOOK_INCOMEACCOUNTREF_NAME);
            gen.writeStringField('value',QUICKBOOK_INCOMEACCOUNTREF_VALUES);
            gen.writeEndObject();
            gen.writeFieldName('AssetAccountRef');
            gen.writeStartObject();
            gen.writeStringField('name',QUICKBOOK_ASSETACCOUNTREF_NAME);
            gen.writeStringField('value',QUICKBOOK_ASSETACCOUNTREF_VALUES);
            gen.writeEndObject();
            gen.writeStringField('InvStartDate','2018-01-01');
            gen.writeStringField('Type',types);
            gen.writeFieldName('ExpenseAccountRef');
            gen.writeStartObject();
            gen.writeStringField('name',QUICKBOOK_EXPENSEACCOUNTREF_NAME);
            gen.writeStringField('value',QUICKBOOK_EXPENSEACCOUNTREF_VALUES);
            gen.writeEndObject();
            gen.writeEndObject();
            requestjson = gen.getAsString();
            String requestPayload= requestjson;    
            HttpRequest req = new HttpRequest();
            req.setEndpoint(QUICKBOOK_PRODUCT_ENDPOINTS);
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody(requestPayload);
            Http http = new Http();
            HttpResponse res = http.send(req);
            String response = res.getBody();
            string idsexist='';
 		    string withoutidprod;
            List<String> rst = new List<string>();
           rst.add(response);

            Dom.Document doc = new Dom.Document();
            List<string> dat = new list <string>();
            for(String rs : rst )
            {
             string spl =rs.replace(':', ',');
                List<String> lstAlpha = spl.split(',');
                for(string st : lstAlpha){
                     System.debug('st'+st.contains('Id='));
                    if(st.contains('Id=')){idsexist = st;
                        withoutidprod = idsexist.replace('"', '');

                    }
                    
                }
              
            }
            if(withoutidprod !=null){
                string allstring = string.join(withoutidprod.split('='),',');
                String result = withoutidprod.substringAfter('=');
                HttpRequest reqe = new HttpRequest();
                String Endpoints = String.format(QUICKBOOK_PRODUCT_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(result)});
                reqe.setEndpoint(Endpoints);
                reqe.setMethod('GET');
                reqe.setHeader('Content-Type','application/json');
                Http httpp = new Http();
                HttpResponse ress = httpp.send(reqe);
                String responses = ress.getBody();
                system.debug('responses'+responses);    
                
                string synctokens='';
                string Idsup; 
                string activestatus;
                Dom.Document docss = new Dom.Document();  
                docss.load( responses );  
                Dom.XMLNode rootElement = docss.getRootElement();  
                List<Product2> updateacc1 = new  List<Product2>();
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                    {
                        
                        if(detailElement.getName() == 'Id')
                        {
                            if(detailElement.getName() == 'Id')
                            {
                                integer Ids = integer.valueOf(detailElement.getText());
                                Product2 Pro = new Product2();
                                Pro.Id = recordId;
                                Pro.QB_Id__c =Ids;
                                updateacc1.add(Pro);
                            }
                            Idsup =detailElement.getText();
                            
                        }if(detailElement.getName() == 'SyncToken'){
                            synctokens = detailElement.getText();  
                            
                        }
                        if(detailElement.getName() == 'Active')
                        {
                            activestatus= detailElement.getText();  
                        }
                    }
                    
                }     
                
                string taxs = proObj.Apply_Excise_Tax__c;
                Integer proids;
                if(Idsup != null)
                {
                    proids = Integer.valueOf(Idsup);   
                }
                string typesdata;    
                String recordtypenames = Schema.SObjectType.Product2.getRecordTypeInfosById().get(proObj.RecordTypeId).getname();
                Boolean TQHs; 
                if(recordtypenames == PRODUCT_RECORD_TYPE_NAME_PRODUCT)
                {
                    typesdata = QUICKBOOK_RECORD_TYPE_NAME_INVENTORY; 
                    TQHs= true;
                }else if(recordtypenames == PRODUCT_RECORD_TYPE_NAME_SERVICE){
                    typesdata = QUICKBOOK_RECORD_TYPE_NAME_SERVICE;
                    TQHs= false;
                }else if(recordtypenames == PRODUCT_RECORD_TYPE_NAME_DISCOUNTS){
                    typesdata = QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY;
                    TQHs=false ;
                }      
                Boolean Taxables; 
                if(tax == 'No')
                {
                    Taxables = false;  
                }else{
                    Taxables = true;     
                }
                if(activestatus == 'true')
                {
                    String requestjsons ='';    
                    JSONGenerator gendata = JSON.createGenerator(true);
                    gendata.writeStartObject();	
                    gendata.writeNumberField('Id',proids);
                    gendata.writeBooleanField('TrackQtyOnHand',TQHs);
                    gendata.writeStringField('FullyQualifiedName',proObj.Name);
                    gendata.writeStringField('Name',proObj.Name);
                    gendata.writeNumberField('QtyOnHand',proObj.Available_Inventory__c);
                    gendata.writeNumberField('UnitPrice',Pb.UnitPrice);
                    gendata.writeNumberField('PurchaseCost',Pb.UnitPrice);
                    gendata.writeBooleanField('Taxable',Taxables);
                    gendata.writeBooleanField('Active',true);
                    gendata.writeStringField('sparse','false');
                    gendata.writeStringField('SyncToken',synctokens); 
                    gendata.writeFieldName('IncomeAccountRef');
                    gendata.writeStartObject();
                    gendata.writeStringField('name',QUICKBOOK_INCOMEACCOUNTREF_NAME);
                    gendata.writeStringField('value',QUICKBOOK_INCOMEACCOUNTREF_VALUES);
                    gendata.writeEndObject();
                    gendata.writeFieldName('AssetAccountRef');
                    gendata.writeStartObject();
                    gendata.writeStringField('name',QUICKBOOK_ASSETACCOUNTREF_NAME);
                    gendata.writeStringField('value',QUICKBOOK_ASSETACCOUNTREF_VALUES);
                    gendata.writeEndObject();
                    gendata.writeStringField('InvStartDate','2018-01-01');
                    gendata.writeStringField('Type',typesdata);
                    gendata.writeFieldName('ExpenseAccountRef');
                    gendata.writeStartObject();
                    gendata.writeStringField('name',QUICKBOOK_EXPENSEACCOUNTREF_NAME);
                    gendata.writeStringField('value',QUICKBOOK_EXPENSEACCOUNTREF_VALUES);
                    gendata.writeEndObject();
                    gendata.writeEndObject();
                    requestjsons = gendata.getAsString();
                    String requestPayloads= requestjsons;
                    HttpRequest reqs = new HttpRequest();
                    reqs.setEndpoint(QUICKBOOK_PRODUCT_ENDPOINTS);
                    reqs.setMethod('POST');
                    reqs.setHeader('Content-Type','application/json');
                    reqs.setBody(requestPayloads);
                    Http https = new Http();
                    HttpResponse rest = https.send(reqs);
                    String resp = rest.getBody();
                    if(rest.getstatuscode() == 200){
                        system.debug('sucess'+ress);  
                    }else{
                        system.debug('error'+ress);
                    }  
                    update updateacc1; 
                }   
                
                
            }else{
                
            
            system.debug('response>>'+response);
           
                doc.load(response);  
                Dom.XMLNode rootElement = doc.getRootElement();  
                List<Product2> updateacc = new  List<Product2>();
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName() == 'Id')
                    {
                        integer Ids = integer.valueOf(detailElement.getText());
                        Product2 Pro = new Product2();
                        Pro.Id = recordId;
                        Pro.QB_Id__c =Ids;
                        updateacc.add(Pro);
                    }
                }  
                update updateacc;
                if(res.getstatuscode() == 200){
                    system.debug('sucess'+res);  
                }else{
                    system.debug('error'+res);
                } 
            }
        }else{
            // when we have Qb ids with product records it will update  records again into QB   
            HttpRequest reqe = new HttpRequest();
             Decimal  QBids = proObj.QB_Id__c; 
            String Endpoints = String.format(QUICKBOOK_PRODUCT_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(QBids)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus ;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                        
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                        
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                }
                
            }  
            string tax = proObj.Apply_Excise_Tax__c;
            Integer proids = Integer.valueOf(Idsup);
            string types;    
            String recordtypename = Schema.SObjectType.Product2.getRecordTypeInfosById().get(proObj.RecordTypeId).getname();
            Boolean TQH; 
            if(recordtypename == PRODUCT_RECORD_TYPE_NAME_PRODUCT)
            {
                types = QUICKBOOK_RECORD_TYPE_NAME_INVENTORY; 
                TQH= true;
            }else if(recordtypename == PRODUCT_RECORD_TYPE_NAME_SERVICE){
                types = QUICKBOOK_RECORD_TYPE_NAME_SERVICE;
                TQH= false;
            }else if(recordtypename == PRODUCT_RECORD_TYPE_NAME_DISCOUNTS){
                types = QUICKBOOK_RECORD_TYPE_NAME_NONINVENTORY;
                TQH=false ;
            }      
            Boolean Taxable; 
            if(tax == 'No')
            {
                Taxable = false;  
            }else{
                Taxable = true;     
            }
            if(activestatus == 'true')
            {
                String requestjson ='';    
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();	
                gen.writeNumberField('Id',proids);
                gen.writeBooleanField('TrackQtyOnHand',TQH);
                gen.writeStringField('FullyQualifiedName',proObj.Name);
                gen.writeStringField('Name',proObj.Name);
                gen.writeNumberField('QtyOnHand',proObj.Available_Inventory__c);
                gen.writeNumberField('UnitPrice',Pb.UnitPrice);
                gen.writeNumberField('PurchaseCost',Pb.UnitPrice);
                gen.writeBooleanField('Taxable',Taxable);
                gen.writeBooleanField('Active',true);
                gen.writeStringField('sparse','false');
                gen.writeStringField('SyncToken',synctokens); 
                gen.writeFieldName('IncomeAccountRef');
                gen.writeStartObject();
                gen.writeStringField('name',QUICKBOOK_INCOMEACCOUNTREF_NAME);
                gen.writeStringField('value',QUICKBOOK_INCOMEACCOUNTREF_VALUES);
                gen.writeEndObject();
                gen.writeFieldName('AssetAccountRef');
                gen.writeStartObject();
                gen.writeStringField('name',QUICKBOOK_ASSETACCOUNTREF_NAME);
                gen.writeStringField('value',QUICKBOOK_ASSETACCOUNTREF_VALUES);
                gen.writeEndObject();
              gen.writeStringField('InvStartDate','2018-01-01');
                gen.writeStringField('Type',types);
                gen.writeFieldName('ExpenseAccountRef');
                gen.writeStartObject();
                gen.writeStringField('name',QUICKBOOK_EXPENSEACCOUNTREF_NAME);
                gen.writeStringField('value',QUICKBOOK_EXPENSEACCOUNTREF_VALUES);
                gen.writeEndObject();
                gen.writeEndObject();
                requestjson = gen.getAsString();
                String requestPayload= requestjson;
                HttpRequest req = new HttpRequest();
                req.setEndpoint(QUICKBOOK_PRODUCT_ENDPOINTS);
                req.setMethod('POST');
                req.setHeader('Content-Type','application/json');
                req.setBody(requestPayload);
                Http http = new Http();
                HttpResponse res = http.send(req);
                String response = res.getBody();
                if(ress.getstatuscode() == 200){
                    system.debug('sucess'+ress);  
                }else{
                    system.debug('error'+ress);
                }  
            }
            else{
                r.data.put('message',ERROR_MSG_QB_INACTIVE);    
                return r;     
            }      
        }  
        return r; 
    } 
        /** Push Sf Invoice records to push into QB  **/
   @AuraEnabled
    public static AuraResponse SyncInvoiceWithQuickBooks(String recordId){
        AuraResponse r = new AuraResponse('QuickBookConncetion.SyncInvoiceWithQuickBooks()');
        Invoice__c  InvObj = [select id,Invoice_Date__c,QB_Id__c,Name,Receiver_Email__c,Receiver_Name__c,Total_Payments_Received__c,Invoice_Balance__c,Invoice_Due_Date__c,Receiver_Name__r.Name,Receiver_Name__r.QB_Customer_ID__c,
                              Receiver_ID__c,Receiver_Name__r.BillingCity,Receiver_Name__r.BillingStreet,Receiver_Name__r.BillingCountry,Receiver_Name__r.BillingPostalCode,Receiver_Name__r.BillingState from Invoice__c  where id =:recordId];
              List<Invoice__c> updateacc1 = new  List<Invoice__c>();

        String requestPayload;
             system.debug('InvObjInvObj'+InvObj.Receiver_Name__r.Id);
        List<Invoice_Line__c> invline =[select id ,RecordTypeId,Unit_Cultivation_Tax__c,Apply_Cultivation_Tax__c,Apply_Excise_Tax__c, name,Product_Name__c,Line_Total_Product_Price__c,Invoice_Qty__c,Line_Total_Invoice_Amount__c,Retail_Wholesale_Price__c,Invoice__c, Invoice__r.Name,Product_Name__r.QB_Id__c, Product_Name__r.Name from Invoice_Line__c  where Invoice__c =:recordId];
        Integer totalrecords = invline.size();
                            set<string>prodname = new set<string>();
        if(InvObj.Receiver_Name__r.QB_Customer_ID__c == null){
           r.data.put('message','error');    
                return r;   
        }
           else if(InvObj.Receiver_Name__r.QB_Customer_ID__c != null && InvObj.QB_Id__c == null){
               
               if(InvObj.Invoice_Due_Date__c == null){
                 r.data.put('validation','please select Invoice DueDate');    
                return r;    
               }
               
               
            system.debug('inside cust');
             Decimal  custid = InvObj.Receiver_Name__r.QB_Customer_ID__c; 
            string custstring = string.valueOf(custid);
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QUICKBOOK_CUSTOMER_WITH_IDS_ENDPOINTS,new List<String>{String.valueOf(custid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
            Dom.Document doc = new Dom.Document();  
            doc.load( responses );  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText();  
                    }
                }
            }  
            if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
            }else{
                system.debug('error'+ress);
            }  
            
         
              String requestjson ='';
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();	
            gen.writeFieldName('CustomerRef');
            gen.writeStartObject();
            gen.writeStringField('value',Idsup);
            gen.writeEndObject();
              gen.writeFieldName('BillEmail');
            gen.writeStartObject();
            gen.writeStringField('Address',InvObj.Receiver_Email__c);
              gen.writeEndObject();
            gen.writeFieldName('ShipAddr');
            gen.writeStartObject();
            gen.writeStringField('City',InvObj.Receiver_Name__r.BillingCity);
            gen.writeStringField('Line1',InvObj.Receiver_Name__r.BillingStreet);
            gen.writeStringField('Country',InvObj.Receiver_Name__r.BillingCountry); 
            gen.writeStringField('PostalCode',InvObj.Receiver_Name__r.BillingPostalCode);
            gen.writeStringField('CountrySubDivisionCode',InvObj.Receiver_Name__r.BillingState);  
            gen.writeEndObject();
              //gen.writeStringField('TaxCodeRef','TAX');
            gen.writeStringField('DueDate',String.valueOf(InvObj.Invoice_Due_Date__c));
               if(InvObj.Invoice_Due_Date__c > InvObj.Invoice_Date__c){
               }else{
               }
			 if(InvObj.Invoice_Due_Date__c > InvObj.Invoice_Date__c){  gen.writeStringField('TxnDate',String.valueOf(InvObj.Invoice_Date__c));     
                  }
			gen.writeStringField('TotalAmt','100');//doubt
              gen.writeStringField('DocNumber',String.valueOf(InvObj.Name));
            gen.writeFieldName('Line');
            gen.writeStartArray();
            for(integer i=0;i<totalrecords;i++){	
                    Id InvRecordTypeID   = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
                string unitprice; string Amt;
					if(invline[i].RecordTypeId == InvRecordTypeID){
                      unitprice = String.valueOf(invline[i].Unit_Cultivation_Tax__c) ; 
                        Amt = String.valueOf(invline[i].Line_Total_Invoice_Amount__c	);
                         }else{
                           unitprice = String.valueOf(invline[i].Retail_Wholesale_Price__c); 
                               Amt = String.valueOf(invline[i].Line_Total_Product_Price__c	);
                         }
                   string taxvalues='';
                     if(invline[i].Apply_Cultivation_Tax__c == 'yes' || invline[i].Apply_Excise_Tax__c == 'yes' ){
                         taxvalues='TAX';
                     }
                    system.debug('unitprice>>'+unitprice);
                if(invline[i].Product_Name__r.QB_Id__c !=null){
                    gen.writeStartObject();
                    gen.writeStringField('DetailType','SalesItemLineDetail');
                    gen.writeStringField('Amount',Amt);     
                    gen.writeFieldName('SalesItemLineDetail');
                    gen.writeStartObject();
                    gen.writeFieldName('TaxCodeRef');
                    gen.writeStartObject();
                    gen.writeStringField('value',taxvalues);
                    gen.writeEndObject();
                    gen.writeStringField('Qty',String.valueOf(invline[i].Invoice_Qty__c)); 
                    gen.writeStringField('UnitPrice',unitprice); 
                    gen.writeFieldName('ItemRef');
                    gen.writeStartObject();
                    gen.writeStringField('name',invline[i].Product_Name__r.Name);
                    gen.writeStringField('value',String.valueOf(invline[i].Product_Name__r.QB_Id__c));
                    gen.writeEndObject();
                    gen.writeEndObject();
                    gen.writeEndObject();
                }else{
                    system.debug('String.valueOf(InvObj.Name)'+String.valueOf(InvObj.Name));
                    r.data.put('product','sync product to Quickbook' ); 
                    return r;    
                }
            }
            gen.writeEndArray();
            gen.writeEndObject();
            
            requestjson = gen.getAsString();
             
             requestPayload= requestjson;
        system.debug('requestPayload'+requestPayload);
                 
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:QuickBookWovn/v3/company/4620816365184635780/invoice?minorversion=63');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody(requestPayload);
            Http http = new Http();
            HttpResponse res = http.send(req);
            String response = res.getBody();
            system.debug('response'+response); 
          
            Dom.Document docunq = new Dom.Document();  
            docunq.load( response );  
            Dom.XMLNode rootElementsuq = docunq.getRootElement();  
            for ( Dom.XMLNode childElement : rootElementsuq.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    
                    system.debug('detailElement'+Idsup);
                    if(detailElement.getName() == 'Id')
                    {
                       
                             
                            integer Ids = integer.valueOf(detailElement.getText());
                            system.debug('Ids'+Ids);
                            Invoice__c Pro = new Invoice__c();
                            Pro.Id = recordId;
                            Pro.QB_Id__c =Ids;
                            updateacc1.add(Pro);
                      
                        
                    }
                }
                
            }     
           
             
              string idsexist='';
 		    string withoutidprod;
            List<String> rst = new List<string>();
           rst.add(response);

            for(String rs : rst )
            {
             string spl =rs.replace(':', ',');
                List<String> lstAlpha = spl.split(',');
                for(string st : lstAlpha){
                       System.debug('st'+st);
                     System.debug('st'+st.contains('TxnId='));
                    if(st.contains('Id=')){idsexist = st; withoutidprod = idsexist.replace('"', '');

                    }
                    
                }
              
            } 
             System.debug('withoutidprod'+withoutidprod);
            if(withoutidprod !=null){
                
           
              string allstring = string.join(withoutidprod.split('='),',');
                String result = withoutidprod.substringAfter('TxnId='); 
                  System.debug('result'+result);
            HttpRequest reqeinv = new HttpRequest();
            reqeinv.setEndpoint('callout:QuickBookWovn/v3/company/4620816365184635780/invoice/'+result+'?minorversion=63');
            reqeinv.setMethod('GET');
            reqeinv.setHeader('Content-Type','application/json');
            Http httpps = new Http();
            HttpResponse resst = httpps.send(reqeinv);
            String responsesinv = resst.getBody();
            system.debug('responses'+responsesinv);  
            System.debug('result'+result);
            string docNum='';
            string synctokensinv='';
            Dom.Document docss = new Dom.Document();  
            docss.load( responses );  
            Dom.XMLNode rootElements = docss.getRootElement();  
            for ( Dom.XMLNode childElement : rootElements.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement'+detailElement.getName());
                    if(detailElement.getName() == 'Id')
                    {
                        if(detailElement.getName() == 'Id')
                        {
                            integer Ids = integer.valueOf(detailElement.getText());
                            Invoice__c Pro = new Invoice__c();
                            Pro.Id = recordId; Pro.QB_Id__c =integer.valueOf(result);
                            updateacc1.add(Pro);
                        }
                        Idsup =detailElement.getText();
                        
                    }if(detailElement.getName() == 'SyncToken'){ synctokensinv = detailElement.getText();  
                        
                    }
                    if(detailElement.getName() == 'DocNumber')
                    {
                        docNum= detailElement.getText();  
                    }
                }
                
            }  
      }  

        upsert  updateacc1;  
            system.debug('sucess'+updateacc1); 
             if(res.getstatuscode() == 200){
            
             system.debug('sucess'+res.getStatus());  

        }else{
            
            system.debug('error'+res);
            // r.data.put('DuplicateInvoice','Invoice Already Sync');    
              //  return r;  
        }
            
            
                
          
        }
        
        
			  if(InvObj.QB_Id__c != null && InvObj.Receiver_Name__r.QB_Customer_ID__c != null){
               system.debug('responses else if qb');  
           HttpRequest reqeinv = new HttpRequest();
            reqeinv.setEndpoint('callout:QuickBookWovn/v3/company/4620816365184635780/invoice/'+String.valueOf(InvObj.QB_Id__c)+'?minorversion=63');
            reqeinv.setMethod('GET');
            reqeinv.setHeader('Content-Type','application/json');
            Http httpps = new Http();
            HttpResponse resst = httpps.send(reqeinv);
            String responseQB= resst.getBody();
            system.debug('responses'+responseQB);  
            string docNum='';
            string synctokensinv='';
            Dom.Document docss = new Dom.Document();  
            docss.load( responseQB );  
            Dom.XMLNode rootElements = docss.getRootElement();  
            for ( Dom.XMLNode childElement : rootElements.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    system.debug('detailElement'+detailElement.getName());
                   if(detailElement.getName() == 'SyncToken'){
                        synctokensinv = detailElement.getText();  
                        
                    }
                    if(detailElement.getName() == 'DocNumber')  { docNum= detailElement.getText();  
                    }
                }
                
            }  
              system.debug('synctokensinv'+synctokensinv);  
               system.debug('docNum'+docNum);  
            String requestjsons ='';
            JSONGenerator gens = JSON.createGenerator(true);
            gens.writeStartObject();	
            gens.writeFieldName('CustomerRef');
            gens.writeStartObject();
            gens.writeStringField('value',String.valueOf(InvObj.Receiver_Name__r.QB_Customer_ID__c) );
            gens.writeEndObject();
            gens.writeFieldName('BillEmail');
            gens.writeStartObject();
            gens.writeStringField('Address',InvObj.Receiver_Email__c);
            gens.writeEndObject();
            gens.writeFieldName('ShipAddr');
            gens.writeStartObject();
            gens.writeStringField('City',InvObj.Receiver_Name__r.BillingCity);
            gens.writeStringField('Line1',InvObj.Receiver_Name__r.BillingStreet);
            gens.writeStringField('Country',InvObj.Receiver_Name__r.BillingCountry); 
            gens.writeStringField('PostalCode',InvObj.Receiver_Name__r.BillingPostalCode);
            gens.writeStringField('CountrySubDivisionCode',InvObj.Receiver_Name__r.BillingState);  
            gens.writeEndObject();
         
            gens.writeStringField('Id',String.valueOf(InvObj.QB_Id__c));
            gens.writeStringField('SyncToken',String.valueOf(synctokensinv));
           //  gens.writeStringField('SyncToken',String.valueOf(docNum));
            gens.writeStringField('DueDate',String.valueOf(InvObj.Invoice_Due_Date__c));
                  if(InvObj.Invoice_Due_Date__c > InvObj.Invoice_Date__c){ gens.writeStringField('TxnDate',String.valueOf(InvObj.Invoice_Date__c));     
                  }
           //
            gens.writeStringField('TotalAmt','100');//doubt
           // gens.writeStringField('DocNumber',String.valueOf(InvObj.Name));
            gens.writeFieldName('Line');
            gens.writeStartArray();
            for(integer i=0;i<totalrecords;i++){	
                if(invline[i].Product_Name__r.QB_Id__c !=null){ Id InvRecordTypeID   = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get('Tax').getRecordTypeId();
                    string taxval ;
					string unitprice; string Amt;
					if(invline[i].RecordTypeId == InvRecordTypeID){
                      unitprice = String.valueOf(invline[i].Unit_Cultivation_Tax__c) ; 
                        Amt = String.valueOf(invline[i].Line_Total_Invoice_Amount__c	);
                         system.debug('unitprice1111>>'+unitprice);
                         }else{
                           unitprice = String.valueOf(invline[i].Retail_Wholesale_Price__c); 
                               Amt = String.valueOf(invline[i].Line_Total_Product_Price__c	);
                              system.debug('unitprice222222>>'+unitprice);
                         }
                    string taxvalues='';
                     if(invline[i].Apply_Cultivation_Tax__c == 'yes' || invline[i].Apply_Excise_Tax__c == 'yes' ){ taxvalues='TAX';
                     }
                    //  gens.writeStringField('TaxCodeRef','TAX');
                    system.debug('unitprice>>'+unitprice);
                    gens.writeStartObject();
                    gens.writeStringField('DetailType','SalesItemLineDetail');
                    gens.writeStringField('Amount',Amt);     
                    gens.writeFieldName('SalesItemLineDetail');
                  gens.writeStartObject();
                     gens.writeFieldName('TaxCodeRef');
                    gens.writeStartObject();
                    gens.writeStringField('value',taxvalues);
                       gens.writeEndObject();
                    gens.writeStringField('Qty',String.valueOf(invline[i].Invoice_Qty__c)); 
                    gens.writeStringField('UnitPrice',unitprice); 
                    gens.writeFieldName('ItemRef');
                    gens.writeStartObject();
                    gens.writeStringField('name',invline[i].Product_Name__r.Name);
                    gens.writeStringField('value',String.valueOf(invline[i].Product_Name__r.QB_Id__c));
                    gens.writeEndObject();
                    gens.writeEndObject();
                    gens.writeEndObject();
                }
            }
            gens.writeEndArray();
            gens.writeEndObject();
            
            requestjsons = gens.getAsString();
            
            requestPayload= requestjsons;
            system.debug('requestPayload'+requestPayload);
            
            HttpRequest req2 = new HttpRequest();
            req2.setEndpoint('callout:QuickBookWovn/v3/company/4620816365184635780/invoice?minorversion=63');
            req2.setMethod('POST');
            req2.setHeader('Content-Type','application/json');
            req2.setBody(requestPayload);
            Http http2 = new Http();
            HttpResponse res2 = http2.send(req2);
            String response2 = res2.getBody();
            system.debug('response2'+response2); 
            system.debug('>>'+res2.getBody());  
              r.data.put('Update','invoice Updated Sucessfully');    
                return r; 
        }
    
         return r;
}
    
    
    /** Push SF Chart_Of_Account records to push into QB **/

    
@AuraEnabled 
Public static AuraResponse syncChartOfAccountWithQuickBooks(String recordId){
 AuraResponse r = new AuraResponse('QuickBookConncetion.syncChartOfAccountWithQuickBooks()');
    
 string status;
 Chart_of_Account__c chartAcc = [SELECT id,Name,Account_Type__c,Account_Description__c,GL_Number__c,Report_Type__c,QB_ChartofAccount_ID__c FROM Chart_of_Account__c where id =:recordId];
        if(chartAcc.QB_ChartofAccount_ID__c == null )
        {
          String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    gen.writeStringField('Name',chartAcc.Name);
                    gen.writeStringField('AccountType','Accounts Receivable');
                  //  gen.writeStringField('AccountType',chartAcc.Account_Type__c);
                    gen.writeEndObject();
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_CHARTACCOUNT_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();  
            system.debug('response>>'+response);
             Dom.Document doc = new Dom.Document();  
                doc.load(response);  
                List<Chart_of_Account__c> updateacc = new  List<Chart_of_Account__c>();
                Dom.XMLNode rootElement = doc.getRootElement();  
                for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                        if(detailElement.getName() == 'Id')
                    {
                        integer Ids = integer.valueOf(detailElement.getText());
                         system.debug('Ids>>'+Ids);
                       Chart_of_Account__c CA = new Chart_of_Account__c();
                        CA.Id = recordId;
                       CA.QB_ChartofAccount_ID__c =Ids;
                      updateacc.add(CA);
                    }
                }  
                update updateacc;
            system.debug('updateacc>>'+updateacc);    
            if(res.getstatuscode() == 200){
                    system.debug('statusCode value ' + res.getStatusCode());
                    status ='Success';
                }

        }
    
    else {
            Decimal  coaid = chartAcc.QB_ChartofAccount_ID__c; 
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QB_CHARTACCOUNT_WITHIDS_ENDPOINT,new List<String>{String.valueOf(coaid)});
            system.debug('Endpoints>>'+Endpoints);
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            system.debug('responses>>'+responses);
            string synctokens='';
            string Idsup; 
            string activestatus;
            Dom.Document doc = new Dom.Document();  
            doc.load(responses);  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                        system.debug('Idsup>>'+Idsup);
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                        system.debug('synctokens>>'+synctokens);
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText(); 
                        system.debug('activestatus>>'+activestatus);
                    }
                }
            }  
			if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                status ='Success';
            }else{
                system.debug('error'+ress);
            }  
			
			 if(activestatus == 'true')
            {
                if(chartAcc.Name != null)
                {
				String requestjson ='';
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();	
                    gen.writeStringField('Name',chartAcc.Name);
                    gen.writeStringField('AccountType','Accounts Receivable');
                  //  gen.writeStringField('AccountType',chartAcc.Account_Type__c);
                    gen.writeStringField('SyncToken',synctokens); 
                    gen.writeStringField('Id',Idsup); 
              //     genCA.writeStringField('Account Description',chartAcc.Account_Description__c);
              //      genCA.writeStringField('GL Number',chartAcc.GL_Number__c);
              //      genCA.writeStringField('Financial Statement Type',chartAcc.Report_Type__c);
                    gen.writeEndObject();
                    
                    requestjson = gen.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_CHARTACCOUNT_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
				}
				else{
                    r.data.put('message', ERR_MSG_MISSING_CHARTACCOUNT_NAME);
                    return r;
                }
            }else{
                r.data.put('message', ERR_MSG_QB_INACTIVE_CHARTACCOUNT);
                return r;     
            }       
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 /*string statusCA;
 Chart_of_Account__c chartAcc = [SELECT id,Name,Account_Type__c,Account_Description__c,GL_Number__c,Report_Type__c,QB_ChartofAccount_ID__c FROM Chart_of_Account__c where id =:recordId];
 system.debug('chartAcc ' + chartAcc);
 if(chartAcc.QB_ChartofAccount_ID__c == null){
  system.debug('chartAcc Id ' + chartAcc.QB_ChartofAccount_ID__c);
     
 if(chartAcc.Name != null){
 system.debug('chartAcc Name ' + chartAcc.Name);
     
 string requestjson = '';
 JSONGenerator genCA = JSON.createGenerator(true);
     system.debug('genCA value ' + genCA);
 genCA.writeStartObject();
 genCA.writeStringField('Name',chartAcc.Name); 
 genCA.writeStringField('AccountType','Accounts Receivable');
 genCA.writeStringField('Account Description',chartAcc.Account_Description__c);
 genCA.writeStringField('GL Number',chartAcc.GL_Number__c);
 genCA.writeStringField('Financial Statement Type',chartAcc.Report_Type__c);
 genCA.writeEndObject();
 requestjson = genCA.getAsString();
      system.debug('requestjson value ' + requestjson);
 string requestPayload = requestjson;
 HttpRequest req = new HttpRequest();
 req.setEndpoint(QUICKBOOK_CHARTACCOUNT_ENDPOINTS);
 req.setMethod('POST');
 req.setHeader('Content-Type','application/json');
 req.setBody(requestPayload);
     system.debug('req value ' + req);
 Http http = new Http();
     system.debug('req value ' + http.send(req));
 HttpResponse res = http.send(req);
     system.debug('req value ' + res);
 String response = res.getBody();
     system.debug('response value ' + response);
                Dom.Document doc = new Dom.Document();  
                doc.load(response);  
                List<Chart_of_Account__c> updateCOA = new  List<Chart_of_Account__c>();
                Dom.XMLNode rootElement = doc.getRootElement();  
                system.debug('rootElement value ' + rootElement);
				for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                    system.debug('childElement value ' + childElement);
                    for ( Dom.XMLNode detailElement : childElement.getChildElements() ) 
                        if(detailElement.getName() == 'Id')
                    {
                        integer Ids = integer.valueOf(detailElement.getText());
                        Chart_of_Account__c COA = new Chart_of_Account__c();
                        COA.Id = recordId;
                        COA.QB_ChartofAccount_ID__c =Ids;
                        updateCOA.add(COA);
                    }
                }
               update updateCOA;
               
              if(res.getstatuscode() == 200){
                    system.debug('statusCode value ' + res.getStatusCode());
                    statusCA ='Success';
                }
 
 } 
 
 } 
    
    
    else{
            Decimal  coaid = chartAcc.QB_ChartofAccount_ID__c; 
            HttpRequest reqe = new HttpRequest();
            String Endpoints = String.format(QB_CHARTACCOUNT_WITHIDS_ENDPOINT,new List<String>{String.valueOf(coaid)});
            reqe.setEndpoint(Endpoints);
            reqe.setMethod('GET');
            reqe.setHeader('Content-Type','application/json');
            Http httpp = new Http();
            HttpResponse ress = httpp.send(reqe);
            String responses = ress.getBody();
            string synctokens='';
            string Idsup; 
            string activestatus;
            Dom.Document doc = new Dom.Document();  
            doc.load(responses);  
            Dom.XMLNode rootElement = doc.getRootElement();  
            for ( Dom.XMLNode childElement : rootElement.getChildElements() ) {  
                for ( Dom.XMLNode detailElement : childElement.getChildElements() )  
                {
                    if(detailElement.getName() == 'Id')
                    {
                        Idsup =detailElement.getText();
                    }if(detailElement.getName() == 'SyncToken'){
                        synctokens = detailElement.getText();  
                    }
                    if(detailElement.getName() == 'Active')
                    {
                        activestatus= detailElement.getText(); 
                    }
                }
            }  
			if(ress.getstatuscode() == 200){
                system.debug('sucess'+ress);  
                statusCA ='Success';
            }else{
                system.debug('error'+ress);
            }  
			
			 if(activestatus == 'true')
            {
                if(chartAcc.Name != null)
                {
				String requestjson ='';
                    JSONGenerator genCA = JSON.createGenerator(true);
                    genCA.writeStartObject();	
                    genCA.writeStringField('Chart of Accounts',chartAcc.Name);
                    genCA.writeStringField('Account Type',chartAcc.Account_Type__c);
                    genCA.writeStringField('SyncToken',synctokens); 
                    genCA.writeStringField('Id',Idsup); 
                    genCA.writeStringField('Account Description',chartAcc.Account_Description__c);
                    genCA.writeStringField('GL Number',chartAcc.GL_Number__c);
                    genCA.writeStringField('Financial Statement Type',chartAcc.Report_Type__c);
                    genCA.writeEndObject();
                    
                    requestjson = genCA.getAsString();
                    String requestPayload= requestjson;
                    system.debug('requestPayload'+requestPayload);
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(QUICKBOOK_CHARTACCOUNT_ENDPOINTS);
                    req.setMethod('POST');
                    req.setHeader('Content-Type','application/json');
                    req.setBody(requestPayload);
                    Http http = new Http();
                    HttpResponse res = http.send(req);
                    String response = res.getBody();
				}
				else{
                    r.data.put('message', ERR_MSG_MISSING_CHARTACCOUNT_NAME);
                    return r;
                }
            }else{
                r.data.put('message', ERR_MSG_QB_INACTIVE_CHARTACCOUNT);
                return r;     
            }       
        }*/
        return r;
					
}
    
    
}