@isTest
public class printReportPdfCtrlTest {
    public static testmethod void runTest(){
        string filters = '{ "orderByField": "Name", "isASC": false }';
        ApexPages.currentPage().getParameters().put('filters',filters);
        printReportPdfCtrl print = new printReportPdfCtrl();
    }
}