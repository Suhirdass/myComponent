public class AuraResponse {
    
    private String scope {get;set;}
    public List<String> errors {get;set;}

    @AuraEnabled
    public Map<String, Object> data {get;set;}
    
    public AuraResponse(String scope){
        this.scope = scope;
        this.errors = new List<String>();
        this.data = new Map<String, Object>();
    }
    
    public void handleException(Exception e){
        System.debug('handleException: ' + this.scope + ' -::- ' + e.getMessage());
        handleException(e, true);
    }
    
    public void handleException(Exception e, Boolean throwAura){
        //@todo implement the logic to save the exception(this.scope, e) into database.
        if(throwAura){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    public void handleErrors(){
        if(!this.errors.isEmpty()){
            //@todo implement the logic to save the errors(this.scope, errors) into database.
            System.debug('handleErrors: ' + this.scope + ' -::- ' + this.errors);
            throw new AuraHandledException(String.join(this.errors, ', ') + '.');   
        }
    }
}