public class CancelPWOController {
    public Production_Work_Order__c PWO{set;get;}
    public CancelPWOController(ApexPages.StandardController sc){
        PWO = (Production_Work_Order__c) sc.getRecord();
        
    }
    
    public PageReference cancelPWO(){
        PageReference pr;
        Map<String,String> r = updatePWO(PWO.Id);
        if(r.containsKey('success')){
            pr = new PageReference('/'+PWO.Id);
        }else if(r.containsKey('warning')){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,'PWO already cancelled');
            ApexPages.addMessage(msg);
        }else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,r.get('error'));
            ApexPages.addMessage(msg);
        }
		return pr;
    }
    @AuraEnabled
    public static String getPWO(String PWOId){
        Production_Work_Order__c PWOObj = [SELECT Id,Name FROM Production_Work_Order__c WHERE Id = :PWOId];
        
        return PWOObj.Name;
    }
    
    @AuraEnabled
    public static Map<String,String> updatePWO(String PWOId){
        Map<String,String> r = new Map<String,String>();
        Production_Work_Order__c PWOObj = [SELECT Id,Name, Status__c ,Packaging_Status__c FROM Production_Work_Order__c WHERE Id = :PWOId];
        try{
            if(PWOObj.Status__c == 'Cancelled'){
                /*ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,'PWO already cancelled');
                ApexPages.addMessage(msg);*/
                r.put('warning','PWO already cancelled');
                return r;
            }
            PWOObj.Status__c = 'Cancelled';
            PWOObj.Packaging_Status__c = 'Cancelled';
            update PWOObj;
            r.put('success','PWO cancelled successfully');
        }catch(Exception e){
            /*ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(msg);*/
            r.put('error',e.getMessage());
        }
        return r;
    }
    public PageReference redirectToPWO(){
        return new PageReference('/'+PWO.Id);
    }
}