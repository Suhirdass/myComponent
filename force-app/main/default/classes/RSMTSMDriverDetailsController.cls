public with sharing class RSMTSMDriverDetailsController
{
    //TSM Details
    // TSM Iterable to process
    public CustomIterable retreiveTSMIterable {get; set;}
        
     // List TSM to display per page
    public List<RetreiveTSMWrapper> setTSM {get; set;}
    
    // TSM list to process
    public List<RetreiveTSMWrapper> tsmList {get; set;}
    
    public List<Shipping_Manifest__c> retrievetsmList {get; set;}

    
    public Boolean hasTSM {get; set;}
    
    public Boolean hideDatePicker {get; set;}
    
    public Drivers__c objDriver {get; set;}
    
     // Page size to display number of TSM per page
    public String pageSizeTSM {get; set;}
    
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    
    string userName;
    
     // Constructor - Initialize the values
    public RSMTSMDriverDetailsController(){
        dat = date.today();
        tsmList = new List<RetreiveTSMWrapper>();
        setTSM = new List<RetreiveTSMWrapper>();       
        
        pageSizeTSM = '10';
        rsmList = new List<RetreiveRSMWrapper>();
        setRSM = new List<RetreiveRSMWrapper>();       
        pageSizeRSM = '10';
        
        objDriver = new Drivers__c();
        
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        
        getDriverUserdetails();
    }   
    
    public void getDriverUserdetails(){
        userName = UserInfo.getName();
               
        system.debug('userName---'+userName);
        
        List <Drivers__c> lstDriver = [select id, Name, Driver_License_Number__c, Expiration_Date__c, Driver_License_Class__c, State_Issued__c, Active__c, License_Expired__c
                     From Drivers__c where Name =: userName limit 1];
                     
        if(lstDriver.size() > 0){
            
            if(lstDriver[0].License_Expired__c){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Driver License is Expired!'));
                hideDatePicker = false;  
                
            }else{
                objDriver= lstDriver[0];
                hideDatePicker = true;
            }
        }else{
        
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'User is not a Driver User!'));
             hideDatePicker = false;  
        
        }
    
    }
    
    public void retreiveTSMRSM() {        
        String queryTSM= '';
        String strFilter = '';
        hasTSM = false;
        hasRSM = false;
        tsmList = new List<RetreiveTSMWrapper>();
        setTSM = new List<RetreiveTSMWrapper>(); 
        rsmList = new List<RetreiveRSMWrapper>();
        setRSM = new List<RetreiveRSMWrapper>();    
        system.debug('dat'+dat);
        

        if(dat == null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select a Valid Date and Try Again !'));

        }        
        
        else{
            if(dat != null)
            {
                strFilter  = strFilter  +  ' AND Planned_Ship_Transfer_Date__c =: dat AND Driver__r.Name =: userName';
            }
    
            if(strFilter != '')
            {           
                Integer limitRecords = LIMITS.getLimitQueryRows();
                queryTSM = 'Select Name ,id, Status__c, Planned_Ship_Transfer_Date__c, Driver__c, Actual_Arrival_Date_Time__c, Actual_Departure_Date_Time__c from Shipping_Manifest__c Where RecordTypeId =: tsmRecordTypeId '+strFilter+ ' order by id limit 1000';
                retrievetsmList = Database.query(queryTSM);
                System.debug('retrievetsmList..'+retrievetsmList);

            }
        
            System.debug('retrievetsmList..'+ retrievetsmList);
        
        
            for(Shipping_Manifest__c tsm : retrievetsmList){
                RetreiveTSMWrapper tsmWrapper = new RetreiveTSMWrapper(tsm);
                tsmList.add(tsmWrapper);

            }
        
            if(tsmList != null && tsmList.size() > 0) {
                    hasTSM = true;
                    System.debug('tsmList..'+tsmList);
                    retreiveTSMIterable = new CustomIterable(tsmList, Integer.valueOf(pageSizeTSM)); 
                    System.debug('retreiveTSMIterable..'+retreiveTSMIterable);
                    nextTSM();
                    System.debug('setTSM..'+ setTSM);

            }
        
             String queryRSM= '';
            String sreFilter = '';
            system.debug('dat'+dat);

        
            if(dat != null)
            {
               sreFilter  = sreFilter  +  ' AND Planned_Ship_Transfer_Date__c =: dat AND Driver__r.Name =: userName';
            }
        
            if(sreFilter != '')
            {           
                Integer limitRecords = LIMITS.getLimitQueryRows();
                queryRSM = 'Select Name ,id, Status__c, Planned_Ship_Transfer_Date__c, Receiver_Acceptance_Date__c, Driver__c, Actual_Departure_Date_Time__c from Shipping_Manifest__c Where RecordTypeId =: rsmRecordTypeId '+sreFilter+ ' order by id limit 1000';
                retrieversmList = Database.query(queryRSM);
                System.debug('retrieversmList..'+retrieversmList);
    
            }
            
            System.debug('retrieversmList..'+ retrieversmList);
            
            
            for(Shipping_Manifest__c rsm : retrieversmList){
                    RetreiveRSMWrapper rsmWrapper = new RetreiveRSMWrapper(rsm);
                    rsmList.add(rsmWrapper);
    
            }
            
            if(rsmList != null && rsmList.size() > 0) {
                    hasRSM = true;
                    System.debug('rsmList..'+rsmList);
                    retreiveRSMIterable = new CustomIterable(rsmList, Integer.valueOf(pageSizeRSM)); 
                    System.debug('retreiveRSMIterable..'+retreiveRSMIterable);
                    nextRSM();
                    System.debug('setRSM..'+ setRSM);
    
            }
                
        }          
    }
    
    /**
     * Change the number of TSM to display according to selected page size
     */
    public PageReference doResetTSMPageSize() {
        retreiveTSMIterable = new CustomIterable(tsmList, Integer.valueOf(pageSizeTSM)); 
        nextTSM(); 
        return null;
    }
    
    /**
     * Get Page size options to display number of inventory positions per page
     */
    public List<SelectOption> getPageSizeOptionsTSM() {
        List<SelectOption> options = new List<SelectOption>();

        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('25', '25'));
        options.add(new SelectOption('50', '50'));
        options.add(new SelectOption('100', '100'));
        
        return options; 
    }
    
    // flag to check if next and last link should be disabled or not
    public Boolean hasNextTSM {
        get{
            return retreiveTSMIterable.hasNext();
        }
        set;
    }
    
    // flag to check if previous and first link should be disabled or not
    public Boolean hasPreviousTSM {
        get{
            return retreiveTSMIterable.hasPrevious();
        }
        set;
    }
    
    // TSM to be displayed on next link
    public void nextTSM(){
        setTSM.clear();
        for(Object tsm :retreiveTSMIterable.next()) {
            setTSM.add((RetreiveTSMWrapper)tsm);
        }
        System.debug('setTSM in next..'+ setTSM);
    }
    
    // TSM to be displayed on previous link
    public void previousTSM(){
        setTSM.clear();
        for(Object tsm :retreiveTSMIterable.previous()) {
            setTSM.add((RetreiveTSMWrapper)tsm);
        }
    }
    
    // TSM to be displayed on first link
    public void firstTSM(){
        setTSM.clear();
        for(Object tsm :retreiveTSMIterable.first()) {
            setTSM.add((RetreiveTSMWrapper)tsm);
        }
    }
    
    // TSM to be displayed on last link
    public void lastTSM(){
        setTSM.clear();
        for(Object tsm :retreiveTSMIterable.last()) {
            setTSM.add((RetreiveTSMWrapper)tsm);
        }
    }
    
     // Wrapper class to store TSM details
    public class RetreiveTSMWrapper{
        public Shipping_Manifest__c tsm {get; set;}
        public Boolean isSelectedTSM {get; set;}

        
        // Constructor
        public RetreiveTSMWrapper(Shipping_Manifest__c tsm){
            this.isSelectedTSM = false;            
            this.tsm = tsm;
            
        }
    }
    
    
    //RSM Details
    // RSM Iterable to process
    public CustomIterable retreiveRSMIterable {get; set;}
        
     // List RSM to display per page
    public List<RetreiveRSMWrapper> setRSM {get; set;}
    
    // RSM list to process
    public List<RetreiveRSMWrapper> rsmList {get; set;}
    
    public List<Shipping_Manifest__c> retrieveRSMList {get; set;}

    
    public Boolean hasRSM {get; set;}
    
     // Page size to display number of RSM per page
    public String pageSizeRSM {get; set;}
    
    public String datename {get; set;}
    public Date dat {get;set;}
    
    
    /*public void retreiveRSM() {        
        String queryRSM= '';
        String sreFilter = '';
        system.debug('dat'+dat);
        
        Date myDate = date.newinstance(dat.year(), dat.month(), dat.day());        
        system.debug('myDate'+myDate);
        
        if(dat != null)
        {
           sreFilter  = sreFilter  +  ' where Planned_Ship_Transfer_Date__c =: dat';
        }
    
        if(sreFilter != '')
        {           
            Integer limitRecords = LIMITS.getLimitQueryRows();
            queryRSM = 'Select Name ,id, Status__c, Planned_Ship_Transfer_Date__c, Receiver_Acceptance_Date__c, Actual_Departure_Date_Time__c from Shipping_Manifest__c '+sreFilter+ ' limit 1000';
            retrieversmList = Database.query(queryRSM);
            System.debug('retrieversmList..'+retrieversmList);

        }
        
        System.debug('retrieversmList..'+ retrieversmList);
        
        
        for(Shipping_Manifest__c rsm : retrieversmList){
            RetreiveRSMWrapper rsmWrapper = new RetreiveRSMWrapper(rsm);
            rsmList.add(rsmWrapper);

        }
        
        if(rsmList != null && rsmList.size() > 0) {
            hasRSM = true;
            System.debug('rsmList..'+rsmList);
            retreiveRSMIterable = new CustomIterable(rsmList, Integer.valueOf(pageSizeRSM)); 
            System.debug('retreiveRSMIterable..'+retreiveRSMIterable);
            nextRSM();
            System.debug('setRSM..'+ setRSM);

        }
                
    }*/
    
    /**
     * Change the number of inventory positions to display according to selected page size
     */
    public PageReference doResetRSMPageSize() {
        retreiveRSMIterable = new CustomIterable(rsmList, Integer.valueOf(pageSizeRSM)); 
        nextRSM(); 
        return null;
    }
    
    /**
     * Get Page size options to display number of inventory positions per page
     */
    public List<SelectOption> getPageSizeOptionsRSM() {
        List<SelectOption> options = new List<SelectOption>();

        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('25', '25'));
        options.add(new SelectOption('50', '50'));
        options.add(new SelectOption('100', '100'));
        
        return options; 
    }
    
    // flag to check if next and last link should be disabled or not
    public Boolean hasNextRSM {
        get{
            return retreiveRSMIterable.hasNext();
        }
        set;
    }
    
    // flag to check if previous and first link should be disabled or not
    public Boolean hasPreviousRSM {
        get{
            return retreiveRSMIterable.hasPrevious();
        }
        set;
    }
    
    // RSM to be displayed on next link
    public void nextRSM(){
        setRSM.clear();
        for(Object rsm :retreiveRSMIterable.next()) {
            setRSM.add((RetreiveRSMWrapper)rsm);
        }
        System.debug('setRSM in next..'+ setRSM);
    }
    
    // RSM to be displayed on previous link
    public void previousRSM(){
        setRSM.clear();
        for(Object rsm :retreiveRSMIterable.previous()) {
            setRSM.add((RetreiveRSMWrapper)rsm);
        }
    }
    
    // RSM to be displayed on first link
    public void firstRSM(){
        setRSM.clear();
        for(Object rsm :retreiveRSMIterable.first()) {
            setRSM.add((RetreiveRSMWrapper)rsm);
        }
    }
    
    // RSM to be displayed on last link
    public void lastRSM(){
        setRSM.clear();
        System.debug('setRSM in last clear..'+ setRSM);
        for(Object rsm :retreiveRSMIterable.last()) {
            setRSM.add((RetreiveRSMWrapper)rsm);
        }
        System.debug('setRSM in last..'+ setRSM);
    }
    
     // Wrapper class to RSM details
    public class RetreiveRSMWrapper{
        public Shipping_Manifest__c rsm {get; set;}
        public Boolean isSelectedRSM {get; set;}
                
        // Constructor
        public RetreiveRSMWrapper(Shipping_Manifest__c rsm){
            this.isSelectedRSM = false;
            this.rsm = rsm;
            
        }
    }
    
    
     /**
     * Redirect to default view of RSMTSMDriverDetails page
     *
     * @return PageReference of current page
     */
    private PageReference redirectToRSMTSMDriverDetailsPage() {
        PageReference page = new PageReference('/apex/RSMTSMDriverDetails');
        page.setRedirect(true);
        return page;
    }
    
    public PageReference updateRSMTSM(){
        
       Savepoint savePoint;
       
       boolean isAnyRSMSelected = false;
       boolean isAnyTSMSelected = false;
        
        try {
        
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
        
            List<Shipping_Manifest__c> lstTSMtoUpdate= new List<Shipping_Manifest__c >();
            
            for(RetreiveTSMWrapper objTSMwrapper: setTSM){
                
                if(objTSMwrapper.isSelectedTSM && objTSMwrapper.tsm.Actual_Departure_Date_Time__c == null){
                        
                        isAnyRSMSelected = true;    
                       
                        objTSMwrapper.tsm.Status__c = 'Received';
                        objTSMwrapper.tsm.Actual_Departure_Date_Time__c = System.now();
                    
                        
                        lstTSMtoUpdate.add(objTSMwrapper.tsm);
                  
                 }
                    
             }
             
            
            List<Shipping_Manifest__c > lstRSMtoUpdate= new List<Shipping_Manifest__c >();
            
            for(RetreiveRSMWrapper objRSMwrapper: setRSM){
                
                if(objRSMwrapper.isSelectedRSM && objRSMwrapper.rsm.Receiver_Acceptance_Date__c== null){
                    
                        isAnyRSMSelected = true;
                        
                        objRSMwrapper.rsm.Status__c= 'Shipment complete';
                        objRSMwrapper.rsm.Receiver_Acceptance_Date__c= System.now();
                    
                        
                        lstRSMtoUpdate.add(objRSMwrapper.rsm);
                  
                 }
                    
             }
             
             
             if(!isAnyRSMSelected || !isAnyRSMSelected ){
                ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Select any RSM/TSM to Update!');
                ApexPages.addMessage(message);
                return null;
             
             }
             
             update lstTSMtoUpdate;
             update lstRSMtoUpdate;
         }
        
         catch (Exception ex) {
            Database.rollback(savePoint);
            
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(message);
            return null;
        }
        return redirectToRSMTSMDriverDetailsPage();
    }
    
}