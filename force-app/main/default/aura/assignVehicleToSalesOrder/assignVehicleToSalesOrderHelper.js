({
sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.rsmList");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse));
        cmp.set("v.rsmList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    sortData1: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.tsmList");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy1(fieldName, reverse));
        cmp.set("v.tsmList", data);
    },
  sortBy1: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },    
    handleValues : function(component,selectedRecord,h){
        var selectedPickLineId = component.get('v.selectedVehicle');
        console.log('Callling Done...',selectedPickLineId);
        if(selectedPickLineId != undefined){
            var pickListLine = component.get('v.selectedVehicle');
           // pickListLine.find(function(element) {
                if(pickListLine == selectedPickLineId){
                    if(selectedRecord.value == undefined){
                    	element.Vehicle__c = '';    
                    } else {
                    	element.Vehicle__c = selectedRecord.value;
                    }
                }      
          //  }); 
            component.set("v.selectedVehicle",pickListLine);
            component.set("v.selectedVehicle",undefined);
        } else {
            window.setTimeout($A.getCallback(function(){
                h.handleValues(component,selectedRecord,h);
                console.log('Callling...');
            }),100);
        }   
    }
    
})