public class ConvertServiceTicketController {
    
    
    Service_Ticket__c st;
    public Service_Ticket__c stlobj {get; set;}
    private Id oppRecordTypeId;
    
    private ApexPages.StandardController stdController;
    
    
    
    
    public ConvertServiceTicketController(ApexPages.StandardController controller){
        this.stdController = controller;
        stlobj = (Service_Ticket__c)stdController.getRecord();
        st = (Service_Ticket__c)controller.getRecord();
        
    } 
    
    
    public  ConvertServiceTicketController()
    { 
        
    } 
    
    
    
    
    
    
    
    @AuraEnabled
    public static AuraResponse  convertServiceTickets(String recordId){
        AuraResponse r = new AuraResponse('ConvertServiceTicketController.convertServiceTickets()');    
        ConvertServiceTicketController assign = new ConvertServiceTicketController();
        assign.stlobj = new Service_Ticket__c();
        
        
        List<Service_Ticket__c> stllst =[SELECT Id, Name, Brand_Contact__c	,Destination_Site__c, Brand_Name__c, Brand_Name__r.Payment_Terms__c, Brand_Name__r.Community_Price_Book__c,Drive_And_Contact_Details__c ,
                                         Status__c ,Transfer_Method__c ,Max_Material_Arrival_Date__c ,Opportunity__c,Request_Date_Time__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c,
                                         (SELECT Id,/*CRP_Required__c,*/Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                                          /*Labels_Qty__c , */Per_Unit_Weight_g__c ,PreRoll_Packaging__c , 
                                          New_Packaged_Product__c ,Qty_Per_Multi_Unit__c, Retail_Wholesale_Price__c,Service_Ticket__c,Spl_Packaging_Notes__c ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                                          Total_Desired_Retail_Ready_Form__c ,Harvest_Batch_Code__c,Total_Units__c ,UID__c,Total_Weight_lbs__c,Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c  
                                          FROM Service_Ticket_Lines__r) 
                                         FROM Service_Ticket__c 
                                         WHERE Id =: recordId];
        
        if(stllst.size() > 0){
            assign.stlobj  = stllst[0];  
        }
        
        if(assign.stlobj .Opportunity__c != null){
            string Opp = assign.stlobj .Opportunity__c;
            r.data.put('Opp', Opp);
            system.debug('assign.stlobj>>>'+Opp);
            
            system.debug('response>>>>'+r);
            return r;
            
        } 
        Savepoint sp = Database.setSavepoint();
        try{ 
            Id oppRecordTypeId;
            
            Site__c[] companySites = [SELECT Id FROM Site__c WHERE Name= : Label.Company_Site_Id];
            Opportunity newOpp = new Opportunity(RecordTypeId =  assign.oppRecordTypeId,Name = assign.stlobj.Name,Requested_Transfer_Date__c = (assign.stlobj.Request_Date_Time__c != NULL ?Date.valueOf(assign.stlobj.Request_Date_Time__c):NULL),AccountId = assign.stlobj.Brand_Name__c,CloseDate = assign.stlobj.Max_Material_Arrival_Date__c,StageName = 'Proposal/Price Quote',Type ='New Business', Sales_Origin__c = 'Brand',Ownership__c = assign.stlobj.Brand_Name__c, Payment_Terms__c = assign.stlobj.Brand_Name__r.Payment_Terms__c, Site_Name__c = (companySites.isEmpty()?null:companySites[0].Id));               
            
            if(assign.stlobj.Destination_Site__c != null){
                newOpp.Site_Name__c = assign.stlobj.Destination_Site__c;
            }
            /*if(assign.stlobj.Transfer_Method__c == 'D2D Transfer'){
newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Transfer').getRecordTypeId(); 
assign.oppRecordTypeId = newOpp.RecordTypeId;
newOpp.AccountId = null;
} else {
newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
assign.oppRecordTypeId = newOpp.RecordTypeId;
} */
            
            newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
            assign.oppRecordTypeId = newOpp.RecordTypeId;
            
            
            newOpp.Total_Mileage_Fee__c = assign.stlobj.Total_Mileage_Fee__c;
            newOpp.Total_Weight_Fee__c = assign.stlobj.Total_Weight_Fee__c;
            newOpp.Service_Booking_Fee__c = assign.stlobj.Service_Booking_Fee__c;
            newOpp.Service_Scheduling_Fee__c = assign.stlobj.Service_Scheduling_Fee__c;
            newOpp.Service_Staging_Fee__c  = assign.stlobj.Service_Staging_Fee__c ;
            
            // assign.oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
            
            //  Site__c[] companySites = [SELECT Id FROM Site__c WHERE Name= : Label.Company_Site_Id];
            //   Opportunity newOpp = new Opportunity(RecordTypeId = assign.oppRecordTypeId,Name = assign.stlobj .Name,AccountId = assign.stlobj .Brand_Name__c,CloseDate = assign.stlobj .Max_Material_Arrival_Date__c,StageName = 'Proposal/Price Quote',Type ='New Business', Sales_Origin__c = 'Brand',Ownership__c = assign.stlobj .Brand_Name__c, Payment_Terms__c = assign.stlobj .Brand_Name__r.Payment_Terms__c, Site_Name__c = (companySites.isEmpty()?null:companySites[0].Id));
            
            insert newOpp;
            Opportunity  newOpps = newOpp;
            
            r.data.put('newOpps', newOpps);
            
            
            system.debug('newOpps>>'+newOpps);
            assign.stlobj .Opportunity__c = newOpp.Id;
            assign.stlobj .Status__c = 'Accepted';
            update assign.stlobj ;
            system.debug('assign.stlobj>>'+assign.stlobj);
            
            List<OpportunityLineItem> olis = new List<OpportunityLineItem>();
            if(!assign.stlobj .Service_Ticket_Lines__r.isEmpty()){
                Set<Id> productIds = new Set<Id>();
                for(Service_Ticket_Line__c stl: assign.stlobj .Service_Ticket_Lines__r){
                    productIds.add(stl.New_Packaged_Product__c);
                }
                if(!productIds.isEmpty()){
                    Map<Id,PricebookEntry> productPriceBookMap = new Map<Id,PricebookEntry>();
                    Map<Id,PricebookEntry> standardproductPriceBookMap = new Map<Id,PricebookEntry>();
                    for(PricebookEntry pbe: [SELECT Id,Product2Id,UnitPrice FROM PricebookEntry WHERE Product2Id IN: productIds AND PriceBook2Id = :  assign.stlobj.Brand_Name__r.Community_Price_Book__c]){
                        productPriceBookMap.put(pbe.Product2Id,pbe);
                    }
                    for(PricebookEntry pbe: [SELECT Id,Product2Id,UnitPrice FROM PricebookEntry WHERE Product2Id IN: productIds AND PriceBook2.Name = : 'Standard Price Book']){
                        standardproductPriceBookMap.put(pbe.Product2Id,pbe);
                    } 
                    
                    for(Service_Ticket_Line__c stl: assign.stlobj .Service_Ticket_Lines__r){
                        System.debug('STL:'+stl);
                        PricebookEntry pbe = productPriceBookMap.get(stl.New_Packaged_Product__c);
                        PricebookEntry spbe = standardproductPriceBookMap.get(stl.New_Packaged_Product__c);
                        
                        System.debug('###pbe:'+pbe);
                        OpportunityLineItem oli = new OpportunityLineItem(
                            OpportunityId = newOpp.Id,
                            PriceBookEntryId = (pbe != null?pbe.Id:null),
                            Quantity = (stl.Qty_Per_Multi_Unit__c > 1? stl.Total_Units__c/stl.Qty_Per_Multi_Unit__c :stl.Total_Units__c),
                            UnitPrice = ((stl.Retail_Wholesale_Price__c == null || stl.Retail_Wholesale_Price__c == 0)?(spbe != null?spbe.UnitPrice:0):stl.Retail_Wholesale_Price__c),
                            Product_Title__c  = 'Distributor',
                            Total_Weight_lbs__c = stl.Total_Weight_lbs__c,
                            Harvest_Batch_Code__c = stl.Harvest_Batch_Code__c
                        );
                        
                        olis.add(oli);
                    }
                    if(!olis.isEmpty()){
                        insert olis;
                        system.debug('olis>>'+olis);
                        // pr = new PageReference('/'+st.Id);
                    }
                }
            }
        }catch(Exception e){
            //  if(!Test.isRunningTest())
            Database.rollback(sp);
            
            return r;
        }
        
        return r;
    }
    
    
    
    
    
    public PageReference convertServiceTicket(){
        PageReference pr;
        if(st != null){
            st = [SELECT Id, Name, Brand_Contact__c	,Destination_Site__c, Brand_Name__c, Brand_Name__r.Payment_Terms__c, Brand_Name__r.Community_Price_Book__c,Drive_And_Contact_Details__c ,
                  Status__c ,Transfer_Method__c ,Max_Material_Arrival_Date__c ,Opportunity__c,Request_Date_Time__c,Total_Mileage_Fee__c, Total_Weight_Fee__c, Total_Weight_lbs__c, Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c,
                  (SELECT Id, /*CRP_Required__c,*/Desired_Retail_Ready_Form__c ,Expected_Arrival_At_Filligreen__c ,Harvest_Batch_ID__c ,
                   /*Labels_Qty__c , */Per_Unit_Weight_g__c ,PreRoll_Packaging__c , 
                   New_Packaged_Product__c ,Qty_Per_Multi_Unit__c,Harvest_Batch_Code__c, Retail_Wholesale_Price__c,Service_Ticket__c,Spl_Packaging_Notes__c ,Test_Required__c ,Total_Cannabis_Weight_g__c ,
                   Total_Desired_Retail_Ready_Form__c ,Total_Units__c ,UID__c,Total_Weight_lbs__c,Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c  
                   FROM Service_Ticket_Lines__r) 
                  FROM Service_Ticket__c 
                  WHERE Id =: st.Id];
            if(st.Opportunity__c != null){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,
                                                              Label.Already_Converted_Service_Ticket);
                ApexPages.addMessage(msg);
                return pr;
            }
            Savepoint sp = Database.setSavepoint();
            try{
                Id oppRecordTypeId;
                
                Site__c[] companySites = [SELECT Id FROM Site__c WHERE Name= : Label.Company_Site_Id];
                Opportunity newOpp = new Opportunity(RecordTypeId = oppRecordTypeId,Name = st.Name,Requested_Transfer_Date__c = (st.Request_Date_Time__c != NULL ?Date.valueOf(st.Request_Date_Time__c):NULL),AccountId = st.Brand_Name__c,CloseDate = st.Max_Material_Arrival_Date__c,StageName = 'Proposal/Price Quote',Type ='New Business', Sales_Origin__c = 'Brand',Ownership__c = st.Brand_Name__c, Payment_Terms__c = st.Brand_Name__r.Payment_Terms__c, Site_Name__c = (companySites.isEmpty()?null:companySites[0].Id));
                
                newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
                oppRecordTypeId = newOpp.RecordTypeId;
                
                if(st.Destination_Site__c != null){
                    newOpp.Site_Name__c = st.Destination_Site__c;
                }
                
                /*if(st.Transfer_Method__c == 'D2D Transfer'){
newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Transfer').getRecordTypeId(); 
oppRecordTypeId = newOpp.RecordTypeId;
newOpp.AccountId = null;
} else {
newOpp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
oppRecordTypeId = newOpp.RecordTypeId;
}*/
                
                newOpp.Total_Mileage_Fee__c = st.Total_Mileage_Fee__c;
                newOpp.Total_Weight_Fee__c = st.Total_Weight_Fee__c;
                newOpp.Service_Booking_Fee__c = st.Service_Booking_Fee__c;
                newOpp.Service_Scheduling_Fee__c = st.Service_Scheduling_Fee__c;
                newOpp.Service_Staging_Fee__c  = st.Service_Staging_Fee__c ;
                
                insert newOpp;
                st.Opportunity__c = newOpp.Id;
                st.Status__c = 'Accepted';
                update st;
                List<OpportunityLineItem> olis = new List<OpportunityLineItem>();
                if(!st.Service_Ticket_Lines__r.isEmpty()){
                    Set<Id> productIds = new Set<Id>();
                    for(Service_Ticket_Line__c stl: st.Service_Ticket_Lines__r){
                        productIds.add(stl.New_Packaged_Product__c);
                    }
                    if(!productIds.isEmpty()){
                        Map<Id,PricebookEntry> productPriceBookMap = new Map<Id,PricebookEntry>();
                        Map<Id,PricebookEntry> standardproductPriceBookMap = new Map<Id,PricebookEntry>();
                        for(PricebookEntry pbe: [SELECT Id,Product2Id,UnitPrice FROM PricebookEntry WHERE Product2Id IN: productIds AND PriceBook2Id = : st.Brand_Name__r.Community_Price_Book__c]){
                            productPriceBookMap.put(pbe.Product2Id,pbe);
                        }
                        for(PricebookEntry pbe: [SELECT Id,Product2Id,UnitPrice FROM PricebookEntry WHERE Product2Id IN: productIds AND PriceBook2.Name = : 'Standard Price Book']){
                            standardproductPriceBookMap.put(pbe.Product2Id,pbe);
                        }
                        for(Service_Ticket_Line__c stl: st.Service_Ticket_Lines__r){
                            System.debug('STL:'+stl);
                            PricebookEntry pbe = productPriceBookMap.get(stl.New_Packaged_Product__c);
                            PricebookEntry spbe = standardproductPriceBookMap.get(stl.New_Packaged_Product__c);
                            System.debug('###pbe:'+pbe);
                            OpportunityLineItem oli = new OpportunityLineItem(
                                OpportunityId = newOpp.Id,
                                PriceBookEntryId = (pbe != null?pbe.Id:null),
                                Quantity = stl.Total_Units__c,
                                UnitPrice = ((stl.Retail_Wholesale_Price__c == null || stl.Retail_Wholesale_Price__c == 0)?(spbe != null?spbe.UnitPrice:0):stl.Retail_Wholesale_Price__c),
                                Product_Title__c  = 'Distributor',
                                Total_Weight_lbs__c = stl.Total_Weight_lbs__c,
                                Harvest_Batch_Code__c = stl.Harvest_Batch_Code__c
                            );
                            olis.add(oli);
                        }
                        if(!olis.isEmpty()){
                            insert olis;
                            pr = new PageReference('/'+st.Id);
                        }
                    }
                }
            }catch(Exception e){
                if(!Test.isRunningTest())
                    Database.rollback(sp);
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,
                                                              e.getMessage());
                ApexPages.addMessage(msg);
                return pr;
            }
        }
        return pr;
    }
}