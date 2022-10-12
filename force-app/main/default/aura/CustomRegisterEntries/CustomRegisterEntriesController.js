({
    /*
     * This finction defined column header
     * and calls getAccounts helper method for column data
     * editable:'true' will make the column editable
     * */
	doInit : function(component, event, helper) { 
        var recordId = component.get("v.recordId");
        var duration = component.get("v.duration");
        if(duration == 'all'){
            duration = 'all1';
        }
        component.set('v.columns', [
            {label: 'Register Entry Line', fieldName: 'entryLink', type: 'url', 
            typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Entry Date', fieldName: 'Entry_Date__c', type: 'date-local',sortable: true},
            {label: 'Entry Memo', fieldName: 'Entry_Memo__c', type: 'text',sortable: true},
            {label: 'Payee', fieldName: 'accountLink', type: 'url', 
            typeAttributes: {label: { fieldName: 'PayeeName' }, target: '_blank'}},
            {label: 'Credit Amount', fieldName: 'Credit_Amount__c', type: 'currency',sortable: true},
            {label: 'Debit Amount', fieldName: 'Debit_Amount__c', type: 'currency',sortable: true},
            {label: 'Old Balance', fieldName: 'Old_Balance__c', type: 'currency',sortable: true},
            {label: 'Transaction Amount', fieldName: 'Transaction_Amount__c', type: 'currency',sortable: true},
            {label: 'Running Balance', fieldName: 'Running_Balance__c', type: 'currency',sortable: true},
            {label: 'Chart of Account', fieldName: 'chartLink', type: 'url', 
            typeAttributes: {label: { fieldName: 'chartName' }, target: '_blank'}}
        ]);
        
        helper.getAccounts(component, helper,duration);
    },
    durationChange : function(component, event, helper) { 
        var sel = component.find("mySelect");
        var nav =	sel.get("v.value");
        var flag = component.get("v.isVF");
        if(nav == '60' || nav == '90' || nav == 'THIS_MONTH'){
            helper.getAccounts(component, helper,nav);
        }else if(nav == 'all' && flag){
            helper.getAccounts(component, helper,'all1');
        }else if(nav == 'all' && !flag){
           // console.log('nav',nav);
            helper.gotoURL(component);
        }
    },
    goBack : function(component, event, helper){
        window.history.back();
    },
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },
    updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection,helper);
    }
  
})