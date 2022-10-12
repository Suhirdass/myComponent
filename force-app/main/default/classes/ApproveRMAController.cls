public class ApproveRMAController {
    public Returns__c RMA{set;get;}
    
    public ApproveRMAController(ApexPages.StandardController sc){
        RMA = (Returns__c)sc.getRecord();
    }
    public PageReference approveRMA(){
        PageReference pr;
        AuraResponse r = approveRMAAndCreateOpp(RMA.Id);
        if(r.errors.size() == 0){
            pr = new PageReference('/'+r.data.get('oppId'));
        }else{
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,String.join(r.errors, ','));
            ApexPages.addMessage(msg);
        }
        return pr;
    }
    public PageReference redirectToRMA(){
        return new PageReference('/'+RMA.Id);
    }
    @AuraEnabled
    public static AuraResponse approveRMAAndCreateOpp(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.approveRMAAndCreateOpp()');
        Returns__c RMARec = [SELECT Id, Name, Return_Status__c,Order_Number__c,Order_Number__r.Retailer__c,Supplier_Name__c,Total_Qty__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,(SELECT Id, Name, Product__c,Product__r.Id , Product__r.Name,Product__r.Image_URL__c,Retail_Wholesale_Price__c, Return_Code__c,Return_Qty__c ,Return_Status__c ,Shipping_Manifest_Line__c, Shipping_Manifest_Line__r.Name,Price_Book_Entry_Id__c FROM Return_Lines__r) FROM Returns__c WHERE Id = :recordId];
        if(RMARec.Return_Status__c == 'Approved'){
            r.errors.add('RMA already Approved');
        }else{
            Savepoint sp = Database.setSavepoint();
            try{
                Site__c defSite=[select id from Site__c where name='2089-3' limit 1];
                Opportunity opp = new Opportunity(Name = RMARec.Name,AccountId = RMARec.Order_Number__r.Retailer__c,StageName = 'Proposal/Price Quote', RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('RMA').getRecordTypeId(), Sales_Origin__c ='Disty', Ownership__c = RMARec.Supplier_Name__c,Order__c = RMARec.Order_Number__c,CloseDate=System.today(),  Type = 'Existing Business',Site_Name__c=defSite.Id);
                insert opp;
                RMARec.Return_Status__c = 'Approved';
                RMARec.Opportunity__c = opp.Id;
                update RMARec;
                System.debug('###:'+[SELECT Id,Name,PriceBook2Id FROM Opportunity WHERE Id = :opp.Id].PriceBook2Id);
                OpportunityLineItem[] oliList = new OpportunityLineItem[]{};
                for(Return_Line__c rl : RMARec.Return_Lines__r){
                    OpportunityLineItem oli = new OpportunityLineItem(
                        Product2 = rl.Product__r,
                        OpportunityId = opp.Id,
                        
                        PriceBookEntryId = Id.valueOf(rl.Price_Book_Entry_Id__c),
                        Quantity = rl.Return_Qty__c,
                        UnitPrice = rl.Retail_Wholesale_Price__c
                    );
                    oliList.add(oli);
                }
                insert oliList;
                r.data.put('oppId',opp.Id);
            }catch(Exception e){
                r.errors.add(e.getMessage());
                Database.rollback(sp);
            }
        }
        return r;
    }
}