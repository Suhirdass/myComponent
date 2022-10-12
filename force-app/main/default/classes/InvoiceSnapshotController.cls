public class InvoiceSnapshotController {
      private static String INVOICE_SNAPSHOT_TO_ADDRESS{
        get{
            return String.isNotBlank(INVOICE_SNAPSHOT_TO_ADDRESS) ? INVOICE_SNAPSHOT_TO_ADDRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Snapshot_TOAddress');
        }set;
    }
    @AuraEnabled
    public static AuraResponse runInvoiceSnapshot(String recordId){
        AuraResponse r = new AuraResponse('InvoiceSnapshotController.runInvoiceSnapshot()');
        

            
        List<Invoice__c> invoicesList = new List<Invoice__c>([SELECT AR_Status__c,AR_Type__c,ApplyLateFee__c,Biller_Name__c,Brand_Quote__r.Name,Chart_of_Account__c,Collections_Status__c,CreatedById,CreatedDate,
                                         Cultivation_Tax_Balance__c,Customer_PO_or_Quote__c,Delivery_City__c,Display_Sample_Order__c,Distributor_Address__c,Distributor_City_State_Zip__c,Brand_Quote__c,
                                         Distributor_Contact__c,Distributor_Email__c,Distributor_License_Class__c,Distributor_License_Expiration_Date__c,Distributor_License_Number__c,Distributor_License_Type__c,Distributor_License__c,Distributor_Name__c,Excise_Tax_Balance__c,Factored_Payable_Amount__c,Factoring_Assignee__c,Factoring_Contact_Email__c,Factoring_Contact__c,Factoring_Discount__c,
                                         Factoring_Rate__c,FG_Opportunity_Name__c,FG_Record_Type__c,Fiscal_Period__c,Id,Invoice_Aged__c,Invoice_Balance__c,Invoice_Date__c,Invoice_Due_Date__c,Invoice_Emailed__c,Invoice_Memo__c,
                                         IsDeleted,Is_Brand_Product__c,Is_Receiver__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Last_Payment_Date__c,LateFeeAmount__c,Likelihood_Pmt_Late__c,
                                         Listing_Fee__c,Name,Next_Payable_Date__c,Opportunity_Name__c,Opportunity_Number__c,Order_Booking_Fee__c,Order_Type__c,OwnerId,Ownership__c,Pack_Out_Fee__c,Payment_Terms__c,Posted_Date__c,Prepayment__c,
                                         Product_Balance__c,Purchased_Date__c,Purchase_Order__c,Receiver_Address__c,Receiver_City_State_Zip__c,Receiver_Contact__c,Receiver_DBA__c,Receiver_Email__c,Receiver_First_Name__c,Receiver_ID__c,
                                         Receiver_License_Class__c,Receiver_License_Expiration_Date__c,Receiver_License_Number__c,Receiver_License_Type__c,Receiver_License__c,Receiver_Name__c,Receiver_Phone__c,Receiver_Zone__c,Receiving_Fee__c,
                                         RecordTypeId,Retailer_PO__c,Revenue_Recognition_Date__c,R_D_Services__c,Sales_Order__c,Sales_Person__c,Sample_Order__c,Schedule_Dispatch_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,
                                         Shipped_Date__c,Shipping_Manifest__c,Shipping_Method__c,Shipping_Terms__c,Ship_Confirmation_Date__c,Site__c,Sold_To_Party__c,Stage_Manifest_Fee__c,Subtotal_Local_Cannabis_Tax__c,Supplier_Address__c,
                                         Supplier_City_State_Zip__c,Excise_Tax_Offset__c,Supplier_Contact__c,Supplier_DBA__c,Supplier_Email__c,Supplier_License_Class__c,Supplier_License_Expiration_Date__c,Supplier_License_Number__c,Supplier_License_Type__c,
                                         Supplier_License__c,Supplier_Name__c,Supplier_Zone__c,SystemModstamp,Tax_Payment_Validation__c,Test_Record__c,TotalInvoiceAmountLateFee__c,Total_Cultivation_Tax_Payments_Received__c,
                                         Total_Cultivation_Tax__c,Total_Excise_Tax_Amount__c,Total_Excise_Tax_Payments_Received__c,Total_Invoice_Amount__c,Total_Line_Items__c,Total_Mileage_Fee__c,Total_Payments_Received__c,
                                         Total_Pick_Pack_Fee__c,Total_Product_Payments_Received__c,Total_Product_Price__c,Total_QA_Review_Fee__c,Total_Weight_Fee__c,Total_Weight_lbs__c,Transfer_Shipping_Manifest__c,Opportunity_Name__r.Name,Ownership__r.Name,Purchase_Order__r.Name,
                                         Receiver_License__r.Name,Receiver_Name__r.Name,Sales_Order__r.Name,Shipping_Manifest__r.Name,Site__r.Name,Supplier_Name__r.Name,Supplier_Contact__r.Name FROM Invoice__c
                                                            WHERE Id =: recordId AND Invoice_Balance__c > 0    ]);
        
        List<Invoice_Snapshot__c> invSnap = new List<Invoice_Snapshot__c>();
        
        Integer IPSCount = 0;
        Integer errorCount = 0;
        String errorsDetails = '';

        
        if(invoicesList.size() > 0){
        	
            for(Invoice__c inv : invoicesList){
                Invoice_Snapshot__c invoiceSnapList = new Invoice_Snapshot__c();
                if(inv.AR_Status__c != null) invoiceSnapList.AR_Status__c = inv.AR_Status__c;
                if(inv.AR_Type__c != null) invoiceSnapList.AR_Type__c = inv.AR_Type__c;
               // if(inv.Brand_Quote__c != null) invoiceSnapList.Brand_Quote__c = inv.Brand_Quote__r.Name;
                if(inv.Brand_Quote__c != null) invoiceSnapList.Brand_Quote__c = inv.Brand_Quote__c;
                if(inv.Collections_Status__c != null) invoiceSnapList.Collections_Status__c = inv.Collections_Status__c;
                if(inv.Delivery_City__c != null) invoiceSnapList.Delivery_City__c = inv.Delivery_City__c; 
                if(inv.Display_Sample_Order__c != null) invoiceSnapList.Display_Sample_Order__c = inv.Display_Sample_Order__c; 
               if(inv.Distributor_Address__c != null) invoiceSnapList.Distributor_Address__c = inv.Distributor_Address__c;
                if(inv.Distributor_City_State_Zip__c != null) invoiceSnapList.Distributor_City_State_Zip__c = inv.Distributor_City_State_Zip__c;
                if(inv.Distributor_Contact__c != null) invoiceSnapList.Distributor_Contact__c = inv.Distributor_Contact__c;
                if(inv.Distributor_License__c != null) invoiceSnapList.Distributor_License__c = inv.Distributor_License__c; 
                 if(inv.Distributor_License_Class__c != null) invoiceSnapList.Distributor_License_Class__c = inv.Distributor_License_Class__c; 
                 if(inv.Distributor_License_Expiration_Date__c != null) invoiceSnapList.Distributor_License_Expiration_Date__c = inv.Distributor_License_Expiration_Date__c; 

                if(inv.Distributor_License_Number__c != null) invoiceSnapList.Distributor_License_Number__c = inv.Distributor_License_Number__c;
                if(inv.Distributor_License_Type__c != null) invoiceSnapList.Distributor_License_Type__c = inv.Distributor_License_Type__c;
                //if(inv.UID__c != null) invoiceSnapList.UID__c = inv.UID__c;
                if(inv.Distributor_Name__c != null) invoiceSnapList.Distributor_Name__c = inv.Distributor_Name__c;
               if(inv.Excise_Tax_Balance__c != null) invoiceSnapList.Excise_Tax_Balance__c = inv.Excise_Tax_Balance__c;
                if(inv.Factored_Payable_Amount__c != null) invoiceSnapList.Factored_Payable_Amount__c = inv.Factored_Payable_Amount__c;
                if(inv.Factoring_Assignee__c != null) invoiceSnapList.Factoring_Assignee__c = inv.Factoring_Assignee__c;
                if(inv.Factoring_Contact__c != null) invoiceSnapList.Factoring_Contact__c = inv.Factoring_Contact__c;
              if(inv.Factoring_Contact_Email__c != null) invoiceSnapList.Factoring_Contact_Email__c = inv.Factoring_Contact_Email__c;
                if(inv.Factoring_Discount__c != null) invoiceSnapList.Factoring_Discount__c = inv.Factoring_Discount__c;
                if(inv.Factoring_Rate__c != null) invoiceSnapList.Factoring_Rate__c = inv.Factoring_Rate__c;
                if(inv.FG_Record_Type__c != null) invoiceSnapList.FG_Record_Type__c = inv.FG_Record_Type__c;
                 if(inv.Invoice_Balance__c != null) invoiceSnapList.Invoice_Balance__c = inv.Invoice_Balance__c;
             if(inv.Tax_Payment_Validation__c != null) invoiceSnapList.Tax_Payment_Validation__c = inv.Tax_Payment_Validation__c;
                if(inv.Invoice_Date__c != null) invoiceSnapList.Invoice_Date__c = inv.Invoice_Date__c;
                if(inv.Invoice_Due_Date__c != null) invoiceSnapList.Invoice_Due_Date__c = inv.Invoice_Due_Date__c;
                if(inv.Invoice_Memo__c != null) invoiceSnapList.Invoice_Memo__c = inv.Invoice_Memo__c;
                if(inv.Is_Receiver__c != null) invoiceSnapList.Is_Receiver__c = inv.Is_Receiver__c;
                if(inv.Last_Payment_Date__c != null) invoiceSnapList.Last_Payment_Date__c = inv.Last_Payment_Date__c;
                if(inv.Purchase_Order__c != null) invoiceSnapList.Purchase_Order__c = inv.Purchase_Order__c;
                if(inv.Listing_Fee__c != null) invoiceSnapList.Listing_Fee__c = inv.Listing_Fee__c;
            if(inv.Test_Record__c != null) invoiceSnapList.Test_Record__c = inv.Test_Record__c;
              if(inv.Name != null) invoiceSnapList.Invoice_Name__c = inv.Name; 
            if(inv.Customer_PO_or_Quote__c != null) invoiceSnapList.Order_or_Service__c = inv.Customer_PO_or_Quote__c;
               if(inv.Opportunity_Name__c != null) invoiceSnapList.Opportunity_Name__c = inv.Opportunity_Name__c;
             //   if(inv.Opportunity_Name__c != null && inv.Opportunity_Name__r.Name != null) invoiceSnapList.Opportunity_Name__c = inv.Opportunity_Name__r.Name;
                if(inv.Opportunity_Number__c != null) invoiceSnapList.Opportunity_Number__c = inv.Opportunity_Number__c;
                if(inv.Order_Booking_Fee__c != null) invoiceSnapList.Order_Booking_Fee__c = inv.Order_Booking_Fee__c;
                if(inv.Order_Type__c != null) invoiceSnapList.Order_Type__c = inv.Order_Type__c;
                if(inv.Supplier_License_Number__c != null) invoiceSnapList.Supplier_License_Number__c = inv.Supplier_License_Number__c;
                if(inv.Supplier_Name__c != null) invoiceSnapList.Supplier_Name__c = inv.Supplier_Name__c;
            if(inv.Supplier_License__c != null) invoiceSnapList.Supplier_License__c = inv.Supplier_License__c;
                if(inv.Ownership__c != null) invoiceSnapList.Ownership__c = inv.Ownership__c;
                if(inv.Pack_Out_Fee__c != null) invoiceSnapList.Pack_Out_Fee__c = inv.Pack_Out_Fee__c;
                if(inv.Payment_Terms__c != null) invoiceSnapList.Payment_Terms__c = inv.Payment_Terms__c;
                if(inv.Posted_Date__c != null) invoiceSnapList.Posted_Date__c = inv.Posted_Date__c;
                if(inv.Product_Balance__c != null) invoiceSnapList.Product_Balance__c = inv.Product_Balance__c;
                if(inv.Purchase_Order__c != null) invoiceSnapList.Purchase_Order__c = inv.Purchase_Order__c;
                if(inv.Purchased_Date__c != null) invoiceSnapList.Purchased_Date__c = inv.Purchased_Date__c;
                if(inv.R_D_Services__c != null) invoiceSnapList.R_D_Services__c = inv.R_D_Services__c;
                if(inv.Receiver_Address__c != null) invoiceSnapList.Receiver_Address__c = inv.Receiver_Address__c;
                if(inv.Receiver_City_State_Zip__c != null) invoiceSnapList.Receiver_City_State_Zip__c = inv.Receiver_City_State_Zip__c;
                if(inv.Receiver_Contact__c != null) invoiceSnapList.Receiver_Contact__c = inv.Receiver_Contact__c;
                if(inv.Receiver_DBA__c != null) invoiceSnapList.Receiver_DBA__c = inv.Receiver_DBA__c;
                if(inv.Receiver_First_Name__c != null) invoiceSnapList.Receiver_First_Name__c = inv.Receiver_First_Name__c;
                if(inv.Receiver_License__c != null) invoiceSnapList.Receiver_License__c = inv.Receiver_License__c;
                if(inv.Receiver_License_Expiration_Date__c != null) invoiceSnapList.Receiver_License_Expiration_Date__c = inv.Receiver_License_Expiration_Date__c;
                if(inv.Receiver_License_Number__c != null) invoiceSnapList.Receiver_License_Number__c = inv.Receiver_License_Number__c;
                if(inv.Receiver_License_Type__c != null) invoiceSnapList.Receiver_License_Type__c = inv.Receiver_License_Type__c;
                if(inv.Receiver_Name__c != null) invoiceSnapList.Receiver_Name__c = inv.Receiver_Name__c;
             if(inv.Receiver_License_Class__c != null) invoiceSnapList.Receiver_License_Class__c = inv.Receiver_License_Class__c;
                if(inv.Receiving_Fee__c != null) invoiceSnapList.Receiving_Fee__c = inv.Receiving_Fee__c;
                if(inv.Retailer_PO__c != null) invoiceSnapList.Retailer_PO__c = inv.Retailer_PO__c;
                if(inv.Revenue_Recognition_Date__c != null) invoiceSnapList.Revenue_Recognition_Date__c = inv.Revenue_Recognition_Date__c;
                if(inv.Sales_Order__c != null) invoiceSnapList.Sales_Order__c = inv.Sales_Order__c;
                if(inv.Sales_Person__c != null) invoiceSnapList.Sales_Person__c = inv.Sales_Person__c;
                if(inv.Site__c != null) invoiceSnapList.Site__c = inv.Site__c;
                if(inv.Sample_Order__c != null) invoiceSnapList.Sample_Order__c = inv.Sample_Order__c;
                if(inv.Schedule_Dispatch_Fee__c != null) invoiceSnapList.Schedule_Dispatch_Fee__c = inv.Schedule_Dispatch_Fee__c;
                if(inv.Service_Booking_Fee__c != null) invoiceSnapList.Service_Booking_Fee__c = inv.Service_Booking_Fee__c;
                if(inv.Service_Scheduling_Fee__c != null) invoiceSnapList.Service_Scheduling_Fee__c = inv.Service_Scheduling_Fee__c;
                if(inv.Service_Staging_Fee__c != null) invoiceSnapList.Service_Staging_Fee__c = inv.Service_Staging_Fee__c;
            	if(inv.Ship_Confirmation_Date__c != null) invoiceSnapList.Ship_Confirmation_Date__c = inv.Ship_Confirmation_Date__c;
                 if(inv.Shipped_Date__c != null) invoiceSnapList.Shipped_Date__c = inv.Shipped_Date__c;
                if(inv.Shipping_Manifest__c != null) invoiceSnapList.Shipping_Manifest__c = inv.Shipping_Manifest__c;
                if(inv.Shipping_Method__c != null) invoiceSnapList.Shipping_Method__c = inv.Shipping_Method__c;
                if(inv.Shipping_Terms__c != null) invoiceSnapList.Shipping_Terms__c = inv.Shipping_Terms__c;
               if(inv.LateFeeAmount__c != null) invoiceSnapList.Late_Fee_Amount__c = inv.LateFeeAmount__c;
                if(inv.Sold_To_Party__c != null) invoiceSnapList.Sold_To_Party__c = inv.Sold_To_Party__c;
                if(inv.Stage_Manifest_Fee__c != null) invoiceSnapList.Stage_Manifest_Fee__c = inv.Stage_Manifest_Fee__c;
                if(inv.Subtotal_Local_Cannabis_Tax__c != null) invoiceSnapList.Subtotal_Local_Cannabis_Tax__c = inv.Subtotal_Local_Cannabis_Tax__c;
                if(inv.Supplier_Address__c != null) invoiceSnapList.Supplier_Address__c = inv.Supplier_Address__c;
                if(inv.Supplier_City_State_Zip__c != null) invoiceSnapList.Supplier_City_State_Zip__c = inv.Supplier_City_State_Zip__c;
                if(inv.Supplier_Contact__c != null) invoiceSnapList.Supplier_Contact__c = inv.Supplier_Contact__c;
                if(inv.Supplier_DBA__c != null) invoiceSnapList.Supplier_DBA__c = inv.Supplier_DBA__c;
                if(inv.Supplier_License_Expiration_Date__c != null) invoiceSnapList.Supplier_License_Expiration_Date__c = inv.Supplier_License_Expiration_Date__c;
                if(inv.Supplier_License_Type__c != null) invoiceSnapList.Supplier_License_Type__c = inv.Supplier_License_Type__c;
                if(inv.Supplier_Name__c != null) invoiceSnapList.Supplier_Name__c = inv.Supplier_Name__c;
                if(inv.Total_Cultivation_Tax__c != null) invoiceSnapList.Total_Cultivation_Tax__c = inv.Total_Cultivation_Tax__c;
                if(inv.Total_Cultivation_Tax_Payments_Received__c != null) invoiceSnapList.Total_Cultivation_Tax_Payments_Received__c = inv.Total_Cultivation_Tax_Payments_Received__c;
                if(inv.Total_Excise_Tax_Amount__c != null) invoiceSnapList.Total_Excise_Tax_Amount__c = inv.Total_Excise_Tax_Amount__c;
                if(inv.Total_Excise_Tax_Payments_Received__c != null) invoiceSnapList.Total_Excise_Tax_Payments_Received__c = inv.Total_Excise_Tax_Payments_Received__c;
                if(inv.Total_Invoice_Amount__c != null) invoiceSnapList.Total_Invoice_Amount__c = inv.Total_Invoice_Amount__c;
                if(inv.Total_Line_Items__c != null) invoiceSnapList.Total_Line_Items__c = inv.Total_Line_Items__c;
                if(inv.Total_Mileage_Fee__c != null) invoiceSnapList.Total_Mileage_Fee__c = inv.Total_Mileage_Fee__c;
                if(inv.Total_Payments_Received__c != null) invoiceSnapList.Total_Payments_Received__c = inv.Total_Payments_Received__c;
                if(inv.Total_Pick_Pack_Fee__c != null) invoiceSnapList.Total_Pick_Pack_Fee__c = inv.Total_Pick_Pack_Fee__c;
                if(inv.Total_Product_Payments_Received__c != null) invoiceSnapList.Total_Product_Payments_Received__c = inv.Total_Product_Payments_Received__c;
                if(inv.Total_Product_Price__c != null) invoiceSnapList.Total_Product_Price__c = inv.Total_Product_Price__c;
                if(inv.Total_QA_Review_Fee__c != null) invoiceSnapList.Total_QA_Review_Fee__c = inv.Total_QA_Review_Fee__c;
                if(inv.Total_Weight_Fee__c != null) invoiceSnapList.Total_Weight_Fee__c = inv.Total_Weight_Fee__c;
                if(inv.Total_Weight_lbs__c != null) invoiceSnapList.Total_Weight_lbs__c = inv.Total_Weight_lbs__c;
                 if(inv.Cultivation_Tax_Balance__c != null) invoiceSnapList.Cultivation_Tax_Balance__c = inv.Cultivation_Tax_Balance__c;

                if(inv.TotalInvoiceAmountLateFee__c != null) invoiceSnapList.TotalInvoiceAmountLateFee__c = inv.TotalInvoiceAmountLateFee__c; 
                  if(inv.ApplyLateFee__c != null) invoiceSnapList.Apply_Late_Fee__c	= inv.ApplyLateFee__c; 
                  if(inv.Biller_Name__c != null) invoiceSnapList.Biller_Name__c	= inv.Biller_Name__c; 
                   if(inv.Chart_of_Account__c != null) invoiceSnapList.Chart_of_Account__c	= inv.Chart_of_Account__c; 
                 if(inv.Distributor_Email__c != null) invoiceSnapList.Distributor_Email__c	= inv.Distributor_Email__c; 
                     if(inv.Excise_Tax_Offset__c != null) invoiceSnapList.Excise_Tax_Offset__c	= inv.Excise_Tax_Offset__c; 
                  if(inv.FG_Opportunity_Name__c != null) invoiceSnapList.FG_Opportunity_Name__c	= inv.FG_Opportunity_Name__c; 
                  if(inv.Fiscal_Period__c != null) invoiceSnapList.Fiscal_Period__c	= inv.Fiscal_Period__c; 
                   if(inv.Invoice_Aged__c != null) invoiceSnapList.Invoice_Aged__c	= inv.Invoice_Aged__c; 
                if(inv.Invoice_Emailed__c != null) invoiceSnapList.Invoice_Emailed__c	= inv.Invoice_Emailed__c; 
                 if(inv.Is_Brand_Product__c != null) invoiceSnapList.Is_Brand_Product__c	= inv.Is_Brand_Product__c;
                 if(inv.Likelihood_Pmt_Late__c != null) invoiceSnapList.Likelihood_Pmt_Late__c	= inv.Likelihood_Pmt_Late__c;
                 if(inv.Next_Payable_Date__c != null) invoiceSnapList.Next_Payable_Date__c = inv.Next_Payable_Date__c;
                 if(inv.Prepayment__c != null) invoiceSnapList.Prepayment__c = inv.Prepayment__c;
                 if(inv.Receiver_Email__c != null) invoiceSnapList.Receiver_Email__c = inv.Receiver_Email__c;
                 if(inv.Receiver_ID__c != null) invoiceSnapList.Receiver_ID__c = inv.Receiver_ID__c;
                 if(inv.Receiver_Phone__c != null) invoiceSnapList.Receiver_Phone__c = inv.Receiver_Phone__c;
                 if(inv.Receiver_Zone__c != null) invoiceSnapList.Receiver_Zone__c = inv.Receiver_Zone__c;
                  if(inv.Supplier_Email__c != null) invoiceSnapList.Supplier_Email__c = inv.Supplier_Email__c;
                 if(inv.Supplier_License_Class__c != null) invoiceSnapList.Supplier_License_Class__c = inv.Supplier_License_Class__c;
                   if(inv.Supplier_Zone__c != null) invoiceSnapList.Supplier_Zone__c = inv.Supplier_Zone__c;
                   if(inv.Transfer_Shipping_Manifest__c != null) invoiceSnapList.Transfer_Shipping_Manifest__c = inv.Transfer_Shipping_Manifest__c;
                 //if(inv.Site__c != null) invoiceSnapList.Site__c = inv.Site__r.Name; 
            	//if(inv.Product_Name__c != null && inv.Product_Name__r.Month_Starting_Inventory__c != null) invoiceSnapList.Starting_Inventory__c = inv.Product_Name__r.Month_Starting_Inventory__c;
            	//if(inv.Product_Name__c != null && inv.Product_Name__r.Total_Inventory__c != null) invoiceSnapList.Ending_Inventory__c = inv.Product_Name__r.Total_Inventory__c;
              /*  AuraResponse recordsData = getSMdetails(inv.Id); 
                invoiceSnapList.Shipping_Manifest__c = (String)recordsData.Data.get('smName'); 
                invoiceSnapList.Shipping_Manifest_Line__c = (String)recordsData.Data.get('smLName');
                invoiceSnapList.Shipping_Manifest_Status__c = (String)recordsData.Data.get('smStatus');
                invoiceSnapList.Shipping_Manifest_Line_Status__c = (String)recordsData.Data.get('smlStatus');
                invoiceSnapList.Ship_Confirmation_Date__c = (Date)recordsData.Data.get('shipConfirmDate');
                invoiceSnapList.Depart_Confirm_Date__c = (Datetime)recordsData.Data.get('departConfirmDate');
                invoiceSnapList.SM_LI_Qty_Ordered__c = (Decimal)recordsData.Data.get('shipLineQtyOrdered');
                invoiceSnapList.SM_LI_Qty_Received__c = (Decimal)recordsData.Data.get('shipLineQtyReceived');
                */
               invSnap.add(invoiceSnapList);
            }
            
            if(invSnap.size() > 0){
            	//insert invSnap; 
                Database.SaveResult[] lsr = Database.insert(invSnap,false);
                for (Database.SaveResult SR : lsr) {
                    if (!SR.isSuccess()) { errorCount +=1;
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
        
        String htmlBody = 'Hello, <br><br>Salesforce Invoice Snapshot Status';
        htmlBody += '<br><ul><li>Snapshot Run Date: '+jobDate+'</li>';
      //  htmlBody += '<li>Total Inventory Position records: '+invPosList.size()+'</li>';
        htmlBody += '<li>Total Snapshot record created: '+IPSCount+'</li>';
       	htmlBody += '<li>Error records: '+errorCount+'</li></ul>';
        if(errorsDetails != ''){htmlBody += 'Error Details: '+ errorsDetails;
        }
        htmlBody += '<br>Thanks<br>IT Support';
        List<String> bccAddresss = label.Brand_BCC_Addresses.split(',');
        mail.setToAddresses(bccAddresss);
        //mail.setToAddresses(new List<String>{'kapil.dhalwal@icloudygems.com'});
        List<String> lstToadd= INVOICE_SNAPSHOT_TO_ADDRESS.split(',');
        mail.setToAddresses(lstToadd);
        mail.setSaveAsActivity(false);
        mail.setHtmlBody(htmlBody);
        mail.setSubject('Invoice Snapshot Records created for '); 
        emails.add(mail);
        Messaging.sendEmail(emails);
        
        return r;
	}
   
    
    public static Auraresponse getSMdetails(Id ipId) {
        AuraResponse r = new AuraResponse('InvoiceSnapshotController.getSMdetails()');
        
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