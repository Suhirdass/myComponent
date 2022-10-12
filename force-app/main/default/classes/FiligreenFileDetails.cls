public class FiligreenFileDetails {
    public  transient String templateBody{set;get;}
    public  transient String templateBodyPDF{set;get;}
    public  String JSONData{set;get;}
    public  String quoteName{set;get;}
    public  String recordId{set;get;}
    public  String objectName{set;get;}
    public  FG_Template__c template{set;get;}
    public Boolean isAuthenticating{set;get;}
    public Boolean isLoadingTemplate{set;get;}
    public Boolean isPreparingData{set;get;}
    public Boolean isDataPrepared{set;get;}
    public Boolean isDocumentNameRequired{set;get;}
    public Boolean isSaveAsAttachment{set;get;}
    public Boolean isLogActivity{set;get;}
    public String documentName{set;get;}
    public String selectedTemplatedId{set;get;}
    public List<SelectOption> templateOptions{set;get;}
    public FiligreenFileDetails(){
        this.templateOptions = new List<SelectOption>();
        this.templateBody = '';
        this.templateBodyPDF = '';
        this.JSONData = '{}';
        this.quoteName = '';
        this.recordId = '';
        this.objectName = '';
        this.template = new FG_Template__c();
        this.isAuthenticating = false;
        this.isLoadingTemplate = false;
        this.isPreparingData = false;
        this.isDataPrepared = false;
        this.documentName = '';
        this.isDocumentNameRequired = false;
        this.isSaveAsAttachment = true;
        this.isLogActivity = true;
    }
}