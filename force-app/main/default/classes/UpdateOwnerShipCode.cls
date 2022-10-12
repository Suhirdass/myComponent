public class UpdateOwnerShipCode implements Database.Batchable<sObject>{
    
    private String objectName = '';
    private String productFieldName = '';
    private String ref = '';
    public UpdateOwnerShipCode(String objectName,String productFieldName){
        this.objectName = objectName;
        this.productFieldName = productFieldName;
        if(productFieldName.equalsIgnoreCase('product2Id')){
             ref = productFieldName.replace('2Id','2');
        }else{
             ref = productFieldName.replace('__c','__r');
        }
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        String whLabeled = ref+'.White_Labelled__c';
        String pName = ref+'.Producer_Name__c';
        String lName = ref+'.Licensee_Name__c';
        DateTime dt = DateTime.newInstance(2019, 1, 1, 00, 00, 00);
        String query = 'SELECT Id,Ownership_code__c,'+productFieldName+','+whLabeled+','+pName+','+lName+' FROM '+objectName;
        query += '  WHERE createdDate >= 2018-01-01T00:00:00.000+0000 AND Ownership_code__c = NULL';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<SObject> items = new List<SObject>();
        for(SObject item : scope)
        {
            Sobject prod = (sObject) item.getSObject(ref);
            String ownerId = '';
            if(item.get(productFieldName) != null){
                if(Boolean.valueOf( prod.get('White_Labelled__c'))){
                    ownerId = String.valueOf(prod.get('Licensee_Name__c'));
                }else{
                    ownerId = String.valueOf(prod.get('Producer_Name__c'));
                }
            }
            sobject sobj = Schema.getGlobalDescribe().get(objectName).newSObject(); 
            sobj.put('Id', String.valueOf(item.get('Id')));
            sobj.put('Ownership_code__c',ownerId);
            items.add(sobj);
        }
        System.debug('Items.size()::'+Items.size());
        Database.update(items,false);
    }
    
    public void finish(Database.BatchableContext BC){}
    public static void updateCode(String objectName, String productFieldName){
        
        
        
    }
}