({
    getAccounts : function(component, helper,duration) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.getLimitedAccounts");
        action.setStorable();
        action.setParams({ "selectedCriteria" :  duration,
                          "parentId" : recordId});
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
                var rows = response.getReturnValue();
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.Payee__c){
                        row.PayeeName = row.Payee__r.Name; 
                        row.accountLink = '/'+row.Payee__c;
                    }
                    if (row.Chart_of_Account__c){
                        row.chartName = row.Chart_of_Account__r.Name; 
                        row.chartLink = '/'+row.Chart_of_Account__c;
                    }
                    row.entryLink = '/'+row.Id;
                }
                component.set("v.allData", response.getReturnValue());
                component.set("v.currentPageNumber",1);
                helper.buildData(component, helper);
            }
        });
        var requestInitiatedTime = new Date().getTime();
        $A.enqueueAction(action);
    },
    gotoURL : function(component){
        //if(!component.get("v.isVF")){
        var urlEvent = $A.get("e.force:navigateToURL");
        var parentId = component.get("v.recordId");
        console.log('parentId',parentId);
        urlEvent.setParams({
            "url": "/apex/CustomRegisterEntriesListview?id="+parentId+"&duration=all"
        });
        urlEvent.fire();
        //}
    },

    /*
     * this function will build table data
     * based on current page selection
     * */
    buildData : function(component, helper) {
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        var x = (pageNumber-1)*pageSize;
        
        //creating data-table data
        for(; x<(pageNumber)*pageSize; x++){
            if(allData[x]){
            	data.push(allData[x]);
            }
        }
        component.set("v.data", data);
        
        helper.generatePageList(component, pageNumber);
    },
    
    /*
     * this function generate page list
     * */
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    },
    sortData: function (cmp, fieldName, sortDirection,helper) {
        var data = cmp.get("v.allData");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.allData", data);
        this.buildData(cmp, helper);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a)?key(a):'', b = key(b)?key(b):'', reverse * ((a > b) - (b > a));
        }
    }
   
 })