@istest
public class massInvoiceRPTest {
        static Receive_Payment__c RP;
    static Supplier_Bill__c SB;
    static Bill_Pay__c bpay;
     static Invoice__c inv;
//static List<RPWrapper> setrp;
static testMethod void theTests(){
 massInvoiceRP.BillPaysdetails('Aster','Product');   
    massInvoiceRP.RPdetails('Aster','Product');  
    
    massInvoiceRP.createRPData(RP, 2.1, 'test', system.today(),system.today(), 'ReconcilitionNotes', false, 'Reference', 'RPBank', null, 'Product', 'cash');
massInvoiceRP.createbilpay(bpay,2.9,'memo',system.today(),system.today(),'notes',false,'bank',null,'cash');
 //   CreateRP
      
     List<massInvoiceRP.RPWrapper> setrpdatas = new List<massInvoiceRP.RPWrapper>();
      massInvoiceRP.CreateRP(setrpdatas);
    List<massInvoiceRP.BilPaysWrapper> setPurchaseOrderLines = new List<massInvoiceRP.BilPaysWrapper>();
      massInvoiceRP.CreatebillPays(setPurchaseOrderLines);
    massInvoiceRP.BilPaysWrapper bill = new massInvoiceRP.BilPaysWrapper();
  // bill.BilPaysWrapper();
    bill.BankReg='test';
    bill.isSelected=false;
     massInvoiceRP.RPWrapper rpwr = new  massInvoiceRP.RPWrapper();
    rpwr.labTestStat='cash';
    //createbilpay( Bill_Pay__c poLinePO,Decimal recQty,string Paymentmemo,Date TransactionDate,Date postdate,string ReconcilitionNotes,Boolean Reconciled,string bank,string SupplierBills, String labStat){
}
    static testMethod void theTests2(){
 
   /* massInvoiceRP.BilPaysWrapper bill = new massInvoiceRP.BilPaysWrapper();
    bill.BankReg='test';
    bill.isSelected=false;*/
    //createbilpay( Bill_Pay__c poLinePO,Decimal recQty,string Paymentmemo,Date TransactionDate,Date postdate,string ReconcilitionNotes,Boolean Reconciled,string bank,string SupplierBills, String labStat){
}
}