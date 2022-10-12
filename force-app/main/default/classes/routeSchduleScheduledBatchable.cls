global class routeSchduleScheduledBatchable implements Schedulable{
global void execute(SchedulableContext sc) {
// Implement any logic to be scheduled

// We now call the batch class to be scheduled
routeSchduleBatch b = new routeSchduleBatch();

//Parameters of ExecuteBatch(context,BatchSize)
database.executebatch(b,10);
}
}