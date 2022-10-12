/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceCollectionStatusUpdateScheduler
 */
public class InvoiceCollectionStatusUpdateScheduler implements Schedulable{
    public void execute(SchedulableContext sc) {
        InvoiceCollectionStatusUpdateBatch batchJob = new InvoiceCollectionStatusUpdateBatch(); 
        database.executebatch(batchJob, 200);
    }
}