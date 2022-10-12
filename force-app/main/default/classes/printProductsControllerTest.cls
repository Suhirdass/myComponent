@isTest
public class printProductsControllerTest {
    public static testmethod void runTest(){
        string filter = '{ "orderByField": "Name", "isASC": false }';
        ApexPages.currentPage().getParameters().put('filters',filter);
        printProductsController print = new printProductsController();
        print.callgetServiceTicketsData();
    }
}