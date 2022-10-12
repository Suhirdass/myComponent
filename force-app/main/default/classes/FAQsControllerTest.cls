@isTest
public class FAQsControllerTest {
    public static testmethod void runFAQTest(){
        FAQ__c faq = new FAQ__c(Category_Order__c = '1',FAQ_Category__c='ONBOARDING',Type__c ='Both');
        insert faq;
        FAQ_Detail__c fd = new FAQ_Detail__c(FAQ__c  = faq.Id,FAQ_Question__c ='WHAT DOES THE ONBOARDING PROCESS LOOK LIKE?',FAQ_Answer__c ='There are a few steps we need from your end before we dive into setting everything up in the system. Here’s a helpful flowchart to explain.',FAQ_Order__c ='1');
        insert fd;
        
        AuraResponse r = FAQsController.getFAQs('Both');
        
       r = FAQsController.getFAQs('test');
        FAQsController.fetchFAQ('DOES');
    }
}