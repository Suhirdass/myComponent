@isTest
public class BatchToMigrateAttachmentToFilesTest {
    private static testmethod void runTest(){
        Invoice__c lstInvoice = new Invoice__c();
        lstInvoice.Ship_Confirmation_Date__c = Date.today();
        lstInvoice.Posted_Date__c = null;
        lstInvoice.AR_Status__c = 'Shipped';
        lstInvoice.Collections_Status__c = 'Pending';
        insert lstInvoice;
        
        Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=lstInvoice.id;
        insert attach;
        
        BatchToMigrateAttachmentToFiles batch= new BatchToMigrateAttachmentToFiles();
		ID rec = Database.executeBatch(batch);
    }
}