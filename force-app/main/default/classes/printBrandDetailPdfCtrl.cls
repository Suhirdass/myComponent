public class printBrandDetailPdfCtrl {
	 public Object filters{get;set;}
    public List<ProductsCtlr.LicenseAddress> LicenseAddress{get;set;}
    public ProductsCtlr.Brand brndRec {get;set;}
    public Contact primaryContact {get;set;}
    public Boolean isBrand {get;set;}
    public printBrandDetailPdfCtrl(){
      callgetServiceTicketsData();  
    }
    
    public void callgetServiceTicketsData(){
        string brandId =ApexPages.currentPage().getParameters().get('id');
        system.debug('iddddddd'+brandId);
        String filters = '{ "orderByField": "Name", "isASC": true }';
        //String checkRecentReports = ApexPages.currentPage().getParameters().get('recentReport');
        System.debug('###filters:'+filters);
        Map<String, Object> mapOfFilters = (Map<String, Object>)JSON.deserializeUntyped(filters);
        System.debug('##mapOfFilters::'+mapOfFilters);
        AuraResponse wrapperData = ProductsCtlr.getBrandLicenseIds(brandId,mapOfFilters);
        System.debug('wrapperData='+wrapperData);
        Set<Id> ids = (Set<Id>)wrapperData.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idValue : ids){
            system.debug('-------->'+idValue);
           idsList.add(idValue); 
        }
        AuraResponse LicenseRecordsData = ProductsCtlr.getBrandLicense(idsList,mapOfFilters);
        LicenseAddress = (List<ProductsCtlr.LicenseAddress>)LicenseRecordsData.Data.get('stateLicenses');
        System.debug('rec-----='+LicenseRecordsData);
        
        AuraResponse recordsData = ProductsCtlr.getBrand(brandId);
        System.debug('recordsData='+recordsData);
        System.debug('recordsData='+recordsData.Data.get('brand'));
        brndRec =(ProductsCtlr.Brand)recordsData.Data.get('brand');
        primaryContact =(Contact)recordsData.Data.get('primaryContact');
        isBrand =(Boolean)recordsData.Data.get('isBrand');
        
    }
}