public class AssignPackoutUIDController {
     private Static String Confirmation_for_QA_Record { 
        get{
            return  String.isNotBlank(Confirmation_for_QA_Record) ? Confirmation_for_QA_Record :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Quality Assurance','Confirmation_for_QA_Record');
        }set;
    }
    public static String QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST{
        get{
            return String.isNotBlank(QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST) ? QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Quality Assurance','Quality_Assurance_RecordType_QA_Picklist');
        }set;
    }
      public static String ERR_MSG_REQUIRED_QR_CODE{
        get{
            return String.isNotBlank(ERR_MSG_REQUIRED_QR_CODE) ? ERR_MSG_REQUIRED_QR_CODE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_Required_QR');
        }set;
    }
     public static String ERR_MSG_REQUIRED_BAR_CODE{
        get{
            return String.isNotBlank(ERR_MSG_REQUIRED_BAR_CODE) ? ERR_MSG_REQUIRED_BAR_CODE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_Required_Bar_Label');
        }set;
    }
    
    @AuraEnabled
    public static AuraResponse getStatus(String picklistId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.getPicklist()');
        Picklist__c pickListRec = [SELECT Status__c,Name FROM Picklist__c WHERE Id =:picklistId LIMIT 1];
     
        r.data.put('pickListName', pickListRec.Name);
        r.data.put('pickListStatus', pickListRec.Status__c);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getPicklist(String picklistId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.getPicklist()');
        
        
        
        String pickListName = [SELECT Name FROM Picklist__c WHERE Id =:picklistId].Name;
        r.data.put('pickListName', pickListName);
        
        List<Picklist_Line__c> lstPicklist = new List<Picklist_Line__c>([SELECT Id,Name,IsPromo__c,Sales_Order_Line__c,Sales_Order_Line__r.Name,Product_Name__c,Product_Name__r.Name,Harvest_Batch_or_Lot_Code__c,UID__c,Inventory_Position__r.UID_New__c,
                                         Inventory_Position__c,Inventory_Position__r.Name,Inventory_Position__r.Harvest_Batch_Code__c,Qty_to_Pick__c,QA_Status__c,QA_Count__c,
                                         Pack_out_UID__c,Pack_out_UID__r.Name,Producer_Name__c,Ownership__c,Inventory_Position__r.Ownership__c,Lab_Test_Status__c,Is_Sample__c,Unit_Price__c
                                         FROM Picklist_Line__c WHERE Picklist__c =: picklistId ORDER BY Product_Name__r.Name,Unit_Price__c,Harvest_Batch_or_Lot_Code__c ASC]);
        
        Picklist__c thePicklist = [select Name, Id, Brand_Quote__c, Sales_Order__c, Scheduled_Pick_Date__c, Ownership__c, Site__c,Site__r.Name, Site__r.Warehouse_Name__c,
                                   Sales_Order__r.Name, Sales_Order__r.Distributor_Name__r.DBA__c, Sales_Order__r.Distributor_Name__c,Sales_Order__r.Receiver_Name__r.DBA__c, 
                                   Sales_Order__r.Receiver_Name__c, Sales_Order__r.Receiver_Name__r.Name,Sales_Order__r.Supplier_Name__r.DBA__c,Sales_Order__r.Receiver_Name__r.QR_Code__c, Sales_Order__r.Receiver_Name__r.Bar_Code__c,Sales_Order__r.Supplier_Name__c, Sales_Order__r.FG_Record_Type__c, Sales_Order__r.Receiver_Contact__c,
                                   Sales_Order__r.Receiver_Contact__r.Name, Sales_Order__r.Customer_PO_or_Quote__c from Picklist__c where id =: picklistId];
        string notemessage;
        boolean receiverQR = thePicklist.Sales_Order__r.Receiver_Name__r.QR_Code__c;
        boolean receiverBar = thePicklist.Sales_Order__r.Receiver_Name__r.Bar_Code__c;
        
        if(receiverQR == true && receiverBar == true)
        {
            boolean notemessageBarCode = true;
            r.data.put('notemessageBarCode', notemessageBarCode);
            
            
        }else if(receiverQR== true)
            
        {
            notemessage =ERR_MSG_REQUIRED_QR_CODE;
            r.data.put('notemessage', notemessage);
            
            
        }else if(receiverBar == true)
            
        {
            notemessage = ERR_MSG_REQUIRED_BAR_CODE;
            r.data.put('notemessage', notemessage);
            
            
        }
        r.data.put('lstPicklist', lstPicklist);
        r.data.put('thePicklist', thePicklist);
        if(lstPicklist.size() > 0){
            Set<Id> pickLineIds = (new Map<Id,Picklist_Line__c>(lstPicklist)).keySet();
            List<Quality_Assurance__c> lstQA = [SELECT ID,Name,Picklist_Line__c FROM Quality_Assurance__c WHERE Picklist_Line__c In :pickLineIds];
            r.data.put('QARecords', lstQA);
        }
          String loggedUserUserName = UserInfo.getName();
            picklist__c pick = [select id ,Sales_Order__c,Site__c,Site__r.Name from  picklist__c where id  =: picklistId];
            List<Site_User__c> lstusersitedata =[select id ,name,User__c,User__r.Name ,User_Active__c,Site__c,Site__r.Active__c,Active__c from Site_User__c where User__r.Name =:loggedUserUserName and Site__c=:pick.Site__c and Site__r.Active__c=True and User_Active__c=True and Active__c=True];
            system.debug('usersite>>>>'+lstusersitedata); 
            system.debug('usersite>>>>'+lstusersitedata.size());
            
            if(lstusersitedata.size()==0){
               r.data.put('errormsgSite',true);
                return r;  
            }
        
      
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse assignPackout(String jsonLineItem){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.assignPackoutUID()');
        if(jsonLineItem != '' && jsonLineItem != null){
            List<Picklist_Line__c> pickLineItem = new List<Picklist_Line__c>();
            pickLineItem = (List<Picklist_Line__c>) System.JSON.deserialize(jsonLineItem, List<Picklist_Line__c>.class);
        	
            if(pickLineItem.size() > 0){
            	update pickLineItem;   
            }
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse createQARec(String qaRecord, String picklistId){
    	AuraResponse r = new AuraResponse('AssignPackoutUIDController.createQARec()');
        if(qaRecord != '' && qaRecord != null){
            
            Quality_Assurance__c qaRec = (Quality_Assurance__c) System.JSON.deserialize(qaRecord, Quality_Assurance__c.class);
            if(qaRec != null){
                
                Id recTypeId = Schema.SObjectType.Quality_Assurance__c.getRecordTypeInfosByName().get(QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST).getRecordTypeId();
                qaRec.RecordTypeId = recTypeId;
                insert qaRec;
            }
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse createQARecord(Id recordId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.createQARecord()');
        Boolean showpopup = false;
        List<PickList_Line__c> plList = [Select Id, Name, Picklist__c,(select Id From Quality_Assurances__r) FROM Picklist_Line__c where Picklist__c =: recordId];
        String alreadyCreatedQAName = '';
        List<string> alreadyQAIds = new List<string>();
        List<Quality_Assurance__c> qaList = new List<Quality_Assurance__c>();
        String recordType = Schema.SObjectType.Quality_Assurance__c.getRecordTypeInfosByName().get(QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST).getRecordTypeId();
        for(PickList_Line__c pl : plList){
            if(pl.Quality_Assurances__r.size() > 0 ){
                    showpopup = true;
                    alreadyCreatedQAName += alreadyCreatedQAName == '' ? pl.Name : ', '+pl.Name;
                    alreadyQAIds.add(pl.Id);
                }else{
                    Quality_Assurance__c QA = new Quality_Assurance__c();
                    QA.Picklist_Line__c = pl.Id;
                    QA.Pass_All__c = true;
                    QA.RecordTypeId = recordType;
                    qaList.add(QA);
                }
        }
        
        if(qaList.size() > 0 ){
            insert qaList;
        }
        
        r.data.put('showpopup',showpopup);
        r.data.put('Confirmation_for_QA_Record', Confirmation_for_QA_Record.replace('{0}', alreadyCreatedQAName));
        r.data.put('alreadyQAIds',alreadyQAIds);
       
        return r;
       
    }
    @AuraEnabled
    public static AuraResponse createNewMassQARecord(List<String> recordIds){
        AuraResponse r = new AuraResponse('MassQAController.createNewRecord()');
        String recordType = Schema.SObjectType.Quality_Assurance__c.getRecordTypeInfosByName().get(QUALITY_ASSURANCE_RECORD_TYPE_QA_PICKLIST).getRecordTypeId();
        List<PickList_Line__c> plList = [Select Id, Name, Picklist__c FROM Picklist_Line__c where Id IN : recordIds];
        List<Quality_Assurance__c> qaList = new List<Quality_Assurance__c>();
        for(PickList_Line__c rl : plList){
            Quality_Assurance__c QA = new Quality_Assurance__c();
            QA.PickList_Line__c = rl.Id;
            QA.Pass_All__c = true;
            QA.RecordTypeId = recordType;
            qaList.add(QA);
        }
        if(qaList.size() > 0 ){
            insert qaList;
        }
        return r;
        
    }
     /** check UID in use true or false**/

    @AuraEnabled 
    public static AuraResponse checkRecordInUse(String recordId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.checkRecordInUse()');
        UID__c  uidRes = [select id, name,In_Use__c from UID__c  where id =:recordId];
        if(uidRes.In_Use__c == true){
            r.data.put('messageactive',true);    
            return r;      
        }
        return r;
    }
    
}