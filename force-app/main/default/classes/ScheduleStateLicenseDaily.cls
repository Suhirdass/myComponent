global class ScheduleStateLicenseDaily Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
       StateLicense_HttpCalloutHelper.getAllLicenseByNumberBatch(); 
    }
}