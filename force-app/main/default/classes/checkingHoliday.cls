public class checkingHoliday implements Database.Batchable<Sobject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,Name,ActivityDate FROM Holiday');
    }
    
    public void execute(Database.BatchableContext BC, List<Holiday> Holidays){
        
        system.debug('Holidays List ' + Holidays);
        Date todayDate = system.today();
        system.debug('TodayDate is ' + todayDate);
       
        for(Holiday holi : Holidays){
            system.debug('Holidays List ' + holi);
            if(todayDate.daysBetween(holi.ActivityDate) == 0){
                holi.addError('Today is Holiday');
            }
        }
        
    }
    
    public void finish(Database.BatchableContext BC){
        system.debug('Date is checked whether it is holiday or not');
    }

}