global class BatchNotifyOnExpireCI implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    

    private static String EXCLUDE_INVENTORY_LOCATIONS{
        get{
            return String.isNotBlank(EXCLUDE_INVENTORY_LOCATIONS) ? EXCLUDE_INVENTORY_LOCATIONS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Exclude_Inventory_Locations');
        }set;
    }
    private static String LAB_TEST_STATUS_EXPIRED_COA{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_EXPIRED_COA) ? LAB_TEST_STATUS_EXPIRED_COA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Expired_COA');
        }set;
    }
    private static String LAB_TEST_STATUS_EXPIRED{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_EXPIRED) ? LAB_TEST_STATUS_EXPIRED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Expired');
        }set;
    }
    private static String CI_EXPIRE_DAY_90{
        get{
            return String.isNotBlank(CI_EXPIRE_DAY_90) ? CI_EXPIRE_DAY_90 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','CI_Expire_Day_90');
        }set;
    }
    private static String CI_EXPIRE_DAY_60{
        get{
            return String.isNotBlank(CI_EXPIRE_DAY_60) ? CI_EXPIRE_DAY_60 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','CI_Expire_Day_60');
        }set;
    }
    private static String CI_EXPIRE_DAY_30{
        get{
            return String.isNotBlank(CI_EXPIRE_DAY_30) ? CI_EXPIRE_DAY_30 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','CI_Expire_Day_30');
        }set;
    }
    private static String CI_EXPIRE_DAY_15{
        get{
            return String.isNotBlank(CI_EXPIRE_DAY_15) ? CI_EXPIRE_DAY_15 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','CI_Expire_Day_15');
        }set;
    }
    private static String CI_EXPIRE_DAY_1{
        get{
            return String.isNotBlank(CI_EXPIRE_DAY_1) ? CI_EXPIRE_DAY_1 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','CI_Expire_Day_1');
        }set;
    }
    public static String AVAILABLE_COUNT_STRING{
        get{
            return String.isNotBlank(AVAILABLE_COUNT_STRING) ? AVAILABLE_COUNT_STRING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Available_Count_String_Inventory');
        }set;
    }
    
    private Integer expireDays = Integer.valueOf(CI_EXPIRE_DAY_1);
    
    public BatchNotifyOnExpireCI(Integer days) {
        expireDays = days;
    }
    public BatchNotifyOnExpireCI() {
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
       
        List<String> lstExpire = new List<String>{LAB_TEST_STATUS_EXPIRED_COA, LAB_TEST_STATUS_EXPIRED};
            Date todaydate = Date.today();
        Date lastDate = Date.today().addDays(expireDays);
        if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_1)){
            lastDate =  todaydate;
        }
        
   
        if(!Test.isRunningTest()){
            
            Company_Custom_Settings__c Company_Settings= Company_Custom_Settings__c.getOrgDefaults();
          
            if(Company_Settings.IsFirst_Expire_Batch__c){
                Date firstDate;
                if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_90)){
                    firstDate = Date.today().addDays(Integer.valueOf(CI_EXPIRE_DAY_60));	    
                } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_60)){
                    firstDate = Date.today().addDays(Integer.valueOf(CI_EXPIRE_DAY_30));    
                } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_30)){
                    firstDate = Date.today().addDays(Integer.valueOf(CI_EXPIRE_DAY_15));    
                } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_15)){
                    firstDate = Date.today().addDays(Integer.valueOf(CI_EXPIRE_DAY_1));    
                } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_1)){
               
                    return Database.getQueryLocator([SELECT Id,Name,Lab_Test_Status__c,Producer_State_License__r.Default_Warehouse__r.Name,Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c,Producer_State_License__r.Default_Warehouse__c ,Product__c,Product__r.Product_Short_Description__c,Product__r.Available_Qty__c,Product__r.Total_Inventory__c,Product__r.Name,Product__r.Brand_Name__c,Product__r.Description,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Batch_Size__c,COA_Number__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c,COA_Expiration_Date__c,COA_Issued_Date__c,Terpene_MG_G__c,Terpene__c,CBD_MG_G__c,CBD__c,THC_MG_G__c,THC__c from Compliance_Images__c 
                                                     WHERE COA_Expiration_Date__c = :lastDate AND Lab_Test_Status__c NOT IN : lstExpire AND Product__r.IsActive =: true AND Product__r.Total_Inventory__c > 0]);      
                }
                return Database.getQueryLocator([SELECT Id,Name,Lab_Test_Status__c,Producer_State_License__r.Default_Warehouse__r.Name,Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c,Producer_State_License__r.Default_Warehouse__c ,Product__c,Product__r.Product_Short_Description__c,Product__r.Available_Qty__c,Product__r.Total_Inventory__c,Product__r.Name,Product__r.Brand_Name__c,Product__r.Description,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Batch_Size__c,COA_Number__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c,COA_Expiration_Date__c,COA_Issued_Date__c,Terpene_MG_G__c,Terpene__c,CBD_MG_G__c,CBD__c,THC_MG_G__c,THC__c from Compliance_Images__c 
                                                 WHERE COA_Expiration_Date__c <= :lastDate AND COA_Expiration_Date__c > :firstDate  AND Lab_Test_Status__c NOT IN : lstExpire AND Product__r.IsActive =: true AND Product__r.Total_Inventory__c > 0]);
                
            } else {
                return Database.getQueryLocator([SELECT Id,Name,Lab_Test_Status__c,Producer_State_License__r.Default_Warehouse__r.Name,Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c,Producer_State_License__r.Default_Warehouse__c ,Product__c,Product__r.Product_Short_Description__c,Product__r.Available_Qty__c,Product__r.Total_Inventory__c,Product__r.Name,Product__r.Brand_Name__c,Product__r.Description,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Batch_Size__c,COA_Number__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c,COA_Expiration_Date__c,COA_Issued_Date__c,Terpene_MG_G__c,Terpene__c,CBD_MG_G__c,CBD__c,THC_MG_G__c,THC__c from Compliance_Images__c 
                                        
                                               WHERE   COA_Expiration_Date__c = :lastDate AND Lab_Test_Status__c NOT IN : lstExpire AND Product__r.IsActive =: true AND Product__r.Total_Inventory__c > 0]);    
       
            }
             
        } else {
            return Database.getQueryLocator([SELECT Id,Name,Lab_Test_Status__c,Producer_State_License__r.Default_Warehouse__r.Name,Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c,Producer_State_License__r.Default_Warehouse__c ,Product__c,Product__r.Product_Short_Description__c,Product__r.Available_Qty__c,Product__r.Total_Inventory__c,Product__r.Name,Product__r.Brand_Name__c,Product__r.Description,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Batch_Size__c,COA_Number__c,Product__r.Producer_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c,COA_Expiration_Date__c,COA_Issued_Date__c,Terpene_MG_G__c,Terpene__c,CBD_MG_G__c,CBD__c,THC_MG_G__c,THC__c from Compliance_Images__c 
                                            WHERE COA_Expiration_Date__c = :lastDate AND Lab_Test_Status__c NOT IN : lstExpire AND Product__r.IsActive =: true]);
        }
    }
    global void execute(Database.BatchableContext bc, List<Compliance_Images__c> records){
       
        Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Compliance_Images__c>> mapBrands = new Map<Id,List<Compliance_Images__c>>();
        
        if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_1) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_15) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_30) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_60) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_90)){
            Set<Id> setIds = new Set<Id>();
            for(Compliance_Images__c comp : records){
               
                if(comp.Harvest_Batch_Code__c != null){
                    setIds.add(comp.Harvest_Batch_Code__c);
                }
                if(comp.Product__r.White_Labelled__c){
                    if(comp.Product__r.Licensee_Name__c != null){
                        brandIds.add(comp.Product__r.Licensee_Name__c); 
                        if(mapBrands.containsKey(comp.Product__r.Licensee_Name__c)){
                            mapBrands.get(comp.Product__r.Licensee_Name__c).add(comp);    
                        } else{  mapBrands.put(comp.Product__r.Licensee_Name__c, new List<Compliance_Images__c>{comp});
                        }
                    }     
                } else {
                    if(comp.Product__r.Producer_Name__c != null){
                        if(comp.Product__r.Brand_Name__c != null){
                            brandIds.add(comp.Product__r.Producer_Name__c); 
                            if(mapBrands.containsKey(comp.Product__r.Producer_Name__c)){  mapBrands.get(comp.Product__r.Producer_Name__c).add(comp);    
                            } else{
                                mapBrands.put(comp.Product__r.Producer_Name__c, new List<Compliance_Images__c>{comp});
                            }    
                        }
                    }    
                }
            }
            
            Map<Id,Decimal> mapInventory = new Map<Id,Decimal>();
             
            List<String> lstInvLocNames = EXCLUDE_INVENTORY_LOCATIONS.split(',');
              String missMatchSite;
              String availableQtySplitBySite;
            Map<Id, string> exMap= new map<Id, string>();
            Map<Id, string> exMapQty= new map<Id, string>();
              String missMatchSiteQty;
             Map<Id, string> splitAvailableQtyMap= new map<Id, string>();
           for(Harvest_Batch_Code__c batchRec : [SELECT Id,Name,(SELECT Id,Name,Product_Name__c,COA_Number_New__c,Inventory_Location__r.Name,Inventory_Qty__c,Site__r.Name,Site__r.Warehouse_Name__c FROM Inventory_Positions__r WHERE Inventory_Location__r.Name NOT IN :lstInvLocNames),(SELECT Id,Name,COA_Number__c,Product__c,Producer_State_License__r.Default_Warehouse__r.Name FROM Compliance_Images__r) FROM Harvest_Batch_Code__c WHERE Id IN:setIds ]){
               system.debug('batchRec>>'+batchRec);
                  for(Compliance_Images__c compRec : batchRec.Compliance_Images__r){
                    Decimal totalInvs = 0.00;
                    Decimal totalSiteInvs = 0.00; Decimal totalSameSiteInvs = 0.00;
                    for(Inventory_Position__c inv : batchRec.Inventory_Positions__r){ 
                        if(compRec.Product__c == inv.Product_Name__c && inv.COA_Number_New__c == compRec.COA_Number__c){
                            totalInvs += inv.Inventory_Qty__c;        
                        }
                           if(compRec.Producer_State_License__r.Default_Warehouse__r.Name ==inv.Site__r.Name && compRec.Product__c == inv.Product_Name__c ){
                               totalSameSiteInvs += inv.Inventory_Qty__c; 
                               availableQtySplitBySite = totalSameSiteInvs+' ';
                               splitAvailableQtyMap.put(compRec.Id,availableQtySplitBySite);
                        }
                        if(compRec.Producer_State_License__r.Default_Warehouse__r.Name !=inv.Site__r.Name && compRec.Product__c == inv.Product_Name__c ){    totalSiteInvs += inv.Inventory_Qty__c;     missMatchSite =inv.Site__r.Warehouse_Name__c;  missMatchSiteQty =totalSiteInvs+' '; exMap.put(compRec.Id,missMatchSite); exMapQty.put(compRec.Id,missMatchSiteQty);
                        }
                        
                    }
                    if(totalInvs != 0.00){
                        mapInventory.put(compRec.Id,totalInvs);    
                    } 
                }
                
            }

            
            if(brandIds.size() > 0){
                List<Account> lstAcc = new List<Account>([SELECT Id,Name,
                                                          (SELECT Id,Name,Email,FirstName,Orders_Email_Opt_In__c from Contacts WHERE Active__c =: true AND Orders_Email_Opt_In__c =: true AND ISEmailBounced =: false AND Compliance_Alert__c =: true AND Email != null)
                                                          FROM Account WHERE Id In : brandIds]); 
                
                if(lstAcc.size() > 0){
                    Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];     
                    
                    Boolean isExist = false;
                    
                    for(Compliance_Images__c comp : records){
                        if(mapInventory.containsKey(comp.Id)){
                            if(mapInventory.get(comp.Id) != 0.00){
                                isExist = true;
                            }
                        }
                    }
                    
                    if(isExist){
                        for(Account acc : lstAcc){
                            Integer contactSize = 0;
                            for(Contact con: acc.Contacts){
                                contactSize += 1 ;
                            }
                            List<Compliance_Images__c> lstComp = mapBrands.get(acc.Id);
                            
                            Boolean isExistRec = false;
                            for(Compliance_Images__c comp : lstComp){
                                if(mapInventory.containsKey(comp.Id)){
                                    isExistRec = true;    	
                                }    
                            }
                            
              
                            if(contactSize > 0){
                                if(isExistRec){
                                    for(Contact con: acc.Contacts){
                                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                        mail.bccsender = false;
                                        String htmlBody = 'Hello '+con.FirstName;
                                        if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_1)){
                                            htmlBody += ',<br><br>Our system shows the COA(s) listed below as <b>expired.</b>';
                                            htmlBody += '<br><br>Please let us know how you’d like to proceed for each COA listed.<br><br>Your options at this time are to retest the batch (for resale or donation) or send the products to canna-waste.';
                                            mail.setSubject('EXPIRED COA(s) for '+acc.Name);
                                        } else {
                                            htmlBody += ', <br><br>Our system shows the COA(s) listed below will expire in '+expireDays+' days.';   htmlBody += '<br><br>Please let us know how you’d like to proceed for each COA listed.';
                                            if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_90)){ mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days');  } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_60)){  mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days');   } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_30) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_15)){ mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days!'); 
                                            }
                                        }
                                        
                                        
                                        
                                        htmlBody += '<br><br><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Batch Size</th>';
                                        
                                        
                                        htmlBody += '<th style="border:1px solid #000">COA</th><th style="border:1px solid #000">Issue Date</th><th style="border:1px solid #000">Expiration Date</th><th style="border:1px solid #000">Lab Result</th><th style="border:1px solid #000">THC %</th>';
                                        htmlBody += '<th style="border:1px solid #000">Location</th><th style="border:1px solid #000">Available Inventory</th>';//<th style="border:1px solid #000">THC (MG/G)</th><th style="border:1px solid #000">CBD (%)</th><th style="border:1px solid #000">CDB (MG/G)</th><th style="border:1px solid #000">Terepene (%)</th><th style="border:1px solid #000">Terepene (MG/G)</th></tr>';
                                  
                                        for(Compliance_Images__c comp : lstComp){
                                            if(mapInventory.containsKey(comp.Id) ){
                                                String expDate = '';
                                                String issueDate = '';
                                                if(comp.COA_Issued_Date__c != null) {
                                                    Datetime dt = (Datetime)comp.COA_Issued_Date__c;  
                                                    issueDate = DateTime.newInstance(comp.COA_Issued_Date__c.year(),comp.COA_Issued_Date__c.month(),comp.COA_Issued_Date__c.day()).format('MM/dd/yyyy');
                                                }
                                                if(comp.COA_Expiration_Date__c != null) {
                                                    Datetime dt = (Datetime)comp.COA_Expiration_Date__c;  
                                                    expDate = DateTime.newInstance(comp.COA_Expiration_Date__c.year(),comp.COA_Expiration_Date__c.month(),comp.COA_Expiration_Date__c.day()).format('MM/dd/yyyy');
                                                }
                                                
                                                htmlBody +='<tr style="border:1px solid #000">'
                                                    +'<td style="border:1px solid #000">'+comp.Product__r.Product_Short_Description__c+'</td>';
                                                
                                                if(comp.Harvest_Batch_Code__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__r.Name+'</td>';	    
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Batch_Size__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Batch_Size__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                
                                                if(comp.COA_Number__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.COA_Number__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.COA_Issued_Date__c != null) htmlBody += '<td style="border:1px solid #000">'+issueDate+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.COA_Expiration_Date__c != null) htmlBody += '<td style="border:1px solid #000">'+expDate+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Lab_Test_Status__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Lab_Test_Status__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.THC__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.THC__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Producer_State_License__r.Default_Warehouse__c != null)
                                                {
                                                    htmlBody += '<td style="border:1px solid #000">'; if(splitAvailableQtyMap.containsKey(comp.Id)) { htmlBody +=comp.Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c;
                                                  
                                                         }
                                                    
                                                    if(exMap.containsKey(comp.Id) && splitAvailableQtyMap.containsKey(comp.Id)) {  htmlBody += '<hr> '; } if(exMap.containsKey(comp.Id)) {   htmlBody +=  exMap.get(comp.Id);  } htmlBody += '</td>';
                                                  
                                                }
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                  if(comp.Producer_State_License__r.Default_Warehouse__c != null)
                                                {
                                                    htmlBody += '<td style="border:1px solid #000">';  if(splitAvailableQtyMap.containsKey(comp.Id)) { htmlBody += +' '+splitAvailableQtyMap.get(comp.Id);  }
                                                    
                                                    if(exMap.containsKey(comp.Id) && splitAvailableQtyMap.containsKey(comp.Id)) { htmlBody += '<hr> ';   }
                                                  
                                                        if(exMap.containsKey(comp.Id)) { htmlBody +=  exMapQty.get(comp.Id); } htmlBody += '</td>';
                                                  
                                                }
                                                else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                                 
                                         } 
                                            
                                            
                                            
                                        }
                                        htmlBody +='</table>';
                                        
                                        List<String> listOfToAddresses = new List<String>();
                                        listOfToAddresses.add(con.Email);
                                        List<String> ccEmails = label.DL_ASR.split(',');
                                        if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_90) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_15) || expireDays == 1){
                                            mail.setCcAddresses(new List<String>{ccEmails[0]}); 
                                        } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_60) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_30)){
                                            List<String> marketingEmails = label.DL_Marketing.split(','); ccEmails.addAll(marketingEmails); mail.setCcAddresses(ccEmails); 
                                        }
                                        
                                        if(orgWide != null)
                                            mail.setOrgWideEmailAddressId(orgWide.Id);
                                        mail.setHtmlBody(htmlBody);
                                        mail.setTargetObjectId(con.Id);
                                        mail.setSaveAsActivity(false);
                                        mail.setToAddresses(listOfToAddresses); 
                                        emails.add(mail);
                                    }
                                }
                            } 
                            else {
                                Boolean isExistRecord = false;
                                for(Compliance_Images__c comp : lstComp){
                                    if(mapInventory.containsKey(comp.Id)){
                                        isExistRecord = true;    	
                                    }    
                                }
                              
                                if(isExistRecord){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    String htmlBody = 'Hello';
                                    mail.bccsender = false;
                                    if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_1)){
                                        htmlBody += ',<br><br>Our system shows the COA(s) listed below as <b>expired.</b>';
                                        htmlBody += '<br><br>Please let us know how you’d like to proceed for each COA listed.<br><br>Your options at this time are to retest the batch (for resale or donation) or send the products to canna-waste.';
                                        mail.setSubject('EXPIRED COA(s) for '+acc.Name);
                                    } else {
                                        htmlBody += ', <br><br>Our system shows the COA(s) listed below will expire in '+expireDays+' days.';    
                                        htmlBody += '<br><br>Please let us know how you’d like to proceed for each COA listed.';
                                        if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_90)){ mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days');     
                                        } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_60)){ mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days');   
                                        } else if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_30) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_15)){ mail.setSubject(acc.Name + ' COA(s) expiring in '+expireDays+ ' Days!'); 
                                        }
                                    }
                                    
                                   htmlBody += '<br><br><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Batch Size</th>';
                                        
                                        
                                        htmlBody += '<th style="border:1px solid #000">COA</th><th style="border:1px solid #000">Issue Date</th><th style="border:1px solid #000">Expiration Date</th><th style="border:1px solid #000">Lab Result</th><th style="border:1px solid #000">THC %</th>';
                                        htmlBody += '<th style="border:1px solid #000">Location</th><th style="border:1px solid #000">Available Inventory</th>';//<th style="border:1px solid #000">THC (MG/G)</th><th style="border:1px solid #000">CBD (%)</th><th style="border:1px solid #000">CDB (MG/G)</th><th style="border:1px solid #000">Terepene (%)</th><th style="border:1px solid #000">Terepene (MG/G)</th></tr>';
                                  
                                        for(Compliance_Images__c comp : lstComp){
                                            if(mapInventory.containsKey(comp.Id) ){
                                                String expDate = '';
                                                String issueDate = '';
                                                if(comp.COA_Issued_Date__c != null) {
                                                    Datetime dt = (Datetime)comp.COA_Issued_Date__c;  
                                                    issueDate = DateTime.newInstance(comp.COA_Issued_Date__c.year(),comp.COA_Issued_Date__c.month(),comp.COA_Issued_Date__c.day()).format('MM/dd/yyyy');
                                                }
                                                if(comp.COA_Expiration_Date__c != null) {
                                                    Datetime dt = (Datetime)comp.COA_Expiration_Date__c;  
                                                    expDate = DateTime.newInstance(comp.COA_Expiration_Date__c.year(),comp.COA_Expiration_Date__c.month(),comp.COA_Expiration_Date__c.day()).format('MM/dd/yyyy');
                                                }
                                                
                                                htmlBody +='<tr style="border:1px solid #000">'
                                                    +'<td style="border:1px solid #000">'+comp.Product__r.Product_Short_Description__c+'</td>';
                                                
                                                if(comp.Harvest_Batch_Code__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__r.Name+'</td>';	    
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Batch_Size__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Batch_Size__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                
                                                if(comp.COA_Number__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.COA_Number__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.COA_Issued_Date__c != null) htmlBody += '<td style="border:1px solid #000">'+issueDate+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.COA_Expiration_Date__c != null) htmlBody += '<td style="border:1px solid #000">'+expDate+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Lab_Test_Status__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.Lab_Test_Status__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.THC__c != null) htmlBody += '<td style="border:1px solid #000">'+comp.THC__c+'</td>';
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                
                                                if(comp.Producer_State_License__r.Default_Warehouse__c != null)
                                                {
                                                    htmlBody += '<td style="border:1px solid #000">';
                                                         if(splitAvailableQtyMap.containsKey(comp.Id)) {
                                                           htmlBody +=comp.Producer_State_License__r.Default_Warehouse__r.Warehouse_Name__c;
                                                         }
                                                    
                                                    if(exMap.containsKey(comp.Id) && splitAvailableQtyMap.containsKey(comp.Id)) {
                                                       htmlBody += '<hr> '; 
                                                    }
                                                  
                                                        if(exMap.containsKey(comp.Id)) {
                                                            htmlBody +=  exMap.get(comp.Id); 
                                                        } htmlBody += '</td>';
                                                  
                                                }
                                                else htmlBody += '<td style="border:1px solid #000"></td>';
                                                  if(comp.Producer_State_License__r.Default_Warehouse__c != null)
                                                {
                                                    htmlBody += '<td style="border:1px solid #000">';
                                                         if(splitAvailableQtyMap.containsKey(comp.Id)) {
                                                         
                                                    htmlBody += +' '+splitAvailableQtyMap.get(comp.Id);
                                                         }
                                                    
                                                    if(exMap.containsKey(comp.Id) && splitAvailableQtyMap.containsKey(comp.Id)) {
                                                       htmlBody += '<hr> '; 
                                                    }
                                                  
                                                        if(exMap.containsKey(comp.Id)) {
                                                            htmlBody +=  exMapQty.get(comp.Id); 
                                                        } htmlBody += '</td>';
                                                  
                                                }
                                                else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                                 
                                         } 
                                            
                                            
                                            
                                        }
                                        htmlBody +='</table>';
                                    List<String> ccEmails = label.DL_ASR.split(',');
                                    List<String> toAddresses = new List<String>();
                                    toAddresses.add(ccEmails[0].trim());
                                    
                                    if(expireDays == Integer.valueOf(CI_EXPIRE_DAY_60) || expireDays == Integer.valueOf(CI_EXPIRE_DAY_30)){
                                        List<String> lstCC = new List<String>();
                                        for(Integer i=1; i < ccEmails.size(); i++){
                                            lstCC.add(ccEmails[i]);    
                                        }
                                        if(lstCC.size() > 0)mail.setCcAddresses(lstCC); 
                                        
                                        List<String> marketingEmails = label.DL_Marketing.split(',');
                                        toAddresses.addAll(marketingEmails);
                                    }
                                    
                                   mail.setToAddresses(toAddresses);
                                    if(orgWide != null)
                                     mail.setOrgWideEmailAddressId(orgWide.Id);
                                    mail.setHtmlBody(htmlBody);
                                    mail.setSaveAsActivity(false);
                                    emails.add(mail);
                                }
                            }
                        }    
                    }
                    
                  
                    if(emails.size() > 0){
                        Messaging.sendEmail(emails);
                        
                        Company_Custom_Settings__c Company_Settings= Company_Custom_Settings__c.getOrgDefaults();
                        Company_Settings.IsFirst_Expire_Batch__c = false;
                        update Company_Settings;
                    }
                }
            }
        }
    }
    global void execute(SchedulableContext sc){
        Company_Custom_Settings__c Company_Settings= Company_Custom_Settings__c.getOrgDefaults();
        if(Company_Settings.Expire_Days__c != null){
            List<String> expDays = Company_Settings.Expire_Days__c.split(',');
            for(String day : expDays){
                Database.executeBatch(new BatchNotifyOnExpireCI(Integer.valueOf(day)));    
            }
        }
    } 
    
    global void finish(Database.BatchableContext bc){} 
}