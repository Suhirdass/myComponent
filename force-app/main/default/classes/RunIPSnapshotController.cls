public class RunIPSnapshotController {
    private static String IP_SNAPSHOT_TO_ADDRESS{
        get{
            return String.isNotBlank(IP_SNAPSHOT_TO_ADDRESS) ? IP_SNAPSHOT_TO_ADDRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','IP_Snapshot_TOAddress');
        }set;
    }
	@AuraEnabled
    public static AuraResponse runIPSnapshot(String recordId){
        AuraResponse r = new AuraResponse('RunIPSnapshotController.runIPSnapshot()');
        
        //List<String> lstString = New List<String>{'CannaWaste','Delivered','Packaged','Quarantine','Test Sampled','Transferred'};
        
        Product2 product = [SELECT Id,Name FROM Product2 WHERE Id =: recordId];    
            
        List<Inventory_Position__c> invPosList = new List<Inventory_Position__c>([SELECT Id,Available_Inventory__c,Producer_Name__c,Cannabis_Category__c,Name,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,
                                                                                  Cannabis_Ratio__c,CBD_MG_G__c,CDB__c,COA_Expiration_Date__c,COA_Issued_Date_New__c,
                                                                                  Cultivation_Type__c,Date_Received__c,Days_in_Inventory__c,COA_Number_New__c,
                                                                                  /*UID__c,*/Elapsed_Days__c,FG_Product_Name__c,Inventory_Qty__c,IP_Case_Qty__c,
                                                                                  Total_Product_Volume__c,IP_Dim_Weight__c,Inventory_Gross_Weight__c,
                                                                                  Is_Brand_Product__c,License_Premise__c,MOQ__c,On_Hand_Value__c,Owner_Active__c,
                                                                                  Product_Description__c,Product_Family__c,Purchase_Order__c,
                                                                                  Quantity_Type__c,Retail_Unit_Form_Factor__c,Sales_Order__c,Sales_Order_Line__r.Sales_Order__c,Sales_Order_Line__r.Sales_Order__r.Name,
                                                                                  Stocking_UOM__c,Strain__c,Strain_Type__c,Supplier_License_Number__c,Supplier_Name__c,
                                                                                  Terpene__c,THC__c,THC_MG_G__c,Unit_Cannabis_Weight__c,Unit_Cost__c,Unit_Cultivation_Tax__c,
                                                                                  Bin_Location__c,Bin_Location__r.Name,/*Harvest_Batch_or_Lot_Code__c,*/Inventory_Last_Movement_date__c,Total_Days_in_Inventory__c,
                                                                                  /*COA_Issued_Date__c,COA_Number__c,*/ Hold__c,Inventory_Location__c,Inventory_Location__r.Name,Inventory_Hold_Reason_Code__c,
                                                                                  Lab_Test_Status__c,Ownership__c,Product_Name__c,Product_Title__c,Qty_Allocated__c,Qty_On_Hand__c,
                                                                                  Rack__c,Rack__r.Name,Rack_Level__c,Rack_Level__r.Name,Receiving_Line__c,Sales_Order_Line__c,Sales_Order_Line__r.Name,Site__c,Site__r.Name,SRLB__c,UID_New__c,UID_New__r.Name,
                                                                                  Aged_Bucket__c,Product_Name__r.Month_Starting_Inventory__c,Product_Name__r.Total_Inventory__c FROM Inventory_Position__c WHERE 
                                                                                  Product_Name__c =: recordId]);
        
        List<Inventory_Snapshot__c> invSnapList = new List<Inventory_Snapshot__c>();
        
        Integer IPSCount = 0;
        Integer errorCount = 0;
        String errorsDetails = '';

        
        if(invPosList.size() > 0){
        	
            for(Inventory_Position__c inv : invPosList){
                Inventory_Snapshot__c invSnap = new Inventory_Snapshot__c();
                if(inv.Available_Inventory__c != null) invSnap.Available_Inventory__c = inv.Available_Inventory__c;
                if(inv.Producer_Name__c != null) invSnap.Producer_Name__c = inv.Producer_Name__c;
                if(inv.Cannabis_Category__c != null) invSnap.Cannabis_Category__c = inv.Cannabis_Category__c;
                if(inv.Harvest_Batch_Code__c != null) invSnap.Harvest_Batch_Code__c = inv.Harvest_Batch_Code__r.Name;
                if(inv.Cannabis_Ratio__c != null) invSnap.Cannabis_Ratio__c = inv.Cannabis_Ratio__c;
                if(inv.CBD_MG_G__c != null) invSnap.CBD_MG_G__c = inv.CBD_MG_G__c;
                if(inv.COA_Expiration_Date__c != null) invSnap.COA_Expiration_Date__c = inv.COA_Expiration_Date__c;
                if(inv.COA_Issued_Date_New__c != null) invSnap.COA_Issued_Date_New__c = inv.COA_Issued_Date_New__c;
                if(inv.Cultivation_Type__c != null) invSnap.Cultivation_Type__c = inv.Cultivation_Type__c;
                if(inv.Date_Received__c != null) invSnap.Date_Received__c = inv.Date_Received__c;
                if(inv.Days_in_Inventory__c != null) invSnap.Days_in_Inventory__c = inv.Days_in_Inventory__c;
                if(inv.COA_Number_New__c != null) invSnap.COA_Number_New__c = inv.COA_Number_New__c;
                //if(inv.UID__c != null) invSnap.UID__c = inv.UID__c;
                if(inv.Elapsed_Days__c != null) invSnap.Elapsed_Days__c = inv.Elapsed_Days__c;
                if(inv.FG_Product_Name__c != null) invSnap.FG_Product_Name__c = inv.FG_Product_Name__c;
                if(inv.Inventory_Qty__c != null) invSnap.Inventory_Qty__c = inv.Inventory_Qty__c;
                if(inv.IP_Case_Qty__c != null) invSnap.IP_Case_Qty__c = inv.IP_Case_Qty__c;
                if(inv.Total_Product_Volume__c != null) invSnap.Total_Product_Volume__c = inv.Total_Product_Volume__c;
                if(inv.IP_Dim_Weight__c != null) invSnap.IP_Dim_Weight__c = inv.IP_Dim_Weight__c;
                if(inv.Inventory_Gross_Weight__c != null) invSnap.Inventory_Gross_Weight__c = inv.Inventory_Gross_Weight__c;
                if(inv.Is_Brand_Product__c != null) invSnap.Is_Brand_Product__c = inv.Is_Brand_Product__c;
                if(inv.License_Premise__c != null) invSnap.License_Premise__c = inv.License_Premise__c;
                if(inv.MOQ__c != null) invSnap.MOQ__c = inv.MOQ__c;
                if(inv.On_Hand_Value__c != null) invSnap.On_Hand_Value__c = inv.On_Hand_Value__c;
                if(inv.Owner_Active__c != null) invSnap.Owner_Active__c = inv.Owner_Active__c;
                if(inv.Product_Description__c != null) invSnap.Product_Description__c = inv.Product_Description__c;
                if(inv.Product_Family__c != null) invSnap.Product_Family__c = inv.Product_Family__c;
                if(inv.Purchase_Order__c != null) invSnap.Purchase_Order__c = inv.Purchase_Order__c;
                if(inv.Quantity_Type__c != null) invSnap.Quantity_Type__c = inv.Quantity_Type__c;
                if(inv.Retail_Unit_Form_Factor__c != null) invSnap.Retail_Unit_Form_Factor__c = inv.Retail_Unit_Form_Factor__c;
                if(inv.Sales_Order_Line__c != null && inv.Sales_Order_Line__r.Sales_Order__c != null) invSnap.Sales_Order__c = inv.Sales_Order_Line__r.Sales_Order__r.Name;
                if(inv.Stocking_UOM__c != null) invSnap.Stocking_UOM__c = inv.Stocking_UOM__c;
                if(inv.Strain__c != null) invSnap.Strain__c = inv.Strain__c;
                if(inv.Strain_Type__c != null) invSnap.Strain_Type__c = inv.Strain_Type__c;
                if(inv.Supplier_License_Number__c != null) invSnap.Supplier_License_Number__c = inv.Supplier_License_Number__c;
                if(inv.Supplier_Name__c != null) invSnap.Supplier_Name__c = inv.Supplier_Name__c;
                if(inv.Terpene__c != null) invSnap.Terpene__c = inv.Terpene__c;
                if(inv.THC__c != null) invSnap.THC__c = inv.THC__c;
                if(inv.THC_MG_G__c != null) invSnap.THC_MG_G__c = inv.THC_MG_G__c;
                if(inv.Unit_Cannabis_Weight__c != null) invSnap.Unit_Cannabis_Weight__c = inv.Unit_Cannabis_Weight__c;
                if(inv.Unit_Cost__c != null) invSnap.Unit_Cost__c = inv.Unit_Cost__c;
                if(inv.Unit_Cultivation_Tax__c != null) invSnap.Unit_Cultivation_Tax__c = inv.Unit_Cultivation_Tax__c;
                if(inv.Bin_Location__c != null) invSnap.Bin_Location__c = inv.Bin_Location__r.Name;
                //if(inv.Harvest_Batch_or_Lot_Code__c != null) invSnap.Harvest_Batch_or_Lot_Code__c = inv.Harvest_Batch_or_Lot_Code__c;
                //if(inv.COA_Issued_Date__c != null) invSnap.COA_Issued_Date__c = inv.COA_Issued_Date__c;
                //if(inv.COA_Number__c != null) invSnap.COA_Number__c = inv.COA_Number__c;
                if(inv.Hold__c != null) invSnap.Hold__c = inv.Hold__c;
                if(inv.Inventory_Location__c != null) invSnap.Inventory_Location__c = inv.Inventory_Location__r.Name;
                if(inv.Inventory_Hold_Reason_Code__c != null) invSnap.Inventory_Hold_Reason_Code__c = inv.Inventory_Hold_Reason_Code__c;
                if(inv.Lab_Test_Status__c != null) invSnap.Lab_Test_Status__c = inv.Lab_Test_Status__c;
                if(inv.Ownership__c != null) invSnap.Ownership__c = inv.Ownership__c;
                if(inv.Product_Name__c != null) invSnap.Product_Name__c = inv.Product_Name__c;
                if(inv.Product_Title__c != null) invSnap.Product_Title__c = inv.Product_Title__c;
                if(inv.Qty_Allocated__c != null) invSnap.Qty_Allocated__c = inv.Qty_Allocated__c;
                if(inv.Qty_On_Hand__c != null) invSnap.Qty_On_Hand__c = inv.Qty_On_Hand__c;
                if(inv.Rack__c != null) invSnap.Rack__c = inv.Rack__r.Name;
                if(inv.Rack_Level__c != null) invSnap.Rack_Level__c = inv.Rack_Level__r.Name;
                if(inv.Receiving_Line__c != null) invSnap.Receiving_Line__c = inv.Receiving_Line__c;
                if(inv.Sales_Order_Line__c != null) invSnap.Sales_Order_Line__c = inv.Sales_Order_Line__r.Name;
                if(inv.Site__c != null) invSnap.Site__c = inv.Site__r.Name;
                if(inv.SRLB__c != null) invSnap.SRLB__c = inv.SRLB__c;
                if(inv.UID_New__c != null) invSnap.UID_New__c = inv.UID_New__r.Name;
                if(inv.Total_Days_in_Inventory__c != null) invSnap.Total_Days_in_Inventory__c = inv.Total_Days_in_Inventory__c;
                if(inv.Inventory_Last_Movement_date__c != null) invSnap.Inventory_Last_Movement_date__c = inv.Inventory_Last_Movement_date__c;
                if(inv.Aged_Bucket__c != null) invSnap.Aged_Bucket__c = inv.Aged_Bucket__c;
            	if(inv.Name != null) invSnap.Inventory_Position__c = inv.Name;
            	if(inv.Product_Name__c != null && inv.Product_Name__r.Month_Starting_Inventory__c != null) invSnap.Starting_Inventory__c = inv.Product_Name__r.Month_Starting_Inventory__c;
            	if(inv.Product_Name__c != null && inv.Product_Name__r.Total_Inventory__c != null) invSnap.Ending_Inventory__c = inv.Product_Name__r.Total_Inventory__c;
                AuraResponse recordsData = getSMdetails(inv.Id);
                invSnap.Shipping_Manifest__c = (String)recordsData.Data.get('smName');
                invSnap.Shipping_Manifest_Line__c = (String)recordsData.Data.get('smLName');
                invSnap.Shipping_Manifest_Status__c = (String)recordsData.Data.get('smStatus');
                invSnap.Shipping_Manifest_Line_Status__c = (String)recordsData.Data.get('smlStatus');
                invSnap.Ship_Confirmation_Date__c = (Date)recordsData.Data.get('shipConfirmDate');
                invSnap.Depart_Confirm_Date__c = (Datetime)recordsData.Data.get('departConfirmDate');
                invSnap.SM_LI_Qty_Ordered__c = (Decimal)recordsData.Data.get('shipLineQtyOrdered');
                invSnap.SM_LI_Qty_Received__c = (Decimal)recordsData.Data.get('shipLineQtyReceived');
                
                invSnapList.add(invSnap);
            }
            
            if(invSnapList.size() > 0){
            	//insert invSnapList; 
                Database.SaveResult[] lsr = Database.insert(invSnapList,false);
                for (Database.SaveResult SR : lsr) {
                    if (!SR.isSuccess()) {
                        errorCount +=1;
                        errorsDetails += errorCount+'. ';
                        for(Database.Error err : sr.getErrors()) {
                            errorsDetails += err.getStatusCode() + ': ' + err.getMessage();
                            errorsDetails += err.getFields();
                            System.debug('Error - '+err.getMessage() + '\nStatus Code : '+err.getStatusCode()+'\n Fields : '+err.getFields());
                        }
                        errorsDetails += '<br>';
                        /*Database.Error error = SR.getErrors().get(0);
                    	String failedDML = error.getMessage();
                        errorsDetails += errorCount +'. '+failedDML +;
                    	System.debug('failedDML = '+failedDML);*/
                    } else {
                        IPSCount +=1;
                    }
                }
            }
        }
        
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String jobDate = '';
        Date todayDate  = Date.today();
        jobDate = todayDate.month()+'/'+todayDate.day()+'/'+todayDate.year();
        
        String htmlBody = 'Hello, <br><br>Salesforce Inventory Position Snapshot Status';
        htmlBody += '<br><ul><li>Snapshot Run Date: '+jobDate+'</li>';
        htmlBody += '<li>Total Inventory Position records: '+invPosList.size()+'</li>';
        htmlBody += '<li>Total Snapshot record created: '+IPSCount+'</li>';
       	htmlBody += '<li>Error records: '+errorCount+'</li></ul>';
        if(errorsDetails != ''){
        	htmlBody += 'Error Details: '+ errorsDetails;
        }
        htmlBody += '<br>Thanks<br>IT Support';
        List<String> bccAddresss = label.Brand_BCC_Addresses.split(',');
        mail.setToAddresses(bccAddresss);
         List<String> lstToadd= IP_SNAPSHOT_TO_ADDRESS.split(',');
        mail.setToAddresses(lstToadd);
        mail.setSaveAsActivity(false);
        mail.setHtmlBody(htmlBody);
        mail.setSubject('Inventory Postion Snapshot Records created for '+product.Name); 
        emails.add(mail);
        Messaging.sendEmail(emails);
        
        return r;
	}
   
    
    public static Auraresponse getSMdetails(Id ipId) {
        AuraResponse r = new AuraResponse('RunIPSnapshotController.getSMdetails()');
        
        String smName = '';
        String smLName = '';
        String smStatus = '';
        String smlStatus = '';
        Date shipConfirmDate;
        Datetime departConfirmDate;
        Decimal shipLineQtyOrdered = 0.0;
        Decimal shipLineQtyReceived = 0.0;
        
    	List <Picklist_Line__c> invPickLine = [Select id, Name, (select Id, Name, Actual_Shipment_Qty__c, Qty_Received__c,  SMLine_Status__c, Shipping_Manifest__r.Name, 
                                                      Shipping_Manifest__r.Status__c, Shipping_Manifest__r.Ship_Confirmation_Date__c, 
                                                      Shipping_Manifest__r.Actual_Departure_Date_Time__c  from Shipping_Manifest_Lines__r) 
     												  from Picklist_Line__c where Inventory_Position__r.Id =: ipId];
        List<string> listSMnames = new List<string>();
        List<string> listSMLnames = new List<string>();
        List<string> listSMstatus = new List<string>();
        List<string> listSMLstatus = new List<string>();
        List<Date> listshipConfirmDate = new List<Date>();
        List<Datetime> listdepartConfirmDate = new List<Datetime>();
        List<Decimal> listshipLineQtyOrdered = new List<Decimal>();
        List<Decimal> listshipLineQtyReceived = new List<Decimal>();
            
        for(Picklist_Line__c pkl : invPickLine)
            {
                for(Shipping_Manifest_Line__c sml : pkl.Shipping_Manifest_Lines__r)
                {
                    listSMnames.add(String.valueOf(sml.Shipping_Manifest__r.Name));
                    listSMLnames.add(String.valueOf(sml.Name));
                    listSMstatus.add(sml.Shipping_Manifest__r.Status__c);
                    listSMLstatus.add(sml.SMLine_Status__c);
                    listshipConfirmDate.add(sml.Shipping_Manifest__r.Ship_Confirmation_Date__c);
                    listdepartConfirmDate.add(sml.Shipping_Manifest__r.Actual_Departure_Date_Time__c);
                    listshipLineQtyOrdered.add(sml.Actual_Shipment_Qty__c);
                    listshipLineQtyReceived.add(sml.Qty_Received__c);
                }
            }

    If(listSMnames.size() > 0){ smName = listSMnames[0]; }
    If(listSMLnames.size() > 0){smLName = listSMLnames[0];}
    If(listSMstatus.size() > 0){smStatus = listSMstatus[0];}
    If(listSMLstatus.size() > 0){smlStatus = listSMLstatus[0];}
    If(listshipConfirmDate.size() > 0){shipConfirmDate = listshipConfirmDate[0];}
    If(listdepartConfirmDate.size() > 0){departConfirmDate = listdepartConfirmDate[0];}
    If(listshipLineQtyOrdered.size() > 0){shipLineQtyOrdered = listshipLineQtyOrdered[0];}
    If(listshipLineQtyReceived.size() > 0){shipLineQtyReceived = listshipLineQtyReceived[0];}
    
    r.data.put('smName', smName);
    r.data.put('smLName', smLName);
    r.data.put('smStatus', smStatus);
    r.data.put('smlStatus', smlStatus);
    r.data.put('shipConfirmDate', shipConfirmDate);
    r.data.put('departConfirmDate', departConfirmDate);
    r.data.put('shipLineQtyOrdered', shipLineQtyOrdered);
    r.data.put('shipLineQtyReceived', shipLineQtyReceived);
    return r;
    }
}