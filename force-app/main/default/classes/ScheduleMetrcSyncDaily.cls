global class ScheduleMetrcSyncDaily Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Metrc_SyncBatchHandler.Metrc_DataSyncDaily();
    }
}