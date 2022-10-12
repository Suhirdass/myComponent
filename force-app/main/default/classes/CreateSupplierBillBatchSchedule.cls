public class CreateSupplierBillBatchSchedule implements Schedulable{
   public void execute(SchedulableContext sc) {
      CreateSupplierBillBatch createSupplierBillBatch = new CreateSupplierBillBatch();
      if(!Test.isRunningTest()){ 
      database.executebatch(createSupplierBillBatch);
   }
 }
}