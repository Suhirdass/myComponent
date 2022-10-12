public class picklistBarcodeScannerCtrl {
    
    public Picklist_Line__c[] picklistLineItems {get;set;}
    public Picklist_Line__c[] pickedPicklistLineItems {get;set;}
    public Picklist__c picklistId {get; set;}
    public String myString {get; set;}
    private Picklist__c picklistObj = null;
    public Picklist_Line__c pkltoUpdate {get; set;}
	
    public static boolean isTestClass = false; public String pklId{set;get;}     
    public Static String DL_ASR_EMAILS{
        get{
            return String.isNotBlank(DL_ASR_EMAILS) ? DL_ASR_EMAILS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
    public Static String IP_HOLD_REASON_INVENTORY_DISCREPANCY{
        get{
            return String.isNotBlank(IP_HOLD_REASON_INVENTORY_DISCREPANCY) ? IP_HOLD_REASON_INVENTORY_DISCREPANCY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','IP_Hold_Reason_Inventory_Discrepancy');
        }set;
    }
    private Static String STATUS_CANCELLED{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','PicklistLine_Cancelled');
        }set;
    }
    private Static String STATUS_REJECTED{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','Picklist_Line_Status_Rejected');
        }set;
    }

    public Static String PICKLIST_STATUS_QA_REVIEW{
        get{
            return String.isNotBlank(PICKLIST_STATUS_QA_REVIEW) ? PICKLIST_STATUS_QA_REVIEW: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_Status_QA_Review');
        }set;
    }
    
    
    public picklistBarcodeScannerCtrl(ApexPages.StandardController stdController) {
        picklistId = (Picklist__c) stdController.getRecord();
    }
    
    Public picklistBarcodeScannerCtrl(){
        myString = '';
    }

    
    public PageReference cancelAction() {
        PageReference page = new PageReference('/'+picklistId.Id);
        page.setRedirect(true);
        return page;
    }
    
    
    public void getScannedValue(){
        List<Picklist_Line__c> pklToUpdate = [select Id, Name,Product_Name__r.Name, Inventory_Position__r.Site__r.Name,Actual_Qty_to_Pick__c,
                                              Inventory_Position__r.Site__r.Warehouse_Name__c, UID__c,  Inventory_Location__c, Harvest_Batch_or_Lot_Code__c,
                                              Bin_Location__c, Rack__c, Rack_Level__c from Picklist_Line__c where Picklist__r.Id =: picklistId.Id];
        
        for(Picklist_Line__c pkl : pklToUpdate){
            string location = pkl.Product_Name__r.Name+' - '+pkl.Harvest_Batch_or_Lot_Code__c+' - '+pkl.Inventory_Position__r.Site__r.Name+' - '+pkl.Inventory_Location__c+' - '+pkl.Rack__c+' - '+pkl.Rack_Level__c+' - '+pkl.Bin_Location__c;
            myString = pkl.Product_Name__r.Name;
            
        }
        //  update pklToUpdate;
    }
    
     @AuraEnabled
    public static AuraResponse manualUpdateScan(String manScanId){
        AuraResponse r = new AuraResponse('picklistBarcodeScannerCtrl.manualUpdateScan()');
        picklistBarcodeScannerCtrl assign = new picklistBarcodeScannerCtrl();
        assign.pkltoUpdate  = [select Id, Name from Picklist_Line__c where Id =: manScanId];
        update assign.pkltoUpdate;
        return r;
    }
    

    @AuraEnabled
    public static AuraResponse getPicklistLineItems(String recordId){
        AuraResponse r = new AuraResponse('picklistBarcodeScannerCtrl.getPicklistLineItems()');
        picklistBarcodeScannerCtrl assign = new picklistBarcodeScannerCtrl();
        assign.picklistLineItems = [select Id, Name, Product_Name__c, Item_Picked__c, Product_Name__r.Name, Qty_to_Pick__c, Qty_Picked__c, UID__c, Inventory_Location__c,
                                    Bin_Location__c, Rack__c, Rack_Level__c, Actual_Qty_to_Pick__c, Picklist__r.Status__c,Harvest_Batch_or_Lot_Code__c,Order_Qty_Cases__c,Product_Name__r.MOQ__c
                                    from Picklist_Line__c where Picklist__r.Id =: recordId AND Item_Picked__c = False];
        
        assign.pickedPicklistLineItems = [select Id, Name, Product_Name__c, Item_Picked__c, Product_Name__r.Name, Qty_to_Pick__c, Qty_Picked__c, UID__c, Inventory_Location__c,
                                    Bin_Location__c, Rack__c, Rack_Level__c, Actual_Qty_to_Pick__c, Picklist__r.Status__c,Harvest_Batch_or_Lot_Code__c,Order_Qty_Cases__c,Product_Name__r.MOQ__c
                                    from Picklist_Line__c where Picklist__r.Id =: recordId AND Item_Picked__c = True];
        
        
        
		assign.picklistId = [select id ,Status__c from  picklist__c where id  =: recordId];
        string cacheKey = 'local.BrandRetailDeliveryOrderItems.'+UserInfo.getUserId();
        r.data.put('picklistLineItems', assign.picklistLineItems);
        r.data.put('pickedPicklistLineItems', assign.pickedPicklistLineItems);
        r.data.put('statusBQ',assign.picklistId.Status__c);
        return r;   
    }
    
    
   @AuraEnabled
    public static AuraResponse updatePicklistLineItems(String pklId, List<Picklist_Line__c> picklistLineItems){
        AuraResponse r = new AuraResponse('picklistBarcodeScannerCtrl.updatePicklistLineItems()');
        picklistBarcodeScannerCtrl assign = new picklistBarcodeScannerCtrl();
        List<Picklist_Line__c> pklUpdate = new List<Picklist_Line__c>();
        for(Picklist_Line__c pklUp : picklistLineItems){
            if(pklUp.Id == pklId){
                pklUp.Item_Picked__c = true;
                pklUpdate.add(pklUp);
            }
        }
        update pklUpdate;
        
        Picklist_Line__c pkl = [select id, Sales_Order_Line__c, Sales_Order_Line__r.Actual_Qty_Ordered__c, Qty_to_Pick__c, Qty_Picked__c, Inventory_Position__c from Picklist_Line__c where Id =: pklId];
        if((pkl.Qty_to_Pick__c > pkl.Qty_Picked__c) || isTestClass == true ){ 
            Inventory_Position__c pklIP = new Inventory_Position__c();
            pklIP.Id=pkl.Inventory_Position__c;
            pklIP.Qty_Allocated__c = pkl.Qty_Picked__c;
            update pklIP;
            decimal QHand;
            Id soliid = null;
        if(pkl.Sales_Order_Line__r.Actual_Qty_Ordered__c != null &&  pkl.Qty_Picked__c != null) { QHand= (pkl.Sales_Order_Line__r.Actual_Qty_Ordered__c - pkl.Qty_Picked__c);
        }
            Inventory_Position__c cloneIP = pklIP.clone();
            cloneIP.Qty_Allocated__c = 0;
            cloneIP.Qty_On_Hand__c = QHand;
            cloneIP.Sales_Order_Line__c = soliid;
            cloneIP.Hold__c = true;
            cloneIP.Inventory_Hold_Reason_Code__c = IP_HOLD_REASON_INVENTORY_DISCREPANCY;
            insert cloneIP;            
            
            decimal qtyAddIPs = 0;
            if( pkl.Sales_Order_Line__c != null){
            Sales_Order_Line__c soli = [select Id, Qty_Ordered__c, Brand_Quote_Line__c, Actual_Qty_Ordered__c, (select Qty_Allocated__c from   Inventory_Positions__r ) from Sales_Order_Line__c where Id =: pkl.Sales_Order_Line__c];
            for(Inventory_Position__c Ip : soli.Inventory_Positions__r)  { 
            qtyAddIPs = qtyAddIPs + Ip.Qty_Allocated__c;} soli.Qty_Ordered__c = qtyAddIPs; update soli;
             Brand_Quote_Line__c bqli = [select Quantity_Cases__c, MOQ__c, Opportunity_Line_Item_Id__c from   Brand_Quote_Line__c where Id =: soli.Brand_Quote_Line__c];
            bqli.Quantity_Cases__c = (qtyAddIPs / bqli.MOQ__c);   update bqli;
            OpportunityLineItem oppli = [select id, Order_Line_Item__c from OpportunityLineItem where Id =: bqli.Opportunity_Line_Item_Id__c];
            Order_Line_Item__c oli = [Select Quantity_Cases__c, MOQ__c from Order_Line_Item__c where Id =: oppli.Order_Line_Item__c];
            oli.Quantity_Cases__c = (qtyAddIPs / oli.MOQ__c);   update oli;
           }
        }
        
        return r;   
    }
    
    @AuraEnabled
    public static AuraResponse pickConfirm(String recordId){
       
        AuraResponse r = new AuraResponse('picklistBarcodeScannerCtrl.pickConfirm()');    
        picklistBarcodeScannerCtrl assign = new picklistBarcodeScannerCtrl();
        Picklist__c  picklistObj = new Picklist__c();
        assign.picklistObj = new Picklist__c();
        Savepoint savePoint;
        
        try {
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            picklist__c pick = [select id ,Status__c, Sales_Order__c from  picklist__c where id  =: recordId];
            
            Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
            Account  supAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
            Account  recAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
            Account  disAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
            String accountName = '';
            Set<String> my_list = new Set<String>();
            if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
            {
                if(supAcc.Hold__c == true){
                    my_list.add(supAcc.DBA__c);
                }
                if(disAcc.Hold__c == true){
                    my_list.add(disAcc.DBA__c);
                }
                if(recAcc.Hold__c == true){
                    my_list.add(recAcc.DBA__c);
                }
                accountName = String.join(new List<String>(my_list), ', ');  
                String ErrorMessage = 'Account: '+ accountName + ' is on HOLD. Please check with Finance team.';
                r.data.put('errorMsg',ErrorMessage);
            }
            else{
                assign.picklistObj = PicklistSupport.retrievePicklistAndLines(recordId);             
                // Change picklist status to QA Review
                if(assign.picklistObj.Status__c != PicklistSupport.STATUS_QA_CONFIRM &&
                   assign.picklistObj.Status__c != PicklistSupport.STATUS_QA_REVIEW){
                       assign.picklistObj.Status__c = PicklistSupport.STATUS_QA_REVIEW;
                       //update assign.picklistObj;
                       string statuspick = assign.picklistObj.Status__c;
                        r.data.put('statuspick',statuspick);
                       // Update Inventory Positions by moving Inventory Location, Rack, Rack Level and Bin Location to
                       // "QA Review"
                       Set<Id> invPositionIds = new Set<Id>();
                       List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
                       Set<Id> siteIds = new Set<Id>();
                       for(Picklist_Line__c picklistLineObj : assign.picklistObj.Picklist_Lines__r){
                           if((picklistLineObj.Status__c != STATUS_CANCELLED && picklistLineObj.Status__c != STATUS_REJECTED)||picklistLineObj.Status__c == null ){
                               invPositionIds.add(picklistLineObj.Inventory_Position__c);
                               siteIds.add(picklistLineObj.Inventory_Position__r.Site__c);    
                           }
                       }
                   
                       if(invPositionIds.size() > 0){
                           update assign.picklistObj;
                          
                           invPositions = [Select Site__c, Inventory_Location__c,Rack__c,Rack_Level__c, 
                                           Bin_Location__c From Inventory_Position__c Where Id IN: invPositionIds];
                           InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_REVIEW);  
                       }
                   }else{
                       if(assign.picklistObj.Status__c == PicklistSupport.STATUS_QA_CONFIRM){
                           string statusBQ = assign.picklistObj.Status__c;
                           r.data.put('statusBQ',statusBQ);
                           return r;}else if(assign.picklistObj.Status__c == PicklistSupport.STATUS_QA_REVIEW){} string statusBQ = assign.picklistObj.Status__c;  r.data.put('statusBQ',statusBQ); return r;
                   }
            }
        }catch (Exception ex){  
            //ErrorLogs.log('PickConfirmController:pickConfirm()', ex.getStackTraceString(), ex.getMessage());  return null;
        }
        
        
        //Email Start
            picklist__c pickEmail = [select id ,Name,Status__c, Sales_Order__c, Total_Line_Item__c, Sales_Order__r.Receiver_Contact__r.Name,
                                     Sales_Order__r.Receiver_City_State_Zip__c, Receiver_DBA__c,Sales_Order__r.Receiver_Address__c, Sales_Order__r.Name
                                     from  picklist__c where id  =: recordId];
      
            if(pickEmail.Status__c == PICKLIST_STATUS_QA_REVIEW){
               
               list<Picklist_Line__c> partialPKL = new list<Picklist_Line__c>();
                list<Picklist_Line__c> fullPKL = new list<Picklist_Line__c>();
               List<Picklist_Line__c> picklistLineItems = [select Id, Name, Qty_to_Pick__c, Qty_Picked__c, Sales_Order_Line__r.Name, Sales_Order_Line__r.Actual_Qty_Ordered__c,
                                                           Harvest_Batch_or_Lot_Code__c, Product_Description__c, Product_Name__r.Name, Actual_Qty_to_Pick__c
                                                           from Picklist_Line__c where Picklist__r.Id =: recordId];
               
                for(Picklist_Line__c pkl : picklistLineItems){
                  
                      if(pkl.Actual_Qty_to_Pick__c > pkl.Qty_Picked__c){ partialPKL.add(pkl); }
                    else{  fullPKL.add(pkl); }
                } 
               
            if(partialPKL.size() > 0  || isTestClass == true){
                        
            Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};  
             if(partialPKL.size() == pickEmail.Total_Line_Item__c){ Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                                                   
                   mail.setSubject(pickEmail.Name +' was partially picked.');  String htmlBody = 'Hello Team';
                   htmlBody += ',<br/><br/>'+pickEmail.Name+' pick confirmed with partially qty. A summary of the picklist is listed below.';
                   htmlBody += '<br/><br/>Business:&nbsp;'+pickEmail.Receiver_DBA__c;
                   htmlBody += '<br/>Contact:&nbsp;'+pickEmail.Sales_Order__r.Receiver_Contact__r.Name;
                   htmlBody += '<br/>Address:&nbsp;'+pickEmail.Sales_Order__r.Receiver_Address__c+', '+pickEmail.Sales_Order__r.Receiver_City_State_Zip__c;
                   htmlBody += '<br/>Total Line Items:&nbsp;'+pickEmail.Total_Line_Item__c;
                   htmlBody += '<br/>Sales Order:&nbsp;'+pickEmail.Sales_Order__r.Name;
                 
                   //Table Start
                   htmlBody += '<br/><br/>Partially picked line items:';
                   htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">SO Line</th><th style="border:1px solid #000">Picklist Line</th><th style="border:1px solid #000">Product Name</th>';
                   htmlBody += '<th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Actual Qty to Pick</th><th style="border:1px solid #000">Qty picked</th></tr>';
                     for(Picklist_Line__c pkli : partialPKL){ htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+pkli.Sales_Order_Line__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Name__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Description__c+'</td>';
                         if(pkli.Harvest_Batch_or_Lot_Code__c != null){ htmlBody += '<td style="border:1px solid #000">'+pkli.Harvest_Batch_or_Lot_Code__c+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         
                         if(pkli.Actual_Qty_to_Pick__c != null){Decimal actRec = pkli.Actual_Qty_to_Pick__c; String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');
                             if(getDecimal.size()>1){if(getDecimal[1] == '00'){ actRec = actRec.setScale(0);}} htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         
                         if(pkli.Qty_Picked__c != null){Decimal actRec = pkli.Qty_Picked__c; String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');
                             if(getDecimal.size()>1){if(getDecimal[1] == '00'){actRec = actRec.setScale(0);}} htmlBody += '<td style="border:1px solid #000">'+actRec+'</td></tr>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td></tr>';  } htmlBody +='</table>';
                                                                   
                 	List<String> ccEmails = DL_ASR_EMAILS.split(',');
                      
                 	   mail.setHtmlBody(htmlBody);
                       mail.setToAddresses(ccEmails); emails.add(mail);
                  } 
             else {
                 
                      //Start of Else
                   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                   mail.setSubject(pickEmail.Name +' was partially picked.');
                   String htmlBody = 'Hello Team';
                   htmlBody += ',<br/><br/>'+pickEmail.Name+' pick confirmed with partially qty. A summary of the picklist is listed below.';
                   htmlBody += '<br/><br/>Business:&nbsp;'+pickEmail.Receiver_DBA__c;
                   htmlBody += '<br/>Contact:&nbsp;'+pickEmail.Sales_Order__r.Receiver_Contact__r.Name;
                   htmlBody += '<br/>Address:&nbsp;'+pickEmail.Sales_Order__r.Receiver_Address__c+', '+pickEmail.Sales_Order__r.Receiver_City_State_Zip__c;
                   htmlBody += '<br/>Total Line Items:&nbsp;'+pickEmail.Total_Line_Item__c;
                   htmlBody += '<br/>Sales Order:&nbsp;'+pickEmail.Sales_Order__r.Name;
                 
                   //Table Start
                   htmlBody += '<br/><br/>Partially picked line items:';
                   htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">SO Line</th><th style="border:1px solid #000">Picklist Line</th><th style="border:1px solid #000">Product Name</th>';
                   htmlBody += '<th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Actual Qty to Pick</th><th style="border:1px solid #000">Qty picked</th></tr>';
                     for(Picklist_Line__c pkli : partialPKL){ htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+pkli.Sales_Order_Line__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Name__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Description__c+'</td>';
                         if(pkli.Harvest_Batch_or_Lot_Code__c != null){  htmlBody += '<td style="border:1px solid #000">'+pkli.Harvest_Batch_or_Lot_Code__c+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         if(pkli.Actual_Qty_to_Pick__c != null ){
                             Decimal actRec = pkli.Actual_Qty_to_Pick__c; String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');
                             if(getDecimal.size()>1){ if(getDecimal[1] == '00'){ actRec = actRec.setScale(0);}} htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         
                         if(pkli.Qty_Picked__c != null){ Decimal actRec = pkli.Qty_Picked__c; String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');
                             if(getDecimal.size()>1){if(getDecimal[1] == '00'){ actRec = actRec.setScale(0);}} htmlBody += '<td style="border:1px solid #000">'+actRec+'</td></tr>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                     }
                 	htmlBody +='</table>';
                      
                      
                    //Full Table Start
                   htmlBody += '<br/><br/> Picklist line items:';
                   htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">SO Line</th><th style="border:1px solid #000">Picklist Line</th><th style="border:1px solid #000">Product Name</th>';
                   htmlBody += '<th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Actual Qty to Pick</th><th style="border:1px solid #000">Qty picked</th></tr>';
                     for(Picklist_Line__c pkli : fullPKL){
                         htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+pkli.Sales_Order_Line__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Name__r.Name+'</td>';
                         htmlBody += '<td style="border:1px solid #000">'+pkli.Product_Description__c+'</td>';
                         if(pkli.Harvest_Batch_or_Lot_Code__c != null){ htmlBody += '<td style="border:1px solid #000">'+pkli.Harvest_Batch_or_Lot_Code__c+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         string status;
                         if(pkli.Actual_Qty_to_Pick__c != null){Decimal actRec = pkli.Actual_Qty_to_Pick__c; String strQty = actRec + '';  String[] getDecimal = strQty.split('\\.');if(getDecimal.size()>1){if(getDecimal[1] == '00'){  actRec = actRec.setScale(0); }} htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                         } else htmlBody += '<td style="border:1px solid #000"></td>';
                         
                         if(pkli.Qty_Picked__c != null){ Decimal actRec = pkli.Qty_Picked__c; String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');  if(getDecimal.size()>1){if(getDecimal[1] == '00'){ actRec = actRec.setScale(0);}}
                             htmlBody += '<td style="border:1px solid #000">'+actRec+'</td></tr>';   } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                     }
                 	htmlBody +='</table>';

                 	  List<String> ccEmails = DL_ASR_EMAILS.split(',');
                 		
                 	   mail.setHtmlBody(htmlBody);
                       mail.setToAddresses(ccEmails);
                 	   emails.add(mail);
                      //end of else
                      } 
                
                       if(emails.size() > 0){
                           
                        Messaging.sendEmail(emails);
                        }
                  }
        	}
            //Email End
        return r;
    }
}