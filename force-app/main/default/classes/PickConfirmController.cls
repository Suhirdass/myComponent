/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PickConfirmController
 */
public class PickConfirmController{  
 private static String ERR_MSG_LA_SITE{
        get{
            return String.isNotBlank(ERR_MSG_LA_SITE) ? ERR_MSG_LA_SITE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_Pickconfirm_LASite');
        }set;
    }
    private ApexPages.StandardController stdController;
    private Picklist__c picklistObj = null;
    private Id rsmId;

public  PickConfirmController()
        { 
           
        }

    // Constructor
    public PickConfirmController(ApexPages.StandardController controller) {
        this.stdController = controller;
        picklistObj = (Picklist__c)stdController.getRecord();
    }
    
    
    
    
    public class UserException extends Exception{ }
    
    @AuraEnabled
    public static AuraResponse pickConfirm(String recordId){
        AuraResponse r = new AuraResponse('PickConfirmController.pickConfirm()');    
        PickConfirmController assign = new PickConfirmController();
        Picklist__c  picklistObj = new Picklist__c();
        assign.picklistObj = new Picklist__c();
        Savepoint savePoint;
        
        try {
            // Define save point for rollback
            savePoint = Database.setSavepoint();
                   
                    picklist__c pick = [select id ,Sales_Order__c,Site__c,Site__r.Name from  picklist__c where id  =: recordId];

          

            Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
            system.debug('so>>>>'+SOHold);
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
             String loggedUserUserName = UserInfo.getName();
            List<Site_User__c> lstusersitedata =[select id ,name,User__c,User__r.Name ,User_Active__c,Site__c,Site__r.Active__c,Active__c from Site_User__c where User__r.Name =:loggedUserUserName and Site__c=:pick.Site__c and Site__r.Active__c=True and User_Active__c=True and Active__c=True];
            system.debug('usersite>>>>'+lstusersitedata); 
            system.debug('usersite>>>>'+lstusersitedata.size());
            
            if(lstusersitedata.size()==0){
                r.data.put('errormsgSite',ERR_MSG_LA_SITE);
                return r;  
            }
            else{
                assign.picklistObj = PicklistSupport.retrievePicklistAndLines(recordId);
                
                // Change picklist status to QA Review
                if(assign.picklistObj.Status__c != PicklistSupport.STATUS_QA_CONFIRM &&
                   assign.picklistObj.Status__c != PicklistSupport.STATUS_QA_REVIEW){  assign.picklistObj.Status__c = PicklistSupport.STATUS_QA_REVIEW;
                       //update assign.picklistObj;
                       system.debug('statuspick >>>>>>>'+assign.picklistObj.Status__c);
                       assign.picklistObj.Pick_End__c =system.now();assign.picklistObj.Pick_Confirm_Date__c = system.today();
                       string statuspick = assign.picklistObj.Status__c;  r.data.put('statuspick',statuspick);
                       system.debug('statuspick >>>>'+statuspick);
                       // Update Inventory Positions by moving Inventory Location, Rack, Rack Level and Bin Location to
                       // "QA Review"
                       Set<Id> invPositionIds = new Set<Id>(); List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
                       Set<Id> siteIds = new Set<Id>();
                       for(Picklist_Line__c picklistLineObj : assign.picklistObj.Picklist_Lines__r){
                           if(picklistLineObj.Status__c != 'Cancelled' && picklistLineObj.Status__c != 'Rejected'){invPositionIds.add(picklistLineObj.Inventory_Position__c);
                               siteIds.add(picklistLineObj.Inventory_Position__r.Site__c);    
                           }
                       }
                       System.debug('Size = '+invPositionIds.size());
                       if(invPositionIds.size() > 0){ update assign.picklistObj;
                           invPositions = [Select Site__c, Inventory_Location__c,Rack__c,Rack_Level__c,  Bin_Location__c From Inventory_Position__c Where Id IN: invPositionIds];
                           InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_REVIEW);
                           system.debug('i am inside update');    
                       }
                       
                   }else{
                       if(assign.picklistObj.Status__c == PicklistSupport.STATUS_QA_CONFIRM){   string statusBQ = assign.picklistObj.Status__c;
                           r.data.put('statusBQ',statusBQ); return r;
                       }else if(assign.picklistObj.Status__c == PicklistSupport.STATUS_QA_REVIEW){}
                       
                       system.debug('i am inside 2nd if');
                       string statusBQ = assign.picklistObj.Status__c;r.data.put('statusBQ',statusBQ);
                       system.debug('statusBQ >>>>'+statusBQ);
                       
                       // r.data.put('picklistObj', assign.picklistObj.Status__c);
                       system.debug('assign.picklistObj.Status__c>>>>'+assign.picklistObj.Status__c);
                       return r; 
                   }
            }
            
            
        }catch (Exception ex){
            Database.rollback(savePoint);	
            ErrorLogs.log('PickConfirmController:pickConfirm()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return r;
    }
    /**
     * Change picklist status to QA Review
     *
     * @return PageReference of picklist detail page
     */
    public PageReference pickConfirm() {
        PageReference pageRef = null;
        
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
    

            picklistObj = PicklistSupport.retrievePicklistAndLines(picklistObj.Id);
            
            // Change picklist status to QA Review
            if(picklistObj.Status__c != PicklistSupport.STATUS_QA_CONFIRM &&
               picklistObj.Status__c != PicklistSupport.STATUS_QA_REVIEW){
                picklistObj.Status__c = PicklistSupport.STATUS_QA_REVIEW;
                update picklistObj;
                
                // Update Inventory Positions by moving Inventory Location, Rack, Rack Level and Bin Location to
                // "QA Review"
                Set<Id> invPositionIds = new Set<Id>();
                List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
                Set<Id> siteIds = new Set<Id>();
                for(Picklist_Line__c picklistLineObj : picklistObj.Picklist_Lines__r){
                    invPositionIds.add(picklistLineObj.Inventory_Position__c);
                    siteIds.add(picklistLineObj.Inventory_Position__r.Site__c);
                }
                
                invPositions = [Select Site__c, 
                                       Inventory_Location__c,
                                       Rack__c, 
                                       Rack_Level__c, 
                                       Bin_Location__c
                                       From Inventory_Position__c 
                                       Where Id IN: invPositionIds];
                InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_REVIEW);
                   system.debug('i am in update');
            }else{
                ApexPages.Message msg;
                String errMessage;
                if(picklistObj.Status__c == PicklistSupport.STATUS_QA_CONFIRM){
                    errMessage = Label.Already_QA_Confirm_Picklist;
                }else if(picklistObj.Status__c == PicklistSupport.STATUS_QA_REVIEW){
                    errMessage = Label.Already_QA_Review_Picklist;
                }
                msg = new ApexPages.Message(ApexPages.Severity.WARNING, errMessage);
                ApexPages.addMessage(msg);
                return null;
            }
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('PickConfirmController:pickConfirm()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        system.debug('i am chnaging open to qa');
        return redirectToPickList();
    }

    /**
     * Redirect to Picklist detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToPickList() {
        PageReference pageRef;
        if(picklistObj != null){
            pageRef = new PageReference('/'+picklistObj.Id);
        }else{
            pageRef = stdController.view();
        }
        pageRef.setRedirect(true);
        return pageRef;
    }
}