public class testbatch implements Database.Batchable<SObject>, Database.AllowsCallouts {
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([SELECT Id, Name FROM Account]);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scopes) {
         Account acc = scopes[0];
         //use the relative url of your page
     
         PageReference pr = Page.InvoicePDFshipManifest;
         pr.getParameters().put('id','a0b6s000000pt2MAAQ');       
         Blob content = pr.getContent(); 
     
         Attachment att=new Attachment();
         att.Body=content;
         att.Name='test.pdf';
         att.parentId= acc.id;
         insert att;
   }
    
    public void finish(Database.BatchableContext context) {
        //
    }
}