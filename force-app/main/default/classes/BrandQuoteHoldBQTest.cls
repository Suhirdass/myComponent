@isTest(OnInstall=false SeeAllData=false)
public class BrandQuoteHoldBQTest {
    
    static testMethod void  holdBQ(){
        Brand_Quote__c bq = [Select Id, BQ_Status__c, Opportunity_Name__c, Site__c, Ownership__c, RecordTypeId from Brand_Quote__c LIMIT 1];
        BrandQuoteHoldBQ.getRecordName(bq.Id);
        BrandQuoteHoldBQ.holdBQ(bq.Id);
        BrandQuoteHoldBQ.holdBQ(bq.Id);
    }
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
                    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());

    }
}