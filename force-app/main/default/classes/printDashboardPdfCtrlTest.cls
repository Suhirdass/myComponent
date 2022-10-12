@isTest 
public class printDashboardPdfCtrlTest {
	  @isTest
    private static void runTest(){
        
        String filter = '{ "orderByField": "Name", "isASC": false }';
        ApexPages.currentPage().getParameters().put('filters', filter);
        ApexPages.currentPage().getParameters().put('recent', 'false');
        
        printDashboardPdfCtrl printDashboard = new printDashboardPdfCtrl();
        
    }
}