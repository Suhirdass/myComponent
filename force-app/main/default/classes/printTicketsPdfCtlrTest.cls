@isTest
public class printTicketsPdfCtlrTest {
    public static testmethod void runTest(){
        string filters = '{ "orderByField": "Name", "isASC": false }' ;
        ApexPages.currentPage().getParameters().put('filters',filters);
    	printTicketsPdfCtlr print = new printTicketsPdfCtlr();
    }
}