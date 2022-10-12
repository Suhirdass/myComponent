global class ScheduleUIDFinish Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Metrc_SyncBatchHandler.Metrc_SyncUIDBatch();
    }
}