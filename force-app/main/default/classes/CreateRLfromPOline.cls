/********************************************************************
* Project           : Filigreen
*
* Apex name         : CreateRLfromPOline.apxc
*
* Test Class name   : CreateRLfromPOlineTest.apxc
*
* Author            : Vijay Salem
*
* Date created      : 6/7/2018
*
* Purpose           : Apex Controller for CreateRLfromPO.cmp
*
* Revision History  :
*
* Date        Author      		Ref    Revision (Date in YYYYMMDD format) 
* 6/7/2018    Vijay Salem       1      Apex created for VF. 
* 9/9/2020    Praveen Ayyanar   2      Apex modified for Lightning component.
*
**********************************************************************/

public with sharing class CreateRLfromPOline {
    
    private Receiving__c ObjReceiving;
    public Purchase_Order__c poData { get; set; }
    public boolean showPOline { get; set; }
    public boolean isLoadPOclicked { get; set; }
    private ApexPages.StandardController stdCtrl;
    public id currentID { get; set; }
    //public map<id, receivingLineData> mapOfreceivingLineDatabyPOlid { get; set; }
    public boolean disablePoLine { get; set; }
    public boolean poReadonly { get; set; }
    public Map<String, String> getLabStatusData { get; set; }
    public List<PurchaseOrderLineWrapper> setPurchaseOrderLines {get; set;}
    public boolean loadPOLines { get; set; }
    public Boolean hasLineRecords { get; set; }
    public String pageSize { get; set; }
    private static final String PO_STATUS_CLOSED = SalesOrderSupport.SO_STATUS_CLOSED;
    private static final String PO_STATUS_CANCELLED = SalesOrderSupport.SO_STATUS_CANCELLED;
    private static final String PO_LINE_STATUS_CANCELLED = SalesOrderSupport.SO_LINE_STATUS_CANCELLED;
    
    private static String PO_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PO_RECORD_TYPE_NAME_PRODUCT) ? PO_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
    private static String PO_RECORD_TYPE_NAME_RMA{
        get{
            return String.isNotBlank(PO_RECORD_TYPE_NAME_RMA) ? PO_RECORD_TYPE_NAME_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_RMA');
        }set;
    }
    private static String GROUP_WAREHOUSE_TEAM{
        get{
            return String.isNotBlank(GROUP_WAREHOUSE_TEAM) ? GROUP_WAREHOUSE_TEAM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Group','Group_Name_Warehouse_Team');
        }set;
    }
    private static String ERR_MSG_INVALID_PO{
        get{
            return String.isNotBlank(ERR_MSG_INVALID_PO) ? ERR_MSG_INVALID_PO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_Invalid_PO_Create_Receipts');
        }set;
    }
    private static String ERR_MSG_RESELECT_PO{
        get{
            return String.isNotBlank(ERR_MSG_RESELECT_PO) ? ERR_MSG_RESELECT_PO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_Reselect_The_PO');
        }set;
    }
    
    
    public CreateRLfromPOline(ApexPages.StandardController std) {
        stdCtrl = std;
        ObjReceiving = (Receiving__c) stdCtrl.getRecord();
        if (ObjReceiving.Purchase_Order__c != null) {
            poReadonly = true;
            //poDeatils();
        }
        if (ObjReceiving.Purchase_Order__c == null) {
            showPOline = false;
        }
        hasLineRecords = false;
        pageSize = '5';
    }
    
    public CreateRLfromPOline(){}
    
    //Main method for data request
    @AuraEnabled
    public static AuraResponse purchaseOrderDeatils(String poId){
        System.debug('recordId'+ poId);
        AuraResponse r = new AuraResponse('CreateRLfromPOline.purchaseOrderDeatils()');
        
        CreateRLfromPOline assign = new CreateRLfromPOline();
        
        assign.poData = [select id, Name, PO_Status__c, Supplier_Name__r.Name, Ownership__c, Site__c, Site__r.Name,Site__r.Warehouse_Name__c,Brand_Quote__r.Name,Brand_Quote__r.Id,
                         Customer_PO_or_Quote__c,Purchase_Order_Instructions__c,PO_Date__c,Ownership__r.Name,Supplier_Name__c, Supplier_DBA__c, RecordType.developername,
                         RecordType.name,Distributor_Name__r.DBA__c,Distributor_Name__c,Receiver_DBA__c,Receiver_Name__c, Opportunity_Name__c from Purchase_Order__c where id =: poId];
        
        assign.setPurchaseOrderLines = getPurchaseOrderLines(poId);
        
        assign.getLabStatusData = getLabStatus();
        
        if(assign.poData.PO_Status__c == PO_STATUS_CLOSED || assign.poData.PO_Status__c == PO_STATUS_CANCELLED || (assign.poData.RecordType.developername != PO_RECORD_TYPE_NAME_PRODUCT && assign.poData.RecordType.developername != PO_RECORD_TYPE_NAME_RMA)){
            boolean statusPO = true;
            r.data.put('statusPO',statusPO);
            return r;
        }
        r.data.put('poData', assign.poData);
        r.data.put('setPurchaseOrderLines', assign.setPurchaseOrderLines);
        r.data.put('getLabStatusData', assign.getLabStatusData);
        return r;
    }
    
    //For lab status picklist
    @AuraEnabled
    public static Map<String, String> getLabStatus(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Receiving_Line__c.Lab_Test_Status__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    //To get Purchase order lines
    public static List<PurchaseOrderLineWrapper>  getPurchaseOrderLines(String poId){
        List<PurchaseOrderLineWrapper> plWrapper = new List<PurchaseOrderLineWrapper>();
        
        List <Purchase_Order_Line__c> lstPOline = [select id, Purchase_Order__c, Qty_Ordered__c, Unit_Cost__c, Product_Name__r.Name,Product_Name__r.Is_Sample__c,Product_Name__r.Parent_Product__c,
                                                   Product_Name__r.Item_Type__c, Product_Name__r.StockKeepingUnit, Product_Name__r.Unit_DIMs_Verified__c,Product_Name__r.Case_DIMs_Verified__c,
                                                   Product_Name__c,UID_New__c,UID_New__r.Name, Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,
                                                   Product_Name__r.Description, Product_Name__r.Quantity_Type__c, Balance_Qty__c, Balance_Qty_Value__c, Producer_Name__c,
                                                   Total_Received_Qty__c, Product_Title__c, POLI_Status__c from Purchase_Order_Line__c where Purchase_Order__c = :poId];
        
        for(Purchase_Order_Line__c pOrderLineSO : lstPOline){
            PurchaseOrderLineWrapper poLineWrapper = new PurchaseOrderLineWrapper(pOrderLineSO);
                if(pOrderLineSO.Balance_Qty__c <= 0.00 || pOrderLineSO.POLI_Status__c == PO_LINE_STATUS_CANCELLED){
                    poLineWrapper.isDisabled = true; 
                }
                plWrapper.add(poLineWrapper);
        }
        return plWrapper;
    }
    
    //To create Receivings
    @AuraEnabled
    public static AuraResponse CreateRecevings(Purchase_Order__c poData, List<PurchaseOrderLineWrapper> setPurchaseOrderLines, Boolean isDim){
        system.debug('Inside CreateRecevings');
        AuraResponse r = new AuraResponse('CreateRLfromPOline.CreateRecevings()');
        
        CreateRLfromPOline assign = new CreateRLfromPOline();
        
        Boolean hasBalQty = false;
        
        List<String> pordNames = new List<String>();
        
        List<Purchase_Order_Line__c> verifyPOLI = [SELECT id, Name, Balance_Qty__c, Product_Name__r.Name, Qty_Ordered__c,Total_Received_Qty__c FROM Purchase_Order_Line__c WHERE Purchase_Order__r.Id =: poData.Id];
        system.debug('verifyPOLI'+verifyPOLI);
        if(verifyPOLI.size() > 0){
            for(PurchaseOrderLineWrapper poLineWrpVerify : setPurchaseOrderLines){
                system.debug('poLineWrpVerify'+poLineWrpVerify);
                if(poLineWrpVerify.isSelected && !poLineWrpVerify.isDisabled){
                       system.debug('poLineWrpVerify'+poLineWrpVerify);
                            for(Purchase_Order_Line__c vPOLI : verifyPOLI){
                            if(vPOLI.Id == poLineWrpVerify.pOrderLineSO.Id){
                                system.debug('vPOLI'+vPOLI);
                                system.debug('poLineWrpVerify.recQty'+poLineWrpVerify.recQty);
                                system.debug('poLineWrpVerify.pOrderLineSO.Total_Received_Qty__c'+poLineWrpVerify.pOrderLineSO.Total_Received_Qty__c);
                                system.debug('vPOLI.Qty_Ordered__c'+vPOLI.Qty_Ordered__c);
                                system.debug('vPOLI.Balance_Qty__c'+vPOLI.Balance_Qty__c);
                                 if(poLineWrpVerify.recQty > vPOLI.Balance_Qty__c){
                                     system.debug('Inside final if');
                                     hasBalQty = true; 
                                   pordNames.add(' '+vPOLI.Product_Name__r.Name);
                                }
                            }
                        }
                    }
         		}
        }
        system.debug('hasBalQty'+hasBalQty);
        r.data.put('hasBalQty',hasBalQty);
        r.data.put('pordNames',pordNames);
        
        if(!hasBalQty){
        
        for(PurchaseOrderLineWrapper poLineWrapper : setPurchaseOrderLines){
            Decimal recQty = poLineWrapper.recQty;
            Purchase_Order_Line__c pOrderLineSO = poLineWrapper.pOrderLineSO;
        }
        Receiving__c receivingToCreate = createRecInstance(poData);
            if(poData.Id != null){
                insert receivingToCreate;
            }
        
        String redRec = receivingToCreate.Id;
        r.data.put('redRec',redRec);
        List<Receiving_Line__c> receivingLinesToCreate = new List<Receiving_Line__c>();
        List<Purchase_Order_Line__c> poLineToUpdate = new List<Purchase_Order_Line__c>();   
        for(PurchaseOrderLineWrapper poLineWrapper : setPurchaseOrderLines){
            Purchase_Order_Line__c pOrderLineSO = poLineWrapper.pOrderLineSO;
            if(poLineWrapper.isSelected && !poLineWrapper.isDisabled){
                pOrderLineSO.UID_New__c = poLineWrapper.pOrderLineSO.UID_New__c; 
                poLineToUpdate.add(pOrderLineSO);  

                Receiving_Line__c receivingLinePO = createRecLine(poData, pOrderLineSO, 
                                                                  poLineWrapper.recQty, poLineWrapper.labTestStat,
                                                                  receivingToCreate.Id);
                
                receivingLinesToCreate.add(receivingLinePO); 
            }
        }
        update poLineToUpdate; 
        insert receivingLinesToCreate;
        
        if(isDim){
            Set<Id> recIds = (new Map<Id,Receiving_Line__c>(receivingLinesToCreate)).keySet();
            
            List<String> mailToAddresses = new List<String>();
            Set<Id> idList = new Set<Id>();
            
            Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE name =: GROUP_WAREHOUSE_TEAM];
            
            for (GroupMember gm : g.groupMembers) {
                idList.add(gm.userOrGroupId);
            }
            
            User[] usr = [SELECT email FROM user WHERE id IN :idList];
            
            for(User u : usr) {
                mailToAddresses.add(u.email);
            }
            
            
            List<Receiving_Line__c> lstRecLine = [SELECT Id,Name,Purchase_Order_Line__c,Purchase_Order_Line__r.Name,
                                                  Product_Name__c,Product_Name__r.Name,Product_Description__c,Qty_to_Receive__c,
                                                  Product_Name__r.Is_Sample__c,Product_Name__r.Parent_Product__c,
                                                  Purchase_Order_Line__r.Qty_Ordered__c,UID_New__r.Name,Harvest_Batch_Code__r.Name,
                                                  Lab_Test_Status__c,Product_Name__r.Quantity_Type__c,Product_Name__r.Unit_DIMs_Verified__c,
                                                  Product_Name__r.Case_DIMs_Verified__c,(SELECT Id,Name FROM Inventory_Positions__r)
                                                  FROM Receiving_Line__c WHERE Id In : recIds];
            
            Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String htmlBody = 'Hello Team,<br/><br/>';
            htmlBody += 'Purchase Order:&nbsp;'+poData.Name+'<br/>';
            if(poData.Brand_Quote__c != null){
                htmlBody += 'Brand Quote:&nbsp;'+poData.Brand_Quote__r.Name+'<br/>';
            } else {
                htmlBody += 'Brand Quote:&nbsp;<br/>';
            }
            
            if(poData.Site__c != null){
                htmlBody += 'Site:&nbsp;'+poData.Site__r.Name+', '+ poData.Site__r.Warehouse_Name__c+'<br/>';
            } else {
                htmlBody += 'Site:&nbsp;<br/>';
            }
            
            if(poData.Supplier_DBA__c != null){
                htmlBody += 'Supplier Name:&nbsp;'+poData.Supplier_DBA__c+'<br/><br/>';
            } else {
                htmlBody += 'Supplier Name:&nbsp;<br/><br/>';
            }
            
            htmlBody += 'List of products received without Unit DIMs or Case DIMs Verified.<br/><br/>';
            
            htmlBody += '<table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Receiving Line</th>';
            htmlBody += '<th style="border:1px solid #000">PO Line</th><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
            htmlBody += '<th style="border:1px solid #000">Qty Ordered</th><th style="border:1px solid #000">Qty Received</th><th style="border:1px solid #000">UID</th>';
            htmlBody += '<th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Test Status</th><th style="border:1px solid #000">Qty Type</th>';
            htmlBody += '<th style="border:1px solid #000">UDV</th><th style="border:1px solid #000">CDV</th><th style="border:1px solid #000">Inventory Position</th></tr>';
            
            for(Receiving_Line__c rec : lstRecLine){
                if(!(rec.Product_Name__r.Is_Sample__c && rec.Product_Name__r.Parent_Product__c != null)){
                    if(!rec.Product_Name__r.Unit_DIMs_Verified__c || !rec.Product_Name__r.Case_DIMs_Verified__c){
                        htmlBody += '<tr style="border:1px solid #000">';
                        htmlBody += '<td style="border:1px solid #000"><a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+rec.Id+'">'+rec.Name+'</td>';
                        htmlBody += '<td style="border:1px solid #000"><a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+rec.Purchase_Order_Line__c+'">'+rec.Purchase_Order_Line__r.Name+'</td>';
                        htmlBody += '<td style="border:1px solid #000"><a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+rec.Product_Name__c+'">'+rec.Product_Name__r.Name+'</td>';
                        htmlBody += '<td style="border:1px solid #000">'+rec.Product_Description__c+'</td>';
                        htmlBody += '<td style="border:1px solid #000">'+rec.Purchase_Order_Line__r.Qty_Ordered__c+'</td>';
                        htmlBody += '<td style="border:1px solid #000">'+rec.Qty_to_Receive__c+'</td>';
                        htmlBody += '<td style="border:1px solid #000">'+rec.UID_New__r.Name+'</td>';
                        htmlBody += '<td style="border:1px solid #000">'+rec.Harvest_Batch_Code__r.Name+'</td>';
                        if(rec.Lab_Test_Status__c != null) htmlBody += '<td style="border:1px solid #000">'+rec.Lab_Test_Status__c+'</td>';
                        else htmlBody += '<td style="border:1px solid #000"></td>';
                        if(rec.Product_Name__r.Quantity_Type__c != null) htmlBody += '<td style="border:1px solid #000">'+rec.Product_Name__r.Quantity_Type__c+'</td>';
                        else htmlBody += '<td style="border:1px solid #000"></td>';
                        if(rec.Product_Name__r.Unit_DIMs_Verified__c) htmlBody += '<td style="border:1px solid #000">Yes</td>';
                        else htmlBody += '<td style="border:1px solid #000">No</td>';
                        if(rec.Product_Name__r.Case_DIMs_Verified__c) htmlBody += '<td style="border:1px solid #000">Yes</td>';
                        else htmlBody += '<td style="border:1px solid #000">No</td>';
                        
                        if(rec.Inventory_Positions__r.size() > 0){
                            htmlBody += '<td style="border:1px solid #000"><a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+rec.Inventory_Positions__r[0].Id+'">'+rec.Inventory_Positions__r[0].Name+'</td></tr>';
                        } else {
                            htmlBody += '<td style="border:1px solid #000"></td></tr>';
                        }    
                    }
                }
            }
            
            htmlBody += '</table><br/><br/>Thank you,<br/>Filigreen';
            
            mail.setSubject(poData.Name +' - Products received without Unit/Case DIMs Verified');
            mail.setHtmlBody(htmlBody);
            mail.setToAddresses(mailToAddresses); 
            emails.add(mail);
            Messaging.sendEmail(emails);
        }
    }
        return r;
    }
    
    public static Receiving__c createRecInstance(Purchase_Order__c poData){
        Receiving__c objNewReceiving = new Receiving__c();
        objNewReceiving.Purchase_Order__c = poData.Id;
        objNewReceiving.Site__c = poData.Site__c;
        objNewReceiving.Ownership__c = poData.Ownership__c;
        return objNewReceiving;
    }
    
    public static Receiving_Line__c createRecLine(Purchase_Order__c poData, Purchase_Order_Line__c poLinePO,
                                                  Decimal recQty, String labStat,
                                                  Id recId){
                                                      Receiving_Line__c recLineSO = new Receiving_Line__c();
                                                      recLineSO.Purchase_Order_Line__c = poLinePO.Id;
                                                      recLineSO.Receiving_ID__c = recId;
                                                      recLineSO.Site__c = poData.Site__c;
                                                      recLineSO.Qty_to_Receive__c = recQty;
                                                      recLineSO.UID_New__c = poLinePO.UID_New__c;
                                                      recLineSO.Product_Name__c = poLinePO.Product_Name__c;
                                                      recLineSO.Inventory_Location__c = [select Name from Inventory_Location__c where Site_Name__c = :poData.Site__c AND Default_for_Site__c = :true].id;
                                                      recLineSO.Product_Title__c = poLinePO.Product_Title__c;
                                                      recLineSO.Ownership__c = poData.Ownership__c;
                                                      recLineSO.Harvest_Batch_Code__c = poLinePO.Harvest_Batch_Code__c; 
                                                      recLineSO.Lab_Test_Status__c = labStat; 
                                                      return recLineSO;
                                                  }
    
    /*public void poDeatils() {
        mapOfreceivingLineDatabyPOlid = new map<id, receivingLineData> ();
        
        poData = [select id, PO_Status__c, Supplier_Name__r.Name, Ownership__c, Site__c, 
                  RecordType.developername,RecordType.name from Purchase_Order__c
                  where id = :ObjReceiving.Purchase_Order__c]; 
        disablePoLine = false;
        
        if (poData.PO_Status__c == PO_STATUS_CANCELLED || poData.PO_Status__c == PO_STATUS_CLOSED || (poData.RecordType.developername != PO_RECORD_TYPE_NAME_PRODUCT && poData.RecordType.developername != PO_RECORD_TYPE_NAME_RMA)) {
            showPOline = false;
            disablePoLine = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ERR_MSG_INVALID_PO));
        }
    }

    public PageReference doCancel(){
        return stdCtrl.cancel();
    } 
    
    public void showDatatoPage() {
        if (poData == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, ERR_MSG_RESELECT_PO));
            showPOline = false;
        }
        else if (poData != null) {
            showPOline = true;
        }
        isLoadPOclicked = true;
        mapOfreceivingLineDatabyPOlid = new map<id, receivingLineData> ();
        list<Purchase_Order_Line__c> lstPOline = new list<Purchase_Order_Line__c> ();
        boolean makeLineReadonly;
        
        lstPOline = [select id, Purchase_Order__c, Qty_Ordered__c, Unit_Cost__c, Product_Name__r.Name,
                     Product_Name__r.Item_Type__c, Product_Name__r.StockKeepingUnit, Product_Name__c,UID_New__c,Harvest_Batch_Code__c,
                     Product_Name__r.Description, Product_Name__r.Quantity_Type__c, Balance_Qty__c, Balance_Qty_Value__c, Producer_Name__c,
                     Total_Received_Qty__c, Product_Title__c, POLI_Status__c from Purchase_Order_Line__c where Purchase_Order__c = :ObjReceiving.Purchase_Order__c];
        
        for (Purchase_Order_Line__c objPOlnie : lstPOline) {
            
            makeLineReadonly = false;
            
            if (objPOlnie.Balance_Qty__c == 0.00 || objPOlnie.POLI_Status__c == PO_STATUS_CANCELLED) {
                makeLineReadonly = true;
            }
            
            mapOfreceivingLineDatabyPOlid.put(objPOlnie.id, new receivingLineData(
                objPOlnie.Qty_Ordered__c,
                objPOlnie.Balance_Qty__c,
                objPOlnie.Balance_Qty_Value__c,
                objPOlnie.Unit_Cost__c,
                objPOlnie.Product_Name__r.Name,
                objPOlnie.Product_Name__r.Item_Type__c,
                objPOlnie.Product_Name__r.Description,
                objPOlnie.Product_Name__r.Quantity_Type__c,
                false,
                objPOlnie.id,
                objPOlnie.Producer_Name__c,
                objPOlnie.Total_Received_Qty__c,
                objPOlnie.Product_Name__c,
                objPOlnie.Product_Title__c,
                objPOlnie.POLI_Status__c,
                isLoadPOclicked,
                makeLineReadonly,
                objPOlnie.UID_New__c,objPOlnie.Harvest_Batch_Code__c));
            
            hasLineRecords = true;
        }
    } 
    
    public PageReference CreateReceving() {
        Savepoint sp = Database.setSavepoint();
        
        //Create Receiving 
        PageReference retPage = null;
        
        Receiving__c objNewReceiving = new Receiving__c();
        objNewReceiving.Purchase_Order__c = ObjReceiving.Purchase_Order__c;
        objNewReceiving.Site__c = poData.Site__c;
        objNewReceiving.Ownership__c = poData.Ownership__c;
        
        try {
            insert objNewReceiving;
            
        } catch(Exception ex) {
            ApexPages.addMessages(ex);
            Database.rollback(sp);
            return retPage;
        }
        
        List<Receiving_Line__c> lstReceivingLine = new List<Receiving_Line__c> ();
        
        boolean noOfPOlinesSelected = false;
        
        if (mapOfreceivingLineDatabyPOlid != null)
        {
            id inventoryLocationId;
            inventoryLocationId = [select Name from Inventory_Location__c where Site_Name__c = :poData.Site__c AND Default_for_Site__c = :true].id;
            
            for (receivingLineData objreceivingLineData : mapOfreceivingLineDatabyPOlid.values())
            {
                if (objreceivingLineData.isChecked) {
                    noOfPOlinesSelected = true;

                    if (objreceivingLineData.qtyReceived == NULL || Decimal.valueOf(objreceivingLineData.qtyReceived) <= 0.00) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, system.label.Receiving_qty_error));
                        Database.rollback(sp);
                        return retPage;
                    }
                    
                    if (objreceivingLineData.qtyReceived != NULL && Decimal.valueOf(objreceivingLineData.qtyReceived) > objreceivingLineData.balanceqty)
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, system.label.Receiving_qty_greater_error));
                        Database.rollback(sp);
                        return retPage;
                    }
                    
                    if (objreceivingLineData.RLObj.UID_New__c == NULL) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'UID can not be blank for selected lines'));
                        Database.rollback(sp);
                        return retPage;
                    }
                    
                    if (objreceivingLineData.RLObj.Harvest_Batch_Code__c == NULL) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Harvest Batch or lot code can not be blank for selected lines'));
                        Database.rollback(sp);
                        return retPage;
                    }
                    
                    lstReceivingLine.add(new Receiving_Line__c(
                        Purchase_Order_Line__c = objreceivingLineData.pOlineId,
                        Receiving_ID__c = objNewReceiving.id,
                        Site__c = poData.Site__c,
                        Qty_to_Receive__c = Decimal.valueOf(objreceivingLineData.qtyReceived),
                        UID_New__c = objreceivingLineData.RLObj.UID_New__c,
                        Product_Name__c = objreceivingLineData.productId,
                        Inventory_Location__c = inventoryLocationId,
                        Product_Title__c = objreceivingLineData.ProductTitle,
                        Ownership__c = poData.Ownership__c,
                        Harvest_Batch_Code__c = objreceivingLineData.RLObj.Harvest_Batch_Code__c, 
                        Lab_Test_Status__c = objreceivingLineData.labTestStatus));
                }
            }
        }
        
        if (!noOfPOlinesSelected)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'No lines Selected!'));
            Database.rollback(sp);
            return retPage;
        }
        
        try {
            insert lstReceivingLine;
        } catch(Exception ex) {
            ApexPages.addMessages(ex);
            Database.rollback(sp);
            return retPage;
        }
        
        retPage = new PageReference('/' + objNewReceiving.id);
        retPage.setRedirect(true);
        return retPage;
    } 
    
    public List<SelectOption> getLabTestStatuses() {
        List<SelectOption> options = new List<SelectOption> ();
        
        Schema.DescribeFieldResult fieldResult = Receiving_Line__c.Lab_Test_Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry f : ple) {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        return options;
    }*/
    
    public class PurchaseOrderLineWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public Boolean isDisabled {get; set;}
        @AuraEnabled
        public Purchase_Order_Line__c pOrderLineSO {get; set;}
        @AuraEnabled
        public Decimal recQty {get; set;}
        @AuraEnabled
        public String labTestStat {get; set;}
        
        // Constructor
        public PurchaseOrderLineWrapper(Purchase_Order_Line__c pOrderLineSO){
            this.isSelected = false;
            this.isDisabled = false;
            this.pOrderLineSO = pOrderLineSO;
            this.recQty = 0;
            this.labTestStat = '';
        }
        public PurchaseOrderLineWrapper(){
            this.isSelected = false;
            this.isDisabled = false;
            this.pOrderLineSO = pOrderLineSO;
            this.recQty = 0;
            this.labTestStat = '';
        }
    }
    
    
    /*public class receivingLineData {
        
        public boolean isChecked { get; set; }
        public decimal qtyOrdered { get; set; }
        public decimal balanceqty { get; set; }
        public decimal balanceqtyvalue { get; set; }
        public decimal productPrice { get; set; }
        public string productName { get; set; }
        public string productType { get; set; }
        public string productDescription { get; set; }
        public string QuantityType { get; set; }
        public string qtyReceived { get; set; }
        public id pOlineId { get; set; }
        public string uId { get; set; }
        public string producerName { get; set; }
        public decimal totalReceivedQty { get; set; }
        public string productId { get; set; }
        public string ProductTitle { get; set; }
        public string POLIStatus { get; set; }
        public boolean isLoadPOclicked { get; set; }
        public boolean lineReadonly { get; set; }
        public string harvestBatchOrLotCode { get; set; }
        public string labTestStatus { get; set; }
        public Receiving_Line__c RLObj{set;get;}
        
        public receivingLineData(decimal qtyOrdered, decimal balanceqty, decimal balanceqtyvalue, decimal productPrice,
                                 string productName, string productType, String productDescription, string QuantityType, boolean isChecked,
                                 id pOlineId, String producerName, decimal totalReceivedQty, Id productId, String ProductTitle, String POLIStatus, boolean isLoadPOclicked, boolean lineReadonly,String UID, String batchId) {
                                     this.qtyOrdered = qtyOrdered;
                                     this.balanceqty = balanceqty;
                                     this.balanceqtyvalue = balanceqtyvalue;
                                     this.productPrice = productPrice;
                                     this.productName = productName;
                                     this.productType = productType;
                                     this.productDescription = productDescription;
                                     this.QuantityType = QuantityType;
                                     this.isChecked = isChecked;
                                     this.pOlineId = pOlineId;
                                     this.qtyReceived = '';
                                     this.uId = '';
                                     this.producerName = producerName;
                                     this.totalReceivedQty = totalReceivedQty;
                                     this.productId = productId;
                                     this.ProductTitle = ProductTitle;
                                     this.POLIStatus = POLIStatus;
                                     this.isLoadPOclicked = false;
                                     this.lineReadonly = lineReadonly;
                                     this.harvestBatchOrLotCode = '';
                                     this.labTestStatus = '';
                                     this.RLObj = new Receiving_Line__c(UID_New__c = UID,Harvest_Batch_Code__c = batchId);
                                 }
    } */
}