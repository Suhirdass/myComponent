public class poSnapshotController {
   private static String PURCHASE_ORDER_SNAPSHOT_TO_ADDRESS{ 
        get{
            return String.isNotBlank(PURCHASE_ORDER_SNAPSHOT_TO_ADDRESS) ? PURCHASE_ORDER_SNAPSHOT_TO_ADDRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Snapshot_TOAddress');
        }set;
    }

 @AuraEnabled
    public static AuraResponse runPOSnapshot(String recordId){
        AuraResponse r = new AuraResponse('poSnapshotController.runPOSnapshot()');
        

            
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>([SELECT Arrival_Date__c,Bill_Created__c,Brand_Quote__c,Buyer_Name__c,Chart_of_Account__c,Create_Supplier_Bill__c,
                                                              Cultivation_Tax_Exempt__c,Customer_PO_or_Quote__c,Display_Sample_Order__c,Distributor_Address__c,Distributor_City_State_Zip__c
                                                              ,Distributor_Contact__c,Distributor_Email__c,Distributor_License_Class__c,Distributor_License_Expiration_Date__c,
                                                              Distributor_License_Number__c,Distributor_License_Type__c,Distributor_License__c,Distributor_Name__c,Distributor_Phone__c,
                                                              Driver__c,Factoring_Assignee__c,Factoring_Contact__c,Factoring_Discount__c,Factoring_Rate__c,Fiscal_Period__c
                                                              ,Flag_for_closed_Status__c,Goods_Receipt_Closed_Date__c,Goods_Receipt_Date__c,Id,IsDeleted,Is_Brand_Product__c,
                                                              Last_Payment_Date__c,Last_Recalc_History__c,Name,Next_Payable_Date__c,Opportunity_Name__c,Opportunity_Number__c,
                                                              Order_Type__c,OwnerId,Ownership__c,Payment_Eligible__c,Payment_Terms__c,Pick_up_City__c,Planned_Ship_Transfer_Date__c,
                                                              PO_Balance__c,PO_Date__c,PO_Status__c,PO_Type__c,Priority__c,Promised_Date__c,Purchase_Order_Instructions__c,
                                                              Receiver_Address__c,Receiver_City_State_Zip__c,Receiver_Contact__c,Receiver_DBA__c,Receiver_Email__c,
                                                              Receiver_License_Class__c,Receiver_License_Expiration_Date__c,Receiver_License_Number__c,Receiver_License_Type__c,
                                                              Receiver_License__c,Receiver_Name__c,Receiver_Phone__c,Receiver_Zone__c,Receiving_Fee__c,RecordTypeId,Request_Date__c,
                                                              Retailer_Collection_Status__c,Sales_Person__c,Sample_Order__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,
                                                              Service_Staging_Fee__c,Shipping_Method__c,Shipping_Terms__c,Ship_Confirmation_Date__c,Site__c,Sold_to_Party_DBA__c,
                                                              Sold_to_Party_Legal_Name__c,Supplier_Address__c,Supplier_City_State_Zip__c,Supplier_Contact__c,Supplier_DBA__c,
                                                              Supplier_Email__c,Supplier_First_Name__c,Supplier_ID__c,Supplier_License_Class__c,Supplier_License_Expiration_Date__c,
                                                              Supplier_License_Number__c,Supplier_License_Type__c,Supplier_License__c,Supplier_Name__c,Supplier_Payment_Settled_Date__c,
                                                              Supplier_Zone__c,Supplier_Payable_Date__c,SystemModstamp,Test_Record__c,Total_Cost__c,Total_Partially_Received_Lines__c,Total_Cultivation_Tax__c,Total_Line_Items__c,
                                                              Total_Mileage_Fee__c,Total_Cancelled_Lines__c,Total_Closed_Lines__c,Brand_Quote__r.Name,Total_Payments_Made__c,Total_Weight_Fee__c,Total_Weight_lbs__c,Vehicle__c,Window_End__c,Flash_Title_Date__c,
                                                                      Window_Start_End__c,Window_Start__c FROM Purchase_Order__c   WHERE Id =:recordId]);
        
        List<Purchase_Order_Snapshot__c> POSnap = new List<Purchase_Order_Snapshot__c>();
        
        Integer IPSCount = 0;
        Integer errorCount = 0;
        String errorsDetails = '';

        
        if(poList.size() > 0){
        	
            for(Purchase_Order__c PO : poList){
                Purchase_Order_Snapshot__c POSnapList = new Purchase_Order_Snapshot__c();
                if(PO.Arrival_Date__c != null) POSnapList.Arrival_Date__c = PO.Arrival_Date__c;
                if(PO.Chart_of_Account__c != null) POSnapList.Chart_of_Account__c = PO.Chart_of_Account__c;
                if(PO.Brand_Quote__c != null) POSnapList.Brand_Quote__c = PO.Brand_Quote__c;
            if(PO.Buyer_Name__c != null) POSnapList.Buyer_Name__c = PO.Buyer_Name__c;
              if(PO.Bill_Created__c != null) POSnapList.Bill_Created__c = PO.Bill_Created__c;
                if(PO.Create_Supplier_Bill__c != null) POSnapList.Create_Supplier_Bill__c = PO.Create_Supplier_Bill__c;
                if(PO.Cultivation_Tax_Exempt__c != null) POSnapList.Cultivation_Tax_Exempt__c = PO.Cultivation_Tax_Exempt__c;
                if(PO.Customer_PO_or_Quote__c != null) POSnapList.Order_or_Service__c = PO.Customer_PO_or_Quote__c; 
                if(PO.Display_Sample_Order__c != null) POSnapList.Display_Sample_Order__c = PO.Display_Sample_Order__c; 
                if(PO.Distributor_Address__c != null) POSnapList.Distributor_Address__c = PO.Distributor_Address__c;
                if(PO.Distributor_City_State_Zip__c != null) POSnapList.Distributor_City_State_Zip__c = PO.Distributor_City_State_Zip__c;
                if(PO.Distributor_Contact__c != null) POSnapList.Distributor_Contact__c = PO.Distributor_Contact__c;
                                if(PO.name != null) POSnapList.Purchase_Order__c = PO.name;
                //  if(PO.Distributor_License__c != null) POSnapList.Distributor_License__c = PO.Distributor_License__c; 
                if(PO.Distributor_License_Expiration_Date__c != null) POSnapList.Distributor_License_Expiration_Date__c = PO.Distributor_License_Expiration_Date__c;
                if(PO.Distributor_License_Type__c != null) POSnapList.Distributor_License_Type__c = PO.Distributor_License_Type__c;
                //if(PO.UID__c != null) POSnapList.UID__c = PO.UID__c;
                if(PO.Distributor_Name__c != null) POSnapList.Distributor_Name__c = PO.Distributor_Name__c;
                if(PO.Distributor_Email__c != null) POSnapList.Distributor_Email__c = PO.Distributor_Email__c;
                 if(PO.Distributor_License__c != null) POSnapList.Distributor_License__c = PO.Distributor_License__c;
                 if(PO.Distributor_License_Number__c != null) POSnapList.Distributor_License_Number__c = PO.Distributor_License_Number__c;
                if(PO.Distributor_Phone__c != null) POSnapList.Distributor_Phone__c = PO.Distributor_Phone__c;
                if(PO.Driver__c != null) POSnapList.Driver__c = PO.Driver__c;
                if(PO.Factoring_Assignee__c != null) POSnapList.Factoring_Assignee__c = PO.Factoring_Assignee__c;
                if(PO.Factoring_Contact__c != null) POSnapList.Factoring_Contact__c = PO.Factoring_Contact__c;
                if(PO.Factoring_Discount__c != null) POSnapList.Factoring_Discount__c = PO.Factoring_Discount__c;
                if(PO.Factoring_Rate__c != null) POSnapList.Factoring_Rate__c = PO.Factoring_Rate__c;
                if(PO.Fiscal_Period__c != null) POSnapList.Fiscal_Period__c = PO.Fiscal_Period__c;
                if(PO.Flash_Title_Date__c != null) POSnapList.Flash_Title_Date__c = PO.Flash_Title_Date__c;
                if(PO.Goods_Receipt_Closed_Date__c != null) POSnapList.Goods_Receipt_Closed_Date__c = PO.Goods_Receipt_Closed_Date__c;
                if(PO.Goods_Receipt_Date__c != null) POSnapList.Goods_Receipt_Date__c = PO.Goods_Receipt_Date__c;
                if(PO.Is_Brand_Product__c != null) POSnapList.Is_Brand_Product__c = PO.Is_Brand_Product__c;
                if(PO.Last_Payment_Date__c != null) POSnapList.Last_Payment_Date__c = PO.Last_Payment_Date__c;
                if(PO.Next_Payable_Date__c != null) POSnapList.Next_Payable_Date__c = PO.Next_Payable_Date__c;
                if(PO.Opportunity_Name__c != null) POSnapList.Opportunity_Name__c = PO.Opportunity_Name__c;
                //  if(PO.Name != null) POSnapList.Name = PO.Name;
                // if(PO.Opportunity_Name__c != null && PO.Opportunity_Name__r.Name != null) POSnapList.Opportunity_Name__c = PO.Opportunity_Name__r.Name;
                 if(PO.Opportunity_Number__c != null) POSnapList.Opportunity_Number__c = PO.Opportunity_Number__c;
                if(PO.Ownership__c != null) POSnapList.Ownership__c = PO.Ownership__c;
                if(PO.Order_Type__c != null) POSnapList.Order_Type__c = PO.Order_Type__c;
                if(PO.Payment_Eligible__c != null) POSnapList.Payment_Eligible__c = PO.Payment_Eligible__c;
                if(PO.Payment_Terms__c != null) POSnapList.Payment_Terms__c = PO.Payment_Terms__c;
                if(PO.Pick_up_City__c != null) POSnapList.Pick_up_City__c = PO.Pick_up_City__c;
                if(PO.Planned_Ship_Transfer_Date__c != null) POSnapList.Planned_Ship_Transfer_Date__c = PO.Planned_Ship_Transfer_Date__c;
                if(PO.PO_Balance__c != null) POSnapList.PO_Balance__c = PO.PO_Balance__c;
                if(PO.PO_Date__c != null) POSnapList.PO_Date__c = PO.PO_Date__c;
                if(PO.PO_Status__c != null) POSnapList.PO_Status__c = PO.PO_Status__c;
                if(PO.PO_Type__c != null) POSnapList.PO_Type__c = PO.PO_Type__c;
                if(PO.Priority__c != null) POSnapList.Priority__c = PO.Priority__c;
                if(PO.Promised_Date__c != null) POSnapList.Promised_Date__c = PO.Promised_Date__c;
                if(PO.Receiver_Address__c != null) POSnapList.Receiver_Address__c = PO.Receiver_Address__c;
                if(PO.Purchase_Order_Instructions__c != null) POSnapList.Purchase_Order_Instructions__c = PO.Purchase_Order_Instructions__c;
                if(PO.Receiver_City_State_Zip__c != null) POSnapList.Receiver_City_State_Zip__c = PO.Receiver_City_State_Zip__c;
                if(PO.Receiver_Contact__c != null) POSnapList.Receiver_Contact__c = PO.Receiver_Contact__c;
                if(PO.Receiver_DBA__c != null) POSnapList.Receiver_DBA__c = PO.Receiver_DBA__c;
                // if(PO.Receiver_License_Class__c != null) POSnapList.Receiver_License_Class__c = PO.Receiver_License_Class__c;
                if(PO.Receiver_Email__c != null) POSnapList.Receiver_Email__c = PO.Receiver_Email__c;
                if(PO.Receiver_License_Expiration_Date__c != null) POSnapList.Receiver_License_Expiration_Date__c = PO.Receiver_License_Expiration_Date__c;
                if(PO.Receiver_License_Number__c != null) POSnapList.Receiver_License_Number__c = PO.Receiver_License_Number__c;
                if(PO.Receiver_License_Type__c != null) POSnapList.Receiver_License_Type__c = PO.Receiver_License_Type__c;
               if(PO.Receiver_License__c != null) POSnapList.Receiver_License__c = PO.Receiver_License__c;
               if(PO.Receiver_Name__c != null) POSnapList.Receiver_Name__c = PO.Receiver_Name__c;
         		if(PO.Receiver_Phone__c != null) POSnapList.Receiver_Phone__c = PO.Receiver_Phone__c;
          		 if(PO.Receiving_Fee__c != null) POSnapList.Receiving_Fee__c = PO.Receiving_Fee__c;
                //   if(PO.RecordTypeId != null) POSnapList.RecordTypeId = PO.RecordTypeId;
                if(PO.Request_Date__c != null) POSnapList.Request_Date__c = PO.Request_Date__c;
                if(PO.Retailer_Collection_Status__c != null) POSnapList.Retailer_Collection_Status__c = PO.Retailer_Collection_Status__c;
                
               //  if(PO.Sample_Order__c != null) POSnapList.Sample_Order__c = PO.Sample_Order__c;
                //  if(PO.Revenue_Recognition_Date__c != null) POSnapList.Revenue_Recognition_Date__c = PO.Revenue_Recognition_Date__c;
                //   if(PO.Sales_Order__c != null) POSnapList.Sales_Order__c = PO.Sales_Order__c;
                if(PO.Sales_Person__c != null) POSnapList.Sales_Person__c = PO.Sales_Person__c;
                if(PO.Site__c != null) POSnapList.Site__c = PO.Site__c;
                if(PO.Sample_Order__c != null) POSnapList.Sample_Order__c = PO.Sample_Order__c;
                //  if(PO.Schedule_Dispatch_Fee__c != null) POSnapList.Schedule_Dispatch_Fee__c = PO.Schedule_Dispatch_Fee__c;
                if(PO.Service_Booking_Fee__c != null) POSnapList.Service_Booking_Fee__c = PO.Service_Booking_Fee__c;
                if(PO.Service_Scheduling_Fee__c != null) POSnapList.Service_Scheduling_Fee__c = PO.Service_Scheduling_Fee__c;
                if(PO.Service_Staging_Fee__c != null) POSnapList.Service_Staging_Fee__c = PO.Service_Staging_Fee__c;
              //  if(PO.Ship_Confirmation_Date__c != null) POSnapList.Ship_Confirmation_Date__c = PO.Ship_Confirmation_Date__c;
                if(PO.Shipping_Terms__c != null) POSnapList.Shipping_Terms__c = PO.Shipping_Terms__c;
                if(PO.Ship_Confirmation_Date__c != null) POSnapList.Ship_Confirmation_Date__c = PO.Ship_Confirmation_Date__c;
                if(PO.Shipping_Method__c != null) POSnapList.Shipping_Method__c = PO.Shipping_Method__c;
              //  if(PO.Shipping_Terms__c != null) POSnapList.Shipping_Terms__c = PO.Shipping_Terms__c;
                if(PO.Sold_to_Party_DBA__c != null) POSnapList.Sold_to_Party_DBA__c = PO.Sold_to_Party_DBA__c;
                if(PO.Sold_to_Party_Legal_Name__c != null) POSnapList.Sold_to_Party_Legal_Name__c = PO.Sold_to_Party_Legal_Name__c;
                if(PO.Supplier_Email__c != null) POSnapList.Supplier_Email__c = PO.Supplier_Email__c;
                if(PO.Supplier_Address__c != null) POSnapList.Supplier_Address__c = PO.Supplier_Address__c;
                if(PO.Supplier_City_State_Zip__c != null) POSnapList.Supplier_City_State_Zip__c = PO.Supplier_City_State_Zip__c;
                if(PO.Supplier_Contact__c != null) POSnapList.Supplier_Contact__c = PO.Supplier_Contact__c;
                if(PO.Supplier_DBA__c != null) POSnapList.Supplier_DBA__c = PO.Supplier_DBA__c;
                if(PO.Supplier_License_Expiration_Date__c != null) POSnapList.Supplier_License_Expiration_Date__c = PO.Supplier_License_Expiration_Date__c;
                if(PO.Supplier_License_Type__c != null) POSnapList.Supplier_License_Type__c = PO.Supplier_License_Type__c;
                if(PO.Supplier_Name__c != null) POSnapList.Supplier_Name__c = PO.Supplier_Name__c;
                if(PO.Supplier_First_Name__c != null) POSnapList.Supplier_First_Name__c = PO.Supplier_First_Name__c;
           if(PO.Supplier_License__c != null) POSnapList.Supplier_License__c = PO.Supplier_License__c;
               if(PO.Supplier_Payable_Date__c != null) POSnapList.Supplier_Payable_Date__c = PO.Supplier_Payable_Date__c;
                //  if(PO.Supplier_ID__c != null) POSnapList.Supplier_ID__c = PO.Supplier_ID__c;
                //   if(PO.Supplier_License_Class__c != null) POSnapList.Supplier_License_Class__c = PO.Supplier_License_Class__c;
                if(PO.Supplier_License_Number__c != null) POSnapList.Supplier_License_Number__c = PO.Supplier_License_Number__c;
                if(PO.Supplier_Payment_Settled_Date__c != null) POSnapList.Supplier_Payment_Settled_Date__c = PO.Supplier_Payment_Settled_Date__c;
                //  if(PO.Supplier_Zone__c != null) POSnapList.Supplier_Zone__c = PO.Supplier_Zone__c;
                //if(PO.SystemModstamp != null) POSnapList.SystemModstamp = PO.SystemModstamp;
                //  if(PO.Test_Record__c != null) POSnapList.Test_Record__c = PO.Test_Record__c;
                if(PO.Total_Cost__c != null) POSnapList.Total_Cost__c = PO.Total_Cost__c;
                if(PO.Total_Cultivation_Tax__c != null) POSnapList.Total_Cultivation_Tax__c = PO.Total_Cultivation_Tax__c;
                //if(PO.Total_Cultivation_Tax_Payments_Received__c != null) POSnapList.Total_Cultivation_Tax_Payments_Received__c = PO.Total_Cultivation_Tax_Payments_Received__c;
                //if(PO.Total_Excise_Tax_Amount__c != null) POSnapList.Total_Excise_Tax_Amount__c = PO.Total_Excise_Tax_Amount__c;
                // if(PO.Total_Excise_Tax_Payments_Received__c != null) POSnapList.Total_Excise_Tax_Payments_Received__c = PO.Total_Excise_Tax_Payments_Received__c;
                // if(PO.Total_POoice_Amount__c != null) POSnapList.Total_POoice_Amount__c = PO.Total_POoice_Amount__c;
                 if(PO.Total_Cancelled_Lines__c != null) POSnapList.Total_Cancelled_Lines__c = PO.Total_Cancelled_Lines__c;
            if(PO.Total_Partially_Received_Lines__c != null) POSnapList.Total_Partially_Received_Lines__c = PO.Total_Partially_Received_Lines__c;
             if(PO.Total_Closed_Lines__c != null) POSnapList.Total_Closed_Lines__c = PO.Total_Closed_Lines__c;
               if(PO.Total_Line_Items__c != null) POSnapList.Total_Line_Items__c = PO.Total_Line_Items__c;
                if(PO.Total_Mileage_Fee__c != null) POSnapList.Total_Mileage_Fee__c = PO.Total_Mileage_Fee__c;
                if(PO.Total_Payments_Made__c != null) POSnapList.Total_Payments_Made__c = PO.Total_Payments_Made__c;
                // if(PO.Total_Pick_Pack_Fee__c != null) POSnapList.Total_Pick_Pack_Fee__c = PO.Total_Pick_Pack_Fee__c;
                //  if(PO.Total_Product_Payments_Received__c != null) POSnapList.Total_Product_Payments_Received__c = PO.Total_Product_Payments_Received__c;
                if(PO.Window_Start_End__c != null) POSnapList.Window_Start_End__c = PO.Window_Start_End__c;
                if(PO.Window_End__c != null) POSnapList.Window_End__c = PO.Window_End__c;
            if(PO.Window_Start__c != null) POSnapList.Window_Start__c = PO.Window_Start__c;
                if(PO.Total_Weight_Fee__c != null) POSnapList.Total_Weight_Fee__c = PO.Total_Weight_Fee__c;
                if(PO.Total_Weight_lbs__c != null) POSnapList.Total_Weight_lbs__c = PO.Total_Weight_lbs__c;
                if(PO.Vehicle__c != null) POSnapList.Vehicle__c = PO.Vehicle__c; 
                
                POSnap.add(POSnapList);
            }
            
            if(POSnap.size() > 0){
            	//insert POSnap; 
                Database.SaveResult[] lsr = Database.insert(POSnap,false);
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
        
        String htmlBody = 'Hello, <br><br>Salesforce PO entory Position Snapshot Status';
        htmlBody += '<br><ul><li>Snapshot Run Date: '+jobDate+'</li>';
      //  htmlBody += '<li>Total PO entry Position records: '+POPosList.size()+'</li>';
        htmlBody += '<li>Total Snapshot record created: '+IPSCount+'</li>';
       	htmlBody += '<li>Error records: '+errorCount+'</li></ul>';
        if(errorsDetails != ''){
        	htmlBody += 'Error Details: '+ errorsDetails;
        }
        htmlBody += '<br>Thanks<br>IT Support';
        List<String> bccAddresss = label.Brand_BCC_Addresses.split(',');
        mail.setToAddresses(bccAddresss);
        //mail.setToAddresses(new List<String>{'kapil.dhalwal@icloudygems.com'});
          List<String> lstToadd= PURCHASE_ORDER_SNAPSHOT_TO_ADDRESS.split(',');
        mail.setToAddresses(lstToadd);
       // mail.setToAddresses(new List<String>{PURCHASE_ORDER_SNAPSHOT_TO_ADDRESS});
        mail.setSaveAsActivity(false);
        mail.setHtmlBody(htmlBody);
        mail.setSubject('PO entry Snapshot Records created for '); 
        emails.add(mail);
        Messaging.sendEmail(emails);
        
        return r;
	}

    

}