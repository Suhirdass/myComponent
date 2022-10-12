({
	doInit : function(c, e, h) {
        h.request(c, 'cloneBQ', {recordId: c.get("v.recordId")}, function(r){
          c.set('v.bq', r.bq);
          c.set('v.setBQLines', r.setBQLines);
          c.set('v.hasBQLines', r.hasBQLines);
          c.set('v.DLhasExpired', r.DLhasExpired);
          c.set('v.SLhasExpired', r.SLhasExpired);
          c.set('v.RLhasExpired', r.RLhasExpired);
            
            var bqVal = c.get("v.bq");
            if(bqVal.Distributor_License_Number__c !== undefined){
                c.set('v.DLundef', true);
            }
             if(bqVal.Supplier_License_Number__c !== undefined){
                c.set('v.SLundef', true);
            }
             if(bqVal.Receiver_License_Number__c !== undefined){
                c.set('v.RLundef', true);
            }
        });
	},
    
	onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    
	selectAllCheckboxes : function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");

        if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                	checkContact[i].set("v.value",checkvalue);
            } 
        } else{
             checkContact.set("v.value",checkvalue); 
        }
    },
    
	saveClone : function(c, e, h){
         var setBQLines = c.get('v.setBQLines');
         var anyCheckSelected = 'false';
        setBQLines.forEach(function (bqli, index){
            if(bqli.isSelected){
                anyCheckSelected = 'true';
            } 
        });
    if(anyCheckSelected == 'false'){
            h.warning({message: 'Please select Brand Quote Line'});
        } 
    else{
       h.request(c, 'cloneBrandQuoteLight', 
          { bq: c.get("v.bq"), setBQLines: c.get("v.setBQLines") }, function(r){ 
            if(r.Error != null || r.Error != undefined){
                        h.warning({ message: (r.Error) });
                        return false;      
            } else {
                try{
                window.location.href = '/' + r.redirectId ; 
            } catch(ex){
                console.log('Exception '+ex);
            }
            }
        }); 
     }   
   },
})