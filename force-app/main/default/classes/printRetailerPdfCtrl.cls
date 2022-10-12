public class printRetailerPdfCtrl {
	 //public Object filters{get;set;}
    public List<ProductsCtlr.LicenseAddress> LicenseAddress{get;set;}
    public ProductsCtlr.Retailer retailerRec {get;set;}
    public Boolean isBrand {get;set;}
    public printRetailerPdfCtrl(){
      callgetRetailersData();  
    }
    
    public void callgetRetailersData(){
        string brandId =ApexPages.currentPage().getParameters().get('id');
        system.debug('iddddddd'+brandId);
        String filters = '{ "orderByField": "Name", "isASC": true }';
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
        
        AuraResponse recordsData = ProductsCtlr.getRetailer(brandId);
        System.debug('recordsData='+recordsData);
        retailerRec =(ProductsCtlr.Retailer)recordsData.Data.get('retailer');
        isBrand =(Boolean)recordsData.Data.get('isBrand');
        System.debug('isBrand='+isBrand);

    }
}