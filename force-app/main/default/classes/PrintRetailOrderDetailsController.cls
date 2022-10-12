public class PrintRetailOrderDetailsController {
	public ProductsCtlr.Order retailOrder{get;set;}
    public List<ProductsCtlr.RMA> rmaList{get;set;}
    public List<Invoice__c> invoices{get;set;}
    public List<Shipping_Manifest__c> shipManifests{get;set;}
    public string headerTxt{get;set;}
    
    public PrintRetailOrderDetailsController(){
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        headerTxt = 'Order Details #';
        AuraResponse wrapperData = ProductsCtlr.getRetailOrder(recordId);
        retailOrder = (ProductsCtlr.Order)wrapperData.data.get('retailOrder');
        rmaList = (List<ProductsCtlr.RMA>)wrapperData.data.get('returnOrders');
        invoices = (List<Invoice__c>) wrapperData.data.get('invoices');
        shipManifests = (List<Shipping_Manifest__c>) wrapperData.data.get('shipManifests');
    }
}