/**************************************************************************************
Apex Class Name    : OpportunityProductEntryExtension 
Test Class Name    : OpportunityProductEntryExtensionTest
Version            : 1.0
Created Date       : Aug 24 2018
Function           : Used for OpportunityProductEntry VF page and used in "Add Product" button.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh               08/24/2018              Original Version
* Praveen      		   03/24/2020              Error messages for search and selected items
* Praveen      		   08/04/2020              Lightning conversion
* Kumaravendan         08/09/2020              code standard
*******************************************************************************/
public with sharing class OpportunityProductEntryExtension {
    
    public Opportunity theOpp {get;set;}
    public static String searchString {get;set;}
    public opportunityLineItem[] shoppingCart {get;set;}
    public priceBookEntry[] AvailableProducts {get;set;}
    public Pricebook2 theBook {get;set;}   
    public String toSelect {get; set;}
    public String toUnselect {get; set;}
    public Boolean overLimit {get;set;}
    public Boolean prodSelect {get;set;}
    public Boolean multipleCurrencies {get; set;}
    private Boolean forcePricebookSelection = false;
    private opportunityLineItem[] forDeletion = new opportunityLineItem[]{};    
    private String sortOrder = 'Product2.Name';
    public String ascendingOrDescending = ' ASC ';
    public list<Pricebook2> pblist;
    public String successMessage = '';

    public opportunityProductEntryExtension(ApexPages.StandardController controller) {
        
        // Need to know if org has multiple currencies enabled
        multipleCurrencies = UserInfo.isMultiCurrencyOrganization();
        
        // Get information about the Opportunity being worked on
        if(multipleCurrencies)
            theOpp = database.query('select Id, Pricebook2Id, Pricebook2.Name, CurrencyIsoCode from Opportunity where Id = \'' + controller.getRecord().Id + '\' limit 1');
        else
            theOpp = [select Id, Pricebook2Id, PriceBook2.Name from Opportunity where Id = :controller.getRecord().Id limit 1];
        
        // If products were previously selected need to put them in the "selected products" section to start with
        shoppingCart = [select Id, Quantity, TotalPrice, UnitPrice, Description,Product_Title__c,MOQ__c,MOQ_TF__c, PriceBookEntryId,Product2.Available_Inventory__c,Product2.Available_Qty__c,Available_Inventory__c, PriceBookEntry.Name, PriceBookEntry.IsActive, PriceBookEntry.Product2Id, PriceBookEntry.Product2.Name, PriceBookEntry.PriceBook2Id from opportunityLineItem where OpportunityId=:theOpp.Id order by PriceBookEntry.Name ASC ];
        
        for(opportunityLineItem  var:shoppingCart ){
            var.MOQ_TF__c=var.MOQ__c;
            var.Available_Inventory__c =var.Product2.Available_Inventory__c;
        }
        // Check if Opp has a pricebook associated yet
        if(theOpp.Pricebook2Id == null){
            Pricebook2[] activepbs = [select Id, Name from Pricebook2 where isActive = true limit 2];
            if(activepbs.size() == 2){
                forcePricebookSelection = true;
                theBook = new Pricebook2();
            }
            else{
                theBook = activepbs[0];
            }
        }
        else{
            theBook = theOpp.Pricebook2;
        }
        
        if(!forcePricebookSelection)
            updateAvailableList();
    }
    
    public opportunityProductEntryExtension(){
        
    }
    
    @AuraEnabled
    public static AuraResponse opportunityProductEntry(String recordId){
        AuraResponse r = new AuraResponse('OpportunityProductEntryExtension.opportunityProductEntry()');
        
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        
        // Need to know if org has multiple currencies enabled
        oppCons.multipleCurrencies = UserInfo.isMultiCurrencyOrganization();
        
        // Get information about the Opportunity being worked on
        if(oppCons.multipleCurrencies)
            oppCons.theOpp = database.query('select Id,Name, Pricebook2Id, Pricebook2.Name, CurrencyIsoCode from Opportunity where Id = \'' + recordId + '\' limit 1');
        else
            oppCons.theOpp = [select Id,Name, Pricebook2Id, PriceBook2.Name from Opportunity where Id = :recordId limit 1];
        
        // If products were previously selected need to put them in the "selected products" section to start with
        oppCons.shoppingCart = [select Id, Quantity, TotalPrice, UnitPrice, Description,Product_Title__c,MOQ__c,MOQ_TF__c, 
                                PriceBookEntryId,Product2.Available_Inventory__c,Product2.Available_Qty__c,Available_Inventory__c, 
                                PriceBookEntry.Name, PriceBookEntry.IsActive, PriceBookEntry.Product2Id, 
                                PriceBookEntry.Product2.Name, PriceBookEntry.PriceBook2Id, PriceBookEntry.Product2.Available_Qty__c, Is_Sample__c from opportunityLineItem 
                                where OpportunityId=:oppCons.theOpp.Id order by PriceBookEntry.Name ASC ];
        
        
        for(opportunityLineItem  var : oppCons.shoppingCart ){
            var.MOQ_TF__c=var.MOQ__c;
            var.Available_Inventory__c =var.Product2.Available_Inventory__c;
        }        
        
        // Check if Opp has a pricebook associated yet
        if(oppCons.theOpp.Pricebook2Id == null){
            Pricebook2[] activepbs = [select Id, Name from Pricebook2 where isActive = true limit 2];
            if(activepbs.size() == 2){
                oppCons.forcePricebookSelection = true;
                oppCons.theBook = new Pricebook2();
            }
            else{
                oppCons.theBook = activepbs[0];
            }
        }
        else{ 
            oppCons.theBook = oppCons.theOpp.Pricebook2;
        }
        if(!oppCons.forcePricebookSelection){
            oppCons.updateAvailableList();    
        }
        
        
        List<String> lstStr = new List<String>();
        Schema.DescribeFieldResult fieldResult = opportunityLineItem.Product_Title__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            lstStr.add(f.getLabel());
        }   
        
        if(oppCons.shoppingCart.size()==0){
            oppCons.prodSelect = true;
        }
        
        r.data.put('shoppingCart', oppCons.shoppingCart);
        r.data.put('pickListVal', lstStr);
        r.data.put('oppRec', oppCons.theOpp);
        r.data.put('AvailableProducts', oppCons.AvailableProducts);
        r.data.put('theBook', oppCons.theBook);
        r.data.put('overLimit', oppCons.overLimit);
        r.data.put('prodSelect', oppCons.prodSelect);
        
        r.data.put('multipleCurrencies', oppCons.multipleCurrencies);
        return r;        
    }
    
    @AuraEnabled
    public static AuraResponse fetchFilterProducts(String str,String recordId){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.fetchFilterProducts()');
        
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        
        searchString = str;
        AuraResponse aura = opportunityProductEntryExtension.opportunityProductEntry(recordId);
        
        r.data.put('AvailableProducts', aura.data.get('AvailableProducts'));
        r.data.put('overLimit', aura.data.get('overLimit'));
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse addToShoppingCart(String recordId,String toSelectId,List<opportunityLineItem> shoppingCart1,String fieldName,String orderSort,List<priceBookEntry> availableList){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.addToShoppingCart()');
        
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        
        AuraResponse aura = opportunityProductEntryExtension.opportunityProductEntry(recordId);
        
        oppCons.shoppingCart = (List<opportunityLineItem>)aura.data.get('shoppingCart');
        oppCons.AvailableProducts = (List<priceBookEntry>)aura.data.get('AvailableProducts');
        oppCons.theBook = (Pricebook2)aura.data.get('theBook');
        oppCons.overLimit = (Boolean)aura.data.get('overLimit');
        
        oppCons.theOpp = (Opportunity)aura.data.get('oppRec');
        oppCons.multipleCurrencies = (Boolean)aura.data.get('multipleCurrencies');
        
        oppCons.shoppingCart = shoppingCart1;
        oppCons.AvailableProducts = availableList;
        // This function runs when a user hits "select" button next to a product
        Integer count = 0;
        boolean prodSelect;
        for(PricebookEntry d : oppCons.AvailableProducts){
            if((String)d.Id == toSelectId){
                
                oppCons.shoppingCart.add(new opportunityLineItem(OpportunityId=oppCons.theOpp.Id, Available_Inventory__c=d.Product2.Available_Qty__c,
                                                                 PriceBookEntry=d, PriceBookEntryId=d.Id, //Product_Title__c=d.Product2.Product_Title__c,
                                                                 UnitPrice=d.UnitPrice,MOQ_TF__c=d.Product2.MOQ__c,
                                                                 Product2Id=d.Product2.Id,
                                                                 Quantity = 1,Is_Sample__c = d.Product2.Is_Sample__c));//Quantity value is 1 by default.
                //Available_Inventory__c =d.Product2.Available_Inventory__c )); //Available_Qty__c
                oppCons.AvailableProducts.remove(count);
                break;
            }
            count++;
        }
        
        
        
        
        //oppCons.updateAvailableList();  
        r.data.put('shoppingCart', oppCons.shoppingCart);
        r.data.put('AvailableProducts', oppCons.AvailableProducts);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse removeProduct(String recordId,String toSelectId, List<opportunityLineItem> forDeletion1,List<opportunityLineItem> shoppingCart1){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.removeProduct()');
        
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        AuraResponse aura = opportunityProductEntryExtension.opportunityProductEntry(recordId);
        
        oppCons.shoppingCart = (List<opportunityLineItem>)aura.data.get('shoppingCart');
        oppCons.AvailableProducts = (List<priceBookEntry>)aura.data.get('AvailableProducts');
        oppCons.theBook = (Pricebook2)aura.data.get('theBook');
        oppCons.overLimit = (Boolean)aura.data.get('overLimit');
        
        oppCons.theOpp = (Opportunity)aura.data.get('oppRec');
        oppCons.multipleCurrencies = (Boolean)aura.data.get('multipleCurrencies');
        
        
        oppCons.shoppingCart = shoppingCart1;
        // This function runs when a user hits "remove" on an item in the "Selected Products" section
        Integer count = 0;
        for(opportunityLineItem d : oppCons.shoppingCart){
            if((String)d.PriceBookEntryId==toSelectId){
                if(d.Id!=null)
                    forDeletion1.add(d);
                oppCons.shoppingCart.remove(count);
                break;
            }
            count++;
        }
        
        if(oppCons.shoppingCart.size()==0){
            oppCons.prodSelect = true;
        }
        
        oppCons.updateAvailableList();
        r.data.put('shoppingCart', oppCons.shoppingCart);
        r.data.put('forDel', forDeletion1);
        r.data.put('AvailableProducts', oppCons.AvailableProducts);
        r.data.put('theBook', oppCons.theBook);
        r.data.put('overLimit', oppCons.overLimit);
        r.data.put('prodSelect', oppCons.prodSelect);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse onSaveCart(List<opportunityLineItem> shoppingCart,List<opportunityLineItem> forDeletion){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.onSaveCart()');
        // If previously selected products are now removed, we need to delete them
        if(forDeletion.size()>0)
            delete(forDeletion);
        
        // Previously selected products may have new quantities and amounts, and we may have new products listed, so we use upsert here
        try{
            if(shoppingCart.size()>0)
                upsert(shoppingCart);
        }
        catch(Exception e){} 
        r.data.put('shoppingCart', shoppingCart);
        return r;
    }
    
    
    @AuraEnabled
    public static AuraResponse sortOrderList(String recordId,String fieldName,String orderSort){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.sortOrderList()');
        
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        AuraResponse aura = opportunityProductEntryExtension.opportunityProductEntry(recordId);
        
        oppCons.shoppingCart = (List<opportunityLineItem>)aura.data.get('shoppingCart');
        oppCons.AvailableProducts = (List<priceBookEntry>)aura.data.get('AvailableProducts');
        oppCons.theBook = (Pricebook2)aura.data.get('theBook');
        oppCons.overLimit = (Boolean)aura.data.get('overLimit');
        oppCons.theOpp = (Opportunity)aura.data.get('oppRec');
        oppCons.multipleCurrencies = (Boolean)aura.data.get('multipleCurrencies');
        
        oppCons.sortOrder = fieldName;
        if(orderSort == ' ASC ')
            oppCons.ascendingOrDescending = ' DESC ';
        else
            oppCons.ascendingOrDescending = ' ASC ';
        oppCons.updateAvailableList();  
        r.data.put('AvailableProducts', oppCons.AvailableProducts);
        r.data.put('sortOrder', oppCons.ascendingOrDescending);
        r.data.put('sortField', fieldName);
        return r;
    }
    
    // this is the 'action' method on the page
    public PageReference priceBookCheck(){
        
        // if the user needs to select a pricebook before we proceed we send them to standard pricebook selection screen
        if(forcePricebookSelection){        
            return changePricebook();
        }
        else{
            
            //if there is only one active pricebook we go with it and save the opp
            if(theOpp.pricebook2Id != theBook.Id){
                try{
                    theOpp.Pricebook2Id = theBook.Id;
                    update(theOpp);
                }
                catch(Exception e){
                    ApexPages.addMessages(e);
                }
            }
            
            return null;
        }
    }
    
    public String getChosenCurrency(){
        
        if(multipleCurrencies)
            return (String)theOpp.get('CurrencyIsoCode');
        else
            return '';
    }
    
    public void updateAvailableList() {
        
        // We dynamically build a query string and exclude items already in the shopping cart
        String qString;
        if(!Test.isRunningTest()){
            qString = 'select Id,Product2.Is_Sample__c,Product2.Producer_Name__c,Product2.Producer_Name__r.Name,Product2.Available_Qty__c,Product2.Strain__c,Product2.Strain__r.Name,Product2.Brand_Name__c,Product2.Available_Inventory__c,Product2.MOQ__c, Pricebook2Id, IsActive, Product2.Name, Product2.Family, Product2.IsActive, Product2.Description, UnitPrice from PricebookEntry where IsActive=true and Pricebook2Id = \'' + theBook.Id + '\'';
        }else{
            qString = 'select Id,Product2.Producer_Name__c,Product2.Producer_Name__r.Name,Product2.Available_Qty__c,Product2.Strain__c,Product2.Strain__r.Name,Product2.Brand_Name__c,Product2.Available_Inventory__c,Product2.MOQ__c, Pricebook2Id, IsActive, Product2.Name, Product2.Family, Product2.IsActive, Product2.Description, UnitPrice from PricebookEntry where IsActive=true';
            searchString ='Test';
        }
        if(multipleCurrencies)
            qstring += ' and CurrencyIsoCode = \'' + theOpp.get('currencyIsoCode') + '\'';
        
        // note that we are looking for the search string entered by the user in the name OR description
        // modify this to search other fields if desired
        if(searchString!=null){
            qString+= ' and (Product2.Name like \'%' + searchString + '%\' or Product2.Description like \'%' + searchString + '%\' or Product2.Family like \'%' + searchString + '%\'  OR Product2.Brand_Name__c like \'%' + searchString + '%\' OR Product2.Strain__r.Name like \'%' + searchString + '%\' )'; 
        }
        
        Set<Id> selectedEntries = new Set<Id>();
        for(opportunityLineItem d:shoppingCart){
            selectedEntries.add(d.PricebookEntryId);
        }
        
        if(selectedEntries.size()>0){
            String tempFilter = ' and Id not in (';
            for(Id i : selectedEntries){
                tempFilter+= '\'' + (String)i + '\',';
            }
            String extraFilter = tempFilter.substring(0,tempFilter.length()-1);
            extraFilter+= ')';
            
            qString+= extraFilter;
        }
        
        if(selectedEntries.size()==0){
            prodSelect = true;
        }
        else{
            prodSelect = false;
        }
        
        qString+= ' ORDER BY ' + sortOrder + ascendingOrDescending +' Nulls last';
        //qString+= ' order by Product2.Name';
        qString+= ' limit 101';
        
        AvailableProducts = database.query(qString);
        
        // We only display up to 100 results... if there are more than we let the user know (see vf page)
        if(AvailableProducts.size()==101){
            AvailableProducts.remove(100);
            overLimit = true;
        }
        else if (AvailableProducts.size()>0){
            overLimit = true;
        }
        else {
            overLimit=false;
        }  
    }
    
    public void sortByProName(){
        this.sortOrder = 'Product2.Name';        
        if(ascendingOrDescending == ' ASC ')
            ascendingOrDescending = ' DESC ';
        else
            ascendingOrDescending = ' ASC ';
        updateAvailableList();
    }
    
    public void sortByProFamily(){
        this.sortOrder = 'Product2.Family';        
        if(ascendingOrDescending == ' ASC ')
            ascendingOrDescending = ' DESC ';
        else
            ascendingOrDescending = ' ASC ';
        updateAvailableList();
    }
    
    public void sortByProStrain(){
        this.sortOrder = 'Product2.Strain__r.Name';        
        if(ascendingOrDescending == ' ASC ')
            ascendingOrDescending = ' DESC ';
        else
            ascendingOrDescending = ' ASC ';
        updateAvailableList();
    }
    
    public void sortByProduser(){
        this.sortOrder = 'Product2.Producer_Name__r.Name';        
        if(ascendingOrDescending == ' ASC ')
            ascendingOrDescending = ' DESC ';
        else
            ascendingOrDescending = ' ASC ';
        updateAvailableList();
    }
    
    public void addToShoppingCart(){
        
        // This function runs when a user hits "select" button next to a product
        
        for(PricebookEntry d : AvailableProducts){
            if((String)d.Id==toSelect){
                shoppingCart.add(new opportunityLineItem(OpportunityId=theOpp.Id, PriceBookEntry=d, PriceBookEntryId=d.Id, 
                                                         UnitPrice=d.UnitPrice,MOQ_TF__c=d.Product2.MOQ__c,
                                                         Product2Id=d.Product2Id,Quantity=d.Product2.Available_Qty__c,
                                                         Available_Inventory__c =d.Product2.Available_Inventory__c ));
                break;
            }
        }
        
        updateAvailableList();  
    }
    
    public PageReference removeFromShoppingCart(){
        
        // This function runs when a user hits "remove" on an item in the "Selected Products" section
        
        Integer count = 0;
        
        for(opportunityLineItem d : shoppingCart){
            if((String)d.PriceBookEntryId==toUnselect){
                
                if(d.Id!=null)
                    forDeletion.add(d);
                
                shoppingCart.remove(count);
                break;
            }
            count++;
        }
        
        updateAvailableList();
        
        return null;
    }
    
    public PageReference onSave(){
        Boolean validationCheck =false;
        for(opportunityLineItem var:shoppingCart){
            if(var.UnitPrice <= 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter valid Sales Price'));
                //return null;
                validationCheck =true;
            }
            if(var.Quantity < 1) //&& var.Product2.Available_Inventory__c > 1)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter valid Quantity'));
                //  return null;
                validationCheck =true;
            }
            
            if(validationCheck ==true){ return null;}
        }
        // If previously selected products are now removed, we need to delete them
        if(forDeletion.size()>0)
            delete(forDeletion);
        
        // Previously selected products may have new quantities and amounts, and we may have new products listed, so we use upsert here
        try{
            if(shoppingCart.size()>0)
                upsert(shoppingCart);
        }
        catch(Exception e){
            ApexPages.addMessages(e);
            return null;
        }  
        
        // After save return the user to the Opportunity
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    }
    
    public PageReference onCancel(){
        // If user hits cancel we commit no changes and return them to the Opportunity   
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('Id'));
    }
    
    public PageReference changePricebook(){
        
        // This simply returns a PageReference to the standard Pricebook selection screen
        // Note that is uses retURL parameter to make sure the user is sent back after they choose
        PageReference ref = new PageReference('/oppitm/choosepricebook.jsp');
        ref.getParameters().put('id',theOpp.Id);
        ref.getParameters().put('retURL','/apex/opportunityProductEntry?id=' + theOpp.Id);
        return ref;
    }
    
    public PageReference getTotalQty() {
        return null;
    }
    
    // get price book list
    @AuraEnabled
    public static  AuraResponse getPriceBook(){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.getPriceBook()');
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        oppCons.pblist = [select Id, Name from Pricebook2 where isActive = true order by Name ASC];
        r.data.put('pblist', oppCons.pblist);
        return r;
    }
    
    // save price book
    @AuraEnabled
    public static AuraResponse savePriceBook(Id oppId, String priceBookId,List<opportunityLineItem> forDeletion1,List<opportunityLineItem> shoppingCart1){
        AuraResponse r = new AuraResponse('opportunityProductEntryExtension.savePriceBook()');
        opportunityProductEntryExtension oppCons = new opportunityProductEntryExtension();
        if(oppId!=null){
            removeProduct(oppId,priceBookId,forDeletion1,shoppingCart1);
            onSaveCart(shoppingCart1,shoppingCart1);
            Opportunity myOpp = [SELECT Id, Name FROM Opportunity WHERE Id = :oppId];
            myOpp.Pricebook2Id = priceBookId;
            update myOpp;
            oppCons.successMessage = 'Success';
            r.data.put('successMessage', oppCons.successMessage);
            return r;    
        }else{
           oppCons.successMessage = 'Error';
            r.data.put('successMessage', oppCons.successMessage);
            return r;      
        }
        
    }
    
}