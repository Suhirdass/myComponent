public class runSupplierBillSnapshot {
     private static String SUPPLIER_SNAPSHOT_TO_ADDRESS{ 
        get{
            return String.isNotBlank(SUPPLIER_SNAPSHOT_TO_ADDRESS) ? SUPPLIER_SNAPSHOT_TO_ADDRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Supplier_Snapshot_TOAddress');
        }set;
    }

      @AuraEnabled
    public static AuraResponse runSupplierBillSnapshot(String recordId){
        AuraResponse r = new AuraResponse('runSupplierBillSnapshot.runSupplierBillSnapshot()');
        

            
        List<Supplier_Bill__c> supplierBillList = new List<Supplier_Bill__c>([SELECT Bill_Amount__c,Bill_Closing_Date__c,Ownership__c,Bill_Due_Date__c,Bill_Opening_Date__c,Bill_Settled_Date__c,Brand_Quote__c,
                                                                              Chart_of_Account__c,Id,Is_Brand__c,Name,Order_or_Service__c,Outstanding_Balance__c,Payment_Hold__c,Payment_Terms__c,
                                                                              PO_Settled_Date__c,Purchase_Order__c ,Reference__c,Requestor_Name__c,Shipping_Terms__c,
                                                                              Ship_Confirmation_Date__c,Site__c,Sold_to_Party__c,Status__c,Supplier_Address__c,
                                                                              Supplier_Bill_Date__c,Supplier_Name__c,Total_Payments__c FROM Supplier_Bill__c WHERE Id =:recordId AND Outstanding_Balance__c  > 0 ]);
        
        List<Supplier_Bill_Snapshot__c> sBillSnap = new List<Supplier_Bill_Snapshot__c>();
        
        Integer IPSCount = 0;
        Integer errorCount = 0;
        String errorsDetails = '';

         
        if(supplierBillList.size() > 0){
        	
            for(Supplier_Bill__c res : supplierBillList){
                Supplier_Bill_Snapshot__c sbillSnapList = new Supplier_Bill_Snapshot__c();
                if(res.Bill_Amount__c != null) sbillSnapList.Bill_Amount__c = res.Bill_Amount__c;
                if(res.Bill_Closing_Date__c != null) sbillSnapList.Bill_Closing_Date__c = res.Bill_Closing_Date__c;
                if(res.Bill_Due_Date__c != null) sbillSnapList.Bill_Due_Date__c = res.Bill_Due_Date__c;
                if(res.Bill_Settled_Date__c != null) sbillSnapList.Bill_Settled_Date__c = res.Bill_Settled_Date__c;
                if(res.Brand_Quote__c != null) sbillSnapList.Brand_Quote__c = res.Brand_Quote__c; 
                if(res.Chart_of_Account__c != null) sbillSnapList.Chart_of_Account__c = res.Chart_of_Account__c; 
               if(res.Is_Brand__c != null) sbillSnapList.Is_Brand__c = res.Is_Brand__c;
                if(res.Order_or_Service__c != null) sbillSnapList.Order_or_Service__c = res.Order_or_Service__c;
                if(res.Outstanding_Balance__c != null) sbillSnapList.Outstanding_Balance__c = res.Outstanding_Balance__c;
                if(res.Payment_Hold__c != null) sbillSnapList.Payment_Hold__c = res.Payment_Hold__c; 
                if(res.Payment_Terms__c != null) sbillSnapList.Payment_Terms__c = res.Payment_Terms__c;
                if(res.PO_Settled_Date__c != null) sbillSnapList.PO_Settled_Date__c = res.PO_Settled_Date__c;
                 if(res.Purchase_Order__c != null) sbillSnapList.Purchase_Order__c = res.Purchase_Order__c;
                 if(res.Ownership__c != null) sbillSnapList.Ownerids__c = res.Ownership__c;
                if(res.Reference__c != null) sbillSnapList.Reference__c = res.Reference__c; 
                if(res.Requestor_Name__c != null) sbillSnapList.Requestor_Name__c = res.Requestor_Name__c; 
                if(res.Shipping_Terms__c != null) sbillSnapList.Shipping_Terms__c = res.Shipping_Terms__c;
                 if(res.Ship_Confirmation_Date__c != null) sbillSnapList.Ship_Confirmation_Date__c = res.Ship_Confirmation_Date__c;
                 if(res.Site__c != null) sbillSnapList.Site__c = res.Site__c;
                if(res.Sold_to_Party__c != null) sbillSnapList.Sold_to_Party__c = res.Sold_to_Party__c; 
                if(res.Status__c != null) sbillSnapList.Status__c = res.Status__c;
                if(res.Supplier_Address__c != null) sbillSnapList.Supplier_Address__c = res.Supplier_Address__c;
				if(res.Supplier_Bill_Date__c != null) sbillSnapList.Supplier_Bill_Date__c = res.Supplier_Bill_Date__c;
				if(res.Supplier_Name__c != null) sbillSnapList.Supplier_Name__c = res.Supplier_Name__c;
				if(res.Total_Payments__c != null) sbillSnapList.Total_Payments__c = res.Total_Payments__c;
              
               sBillSnap.add(sbillSnapList);
            }
            
            if(sBillSnap.size() > 0){
            	//insert invSnap; 
                Database.SaveResult[] lsr = Database.insert(sBillSnap,false);
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
        
        String htmlBody = 'Hello, <br><br>Salesforce supplier Bill Snapshot Status';
        htmlBody += '<br><ul><li>Snapshot Run Date: '+jobDate+'</li>';
      //  htmlBody += '<li>Total Inventory Position records: '+invPosList.size()+'</li>';
        htmlBody += '<li>Total Snapshot record created: '+IPSCount+'</li>';
       	htmlBody += '<li>Error records: '+errorCount+'</li></ul>';
        if(errorsDetails != ''){
        	htmlBody += 'Error Details: '+ errorsDetails;
        }
        htmlBody += '<br>Thanks<br>IT Support';
        List<String> bccAddresss = label.Brand_BCC_Addresses.split(',');
        mail.setToAddresses(bccAddresss);
        List<String> lstToadd= SUPPLIER_SNAPSHOT_TO_ADDRESS.split(',');
        mail.setToAddresses(lstToadd);
        mail.setSaveAsActivity(false);
        mail.setHtmlBody(htmlBody);
        mail.setSubject('Supplier Bill Records created for '); 
        emails.add(mail);
        Messaging.sendEmail(emails);
        
        return r;
	}
    

}