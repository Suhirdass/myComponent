/**
 * HolidaySupport
 */
public class HolidaySupport {
    
    private static final String RECURS_YEARLY_NTH  = 'RecursYearlyNth';
    private static final String RECURS_YEARLY      = 'RecursYearly';
    private static final String RECURS_MONTHLY_NTH = 'RecursMonthlyNth';
    private static final String RECURS_MONTHLY     = 'RecursMonthly';
    private static final String RECURS_WEEKLY      = 'RecursWeekly';
    private static final String RECURS_DAILY       = 'RecursDaily';
    
    public static Map<Integer, Integer> getBitMaskMap(){
        //1 =  1 Sunday, 2 = 2 Monday, 4 = 3 Tuesday, 8 = 4 Wednesday, 16 = 5 Thursday, 32 = 6 Friday, 64 = 7 Saturday
        return new Map<Integer, Integer>{1 => 1, 2 => 2, 4 => 3, 8 => 4, 16 => 5, 32 => 6, 64 => 7};
    }
    
    public static Map<String, Integer> getMonthMap(){
        return new Map<String, Integer>{'January' => 1, 'February' => 2, 'March' => 3, 'April' => 4, 'May' => 5,
        'June' => 6, 'July' => 7, 'August' => 8, 'September' => 9,
        'October' => 10, 'November' => 11, 'December' => 12};
    }
    
    public static Map<String, Integer> getWeekMap(){
        return new Map<String, Integer>{'First' => 1, 'Second' => 2, 'Third' => 3, 'Fourth' => 4, 'Fifth' => 5};
    }
    
    public static Map<String, Integer> createDayOfWeekMap(){
        return new Map<String, Integer>{'Sunday' => 1, 'Monday' => 2, 'Tuesday' => 3, 'Wednesday' => 4, 'Thursday' => 5, 'Friday' => 6, 'Saturday' => 7};
    }

    // Check if current date is holiday or not by looking holidays list
    public static String isCurrentDateHoliday(Date currentDate, List<Holiday> holidays){
        String holidayName = '';
        Boolean isHoliday = false;
        for (Holiday holidaySO : holidays){
            if (holidaySO.RecurrenceType == RECURS_YEARLY_NTH){
                
                isHoliday = getYearlyNthHoliday(holidaySO, currentDate);
            
            }else if (holidaySO.RecurrenceType == RECURS_YEARLY){
            
                isHoliday = getYearlyHoliday(holidaySO, currentDate);
            
            }else if (holidaySO.RecurrenceType == RECURS_MONTHLY_NTH){
                
                isHoliday = getMonthlyNthHoliday(holidaySO, currentDate);
            
            }else if (holidaySO.RecurrenceType == RECURS_MONTHLY){
            
                isHoliday = getMonthlyHoliday(holidaySO, currentDate);
            
            }else if (holidaySO.RecurrenceType == RECURS_WEEKLY){
                
                isHoliday = getWeeklyHoliday(holidaySO, currentDate);
            
            }else if (holidaySO.RecurrenceType == RECURS_DAILY){
                
                isHoliday = getDailyHoliday(holidaySO, currentDate);
            
            }else if(holidaySO.ActivityDate == currentDate){
            
                isHoliday = true;
            }
           
            if(isHoliday){
                holidayName = holidaySO.Name;
                break;
            }
        }
        return holidayName;
    }

    // Check if current date is holiday set up as a yearly recurrence
    public static Boolean getYearlyHoliday(Holiday holidaySO, Date currentDate){//recurs on set days in a year, like Christmas, New Years 
        Map<String, Integer> monthMap = getMonthMap();
        Integer year = getYear(currentDate);
        Integer month = monthMap.get(holidaySO.RecurrenceMonthOfYear);
        Date d = Date.newInstance(year, month, holidaySO.RecurrenceDayOfMonth);
        return d == currentDate ? true : false;
    }

    // Check if current date is holiday set up as a nth yearly recurrence
    public static Boolean getYearlyNthHoliday(Holiday holidaySO, Date currentDate){//recurs on something like 2nd Tuesday of march - Thanksgiving, MLK day, Columbus Day
        
        Map<Integer, Integer> maskedDayMap = getBitMaskMap();
        Map<String, Integer> monthMap = getMonthMap();
        Map<String, Integer> weekMap = getWeekMap();

        Integer day = maskedDayMap.get(holidaySO.RecurrenceDayOfWeekMask);
        Integer month = monthMap.get(holidaySO.RecurrenceMonthOfYear);
        Integer year = getYear(currentDate);
        
        Date d;
        if (holidaySO.RecurrenceInstance == 'Last'){
            d = getLastXOfMonth(day, month, year);
        }else{
            Integer week = weekMap.get(holidaySO.RecurrenceInstance);
            d = getXDayOfMonth(week, day, Date.newInstance(year, month, 1));
        }
        return d == currentDate ? true : false;
    }

    // Check if current date is holiday set up as a monthly recurrence
    public static Boolean getMonthlyHoliday(Holiday holidaySO, Date currentDate){//recurs on set day of every month - something like 5th of every month
        Date d = getMonth(currentDate);
        Date da = Date.newInstance(d.year(), d.month(), holidaySO.RecurrenceDayOfMonth);
        return da == currentDate ? true : false;
    }
    
    // Check if current date is holiday set up as nth monthly recurrence
    public static Boolean getMonthlyNthHoliday(Holiday holidaySO, Date currentDate){//recurs monthly - something like every second Sunday
        Date month = getMonth(currentDate);
        Integer day = getBitMaskMap().get(holidaySO.RecurrenceDayOfWeekMask);

        Integer week = getWeekMap().get(holidaySO.RecurrenceInstance);
        
        Date d;
        if (holidaySO.RecurrenceInstance == 'Last'){
                d = getLastXOfMonth(day, month.month(), month.year());
        }else{
            d = getXDayOfMonth(week, day, Date.newInstance(month.year(), month.month(), 1));
        }    
        return d == currentDate ? true : false;
    }
    
    // Check if current date is holiday set up as a weekly recurrence
    public static Boolean getWeeklyHoliday(Holiday holidaySO, Date currentDate){//something like every sat, sun or tue
        Integer day = getBitMaskMap().get(holidaySO.RecurrenceDayOfWeekMask);
        Map<String, Integer> wMap = createDayOfWeekMap();
        Date d = Date.newInstance(currentDate.year(), currentDate.month(), currentDate.day());
        //valueOf(currentDate);
        Datetime dt = DateTime.newInstance(d, Time.newInstance(0, 0, 0, 0));
        while (wMap.get(dt.format('EEEE')) != day){
            d = d.addDays(1);
        }
        return d == currentDate ? true : false;
    }
    
    // Check if current date is holiday set up as a daily recurrence
    public static Boolean getDailyHoliday(Holiday holidaySO, Date currentDate){//something like every 15 days from start
        Integer remainder;
        Date dailyDate = currentDate.addDays(-1);

        while (remainder != 0){
            dailyDate = dailyDate.addDays(1);
            remainder = math.mod(holidaySO.RecurrenceStartDate.daysBetween(dailyDate), holidaySO.RecurrenceInterval);
        }
        return dailyDate == currentDate ? true : false;
    }

    // Get the Date for last month recurrence
    public static Date getLastXOfMonth(Integer dayOfWeek, Integer month, Integer year){
        Datetime dt;
        Map<String, Integer> DayOfWeekMap = createDayofWeekMap();
        Date lastMonthDate = Date.newInstance(year, month + 1, 0);
        dt = DateTime.newInstance(lastMonthDate, Time.newInstance(0, 0, 0, 0));
        Integer day = DayOfWeekMap.get(dt.format('EEEE'));

        while(day != dayOfWeek){
            lastMonthDate = lastMonthDate.addDays(-1);
            dt = DateTime.newInstance(lastMonthDate, Time.newInstance(0, 0, 0, 0));
            day = DayOfWeekMap.get(dt.format('EEEE'));
        }
        return Date.valueOf(lastMonthDate);
    }

    // Get the Date for nth month recurrence
    public static Date getXDayOfMonth(Integer week, Integer day, Date monthIn){
        Map<String, Integer> DayOfWeekMap = createDayofWeekMap();
        Date firstMonthDate = Date.newInstance(monthIn.year(), monthIn.month(), 0);
        
        Integer dayName;
        while(dayName != day){
            firstMonthDate = firstMonthDate.addDays(1);
            Datetime dt = DateTime.newInstance(firstMonthDate, Time.newInstance(0, 0, 0, 0));
            dayName = DayOfWeekMap.get(dt.format('EEEE'));
        }
        if (week == 1){
            return Date.valueOf(firstMonthDate);
        }else{
            return Date.valueOf(firstMonthDate.addDays(7 * (week - 1)));
        }
    }

    public static Date getMonth(Date currentDate){
        Date m = Date.newInstance(currentDate.year(), currentDate.month(), 1);
        return m;
    }

    public static Integer getYear(Date currentDate){
        return currentDate.year();
    }
}