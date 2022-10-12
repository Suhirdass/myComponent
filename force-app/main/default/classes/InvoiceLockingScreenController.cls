public without sharing class InvoiceLockingScreenController {
    private static String Err_Msg_No_Invoices_RevRec{
        get{
            return String.isNotBlank(Err_Msg_No_Invoices_RevRec) ? Err_Msg_No_Invoices_RevRec : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','Err_Msg_No_Invoices_RevRec');
        }set;
    }
    private static String PG_Name_Admin_Lock_Invoice{
        get{
            return String.isNotBlank(PG_Name_Admin_Lock_Invoice) ? PG_Name_Admin_Lock_Invoice : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','PG_Name_Admin_Lock_Invoice');
        }set;
    }
    private static String Err_Msg_User_not_allowed_on_Invoice{
        get{
            return String.isNotBlank(Err_Msg_User_not_allowed_on_Invoice) ? Err_Msg_User_not_allowed_on_Invoice : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','Err_Msg_User_not_allowed_on_Invoice');
        }set;
    }
    private static String Err_Msg_No_RevRecDate_Invoice{
        get{
            return String.isNotBlank(Err_Msg_No_RevRecDate_Invoice) ? Err_Msg_No_RevRecDate_Invoice : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','Err_Msg_No_RevRecDate_Invoice');
        }set;
    }
    private static String Invoice_Ar_Status_Cancelled{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Cancelled) ? Invoice_Ar_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    private static String Invoice_Ar_Status_Rejected{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Rejected) ? Invoice_Ar_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    private static String Lock_All_Invoices_for_RevRec{
        get{
            return String.isNotBlank(Lock_All_Invoices_for_RevRec) ? Lock_All_Invoices_for_RevRec : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','Lock_All_Invoices_for_RevRec');
        }set;
    }
     private static String Msg_For_Blank_RevRec_date_in_Invoice{
        get{
            return String.isNotBlank(Msg_For_Blank_RevRec_date_in_Invoice) ? Msg_For_Blank_RevRec_date_in_Invoice : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Revenue Recognition','Msg_For_Blank_RevRec_date_in_Invoice');
        }set;
    }
    private static String invoice_Collection_Status_Pending{
        get{
            return String.isNotBlank(invoice_Collection_Status_Pending) ? invoice_Collection_Status_Pending : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_Pending');
        }set;
    }
    @AuraEnabled
    public static AuraResponse init(){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.init()');
        Map<Integer,List<monthWrapper>> Months = new Map<Integer,List<monthWrapper>>();
        List<String> monthsLst = getMonths();
        Integer currentYear = System.Today().year();
        List<Revenue_Recognition__c> RevRecList = [SELECT id,Revenue_Recognition_Date__c,IsLocked__c FROM Revenue_Recognition__c WHERE IsLocked__c = true];
        Map<Integer,Map<String,String>> lockedMonths = new  Map<Integer,Map<String,String>>();
        if(RevRecList.size() > 0){
            for(Revenue_Recognition__c RevRec :RevRecList){
                Date rDate = RevRec.Revenue_Recognition_Date__c;
                if(rDate.year() == currentYear ){
                    if(lockedMonths.containsKey(1)){
                        Map<String,String> mLst = lockedMonths.get(1);
                        mLst.put(monthsLst[rDate.month()-1],monthsLst[rDate.month()-1]);
                       lockedMonths.put(1,mLst);
                    }else{
                        System.debug('## enter 1');
                        lockedMonths.put(1,new Map<String,String>{monthsLst[rDate.month()-1] => monthsLst[rDate.month()-1]});
                    }
                    
                }
                if(rDate.year() == currentYear-1){
                    if(lockedMonths.containsKey(0)){
                       Map<String,String> mLst = lockedMonths.get(0);
                        mLst.put(monthsLst[rDate.month()-1],monthsLst[rDate.month()-1]);
                       lockedMonths.put(0,mLst);
                    }else{
                        lockedMonths.put(0,new Map<String,String>{monthsLst[rDate.month()-1] => monthsLst[rDate.month()-1]});
                    }
                    
                }
            }
        }
        for(integer i=0 ; i<2 ; i++){
            List<monthWrapper> mw = new List<monthWrapper>();
            Map<String,String> mMap = new Map<String,String>();
            if(lockedMonths.containsKey(i)){
                mMap = lockedMonths.get(i);
            }
            for(String m :monthsLst){
                if(mMap.size() > 0 && mMap.containsKey(m)){
                     System.debug('## enter 2');
                    mw.add(new monthWrapper(m,true));
                }else{
                    mw.add(new monthWrapper(m,false));
                }
                
            }
            Months.put(i,mw);
        }
        r.data.put('currentYear', currentYear);
        r.data.put('Months', Months);
        return r;
    }
    @AuraEnabled
    public static AuraResponse LockedInvoices( Integer year , Integer month){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.LockedInvoices()');
        List<Invoice__c> invList =[SELECT id,IsLocked__c,Revenue_Recognition_Date__c FROM Invoice__c WHERE  CALENDAR_MONTH(Invoice_Date__c) =: month AND CALENDAR_YEAR(Invoice_Date__c) =: year AND Revenue_Recognition_Date__c != null AND  IsLocked__c = false];
        if(invList.size() > 0){
            List<Invoice__c> InvListForUpdate = new List<Invoice__c>();
            for(Invoice__c inv  :invList){
                inv.IsLocked__c = true; 
                InvListForUpdate.add(inv);
            }
            update InvListForUpdate;
        }
            system.debug('##month : '+ month + '   year :'+year);
            List<Revenue_Recognition__c> RacRecObj = [SELECT id,Revenue_Recognition_Date__c,IsLocked__c FROM Revenue_Recognition__c WHERE Revenue_Recognition_Date__c =: date.parse(month+'/01/'+year) LIMIT 1];
            Revenue_Recognition__c RacRec = new Revenue_Recognition__c();
            if(RacRecObj.size() > 0){
                RacRec.Id = RacRecObj[0].id;
                RacRec.Revenue_Recognition_Date__c = date.parse(month+'/01/'+year);
                RacRec.IsLocked__c = true;
            }else{
                RacRec.Revenue_Recognition_Date__c = date.parse(month+'/01/'+year);
                RacRec.IsLocked__c = true;
            }
            
            upsert RacRec;
        
            /*for(Invoice__c inv : invList){
                inv.IsLocked__c = true;
            }
            update invList;
        }else{
            r.data.put('Error', Err_Msg_No_Invoices_RevRec);
        }*/
        
        return r;
    }
    @AuraEnabled
    public static AuraResponse checkMonthInvoices( Integer year , Integer month){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.checkMonthInvoices()');//AND Revenue_Recognition_Date__c = null  AND IsLocked__c = false
        List<GroupMember> Lock_InvoiceMembers = [SELECT Id,GroupId, UserOrGroupId FROM GroupMember WHERE Group.Name =: PG_Name_Admin_Lock_Invoice];
        Set<Id> allowedGroupIds = new Set<Id>();
        if(Lock_InvoiceMembers.size() > 0){
            for(GroupMember GM:Lock_InvoiceMembers){
                String memberId = GM.UserOrGroupId;
                if(memberId.startsWith('00G')){
                    allowedGroupIds.add(GM.UserOrGroupId);
                }
            }
            if(allowedGroupIds.size() > 0){
                Lock_InvoiceMembers = [SELECT Id,GroupId, UserOrGroupId FROM GroupMember WHERE Group.Name =: PG_Name_Admin_Lock_Invoice OR GroupId IN :allowedGroupIds];
                Boolean isAllowed = false;
                for(GroupMember GM:Lock_InvoiceMembers){
                    if(GM.UserOrGroupId == UserInfo.getUserId()){
                        isAllowed = true;
                        break;
                    }
                }
                if(isAllowed == false){
                    r.data.put('isUserNotAllowed',Err_Msg_User_not_allowed_on_Invoice);
                    return r;
                }
            }
        }
        List<Invoice__c> invList =[SELECT id,IsLocked__c,Revenue_Recognition_Date__c FROM Invoice__c WHERE  CALENDAR_MONTH(Invoice_Date__c) =: month AND CALENDAR_YEAR(Invoice_Date__c) =: year AND AR_Status__c NOT IN (:Invoice_Ar_Status_Cancelled,:Invoice_Ar_Status_Rejected)];
         r.data.put('InvoiceSize', invList.size()); 
        if(invList.size() > 0){
            boolean ckhVail = false;
                for(Invoice__c inv :invList){
                    if(inv.Revenue_Recognition_Date__c == null){
                        ckhVail = true;
                        break;
                    }
                }
            if(ckhVail){
                r.data.put('isPendingInvoices',true);
                r.data.put('Error', Msg_For_Blank_RevRec_date_in_Invoice);
            }else{
                
               r.data.put('Error', Lock_All_Invoices_for_RevRec); 
            }
        }else{
            r.data.put('isNoInvoices',true);
           r.data.put('Error', Err_Msg_No_Invoices_RevRec); 
        }
        return r;
    }
    /*@AuraEnabled
    public static AuraResponse onSaveInvoice( String invJSONStr,String ReciCon,String conEmail ,String conPhone,Decimal payAmt ){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.onSaveInvoice()');
        Invoice__c inv = (Invoice__c) JSON.deserialize(invJSONStr, Invoice__c.class);
        Invoice__c updateInvoice = getInvoice(inv.id);
        updateInvoice.IsLocked__c = true;
        Contact updateCon = new Contact(Id = ReciCon);
        Date datobj = updateInvoice.Revenue_Recognition_Date__c;
                Integer yr = datobj.year();
                Integer mon = datobj.month();
		AuraResponse r2 = checkMonthInvoices(yr,mon);
        if(r2.data.get('InvoiceSize') == 1){
            date rrd =date.parse(mon+'/01/'+yr);
            Revenue_Recognition__c RevRec = new  Revenue_Recognition__c();
            RevRec = [SELECT id,Revenue_Recognition_Date__c,IsLocked__c FROM Revenue_Recognition__c WHERE IsLocked__c = false AND Revenue_Recognition_Date__c=:rrd LIMIT 1];
            if(RevRec != null){
                RevRec.IsLocked__c = true;
                update RevRec;
            }
        }
        if(ReciCon != '' && updateInvoice.Receiver_Contact__c != ReciCon){
            updateInvoice.Receiver_Contact__c = ReciCon;
        }
        if(updateInvoice.Receiver_Contact__r.Email != conEmail){
            updateCon.Email = conEmail;
        }
        if(updateInvoice.Receiver_Contact__r.Phone != conPhone){
            updateCon.Phone = conPhone;
        }
        if(updateInvoice != null){
            update updateInvoice;
            if(updateCon != null)
                update updateCon;
        }
        system.debug('##Invoice of JSON : '+updateInvoice);
        return r;
    }*/
    public static Invoice__c getInvoice(string idStr){
        Invoice__c Invoice = [SELECT Id,IsLocked__c,Name,Receiver_Name__c,Receiver_Name__r.Name,Receiver_DBA__c,Revenue_Recognition_Date__c,Invoice_Date__c,
                              Invoice_Due_Date__c,Payment_Terms__c,Total_Invoice_Amount__c,Invoice_Balance__c,RecordType.Name,Receiver_Contact__c,Receiver_Contact__r.Name,
                              Receiver_Contact__r.Email,Receiver_Contact__r.Phone FROM Invoice__c WHERE Id =: idStr ];
        return Invoice;
    }
    @AuraEnabled
    public static AuraResponse lockAndUnlockToInvoice( String recordId,Boolean isUpdateInv){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.checkInvoice()');
        List<GroupMember> Lock_InvoiceMembers = [SELECT Id,GroupId, UserOrGroupId FROM GroupMember WHERE Group.Name =: PG_Name_Admin_Lock_Invoice];
        Set<Id> allowedGroupIds = new Set<Id>();
        if(Lock_InvoiceMembers.size() > 0){
            for(GroupMember GM:Lock_InvoiceMembers){
                String memberId = GM.UserOrGroupId;
                if(memberId.startsWith('00G')){
                    allowedGroupIds.add(GM.UserOrGroupId);
                }
            }
            if(allowedGroupIds.size() > 0){
                Lock_InvoiceMembers = [SELECT Id,GroupId, UserOrGroupId FROM GroupMember WHERE Group.Name =: PG_Name_Admin_Lock_Invoice OR GroupId IN :allowedGroupIds];
                Boolean isAllowed = false;
                for(GroupMember GM:Lock_InvoiceMembers){
                    if(GM.UserOrGroupId == UserInfo.getUserId()){
                        isAllowed = true;
                        break;
                    }
                }
                if(isAllowed == false){
                    r.data.put('Error',Err_Msg_User_not_allowed_on_Invoice);
                    return r;
                }
            }
        }
        
        Invoice__c Invoice = getInvoice(recordId);
        if(Invoice.Id != null ){
            if(isUpdateInv){
                if(Invoice.Revenue_Recognition_Date__c != null && Invoice.IsLocked__c){
                    Date datobj = Invoice.Invoice_Date__c;
                    Integer yr = datobj.year();
                    Integer mon = datobj.month();
                    //date rrd =date.parse(mon+'/01/'+yr);
                    List<Revenue_Recognition__c> RevRec = [SELECT id,Revenue_Recognition_Date__c,IsLocked__c FROM Revenue_Recognition__c WHERE IsLocked__c = true AND CALENDAR_MONTH(Revenue_Recognition_Date__c) =: mon AND CALENDAR_YEAR(Revenue_Recognition_Date__c) =: yr  LIMIT 1];
                    if(RevRec.size() > 0 ){
                        RevRec[0].IsLocked__c = false;
                        update RevRec[0];
                    }
                }
                Invoice.IsLocked__c = Invoice.IsLocked__c ? false : true;
                //Invoice.Revenue_Recognition_Date__c = Invoice.IsLocked__c ? system.today()  : null;
                update Invoice;
            }else{
                if(Invoice.Revenue_Recognition_Date__c != null){
                     r.data.put('Invoice', Invoice);
                	r.data.put('success','success');
                }else{
                    r.data.put('Error', Err_Msg_No_RevRecDate_Invoice); 
                }
               
            }
        }
        return r;
    }
   /* @AuraEnabled
    public static AuraResponse checkInvoice( String recordId,Boolean isUpdateInv){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.checkInvoice()');
        Invoice__c Invoice = getInvoice(recordId);
        if(Invoice != null && Invoice.IsLocked__c){
            if(isUpdateInv){
                Invoice.IsLocked__c = false;
                update Invoice;
                Date datobj = Invoice.Revenue_Recognition_Date__c;
                Integer yr = datobj.year();
                Integer mon = datobj.month();
                date rrd =date.parse(mon+'/01/'+yr);
                Revenue_Recognition__c RevRec = new  Revenue_Recognition__c();
                RevRec = [SELECT id,Revenue_Recognition_Date__c,IsLocked__c FROM Revenue_Recognition__c WHERE IsLocked__c = true AND Revenue_Recognition_Date__c=:rrd LIMIT 1];
                if(RevRec != null){
                    RevRec.IsLocked__c = false;
                	update RevRec;
                }
                
            }
            
            r.data.put('Invoice', Invoice); 
            r.data.put('success','success');
        }else{
            r.data.put('Error', 'Do not editable invoice because Invoice is not locked.'); 
        }
        return r;
    }*/
   /* @AuraEnabled
    public static AuraResponse getInvoiceReceiverContact( String recordId){
        AuraResponse r = new AuraResponse('InvoiceLockingScreenController.getInvoiceReceiverContact()');
        Contact con = [SELECT id,Name,Email,Phone FROM Contact WHERE id=:recordId];
        r.data.put('ReceiverCon', con); 
        return r;
    }*/
	@AuraEnabled 
    public static List<String> getMonths(){
        List<String> options = new List<String>{'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'};
          
        return options;
    }
    @AuraEnabled
    public static InvoiceDataTableWrapper getInvoiceData(Integer pageNumber, Integer pageSize,Integer year,Integer month) {
         
        //Offset for SOQL
        Integer offset = (pageNumber - 1) * pageSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Invoice__c WHERE  CALENDAR_MONTH(Invoice_Date__c) =: month AND CALENDAR_YEAR(Invoice_Date__c) =: year AND AR_Status__c NOT IN (:Invoice_Ar_Status_Cancelled,:Invoice_Ar_Status_Rejected)];//AND Collections_Status__c =:invoice_Collection_Status_Pending
        Integer recordEnd = pageSize * pageNumber;
 
        //Instance of Contact DataTable Wrapper Class
        InvoiceDataTableWrapper objDT =  new InvoiceDataTableWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.invoiceList = [SELECT Id, Name,Invoice_Date__c,Ship_Confirmation_Date__c,Revenue_Recognition_Date__c,Collections_Status__c,AR_Status__c,Sales_Order__c,Sales_Order__r.Name,RecordType.Name,Invoice_Balance__c FROM Invoice__c WHERE  CALENDAR_MONTH(Invoice_Date__c) =: month AND CALENDAR_YEAR(Invoice_Date__c) =: year AND AR_Status__c NOT IN (:Invoice_Ar_Status_Cancelled,:Invoice_Ar_Status_Rejected) ORDER BY Revenue_Recognition_Date__c NULLS FIRST LIMIT :pageSize OFFSET :offset];//AND Collections_Status__c =:invoice_Collection_Status_Pending
        return objDT;
    }
     
    //Wrapper Class For Contact DataTable  
    public class InvoiceDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Invoice__c> invoiceList {get;set;}
    }
    public class monthWrapper{
        @AuraEnabled
        public Boolean isLockeded {get; set;}
        @AuraEnabled
        public String monthName {get; set;}
        
        public monthWrapper(){
            this.isLockeded = false;
            this.monthName = '';
        }
        public monthWrapper(String m , Boolean l){
            this.isLockeded = l;
            this.monthName = m;
        }
    }
}