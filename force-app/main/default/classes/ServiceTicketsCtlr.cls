public without sharing class ServiceTicketsCtlr {
    private static String RECURSYEARLY{
        get{
            return String.isNotBlank(RECURSYEARLY) ? RECURSYEARLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearly');
        }set;
    }
    private static String RECURSYEARLYNTH{
        get{
            return String.isNotBlank(RECURSYEARLYNTH) ? RECURSYEARLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearlyNth');
        }set;
    }
    private static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    private static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    private static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    private static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    private static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    private static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    private static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    private static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    private static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    private static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    private static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    private static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    private static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    private static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    private static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    private static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    private static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FIRST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FIRST) ? HOLIDAY_RECURRENCE_FIRST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_First');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_SECOND{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_SECOND) ? HOLIDAY_RECURRENCE_SECOND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Second');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_THIRD{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_THIRD) ? HOLIDAY_RECURRENCE_THIRD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Third');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FOURTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FOURTH) ? HOLIDAY_RECURRENCE_FOURTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Fourth');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    private static String IT_DISABLE_BATCH_UID_FAMILIES_1{
        get{
            return String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_1) ? IT_DISABLE_BATCH_UID_FAMILIES_1 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','IT_Disable_Batch_UID_Families_1');
        }set;
    }
    private static String IT_DISABLE_BATCH_UID_FAMILIES_2{
        get{
            return String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_2) ? IT_DISABLE_BATCH_UID_FAMILIES_2 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','IT_Disable_Batch_UID_Families_2');
        }set;
    }
    private static String IT_DISABLE_BATCH_UID_FAMILIES_3{
        get{
            return String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_3) ? IT_DISABLE_BATCH_UID_FAMILIES_3 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','IT_Disable_Batch_UID_Families_3');
        }set;
    }
    private static String IT_DISABLE_BATCH_UID_FAMILIES{
        get{
            return String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES) ? IT_DISABLE_BATCH_UID_FAMILIES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','IT_Disable_Batch_UID_Families') + (String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_1) ? ';' + IT_DISABLE_BATCH_UID_FAMILIES_1 : '') + (String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_2) ? ';' + IT_DISABLE_BATCH_UID_FAMILIES_2 : '') + (String.isNotBlank(IT_DISABLE_BATCH_UID_FAMILIES_3) ? ';' + IT_DISABLE_BATCH_UID_FAMILIES_3 : '');
        }set;
    }
    private static String IT_DISABLE_COA_NUMBER_STATUSES{
        get{
            return String.isNotBlank(IT_DISABLE_COA_NUMBER_STATUSES) ? IT_DISABLE_COA_NUMBER_STATUSES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','IT_Disable_COA_Numner_Statuses') ;
        }set;
    }
    private static String STATE_LICENSE_DROPOFF_TYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_DROPOFF_TYPE) ? STATE_LICENSE_DROPOFF_TYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_DropOff_Type') ;
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    public static Id brandId = Utility.loggedInUser.AccountId;
    public static Company_Custom_Settings__c defaultIDs = Company_Custom_Settings__c.getOrgDefaults();
    
    
    @AuraEnabled
    public static AuraResponse init(String recordId){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getBrandProducts()');
        Map<String, String> defaultLicense = new Map<String, String>();
        Map<Id,State_Licenses__c> stateLicenseMap = new Map<Id,State_Licenses__c>();
        //Company_Custom_Settings__c defaultIDs = Company_Custom_Settings__c.getOrgDefaults();
        
        Map<Id,State_Licenses__c> filigreenStateLicenseMap = new Map<Id,State_Licenses__c>();
        List<Map<String, String>> filigreenLicenses = new List<Map<String, String>>();
        //Set<String>licenseIdSet = new Set<String>();
        
        List<Map<String, String>> activeSites = new List<Map<String, String>>();
        List<Map<String, String>> pickupTransporterLicenses = new List<Map<String, String>>();
        Map<Id,Site__c> activeSiteMap = new Map<Id,Site__c>();
        for(Site__c site : [select Id,Name,Warehouse_Name__c,License_ID__c,License_ID__r.License_DBA__c,License_ID__r.License_Number__c,License_ID__r.License_Type__c,License_ID__r.License_Address__c,
                            License_ID__r.License_Zip__c, License_ID__r.License_Country__c, License_ID__r.License_State__c, 
                            License_ID__r.License_City__c from Site__c where Active__c = true]){
        	activeSites.add(new Map<String, String>{'value'=> site.Id, 'label'=> site.Warehouse_Name__c});    
            activeSiteMap.put(site.Id,site);
            pickupTransporterLicenses.add(new Map<String, String>{'value'=> site.License_ID__c, 'label'=>site.License_ID__r.License_Number__c+' | '+site.License_ID__r.License_DBA__c});                    
        }
        r.data.put('activeSites', activeSites);
        r.data.put('activeSiteMap', activeSiteMap);
        r.data.put('pickupTransporterLicenses', pickupTransporterLicenses);
        
        
        State_Licenses__c defaultStateLicense ;
        if(defaultIDs != null){
            defaultLicense = new Map<String, String>{'value'=> defaultIDs.Default_License__c , 'label'=>defaultIDs.Route_Origin_Address__c };
            for(State_Licenses__c sl: [SELECT License_Number__c,License_Type__c,License_Address__c, License_Zip__c, License_Country__c, License_State__c, License_City__c,Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c FROM State_Licenses__c WHERE Id = :defaultIDs.Default_License__c]){
                defaultStateLicense = sl;
            }
        }
        r.data.put('perUnitWeights', Utility.getPicklistItems('Service_Ticket_Line__c', 'Per_Unit_Weight_g__c'));
        r.data.put('desiredRetailReadyForms', Utility.getPicklistItems('Service_Ticket_Line__c', 'Desired_Retail_Ready_Form__c'));
        r.data.put('preRollPackagings', Utility.getPicklistItems('Service_Ticket_Line__c', 'PreRoll_Packaging__c'));
        r.data.put('tamperTypes', Utility.getPicklistItems('Service_Ticket_Line__c', 'Tamper_Type__c'));
        r.data.put('testStatus', Utility.getPicklistItems('Service_Ticket_Line__c', 'Test_Status__c'));
        r.data.put('packageTypes', Utility.getPicklistItems('Service_Ticket_Line__c', 'Package_Type__c'));
        r.data.put('topFrontLabels', Utility.getPicklistItems('Service_Ticket_Line__c', 'Top_Front_Label__c'));
        r.data.put('bottomBackLabels', Utility.getPicklistItems('Service_Ticket_Line__c', 'Bottom_Back_Label__c'));
        r.data.put('bodyTubeLabels', Utility.getPicklistItems('Service_Ticket_Line__c', 'Body_Tube_Label__c'));
        r.data.put('THCCBDClaim_Labels', Utility.getPicklistItems('Service_Ticket_Line__c', 'THC_CBD_Claim_Label__c'));
        r.data.put('Cone_Size', Utility.getPicklistItems('Service_Ticket_Line__c', 'Cone_Size__c'));
        //r.data.put('loggedInUserContactId',Utility.loggedInUser.ContactId);
        List<Map<String, String>> licenses = new List<Map<String, String>>();
        
        Map<String,State_Licenses__c[]> pickUpFromMap = new Map<String,State_Licenses__c[]>();
        List<Map<String, String>> pickUpFromDBA = new List<Map<String, String>>();
        for(State_Licenses__c sl : [SELECT License_Number__c,License_Type__c,License_Address__c, License_Zip__c, License_Country__c,
                                    License_State__c, License_City__c,Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,License_Name__c,
                                    Default_Warehouse__r.License_ID__c,Default_Warehouse__r.License_ID__r.License_Address__c,License_DBA__c,
                                    Default_Warehouse__r.License_ID__r.License_Zip__c,Default_Warehouse__r.License_ID__r.License_Country__c,
                                    Default_Warehouse__r.License_ID__r.License_State__c,Default_Warehouse__r.License_ID__r.License_City__c
                                    FROM State_Licenses__c WHERE License_Status__c = :'Active' AND (License_Name__c = :brandId OR State_License_Holder__c =:brandId)]){
       
       		if(pickUpFromMap.containsKey(sl.License_Name__c)){
                pickUpFromMap.get(sl.License_Name__c).add(sl);
            }else{
                pickUpFromMap.put(sl.License_Name__c , new State_Licenses__c[]{sl});
            }                            
        }
        
        Map<String,Contact[]> onSiteContactMap = new Map<String,Contact[]>();
        for(Account acc : [SELECT Id,Name,(Select Id,Name FROM Contacts WHERE Active__c =: true AND Email != null) FROM Account WHERE Id In : pickUpFromMap.keySet()]){        
            for(Contact con : acc.Contacts){
                if(onSiteContactMap.containsKey(acc.Id)){
                    onSiteContactMap.get(acc.Id).add(con);
                }else{
                    onSiteContactMap.put(acc.Id , new Contact[]{con});
                }     
            }
        }
        r.data.put('onSiteContactMap',onSiteContactMap);
        
        List<Map<String, String>> pickupDBA = new List<Map<String, String>>();
        for(String str : pickUpFromMap.keySet()){
            pickupDBA.add(new Map<String, String>{'value'=> str, 'label'=> pickUpFromMap.get(str)[0].License_DBA__c});
        }
        r.data.put('pickUpFromDBA',pickupDBA);
        r.data.put('pickUpFromMap',pickUpFromMap);
        
        
        
        Boolean isDropOffAvailable = false;
        List<String> lcTypes = new List<String>{'Type 11','Type 12'};
		List<Map<String, String>> transporterLicenses = new List<Map<String, String>>();
        
        for(State_Licenses__c sl: [SELECT License_Number__c,Id,License_Name__r.DBA__c,License_Status__c,License_Name__r.Hide_from_Marketplace__c,License_Type__c
                                   FROM State_Licenses__c WHERE License_Status__c = :'Active' /*AND License_Name__r.Hide_from_Marketplace__c = false*/ AND Default_Warehouse__r.Active__c = true AND License_Type__c IN :lcTypes ]){
        	transporterLicenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=>sl.License_Number__c+' | '+sl.License_Name__r.DBA__c});	                               
        }
        r.data.put('transporterLicenses',transporterLicenses);
        
        for(State_Licenses__c sl: [SELECT License_Number__c,License_Type__c,License_Address__c, License_Zip__c, License_Country__c,License_Name__c,
                                   License_State__c, License_City__c,Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,
                                   Default_Warehouse__r.License_ID__c,Default_Warehouse__r.License_ID__r.License_Address__c,
                                   Default_Warehouse__r.License_ID__r.License_Zip__c,Default_Warehouse__r.License_ID__r.License_Country__c,
                                   Default_Warehouse__r.License_ID__r.License_State__c,Default_Warehouse__r.License_ID__r.License_City__c
                                   FROM State_Licenses__c WHERE License_Status__c = :'Active' AND (License_Name__c = :brandId OR State_License_Holder__c =:brandId)]){
            List<String> address = new List<String>();
            if(String.isNotBlank(sl.License_Address__c)){
                address.add(sl.License_Address__c);
            }
            
            if(String.isNotBlank(sl.License_City__c)){
                address.add(sl.License_City__c);
            }
            if(String.isNotBlank(sl.License_State__c)){
                address.add(sl.License_State__c);
            }
            if(String.isNotBlank(sl.License_Country__c)){
                address.add(sl.License_Country__c);
            }
            if(String.isNotBlank(sl.License_Zip__c)){
                address.add(sl.License_Zip__c);
            }
            stateLicenseMap.put(sl.Id,sl);
            
            List<String> dropOffTypes = STATE_LICENSE_DROPOFF_TYPE.split(';'); 
            
            if(sl.Default_Warehouse__c != null && sl.Default_Warehouse__r.Warehouse_Name__c != null){
                licenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=>sl.License_Number__c+' | '+String.join(address, ', ')});    	
                
                for(Integer i=0; i < dropOffTypes.size(); i++){
                    if(sl.License_Type__c == dropOffTypes[i] ){
                        filigreenStateLicenseMap.put(sl.License_Name__c,sl);
                        isDropOffAvailable = true; 
                        filigreenLicenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=>sl.License_Number__c+' | '+String.join(address, ', ')});
                    }
                }
            } else {
                for(Integer i=0; i < dropOffTypes.size(); i++){
                    if(sl.License_Type__c == dropOffTypes[i] ){
                        filigreenStateLicenseMap.put(sl.License_Name__c,sl);
                        isDropOffAvailable = true; 
                        filigreenLicenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=> sl.License_Number__c+' - '+String.join(address, ', ')});
                    }
                }
                licenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=> sl.License_Number__c+' | '+String.join(address, ', ')});
            }
        }
        r.data.put('filigreenLicenses', filigreenLicenses);
        r.data.put('isDropOffAvailable',isDropOffAvailable);
        r.data.put('filigreenStateLicenseMap', filigreenStateLicenseMap);
        r.data.put('licenses', licenses);
        r.data.put('stateLicenseMap', stateLicenseMap);
        r.data.put('defaultLicense', defaultLicense);
        r.data.put('defaultStateLicense', defaultStateLicense);
        Set<Id> productIds = new Set<Id>();
        Map<Id,BrandProduct> productMap = new Map<Id,BrandProduct>();
        BrandProduct[] products = new BrandProduct[]{};
            for(Product2 p: [SELECT Name,Product_Short_Description__c FROM Product2 WHERE  ( (Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Licensee_Name__c = :brandId AND White_Labelled__c = true)) AND IsActive = true AND  RecordType.Name NOT IN ('Discount') ORDER BY Name]){//Hide_From_Marketplace__c = false AND
                productIds.add(p.Id);
                BrandProduct prd = new BrandProduct(p);
                productMap.put(p.Id,prd);
                if(Test.isRunningTest()){
                    products.add(prd);
                }
            }
        Map<Id,PriceBookEntry> productPriceBooks = new Map<Id,PriceBookEntry>();
        if(!productIds.isEmpty()){
            for(PriceBookEntry pbe :[SELECT Id,Product2Id,Product2.Family,Product2.Name,Product2.MOQ__c,Product2.Product_Short_Description__c,UnitPrice FROM PriceBookEntry WHERE PriceBook2.Name = 'Standard Price Book' AND isActive= true AND Product2Id IN :productIds ORDER BY Product2.Name]){
                productPriceBooks.put(pbe.Product2Id,pbe);
            }
        }
        
        for(Id pId: productPriceBooks.keySet()){
            products.add(productMap.get(pId));
        }
        
        r.data.put('productPriceBooks',productPriceBooks);
        r.data.put('products', products);
        
        BrandContact[] contacts = new BrandContact[]{};
            for(Contact p: [SELECT Name FROM Contact WHERE AccountId = :brandId AND Active__c =: true Order By Name]){
                contacts.add(new BrandContact(p));
            }
        r.data.put('contacts', contacts);
        
        ServiceTicket st = new ServiceTicket();
        List<ServiceTicketLine> serviceTicketLines = new List<ServiceTicketLine>();
        if(String.isNotBlank(recordId)){
            for(Service_Ticket__c tmpST: [SELECT Id,Name,CreatedDate,Destination_Site__c,Destination_Site__r.Warehouse_Name__c,
                                          Destination_Site__r.License_ID__c,Destination_Site__r.License_ID__r.License_Address__c,
                                          Destination_Site__r.License_ID__r.License_Number__c,Transporter__c,Transporter__r.License_Name__r.DBA__c,
                                          Transporter__r.License_Number__c,Licensed_Premise__r.License_DBA__c,
                                          Destination_Site__r.License_ID__r.License_Zip__c,Destination_Site__r.License_ID__r.License_Country__c,
                                          Destination_Site__r.License_ID__r.License_State__c,Destination_Site__r.License_ID__r.License_City__c,
                                          Brand_Name__r.DBA__c, Brand_Name__c, Brand_Name__r.Name, Brand_Contact__c,
                                          Brand_Contact__r.Name, Transfer_Method__c, Licensed_Premise__c,Brand_Name__r.Membership_Level__c,
                                          Licensed_Premise__r.License_Number__c,Licensed_Premise__r.License_Type__c,Licensed_Premise__r.License_Name__c,
                                          Licensed_Premise_Address__c, Drive_And_Contact_Details__c, Pass_through_Payment__c, Status__c,Total_Service_Lines__c,
                                          Request_Date_Time__c,DL__c,Employee__c,Vehicle_Make__c,Vehicle_Model__c,License_Plate__c,
                                          Special_Instruction__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c    
                                          FROM Service_Ticket__c WHERE Id = :recordId AND Status__c IN ('Pending','Draft','Accepted','Completed','Cancelled') AND
                                          Brand_Name__c = :brandId]){
                                              st = new ServiceTicket(tmpST);
                                              st.passThroughPayment = tmpST.Pass_through_Payment__c;
                                              st.destinationSiteId = tmpST.Destination_Site__c;
                                              st.destinationSiteName = tmpST.Destination_Site__r.Warehouse_Name__c;
                                              st.transportLicenseName = tmpST.Transporter__r.License_Number__c+' | '+tmpST.Transporter__r.License_Name__r.DBA__c;
                                              st.pickupFromDBA = tmpST.Licensed_Premise__r.License_Name__c;
                                              st.pickupFromDBAName = tmpST.Licensed_Premise__r.License_DBA__c;
                                              st.membershipLevel = tmpST.Brand_Name__c != null ? tmpST.Brand_Name__r.Membership_Level__c : '';
                                              List<String> lstLaAddress = new List<String>();
                                              String siteAddress;  
                                              if(tmpST.Destination_Site__r.License_ID__c != null){
                                                  if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Address__c)){
                                                      lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Address__c);
                                                  }
                                                  if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_City__c)){
                                                      lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_City__c);
                                                  }
                                                  if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_State__c)){
                                                      lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_State__c);
                                                  }
                                                  if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Country__c)){
                                                      lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Country__c);
                                                  }
                                                  if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Zip__c)){
                                                      lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Zip__c);
                                                  }
                                                  siteAddress = String.join(lstLaAddress, ', ');
                                                  siteAddress = tmpST.Destination_Site__r.License_ID__r.License_Number__c + ' | '+siteAddress;
                                              }                              
                                              st.destinationSiteAddress = siteAddress;
                                          }
            
            if(String.isNotBlank(st.id)){
                Service_Ticket_Line__c[] STLines = [SELECT  Desired_Retail_Ready_Form__c,New_Packaged_Product__r.Description,New_Packaged_Product__r.Product_Short_Description__c,New_Batch_ID__c,
                                                    New_Batch_ID__r.Name,Medium_Label_Qty__c,Small_Label_Qty__c,Large_Label_Qty__c, Expected_Arrival_At_Filligreen__c, 
                                                    Filligreen_Packaging_Date__c, Harvest_Batch_ID__c, Per_Unit_Weight_g__c, PreRoll_Packaging__c,
                                                    Product_Description__c, Product_Family__c, Qty_Per_Multi_Unit__c, /*Retail_Ready_Cannabis_Weight_g__c,*/ 
                                                    Retail_Wholesale_Price__c, Service_Ticket__c, Strain__c, Strain_Type__c, Test_Required__c, Total_Cannabis_Weight_g__c, 
                                                    Total_Units__c, UID__c,Tamper_Type__c ,Package_Type__c, Spl_Packaging_Notes__c,Transfer_of_Custody__c,Top_Front_Label__c,
                                                    Bottom_Back_Label__c,Body_Tube_Label__c,THC_CBD_Claim_Label__c , Qty_of_Misc_Label__c, COA_Number__c,Status__c,
                                                    Total_Qty__c,Total_Quoted_Price__c,Cone_Size__c,New_Packaged_Product__c,New_Packaged_Product__r.Name,UID_New__c,Product__r.MOQ__c,
                                                    UID_New__r.Name,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Source_Batch_ID__c,Source_Batch_ID__r.Name,Test_Status__c,Product__c,Product__r.Name,Product__r.Product_Short_Description__c,Total_Weight_lbs__c, Weight_to_Order_Ratio__c, Weight_to_Mileage_Fee__c,Product__r.Unit_Shipping_Weight_lbs__c,
                                                    (SELECT Id, Packaging_Status__c, Released_Date__c  FROM Production_Work_Orders__r)
                                                    FROM Service_Ticket_Line__c 
                                                    WHERE Service_Ticket__c = :recordId 
                                                    ORDER BY Name];
                if(STLines.size() > 0){
                    Set<Id> serviceIdSet = new Set<Id>();
                    for(Service_Ticket_Line__c service : STLines){
                        serviceIdSet.add(service.Id);
                    }  
                    
                    Map<String,ContentDocumentLink> mapFileIds = new Map<String,ContentDocumentLink>();
                    for(ContentDocumentLink cont : [SELECT Id, LinkedEntityId,ContentDocumentId,ContentDocument.title FROM ContentDocumentLink WHERE LinkedEntityId in : serviceIdSet]){
                        mapFileIds.put(cont.LinkedEntityId,cont);
                    }
                    
                    for(Service_Ticket_Line__c tmpSTL: STLines){
                        System.debug('serviceTicketLines = '+tmpSTL.Qty_Per_Multi_Unit__c);
                        if(mapFileIds.containskey(tmpSTL.Id)){
                            serviceTicketLines.add(new ServiceTicketLine(tmpSTL,true,mapFileIds.get(tmpSTL.Id)));    
                        } else {
                            serviceTicketLines.add(new ServiceTicketLine(tmpSTL,false));  
                        }
                    }
                }
            }
        }
        if(serviceTicketLines.isEmpty()){
            if(!contacts.isEmpty()){
                User brandUser = [SELECT ContactId,Contact.Name FROM User WHERE Id = :UserInfo.getUserId()];
                st.brandContactId = brandUser.ContactId;//Utility.loggedInUser.ContactId;
                st.brandContact = brandUser.Contact.Name;
            }
            serviceTicketLines.add(new ServiceTicketLine());
        }
        
        if(st.requestDate != null){
            String str = st.requestDate+'';
            String[] lstStr = str.split(' ');
            System.debug('Hello = '+st.id);
            
            String strDate = lstStr[0];
            String[] lstStrDate = strDate.split('-');
            
            str = lstStrDate[1]+'-'+lstStrDate[2]+'-'+lstStrDate[0];
            
            AuraResponse resp = ServiceTicketsCtlr.calanderEvents(str,st.requestTime);
            r.data.put('slots', resp.data.get('slots'));
        }
        
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        if(Community_Settings.containsKey('default')){
            r.data.put('cutOffTime', Community_Settings.get('default').ST_Cutoff_time__c);
        }
        
        String Service_Type_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Service_Type_Tooltip');
        String Product_Name_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Product_Name_Tooltip');
        String Product_SKU_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Product_SKU_Tooltip');
        String Batch_ID_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Batch_ID_Tooltip');
        String Total_Qty_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Total_Qty_Tooltip');
        String Special_Instructions_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Special_Instructions_Tooltip');
        String Units_per_Case_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Units_per_Case_Tooltip');
		String UID_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','UID_Tooltip');
        String Test_Status_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Test_Status_Tooltip');
        String Test_Required_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','Test_Required_Tooltip');
        String COA_Number_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket_Line__c','COA_Number_Tooltip');
        r.data.put('Service_Type_Tooltip', Service_Type_Tooltip != null ? Service_Type_Tooltip : '');
        r.data.put('Product_Name_Tooltip', Product_Name_Tooltip != null ? Product_Name_Tooltip : '');
        r.data.put('Product_SKU_Tooltip', Product_SKU_Tooltip != null ? Product_SKU_Tooltip : '');
        r.data.put('Batch_ID_Tooltip', Batch_ID_Tooltip != null ? Batch_ID_Tooltip : '');
        r.data.put('Total_Qty_Tooltip', Total_Qty_Tooltip != null ? Total_Qty_Tooltip : '');
        r.data.put('Units_per_Case_Tooltip', Units_per_Case_Tooltip != null ? Units_per_Case_Tooltip : '');
        r.data.put('Special_Instructions_Tooltip', Special_Instructions_Tooltip != null ? Special_Instructions_Tooltip : '');
        r.data.put('UID_Tooltip', UID_Tooltip != null ? UID_Tooltip : '');
        r.data.put('Test_Status_Tooltip', Test_Status_Tooltip != null ? Test_Status_Tooltip : '');
        r.data.put('Test_Required_Tooltip', Test_Required_Tooltip != null ? Test_Required_Tooltip : '');
        r.data.put('COA_Number_Tooltip', COA_Number_Tooltip != null ? COA_Number_Tooltip : '');
        r.data.put('IT_DISABLE_BATCH_UID_FAMILIES', IT_DISABLE_BATCH_UID_FAMILIES);
        r.data.put('IT_DISABLE_COA_NUMBER_STATUSES', IT_DISABLE_COA_NUMBER_STATUSES);
        
        List<String> lstLaAddress = new List<String>();
        String laAddressId;
        String laAddress;
        for(State_Licenses__c sl: [SELECT License_Number__c,License_Address__c, License_Zip__c, License_Country__c, License_State__c, License_City__c FROM State_Licenses__c WHERE Name =: 'SLID-2019-05-0000003159']){
            
            if(String.isNotBlank(sl.License_Address__c)){
                lstLaAddress.add(sl.License_Address__c);
            }
            
            if(String.isNotBlank(sl.License_City__c)){
                lstLaAddress.add(sl.License_City__c);
            }
            if(String.isNotBlank(sl.License_State__c)){
                lstLaAddress.add(sl.License_State__c);
            }
            if(String.isNotBlank(sl.License_Country__c)){
                lstLaAddress.add(sl.License_Country__c);
            }
            if(String.isNotBlank(sl.License_Zip__c)){
                lstLaAddress.add(sl.License_Zip__c);
            }
            laAddress = String.join(lstLaAddress, ', ');
            laAddressId = sl.Id;
        }
        r.data.put('laAddress', laAddress);
        r.data.put('laAddressId', laAddressId);
        
        r.data.put('serviceTicket', st);
        System.debug('serviceTicketLines = '+serviceTicketLines);
        r.data.put('serviceTicketLines', serviceTicketLines);
        r.data.put('tmpServiceTicketLine', new ServiceTicketLine());
        
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
                holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
                holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        
        return r;
    }
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
    	List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        
        while(todayDt <= holidayEndDt){
        	if(businessHolidDay.RecurrenceType == RECURSYEARLY){
                todayDt = todayDt.addYears(1);
            }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                todayDt = todayDt.addYears(1);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){
            	date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){
                todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){
            	todayDt = todayDt.addDays(1);
            }    
            holidayList.add(getDateStr(todayDt));       
        }
        return holidayList;
    }
    Public  static string getDateStr(Date holidayDate){
    	string dtStr = holidayDate.month()+'-'+holidayDate.Day()+'-'+holidayDate.year();  
        return dtStr;
    }
    Public  static integer getMonthNumber(string monthName){
        if(monthName == JANUARY_MONTH){
            return 1;
        }else if(monthName == FEBRUARY_MONTH){
            return 2;
        }else if(monthName == MARCH_MONTH){
            return 3;
        }else if(monthName == APRIL_MONTH){
            return 4;
        }else if(monthName == MAY_MONTH){
            return 5;
        }else if(monthName == JUNE_MONTH){
            return 6;
        }else if(monthName == JULY_MONTH){
            return 7;
        }else if(monthName == AUGUST_MONTH){
            return 8;
        }else if(monthName == SEPTEMBER_MONTH){
            return 9;
        }else if(monthName == OCTOBER_MONTH){
            return 10;
        }else if(monthName == NOVEMBER_MONTH){
            return 11;
        }else if(monthName == DECEMBER_MONTH){
            return 12;
        }return 1;
    }
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){
            integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear);
            integer day = 0;
            if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){
                day = Date.daysInMonth(year, month);  
            } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2)
                weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)
                weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8)
                weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 64)
                weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){
                weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){
                weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){
                weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))
                weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
    @AuraEnabled
    public static AuraResponse calanderEvents(String reqDateTime,String reqTime){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.calanderEvents()');
        List<CalendarEvent> slots = new List<CalendarEvent>();
        //Date reqDate = Date.parse(reqDateTime);
        
        System.debug('REQ Date  = '+reqDateTime);
        
        String[] dts = reqDateTime.split('-');
        Date reqDate = date.newinstance(Integer.valueOf(dts[2]), Integer.valueOf(dts[0]), Integer.valueOf(dts[1]));
        
        System.debug('Hello  '+UserInfo.getUserId());
        
        System.debug('Hello  '+reqDate);
        
        List<Calendar> lstCalenders = [SELECT Id,Name FROM Calendar WHERE Name =: Label.Public_Calendar_Name];
        
        Set<String> bookedSlots = new Set<String>();
        String tempPrefix = Schema.getGlobalDescribe().get('Service_Ticket__c').getDescribe().getKeyPrefix();
        
        if(!lstCalenders.isEmpty()){
            List<Event> lstEvent = [select Id,ActivityDate,StartDateTime,whatId from Event where ActivityDate =: reqDate and whatId != null and OwnerId=:lstCalenders[0].Id];
            System.debug('lstEvent = '+lstEvent.size());
            if(lstEvent.size() > 0){
                for(Event eve : lstEvent){
                    String recId = eve.whatId+'';
                    if(eve.StartDateTime != null && recId.startsWith(tempPrefix)){
                        if(eve.StartDateTime.format('h:mm a') == reqTime){
                            
                        } else {
                            bookedSlots.add(eve.StartDateTime.format('h:mm a'));    
                        }
                    }
                }
            }    
        }
        System.debug('bookedSlots = '+bookedSlots.size());
        System.debug('bookedSlots = '+bookedSlots);
        /*if(reqTime != null && reqTime != ''){
bookedSlots.add(reqTime);    
}*/
        
        for(Integer i=0;i<3;i++){
            String slot1 = (9+i)+':00 AM';
            //String slot2 = (9+i)+':30 AM';
            Boolean isAvailable = true;
            if(bookedSlots.contains(slot1)){
                isAvailable = false;
            }
            slots.add(new CalendarEvent(slot1,isAvailable));
            /*isAvailable = true;
            if(bookedSlots.contains(slot2)){
                isAvailable = false;
            }
            slots.add(new CalendarEvent(slot2,isAvailable));*/
        }
        for(Integer i=0;i<5;i++){
            Integer hours =  (12+i);
            if(hours > 12){
                hours = hours - 12;
            }
            String slot1 = hours+':00 PM';
            //String slot2 = hours+':30 PM';
            Boolean isAvailable = true;
            if(bookedSlots.contains(slot1)){
                isAvailable = false;
            }
            slots.add(new CalendarEvent(slot1,isAvailable));
            /*isAvailable = true;
            if(bookedSlots.contains(slot2)){
                isAvailable = false;
            }
            slots.add(new CalendarEvent(slot2,isAvailable));*/
        }
        r.data.put('slots',slots);
        return r;
    }
    public class CalendarEvent{
        @AuraEnabled
        public Boolean isAvailable{set;get;}
        @AuraEnabled
        public String slotTime{set;get;}
        
        public CalendarEvent(String slotTime,Boolean isAvailable){
            this.slotTime = slotTime;
            this.isAvailable = isAvailable;
        }
    }
    @AuraEnabled
    public static String downloadFile(){
        PageReference pr =  new PageReference('/apex/PrintTicketsCSV');
        ContentVersion cont = new ContentVersion();
        Blob b = pr.getContent();
        return b.toString();
    }
    
    @AuraEnabled
    public static String downloadPDFFile(){
        PageReference pr =  new PageReference('/apex/printTicketsPdf');
        ContentVersion cont = new ContentVersion();
        
        Blob b = pr.getContent();
        return b.toString();
        
    }
    @AuraEnabled
    public static AuraResponse insertBatchId(String recName,String BrandId){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.insertBatchId()');
        Harvest_Batch_Code__c batchId = new Harvest_Batch_Code__c();
        batchId.Name = recName;
        batchId.Producer_Name__c = BrandId;
        batchId.Active__c = true;
        batchId.Lab_Test_Status__c = 'Not Tested';
        
        insert batchId;
        
        r.data.put('newRec', batchId);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse insertUId(String recName){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.insertUId()');
        UID__c uId = new UID__c();
        uId.Name = recName;
        uId.Active__c = true;
        
        insert uId;
        
        r.data.put('newRec', uId);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getServiceTicket(String recordId){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getServiceTicket()');
        ServiceTicket st = new ServiceTicket();
        List<ServiceTicketLine> serviceTicketLines = new List<ServiceTicketLine>();
        if(String.isNotBlank(recordId)){
            for(Service_Ticket__c tmpST: [SELECT Id,Name,CreatedDate,Destination_Site__c,Destination_Site__r.Warehouse_Name__c,
                                          Destination_Site__r.License_ID__c,Destination_Site__r.License_ID__r.License_Address__c,
                                          Destination_Site__r.License_ID__r.License_Number__c,Transporter__c,Transporter__r.License_Name__r.DBA__c,
                                          Transporter__r.License_Number__c,Licensed_Premise__r.License_DBA__c,
                                          Destination_Site__r.License_ID__r.License_Zip__c,Destination_Site__r.License_ID__r.License_Country__c,
                                          Destination_Site__r.License_ID__r.License_State__c,Destination_Site__r.License_ID__r.License_City__c,
                                          Brand_Name__r.DBA__c, Brand_Name__c, Brand_Name__r.Name, Brand_Contact__c,Licensed_Premise__r.License_Name__c,
                                          Brand_Contact__r.Name, Transfer_Method__c, Licensed_Premise__c,Brand_Name__r.Membership_Level__c,
                                          Licensed_Premise__r.License_Number__c,Licensed_Premise__r.License_Type__c,
                                          Licensed_Premise_Address__c, Drive_And_Contact_Details__c, Status__c,Total_Service_Lines__c,
                                          Request_Date_Time__c,DL__c,Employee__c,Vehicle_Make__c,Vehicle_Model__c,License_Plate__c, Pass_through_Payment__c,
                                          Special_Instruction__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c    
                                          FROM Service_Ticket__c WHERE Id = :recordId AND Brand_Name__c = :brandId]){
                st = new ServiceTicket(tmpST);
                st.passThroughPayment = tmpST.Pass_through_Payment__c;                           
                st.destinationSiteName = tmpST.Destination_Site__r.Warehouse_Name__c;
                st.transportLicenseName = tmpST.Transporter__r.License_Number__c+' | '+tmpST.Transporter__r.License_Name__r.DBA__c;
                st.pickupFromDBA = tmpST.Licensed_Premise__r.License_Name__c;
                st.pickupFromDBAName = tmpST.Licensed_Premise__r.License_DBA__c;
                List<String> lstLaAddress = new List<String>();
				String siteAddress;  
                if(tmpST.Destination_Site__r.License_ID__c != null){
                	if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Address__c)){
                    	lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Address__c);
                    }
                    if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_City__c)){
                    	lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_City__c);
                    }
                    if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_State__c)){
                    	lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_State__c);
                    }
                    if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Country__c)){
                    	lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Country__c);
                    }
                    if(String.isNotBlank(tmpST.Destination_Site__r.License_ID__r.License_Zip__c)){
                    	lstLaAddress.add(tmpST.Destination_Site__r.License_ID__r.License_Zip__c);
                    }                              
                    siteAddress = String.join(lstLaAddress, ', ');
                    siteAddress = tmpST.Destination_Site__r.License_ID__r.License_Number__c + ' | '+siteAddress;
            	}                              
                st.destinationSiteAddress = siteAddress;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
            }                             
            
            if(String.isNotBlank(st.id)){
                Service_Ticket_Line__c[] STLines = [SELECT  Desired_Retail_Ready_Form__c,New_Packaged_Product__r.Description,New_Packaged_Product__r.Product_Short_Description__c,New_Batch_ID__c,
                                                    New_Batch_ID__r.Name,Medium_Label_Qty__c,Small_Label_Qty__c,Large_Label_Qty__c, Expected_Arrival_At_Filligreen__c, 
                                                    Filligreen_Packaging_Date__c, Harvest_Batch_ID__c, Per_Unit_Weight_g__c, PreRoll_Packaging__c,
                                                     Product_Description__c, Product_Family__c, Qty_Per_Multi_Unit__c, /*Retail_Ready_Cannabis_Weight_g__c,*/ 
                                                    Retail_Wholesale_Price__c, Service_Ticket__c, Strain__c, Strain_Type__c, Test_Required__c, Total_Cannabis_Weight_g__c, 
                                                    Total_Units__c, UID__c,Tamper_Type__c ,Package_Type__c, Spl_Packaging_Notes__c,Transfer_of_Custody__c,Top_Front_Label__c,
                                                    Bottom_Back_Label__c,Body_Tube_Label__c,THC_CBD_Claim_Label__c , Qty_of_Misc_Label__c, COA_Number__c,Status__c,
                                                    Total_Qty__c,Total_Quoted_Price__c,Cone_Size__c,New_Packaged_Product__c,New_Packaged_Product__r.Name,UID_New__c,Product__r.MOQ__c,
                                                    UID_New__r.Name,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Source_Batch_ID__c,Source_Batch_ID__r.Name,Test_Status__c,Product__c,Product__r.Name,Product__r.Product_Short_Description__c,Total_Weight_lbs__c, Weight_to_Order_Ratio__c, Weight_to_Mileage_Fee__c,Product__r.Unit_Shipping_Weight_lbs__c,
                                                    (SELECT Id, Packaging_Status__c, Released_Date__c  FROM Production_Work_Orders__r)
                                                    FROM Service_Ticket_Line__c 
                                                    WHERE Service_Ticket__c = :recordId 
                                                    ORDER BY Name];
                if(STLines.size() > 0){
                    Set<Id> serviceIdSet = new Set<Id>();
                    for(Service_Ticket_Line__c service : STLines){
                        serviceIdSet.add(service.Id);
                    }  
                    
                    Map<String,ContentDocumentLink> mapFileIds = new Map<String,ContentDocumentLink>();
                    for(ContentDocumentLink cont : [SELECT Id, LinkedEntityId,ContentDocumentId,ContentDocument.title FROM ContentDocumentLink WHERE LinkedEntityId in : serviceIdSet]){
                        mapFileIds.put(cont.LinkedEntityId,cont);
                    }
                    
                    for(Service_Ticket_Line__c tmpSTL: STLines){
                        if(mapFileIds.containskey(tmpSTL.Id)){
                            serviceTicketLines.add(new ServiceTicketLine(tmpSTL,true,mapFileIds.get(tmpSTL.Id)));    
                        } else {
                            serviceTicketLines.add(new ServiceTicketLine(tmpSTL,false));  
                        }
                    }
                }
            }
        }
        if(serviceTicketLines.isEmpty()){
            serviceTicketLines.add(new ServiceTicketLine());
        }
        
        r.data.put('serviceTicket', st);
        r.data.put('serviceTicketLines', serviceTicketLines);
        r.data.put('branddetails',[SELECT Id,Name, DBA__c, Image_URL__c FROM Account WHERE Id = :brandId LIMIT 1][0]);
        return r;
    }
    
    private static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
    
    private static Boolean hasListFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && !((List<Object>)filters.get(key)).isEmpty();
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getIds(Map<String, Object> filters,String fromService){
        String orderByField = 'Name';
        String direction = 'ASC';
        String orderBy = '';
        String STStatus = '';
        System.debug('###filters::'+filters);
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getIds()');
        List<String> whereParts = new List<String>{'Brand_Name__c = :brandId'};
            List<String> whereSearchParts = new List<String>();
        String searchTerm = '';
        Date createdDate = null;
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'status')){
                STStatus = String.valueOf(filters.get('status'));
                if(STStatus != 'All'){
                    whereParts.add('(Status__c = :STStatus)');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.indexOf('/') != -1){
                        try{
                            createdDate = Date.parse(searchTerm);
                        }catch(Exception e){
                            
                        }
                    }
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('Name LIKE :searchTerm');
                    whereSearchParts.add('Brand_Name__r.Name LIKE :searchTerm');
                    whereSearchParts.add('Brand_Contact__r.Name LIKE :searchTerm');
                    whereSearchParts.add('Status__c LIKE :searchTerm');
                    whereSearchParts.add('Transfer_Method__c LIKE :searchTerm');
                    whereSearchParts.add('Licensed_Premise_Address__c LIKE :searchTerm');
                    System.debug('##createdDate::'+createdDate);
                    if(createdDate != null){
                        whereSearchParts.add('(Request_Ship_Date__c >= :createdDate AND Request_Ship_Date__c <= :createdDate)');
                    }
                }
            }
        }
        
        List<ServiceTicket> serviceTickets = new List<ServiceTicket>();
        String query = 'SELECT Id FROM Service_Ticket__c';
        if(fromService == 'true'){
        	query += ' WHERE Transfer_Method__c = \'Product Conversions\' AND ';
        }else{
        	query += ' WHERE Transfer_Method__c != \'Product Conversions\' AND ';    
        }
        if(!whereParts.isEmpty()){
            query += String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        System.debug('###whereSearchParts::'+whereSearchParts);
        if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        query += ' ORDER BY '+orderBy;
        
        
        
        
        System.debug('##query::'+query);
        Set<Id> ids = new Set<Id>();
        for(Service_Ticket__c st :(List<Service_Ticket__c>)Database.query(query)){
            //serviceTickets.add(new ServiceTicket(a));
            ids.add(st.Id);
        }
        
        r.data.put('ids', ids);
        r.data.put('isBrand', ProductsCtlr.isBrand);
        //r.data.put('serviceTickets', serviceTickets);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getIdsForFile(Map<String, Object> filters,String fromService){
        String orderByField = 'Name';
        String direction = 'ASC';
        String orderBy = '';
        String STStatus = '';
        System.debug('###filters::'+filters);
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getIdsForFile()');
        List<String> whereParts = new List<String>{'Brand_Name__c = :brandId'};
            List<String> whereSearchParts = new List<String>();
        String searchTerm = '';
        Date createdDate = null;
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'status')){
                STStatus = String.valueOf(filters.get('status'));
                if(STStatus != 'All'){
                    whereSearchParts.add('(Status__c = :STStatus)');
                }
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.indexOf('/') != -1){
                        try{
                            createdDate = Date.parse(searchTerm);
                        }catch(Exception e){
                            
                        }
                    }
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Name__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Contact__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Status__c LIKE :searchTerm)');
                    whereSearchParts.add('(Transfer_Method__c LIKE :searchTerm)');
                    whereSearchParts.add('(Licensed_Premise_Address__c LIKE :searchTerm)');
                    System.debug('##createdDate::'+createdDate);
                    if(createdDate != null){
                        whereSearchParts.add('(CreatedDate >= :createdDate AND CreatedDate <= :createdDate)');
                    }
                }
            }
        }
        List<ServiceTicket> serviceTickets = new List<ServiceTicket>();
        String query = 'SELECT Id FROM Service_Ticket__c';
        if(fromService == 'true'){
        	query += ' WHERE Transfer_Method__c = \'Product Conversions\' AND ';
        }else{
        	query += ' WHERE Transfer_Method__c != \'Product Conversions\' AND ';    
        }
        if(!whereParts.isEmpty()){
            query += String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        System.debug('###whereSearchParts::'+whereSearchParts);
        if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        query += ' ORDER BY '+orderBy;
        
        
        
        
        System.debug('##query::'+query);
        Set<Id> ids = new Set<Id>();
        for(Service_Ticket__c st :(List<Service_Ticket__c>)Database.query(query)){
            //serviceTickets.add(new ServiceTicket(a));
            ids.add(st.Id);
        }
        
        r.data.put('ids', ids);
        r.data.put('isBrand', ProductsCtlr.isBrand);
        //r.data.put('serviceTickets', serviceTickets);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getServiceTickets(List<String> ids, Map<String, Object> filters){
        String orderByField = 'Name';
        String direction = 'ASC';
        String orderBy = '';
        System.debug('###filters::'+filters);
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
        }
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getServiceTickets()');
        List<String> whereParts = new List<String>{'Brand_Name__c = :brandId'};
            whereParts.add('Id IN :ids');
        List<String> whereSearchParts = new List<String>();
        String searchTerm = '';
        Date createdDate = null;
        if(filters != null){
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.indexOf('/') != -1){
                        try{
                            createdDate = Date.parse(searchTerm);
                        }catch(Exception e){
                        }
                    }
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Name__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Contact__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Status__c LIKE :searchTerm)');
                    whereSearchParts.add('(Transfer_Method__c LIKE :searchTerm)');
                    whereSearchParts.add('(Licensed_Premise_Address__c LIKE :searchTerm)');
                    System.debug('##createdDate::'+createdDate);
                    if(createdDate != null){
                        whereSearchParts.add('(CreatedDate >= :createdDate AND CreatedDate <= :createdDate)');
                    }
                }
            }
        }
        List<ServiceTicket> serviceTickets = new List<ServiceTicket>();
        String query = 'SELECT Name,CreatedDate, Brand_Name__c,Transporter__c, Brand_Name__r.Name,Brand_Name__r.DBA__c, Brand_Contact__c, Brand_Contact__r.Name, Transfer_Method__c, Licensed_Premise__c,Licensed_Premise__r.License_Number__c,Licensed_Premise__r.License_Type__c,Licensed_Premise_Address__c, Drive_And_Contact_Details__c, Status__c,Total_Service_Lines__c,Request_Date_Time__c,DL__c,Employee__c,Vehicle_Make__c,Vehicle_Model__c,License_Plate__c, Special_Instruction__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c,(SELECT Id, Status__c FROM Service_Ticket_Lines__r)  FROM Service_Ticket__c';
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        System.debug('###whereSearchParts::'+whereSearchParts);
        if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        query += ' ORDER BY '+orderBy;//ORDER BY Name DESC';
        System.debug('##query::'+query);
        for(Service_Ticket__c st:(List<Service_Ticket__c>)Database.query(query)){
            ServiceTicket stw =  new ServiceTicket(st);
            Integer completedSTLines = 0;
            if(st.Service_Ticket_Lines__r.size() > 0){
                for(Service_Ticket_Line__c STL: st.Service_Ticket_Lines__r){
                    if(STL.Status__c == 'Completed'){
                        completedSTLines++;
                    }
                }
            }
            stw.totalCompletedServiceLines = completedSTLines+' of '+st.Service_Ticket_Lines__r.size();
            serviceTickets.add(stw);
        }
        r.data.put('records', serviceTickets);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getServiceTicketsFile(List<String> ids, Map<String, Object> filters){
        String orderByField = 'Name';
        String direction = 'ASC';
        String orderBy = '';
        System.debug('###filters::'+filters);
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
        }
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.getServiceTicketsFile()');
        List<String> whereParts = new List<String>{'Brand_Name__c = :brandId'};
            whereParts.add('Id IN :ids');
        List<String> whereSearchParts = new List<String>();
        String searchTerm = '';
        Date createdDate = null;
        if(filters != null){
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.indexOf('/') != -1){
                        try{
                            createdDate = Date.parse(searchTerm);
                        }catch(Exception e){
                        }
                    }
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Name__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Brand_Contact__r.Name LIKE :searchTerm)');
                    whereSearchParts.add('(Status__c LIKE :searchTerm)');
                    whereSearchParts.add('(Transfer_Method__c LIKE :searchTerm)');
                    whereSearchParts.add('(Licensed_Premise_Address__c LIKE :searchTerm)');
                    System.debug('##createdDate::'+createdDate);
                    if(createdDate != null){
                        whereSearchParts.add('(CreatedDate >= :createdDate AND CreatedDate <= :createdDate)');
                    }
                }
            }
        }
        List<ServiceTicket> serviceTickets = new List<ServiceTicket>();
        String query = 'SELECT Name,CreatedDate, Brand_Name__c, Request_Date_Time__c ,Transporter__c,Brand_Name__r.Name,Brand_Name__r.DBA__c, Brand_Contact__c, Brand_Contact__r.Name, Transfer_Method__c, Licensed_Premise__c,Licensed_Premise__r.License_Number__c,Licensed_Premise__r.License_Type__c,Licensed_Premise_Address__c, Drive_And_Contact_Details__c, Status__c,Total_Service_Lines__c,DL__c,Employee__c,Vehicle_Make__c,Vehicle_Model__c,License_Plate__c, Special_Instruction__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c,(SELECT Id, Status__c FROM Service_Ticket_Lines__r)  FROM Service_Ticket__c';
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        System.debug('###whereSearchParts::'+whereSearchParts);
        if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        query += ' ORDER BY '+orderBy;//ORDER BY Name DESC';
        System.debug('##query::'+query);
        for(Service_Ticket__c st:(List<Service_Ticket__c>)Database.query(query)){
            ServiceTicket stw =  new ServiceTicket(st);
            Integer completedSTLines = 0;
            if(st.Service_Ticket_Lines__r.size() > 0){
                for(Service_Ticket_Line__c STL: st.Service_Ticket_Lines__r){
                    if(STL.Status__c == 'Completed'){
                        completedSTLines++;
                    }
                }
            }
            stw.totalCompletedServiceLines = completedSTLines+' of '+st.Service_Ticket_Lines__r.size();
            serviceTickets.add(stw);
        }
        
        r.data.put('records', serviceTickets);
        return r;
    }
    @AuraEnabled
                    public static AuraResponse saveSeriveTicket(String recordId, String serviceTicketData, String serviceTicketLinesData, String requestDate, Boolean isServiceTicket){
        AuraResponse r = new AuraResponse('ServiceTicketsCtlr.saveSeriveTicket()');
        
        System.debug('requestDate '+requestDate);
        
        
        ServiceTicket st = (ServiceTicket)JSON.deserialize(serviceTicketData, ServiceTicket.class);
        List<ServiceTicketLine> stls = (List<ServiceTicketLine>)JSON.deserialize(serviceTicketLinesData, List<ServiceTicketLine>.class);
        
        if(stls.isEmpty()){
            r.errors.add('Add atleast a service ticket line');
        }
        if(String.isNotBlank(recordId)){
            for(Service_Ticket__c tmpST: [SELECT Status__c, Brand_Name__c FROM Service_Ticket__c WHERE Id = :recordId]){
                if(!('Pending'.equalsIgnoreCase(tmpST.Status__c) || 'Draft'.equalsIgnoreCase(tmpST.Status__c)) || brandId != tmpST.Brand_Name__c){
                    r.errors.add('The service ticket not found');
                }
            }
        }
        r.handleErrors();
        
        Savepoint sp = Database.setSavepoint();
        try{ 
            Service_Ticket__c serviceTicket = new Service_Ticket__c( Id = (String.isBlank(recordId)? null : recordId),
                                                                    Brand_Name__c = (String.isBlank(brandId)? null : brandId),
                                                                    Brand_Contact__c = (String.isBlank(st.brandContactId)? null : st.brandContactId),
                                                                    Transfer_Method__c = st.transferMethod,
                                                                    Licensed_Premise__c = (String.isBlank(st.licensePremise)?NULL:st.licensePremise),
                                                                    Drive_And_Contact_Details__c = st.driverAndContactDetails,
                                                                    DL__c = st.DLNumber,
                                                                    Employee__c = st.employeeNumber,
                                                                    Transporter__c = (String.isBlank(st.transportLicenseId)? null : st.transportLicenseId),
                                                                    Vehicle_Make__c = st.vehicleMake,
                                                                    Vehicle_Model__c = st.vehicleModel,
                                                                    License_Plate__c = st.licensePlate ,
                                                                    Destination_Site__c = (String.isBlank(st.destinationSiteId)? null : st.destinationSiteId),
                                                                    Total_Mileage_Fee__c = st.totalMileageFee,
                                                                    Total_Weight_Fee__c = st.totalWeightFee,
                                                                    Service_Booking_Fee__c = st.serviceBookingFee,
                                                                    Service_Scheduling_Fee__c = st.serviceSchedulingFee,
                                                                    Service_Staging_Fee__c  = st.serviceStagingFee,
                                                                    Special_Instruction__c = st.specialInstruction,
                                                                    Pass_Through_Payment__c = st.passThroughPayment);
            
            System.debug('###requestDate:'+requestDate);
            if(requestDate != null && requestDate != ''){
                if(isServiceTicket == true){
                    String[] dateTimeParts = requestDate.split(' ');
                    String [] dateParts = dateTimeParts[0].split('-');
                    String dateString = dateParts[2]+'-'+dateParts[0]+'-'+dateParts[1]+' '+dateTimeParts[1];
                    DateTime reqDate = DateTime.valueOf(dateString);
                    serviceTicket.Request_Date_Time__c = reqDate;
                    
                }else{
                    requestDate = requestDate.replace('-','/');
                    DateTime reqDate = DateTime.parse(requestDate);
                    serviceTicket.Request_Date_Time__c = reqDate;
                }
                
            }  
            
            System.debug('st.status1 - '+st.status);
            if(String.isBlank(recordId)){
                System.debug('st.status2 - '+st.status);
                if(st.status == 'Draft'){
                	serviceTicket.Status__c = 'Draft';
                } else {
                    serviceTicket.Status__c = 'Pending';
                }
                System.debug('st.status3 - '+serviceTicket.Status__c);
            } else if(st.status == 'Draft'){
                serviceTicket.Status__c = 'Draft';
            } else {
                serviceTicket.Status__c = 'Pending';
            }
            System.debug('st.status4 - '+serviceTicket.Status__c);
            
            upsert serviceTicket;
            serviceTicket = [SELECT Id, Name FROM Service_Ticket__c WHERE Id = :serviceTicket.Id];
            r.data.put('serviceTicket',serviceTicket);
            List<Service_Ticket_Line__c> serviceTicketLines = new List<Service_Ticket_Line__c>();
            for(ServiceTicketLine stl: stls){
                System.debug('####stl::'+stl);
                Boolean newVal;
                if(stl.Test_Required == 'Yes')
                    newVal = true;
                else
                    newVal = false;
                serviceTicketLines.add(new Service_Ticket_Line__c(Id = (String.isBlank(stl.id)? null: stl.id),
                                                                  Service_Ticket__c = serviceTicket.Id,
                                                                  Desired_Retail_Ready_Form__c = stl.Desired_Retail_Ready_Form,
                                                                  Expected_Arrival_At_Filligreen__c = stl.Expected_Arrival_At_Filligreen,
                                                                  Harvest_Batch_Code__c = (String.isBlank(stl.Harvest_Batch_ID)?null:stl.Harvest_Batch_ID),
                                                                  Source_Batch_ID__c = (String.isBlank(stl.Harvest_Batch_ID_Convert)?null:stl.Harvest_Batch_ID_Convert),
                                                                  UID_New__c = (String.isBlank(stl.UID)?null:stl.UID),
                                                                  Per_Unit_Weight_g__c = stl.Per_Unit_Weight_g,
                                                                  PreRoll_Packaging__c = stl.PreRoll_Packaging,
                                                                  //Product__c = stl.Product,
                                                                  Qty_Per_Multi_Unit__c = stl.Qty_Per_Multi_Unit,
                                                                  Retail_Wholesale_Price__c = stl.Retail_Wholesale_Price,
                                                                  Test_Required__c = newVal,
                                                                  Test_Status__c = stl.testStatus,
                                                                  Total_Units__c = stl.Total_Units,
                                                                  Spl_Packaging_Notes__c =stl.Spl_Packaging_Notes,
                                                                  Transfer_of_Custody__c = stl.Transfer_of_Custody,
                                                                  Tamper_Type__c = stl.Tamper_Type,
                                                                  Package_Type__c = stl.Package_Type,
                                                                  Top_Front_Label__c = stl.Top_Front_Label,
                                                                  Bottom_Back_Label__c = stl.Bottom_Back_Label,
                                                                  Body_Tube_Label__c = stl.Body_Tube_Label,
                                                                  THC_CBD_Claim_Label__c = stl.THC_CBD_Claim_Label,
                                                                  Qty_of_Misc_Label__c = stl.Qty_of_Misc_Label,
                                                                  COA_Number__c = stl.COA_Number,
                                                                  Status__c = stl.status,
                                                                  Cone_Size__c = stl.Cone_Size,
                                                                  Small_Label_Qty__c = stl.smallLabelQty,
                                                                  Medium_Label_Qty__c = stl.mediumLabelQty,  
                                                                  Large_Label_Qty__c = stl.largeLabelQty, 
                                                                  Total_Weight_lbs__c = stl.totalWeightLbs, 
                                                                  New_Batch_ID__c = (String.isBlank(stl.New_Batch_ID)?null:stl.New_Batch_ID),
                                                                  Product__c = (String.isBlank(stl.Product_Packaged_From)?null:stl.Product_Packaged_From),
                                                                  New_Packaged_Product__c = (String.isBlank(stl.New_Packaged_Product)?null:stl.New_Packaged_Product)));
            }
            upsert serviceTicketLines;
            
            List<Service_Ticket_Line__c> deleteSLIs = new List<Service_Ticket_Line__c>([SELECT Id FROM Service_Ticket_Line__c WHERE Service_Ticket__c = :serviceTicket.Id AND Id NOT IN :serviceTicketLines]);
            if(!deleteSLIs.isEmpty()){
                delete deleteSLIs;
            }
        }catch(DmlException e){
            System.debug('###Exception::'+e.getMessage());
            Database.rollback(sp);
            r.handleException(e);
        }
        
        return r;
    }
    public class BrandProduct{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String shortDescription{get;set;}
        public BrandProduct(Product2 p){
            this.id = p.Id;
            this.name = p.Product_Short_Description__c;
            this.shortDescription = p.Product_Short_Description__c;
        }
    }
    
    public class BrandContact{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        
        public BrandContact(Contact c){
            id = c.Id;
            name = c.Name;
        }
    }
    
    public class ServiceTicket{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String ticketNumber{set;get;}
        @AuraEnabled
        public String pickupFromDBA{set;get;}
        @AuraEnabled
        public String pickupFromDBAName{set;get;}
        @AuraEnabled
        public String brandName{set;get;}
        @AuraEnabled
        public String brandDBA{set;get;}
        @AuraEnabled
        public String brandId{set;get;}
        @AuraEnabled
        public String brandContact{set;get;}
        @AuraEnabled
        public String brandContactId{set;get;}
        @AuraEnabled
        public String transportLicenseId{set;get;}
        @AuraEnabled
        public String transportLicenseName{set;get;}
        @AuraEnabled
        public String onSiteContactId{set;get;}
        @AuraEnabled
        public String transferMethod{set;get;}
        @AuraEnabled
        public String licensePremise{set;get;}
        @AuraEnabled
        public String licenseType{set;get;}
        @AuraEnabled
        public String licenseNumber{set;get;}
        @AuraEnabled
        public String licensePremiseAddress{set;get;}
        @AuraEnabled
        public String driverAndContactDetails{set;get;}
        @AuraEnabled
        public String status{get;set;}
        @AuraEnabled
        public Integer totalServiceLines{set;get;}
        @AuraEnabled
        public String createdDate{set;get;}
        @AuraEnabled
        public DateTime requestDateTime{set;get;}
        @AuraEnabled
        public Date requestDate{set;get;}
        @AuraEnabled
        public String requestTime{set;get;}
        @AuraEnabled
        public String DLNumber{set;get;}
        @AuraEnabled
        public String employeeNumber{set;get;}
        @AuraEnabled
        public String vehicleMake{set;get;}
        @AuraEnabled
        public String vehicleModel{set;get;}
        @AuraEnabled
        public String licensePlate{set;get;}
        @AuraEnabled
        public String specialInstruction {set;get;}
        @AuraEnabled
        public String totalCompletedServiceLines {set;get;}
        @AuraEnabled
        public String destinationSiteId {set;get;}
        @AuraEnabled
        public String membershipLevel{get;set;}
        @AuraEnabled
        public String destinationSiteName {set;get;}
        @AuraEnabled
        public String destinationSiteAddress {set;get;}
        @AuraEnabled
        public Decimal totalMileageFee{get;set;}
        @AuraEnabled
        public Decimal totalWeightFee{get;set;}
        @AuraEnabled
        public Decimal serviceBookingFee{get;set;}
        @AuraEnabled
        public Decimal serviceSchedulingFee{get;set;}
        @AuraEnabled
        public Decimal serviceStagingFee{get;set;}
        @AuraEnabled
        public Boolean passThroughPayment{get;set;}
        @AuraEnabled
        public String transferDateString {
            get{
                if(this.requestDateTime != null){
                    transferDateString =  this.requestDateTime.format('MM/dd/yyyy');
                }
                return transferDateString;
            }set;
        }
        @AuraEnabled
        public String licenseName {
            get{
                if(this.licenseNumber != null && this.licenseType != NULL){
                    licenseName =  this.licenseNumber +' | '+this.licensePremiseAddress;
                }
                return licenseName;
            }set;
        }
        public ServiceTicket(){
            this.id = '';
            this.ticketNumber = '';
            this.pickupFromDBA = '';
            this.pickupFromDBAName = '';
            this.brandName = Utility.loggedInUser.Account.Name;
            this.brandId = Utility.loggedInUser.AccountId;
            this.brandDBA = Utility.loggedInUser.Account.DBA__c;
            this.brandContact = '';
            this.brandContactId = '';
            this.onSiteContactId ='';
            this.transportLicenseId = '';
            this.transportLicenseName = '';
            this.transferMethod = 'Product Conversions';
            this.DLNumber = '';
            this.employeeNumber = '';
            this.vehicleMake = '';
            this.vehicleModel = '';
            this.licensePlate = '';
            this.specialInstruction = '';
            this.passThroughPayment = false;
            if(defaultIDs != null){
                this.licensePremise = defaultIDs.Default_License__c;
            }
            this.driverAndContactDetails = '';
            this.status = '';
            this.totalCompletedServiceLines = '0 of 0';
            this.totalMileageFee = 0;
            this.totalWeightFee = 0;
            this.serviceBookingFee = 0;
            this.serviceSchedulingFee = 0;
            this.serviceStagingFee = 0;
        }
        
        public ServiceTicket(Service_Ticket__c st){
            this.id = st.Id;
            this.ticketNumber = st.Name;
            this.brandName = st.Brand_Name__r.Name;
            this.brandId = st.Brand_Name__c;
            this.brandDBA = st.Brand_Name__r.DBA__c;
            this.brandContact = st.Brand_Contact__r.Name;
            this.brandContactId = st.Brand_Contact__c;
            this.transferMethod = st.Transfer_Method__c;
            this.licensePremise = st.Licensed_Premise__c;
            this.transportLicenseId = st.Transporter__c;
            this.licenseNumber = st.Licensed_Premise__r.License_Number__c;
            this.licenseType = st.Licensed_Premise__r.License_Type__c;
            this.licensePremiseAddress = st.Licensed_Premise_Address__c;
            this.driverAndContactDetails = st.Drive_And_Contact_Details__c;
            this.status = st.Status__c;
            this.totalServiceLines = Integer.valueOf(st.Total_Service_Lines__c);
            this.createdDate = st.CreatedDate.format('MM/dd/YYYY');
            this.requestDateTime = st.Request_Date_Time__c;
            this.requestDate = (st.Request_Date_Time__c != null?st.Request_Date_Time__c.date():null);
            this.requestTime = (st.Request_Date_Time__c != null?st.Request_Date_Time__c.format('h:mm a'):'');
            this.DLNumber = st.DL__c;
            this.employeeNumber = st.Employee__c;
            this.vehicleMake = st.Vehicle_Make__c;
            this.vehicleModel = st.Vehicle_Model__c;
            this.licensePlate = st.License_Plate__c;
            this.specialInstruction = st.Special_Instruction__c;
            this.totalCompletedServiceLines = '0 of 0';
            this.totalMileageFee = st.Total_Mileage_Fee__c;
            this.totalWeightFee = st.Total_Weight_Fee__c;
            this.serviceBookingFee = st.Service_Booking_Fee__c;
            this.serviceSchedulingFee = st.Service_Scheduling_Fee__c;
            this.serviceStagingFee = st.Service_Staging_Fee__c ;
            this.passThroughPayment = false;
        }
    }
    
    public class ServiceTicketLine{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public Boolean CRP_Required{set;get;}
        @AuraEnabled
        public String Desired_Retail_Ready_Form{set;get;}
        @AuraEnabled
        public Date Expected_Arrival_At_Filligreen{set;get;}
        @AuraEnabled
        public Date Filligreen_Packaging_Date{set;get;}
        @AuraEnabled
        public String Harvest_Batch_ID{set;get;}
        @AuraEnabled
        public String Harvest_Batch_ID_Convert{set;get;}
        @AuraEnabled
        public String Harvest_Batch_Code{set;get;}
        @AuraEnabled
        public String Harvest_Batch_Code_Convert{set;get;}
        @AuraEnabled
        public String UID{set;get;}
        @AuraEnabled
        public String UIDName{set;get;}
        @AuraEnabled
        public decimal Labels_Qty{set;get;}
        @AuraEnabled
        public String Per_Unit_Weight_g{set;get;}
        @AuraEnabled
        public String PreRoll_Packaging{set;get;}
        @AuraEnabled
        public Boolean PreRoll_Packing_Required{set;get;}
        @AuraEnabled
        public String Product{set;get;}
        @AuraEnabled
        public String ProductName{set;get;}
        @AuraEnabled
        public Decimal productWeight{get;set;}
        @AuraEnabled
        public decimal Qty_Per_Multi_Unit{set;get;}
        @AuraEnabled
        public decimal Retail_Ready_Cannabis_Weight_g{set;get;}
        @AuraEnabled
        public decimal Retail_Wholesale_Price{set;get;}
        @AuraEnabled
        public String Test_Required{set;get;}
        @AuraEnabled
        public Boolean Test_Req{set;get;}
        @AuraEnabled
        public Boolean Test_ReqF{set;get;}
        
        @AuraEnabled
        public Boolean Transfer_of_Custody{set;get;}
        @AuraEnabled
        public decimal Total_Units{set;get;}
        @AuraEnabled
        public String Spl_Packaging_Notes{set;get;}
        @AuraEnabled
        public String Tamper_Type{set;get;}
        @AuraEnabled
        public String Package_Type{set;get;}
        @AuraEnabled
        public String Top_Front_Label{set;get;}
        @AuraEnabled
        public String Bottom_Back_Label{set;get;}
        @AuraEnabled
        public String Body_Tube_Label{set;get;}
        @AuraEnabled
        public String THC_CBD_Claim_Label{set;get;}
        @AuraEnabled
        public Decimal Qty_of_Misc_Label{set;get;}
        @AuraEnabled
        public Decimal Total_Qty{set;get;}
        @AuraEnabled
        public String COA_Number{set;get;}
        @AuraEnabled
        public String status{set;get;}
        @AuraEnabled
        public String Cone_Size{set;get;}
        @AuraEnabled
        public String Product_Packaged_From{set;get;}
        @AuraEnabled
        public String Product_Packaged_FromName{set;get;}
        @AuraEnabled
        public String Product_Packaged_FromSKU{set;get;}
        @AuraEnabled
        public Decimal Product_Packaged_MOQ{set;get;}
        @AuraEnabled
        public String New_Packaged_Product{set;get;}
        @AuraEnabled
        public String New_Packaged_ProductName{set;get;}
        @AuraEnabled
        public Decimal Total_Quoted_Price{set;get;}
        @AuraEnabled
        public Decimal smallLabelQty{set;get;}
        @AuraEnabled
        public Decimal mediumLabelQty{set;get;}
        @AuraEnabled
        public Decimal largeLabelQty{set;get;}
        @AuraEnabled
        public String New_Batch_ID{set;get;}
        @AuraEnabled
        public String productDescription{set;get;}
        @AuraEnabled
        public String New_Batch_ID_Name{set;get;}
        @AuraEnabled
        public Boolean hasAttchment{set;get;}
        @AuraEnabled
        public String documentId{set;get;}
        @AuraEnabled
        public String documentTitle{set;get;}
        @AuraEnabled
        public String currentStep{set;get;}
        @AuraEnabled
        public Date releasedDate{set;get;}
        @AuraEnabled
        public String PWOStatus{set;get;}
        @AuraEnabled
        public String testStatus{set;get;}
        @AuraEnabled
        public Decimal totalWeightlbs{get;set;}
        @AuraEnabled
        public Decimal totalCases{
            get{
                totalCases = 0;
                if(this.Total_Units != NULL && this.Qty_Per_Multi_Unit != NULL && this.Qty_Per_Multi_Unit != 0){
                 	totalCases = this.Total_Units/this.Qty_Per_Multi_Unit;   
                }
                return totalCases.setScale(2);
            }set;
        }
        @AuraEnabled
        public String releasedDateString{
            get{
                if(this.releasedDate != null){
                    Integer month = this.releasedDate.month();
                    Integer day = this.releasedDate.day();
                    //releasedDateString = month +'/'+day+'/'+this.releasedDate.year();
                    releasedDateString = ( month > 9?month+'':'0'+month+'')+'/'+( day > 9?day+'':('0'+day+''))+'/'+this.releasedDate.year();
                }
                return releasedDateString;
            }set;
        }
        public ServiceTicketLine(){
            this.id = '';
            this.CRP_Required = false;
            this.Desired_Retail_Ready_Form = '';
            this.Expected_Arrival_At_Filligreen = System.today();
            this.Filligreen_Packaging_Date = System.today();
            this.Harvest_Batch_ID = '';
            this.Harvest_Batch_ID_Convert = '';
            this.Harvest_Batch_Code_Convert = '';
            this.UID = '';
            this.Labels_Qty = this.smallLabelQty = this.mediumLabelQty = this.largeLabelQty = 0;
            this.Per_Unit_Weight_g = '';//453.60(g)
            this.PreRoll_Packaging = '';
            this.Product = '';
            this.Qty_Per_Multi_Unit = 0;
            this.Retail_Ready_Cannabis_Weight_g = 0;
            this.Retail_Wholesale_Price = 0;
            this.Test_Required = 'No';
            this.Test_Req = true;
            this.Test_ReqF = false;
            this.Total_Units = 0;
            this.Spl_Packaging_Notes = '';
            this.ProductName = '';
            this.productWeight = 0;
            this.Transfer_of_Custody = false;
            this.Tamper_Type = '';
            this.Package_Type = '';
            this.COA_Number = '';
            this.Qty_of_Misc_Label = 0;
            this.status = 'New';
            this.New_Packaged_Product = '';
            this.New_Packaged_ProductName = '';
            this.Product_Packaged_From = '';
            this.Product_Packaged_FromName = '';
			this.Product_Packaged_FromSKU = '';
            this.Product_Packaged_MOQ = 0;
            this.Cone_Size = '';
            this.New_Batch_ID = '';
            this.productDescription = '';
            this.New_Batch_ID_Name = '';
            this.hasAttchment = false;
            this.documentId = this.documentTitle = '';
            this.testStatus = '';
            this.totalWeightlbs = 0;
        }
        
        public ServiceTicketLine(Service_Ticket_Line__c stl,Boolean isAttach,ContentDocumentLink content){
            this.id = stl.Id;
            this.Desired_Retail_Ready_Form = stl.Desired_Retail_Ready_Form__c;
            this.Expected_Arrival_At_Filligreen = stl.Expected_Arrival_At_Filligreen__c;
            this.Filligreen_Packaging_Date = stl.Filligreen_Packaging_Date__c;
            this.Harvest_Batch_ID = stl.Harvest_Batch_Code__c ;
            this.Harvest_Batch_ID_Convert = stl.Source_Batch_ID__c;
            this.UID = stl.UID_New__c;
            this.UIDName = stl.UID_New__r.Name;
            this.Harvest_Batch_Code = stl.Harvest_Batch_Code__r.Name;
            this.Harvest_Batch_Code_Convert = stl.Source_Batch_ID__r.Name;
            this.Per_Unit_Weight_g = stl.Per_Unit_Weight_g__c;
            this.PreRoll_Packaging = stl.PreRoll_Packaging__c;
            this.totalWeightlbs = stl.Total_Weight_lbs__c;
            //this.Product = stl.Product__c;
            //this.ProductName = stl.Product__r.Name;
            this.Qty_Per_Multi_Unit = stl.Qty_Per_Multi_Unit__c;
            //this.Retail_Ready_Cannabis_Weight_g = stl.Retail_Ready_Cannabis_Weight_g__c;
            this.Retail_Wholesale_Price = stl.Retail_Wholesale_Price__c;
            if(stl.Test_Required__c)
                this.Test_Required = 'Yes';
            else
                this.Test_Required = 'No';
            this.Total_Units = stl.Total_Units__c;
            this.Spl_Packaging_Notes = stl.Spl_Packaging_Notes__c;
            this.Transfer_of_Custody = stl.Transfer_of_Custody__c;
            this.Tamper_Type = stl.Tamper_Type__c;
            this.Package_Type = stl.Package_Type__c;
            this.Top_Front_Label = stl.Top_Front_Label__c;
            this.Bottom_Back_Label = stl.Bottom_Back_Label__c;
            this.Body_Tube_Label = stl.Body_Tube_Label__c;
            this.THC_CBD_Claim_Label = stl.THC_CBD_Claim_Label__c;
            this.Qty_of_Misc_Label = stl.Qty_of_Misc_Label__c;
            this.COA_Number = stl.COA_Number__c;
            this.status = stl.Status__c;
            this.Total_Qty = stl.Total_Qty__c;
            this.smallLabelQty = stl.Small_Label_Qty__c;
            this.mediumLabelQty = stl.Medium_Label_Qty__c;
            this.largeLabelQty = stl.Large_Label_Qty__c;
            this.Total_Quoted_Price = stl.Total_Quoted_Price__c;
            this.Cone_Size = stl.Cone_Size__c;
            this.New_Packaged_Product = stl.New_Packaged_Product__c;
            this.New_Packaged_ProductName = stl.New_Packaged_Product__r.Name;
            this.New_Batch_ID = stl.New_Batch_ID__c;
            this.productDescription = stl.New_Packaged_Product__r.Product_Short_Description__c;
            this.Product_Packaged_From = stl.Product__c;
            this.Product_Packaged_FromName = stl.Product__r.Name;
			this.Product_Packaged_FromSKU = stl.Product__r.Product_Short_Description__c;
            this.Product_Packaged_MOQ = stl.Product__r.MOQ__c;
            this.productWeight = stl.Product__r.Unit_Shipping_Weight_lbs__c;
            this.New_Batch_ID_Name = stl.New_Batch_ID__r.Name;
            this.testStatus = stl.Test_Status__c;
            this.Test_Req = true;
            this.Test_ReqF = false;
            this.hasAttchment = isAttach;
            this.documentId = content.ContentDocumentId;
            this.documentTitle = content.ContentDocument.title;
            System.debug('###PWOs : '+stl.Production_Work_Orders__r.size());
            if(stl.Production_Work_Orders__r != null && stl.Production_Work_Orders__r.size() > 0){
                System.debug('###PWO : '+stl.Production_Work_Orders__r[0]);                
                this.currentStep = (stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Accepted'?'2':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Released'?'3':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'WIP'?'4':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Completed'?'5':'1'))));
                this.releasedDate = stl.Production_Work_Orders__r[0].Released_Date__c;
                this.PWOStatus = stl.Production_Work_Orders__r[0].Packaging_Status__c;
            }else{
                this.currentStep = '1';
            }
        }
        public ServiceTicketLine(Service_Ticket_Line__c stl,Boolean isAttach){
            this.id = stl.Id;
            this.Desired_Retail_Ready_Form = stl.Desired_Retail_Ready_Form__c;
            this.Expected_Arrival_At_Filligreen = stl.Expected_Arrival_At_Filligreen__c;
            this.Filligreen_Packaging_Date = stl.Filligreen_Packaging_Date__c;
            this.Harvest_Batch_ID = stl.Harvest_Batch_Code__c ;
            this.Harvest_Batch_ID_Convert = stl.Source_Batch_ID__c;
            this.UID = stl.UID_New__c;
            this.UIDName = stl.UID_New__r.Name;
            this.Harvest_Batch_Code = stl.Harvest_Batch_Code__r.Name;
            this.Harvest_Batch_Code_Convert = stl.Source_Batch_ID__r.Name;
            this.Per_Unit_Weight_g = stl.Per_Unit_Weight_g__c;
            this.PreRoll_Packaging = stl.PreRoll_Packaging__c;
            this.totalWeightlbs = stl.Total_Weight_lbs__c;
            //this.Product = stl.Product__c;
            //this.ProductName = stl.Product__r.Product_Short_Description__c;//.Name;
            this.Qty_Per_Multi_Unit = stl.Qty_Per_Multi_Unit__c;
            System.debug('this.Qty_Per_Multi_Unit = '+this.Qty_Per_Multi_Unit);
            //this.Retail_Ready_Cannabis_Weight_g = stl.Retail_Ready_Cannabis_Weight_g__c;
            this.Retail_Wholesale_Price = stl.Retail_Wholesale_Price__c;
            if(stl.Test_Required__c)
                this.Test_Required = 'Yes';
            else
                this.Test_Required = 'No';
            this.Total_Units = stl.Total_Units__c;
            this.testStatus = stl.Test_Status__c;
            this.Spl_Packaging_Notes = stl.Spl_Packaging_Notes__c;
            this.Transfer_of_Custody = stl.Transfer_of_Custody__c;
            this.Tamper_Type = stl.Tamper_Type__c;
            this.Package_Type = stl.Package_Type__c;
            this.Top_Front_Label = stl.Top_Front_Label__c;
            this.Bottom_Back_Label = stl.Bottom_Back_Label__c;
            this.Body_Tube_Label = stl.Body_Tube_Label__c;
            this.THC_CBD_Claim_Label = stl.THC_CBD_Claim_Label__c;
            this.Qty_of_Misc_Label = stl.Qty_of_Misc_Label__c;
            this.COA_Number = stl.COA_Number__c;
            this.status = stl.Status__c;
            this.Total_Qty = stl.Total_Qty__c;
            this.smallLabelQty = stl.Small_Label_Qty__c;
            this.mediumLabelQty = stl.Medium_Label_Qty__c;
            this.largeLabelQty = stl.Large_Label_Qty__c;
            this.Total_Quoted_Price = stl.Total_Quoted_Price__c;
            this.Cone_Size = stl.Cone_Size__c;
            this.New_Packaged_Product = stl.New_Packaged_Product__c;
            this.New_Packaged_ProductName = stl.New_Packaged_Product__r.Name;
            this.New_Batch_ID = stl.New_Batch_ID__c;
            this.productDescription = stl.New_Packaged_Product__r.Product_Short_Description__c;
            this.New_Batch_ID_Name = stl.New_Batch_ID__r.Name;
            this.Test_Req = true;
            this.Test_ReqF = false;
            this.hasAttchment = isAttach;
            this.Product_Packaged_From = stl.Product__c;
            this.Product_Packaged_FromName = stl.Product__r.Name;
			this.Product_Packaged_FromSKU = stl.Product__r.Product_Short_Description__c;
            this.Product_Packaged_MOQ = stl.Product__r.MOQ__c;
            this.productWeight = stl.Product__r.Unit_Shipping_Weight_lbs__c;
            System.debug('###PWOs : '+stl.Production_Work_Orders__r.size());
            if(stl.Production_Work_Orders__r != null && stl.Production_Work_Orders__r.size() > 0){
                System.debug('###PWO : '+stl.Production_Work_Orders__r[0]);                
                this.currentStep = (stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Accepted'?'2':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Released'?'3':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'WIP'?'4':(stl.Production_Work_Orders__r[0].Packaging_Status__c == 'Completed'?'5':'1'))));
                this.releasedDate = stl.Production_Work_Orders__r[0].Released_Date__c;
                this.PWOStatus = stl.Production_Work_Orders__r[0].Packaging_Status__c;
            }else{
                this.currentStep = '1';
            }
        }
    }
    
}