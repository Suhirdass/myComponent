@isTest
public class EmailInvoiceControllerTest {
	@isTest
    private static void runTest(){
        EmailInvoiceController.fatchInvoice('invoice');
        
        apexpages.currentpage().getparameters().put('searchText','invoice');
        EmailInvoiceController emailCtrl = new EmailInvoiceController();
    }
}