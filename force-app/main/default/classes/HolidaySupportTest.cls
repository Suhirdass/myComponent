/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * HolidaySupportTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class HolidaySupportTest{

    // Test non recurrence holiday
    static testMethod void testNonRecurrenceHoliday(){
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'Test Holiday';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = false;
        insert holidayObj;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
        System.assertEquals('Test Holiday', holidayName, 'Current date should be holiday');
        
        currentDate = System.Today() + 1;
        holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
        System.assertEquals('', holidayName, 'Current date should not be holiday');
    }
    
    // Test recurrence holiday - yearly
    static testMethod void testRecurrenceYearlyHoliday(){
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'New Year';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = true;
        holidayObj.RecurrenceDayOfMonth = 1;
        holidayObj.RecurrenceMonthOfYear = 'January';
        holidayObj.RecurrenceType = 'RecursYearly';
        holidayObj.RecurrenceStartDate = System.Today();
        insert holidayObj;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
    }
    
    // Test recurrence holiday - yearly nth
    static testMethod void testRecurrenceYearlyNthHoliday(){
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'Test Yearly Nth';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = true;
        holidayObj.RecurrenceDayOfWeekMask = 16;
        holidayObj.RecurrenceInstance = 'Fourth';
        holidayObj.RecurrenceMonthOfYear = 'November';
        holidayObj.RecurrenceType = 'RecursYearlyNth';
        holidayObj.RecurrenceStartDate = System.Today();
        insert holidayObj;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
    }
    
    // Test recurrence holiday - monthly
    static testMethod void testRecurrenceMonthlyHoliday(){
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'Test Monthly';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = true;
        holidayObj.RecurrenceDayOfMonth = 1;
        holidayObj.RecurrenceInterval = 1;
        holidayObj.RecurrenceType = 'RecursMonthly';
        holidayObj.RecurrenceStartDate = System.Today();
        insert holidayObj;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
    }
    
    // Test recurrence holiday - monthly nth
    static testMethod void testRecurrenceMonthlyNthHoliday(){
        List<Holiday> holidays = new List<Holiday>();
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'Test Monthly Nth';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = true;
        holidayObj.RecurrenceDayOfWeekMask = 1;
        holidayObj.RecurrenceInstance = 'First';
        holidayObj.RecurrenceInterval = 5;
        holidayObj.RecurrenceType = 'RecursMonthlyNth';
        holidayObj.RecurrenceStartDate = System.Today();
        holidays.add(holidayObj);
        
        Holiday holidayObj1 = new Holiday();
        holidayObj1.Name = 'Test Monthly Nth';
        holidayObj1.ActivityDate = System.Today();
        holidayObj1.IsRecurrence = true;
        holidayObj1.RecurrenceDayOfWeekMask = 1;
        holidayObj1.RecurrenceInstance = 'Last';
        holidayObj1.RecurrenceInterval = 5;
        holidayObj1.RecurrenceType = 'RecursMonthlyNth';
        holidayObj1.RecurrenceStartDate = System.Today();
        holidays.add(holidayObj1);
        
        insert holidays;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, holidays);
    }
    
    // Test recurrence holiday - daily
    static testMethod void testRecurrenceDailyHoliday(){
        
        Holiday holidayObj = new Holiday();
        holidayObj.Name = 'Test Daily';
        holidayObj.ActivityDate = System.Today();
        holidayObj.IsRecurrence = true;
        holidayObj.RecurrenceInterval = 6;
        holidayObj.RecurrenceType = 'RecursDaily';
        holidayObj.RecurrenceStartDate = System.Today();
        insert holidayObj;
        
        Date currentDate = System.Today();
        String holidayName = HolidaySupport.isCurrentDateHoliday(currentDate, new List<Holiday>{holidayObj});
    }
}