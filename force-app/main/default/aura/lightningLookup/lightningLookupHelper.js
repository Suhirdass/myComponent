({
	searchRecordsHelper : function(c, e, helper, value) {
        console.log("value::",value);
        
		$A.util.removeClass(c.find("Spinner"), "slds-hide");
        c.set('v.message','');
        c.set('v.recordsList',null);
		// Calling Apex Method
        var action = c.get('c.getRecords');
        action.setParams({
            'objectName': c.get('v.objectName'),
            'fieldName': c.get('v.fieldName'),
            'searchTerm' : c.get('v.searchString'),
            'value':value
        });
        action.setCallback(this,function(response){
        	var result = response.getReturnValue();
        	if(response.getState() === 'SUCCESS') {
                // To check if any records are found for searched keyword
    			if(result.length > 0) {
    				// To check if value attribute is prepopulated or not
					if( $A.util.isEmpty(value) ) {
                        c.set('v.recordsList',result);        
					} else {
						var index = result.findIndex(x => x.value === value)
                        if(index != -1) {
                            var selectedRecord = result[index];
                        }
                        c.set('v.selectedRecord',selectedRecord);
					}
    			} else {
    				c.set('v.message','No Records Found');
    			}
        	} else if(response.getState() === 'INCOMPLETE') {
                c.set('v.message','No Server Response or client is offline');
            } else if(response.getState() === 'ERROR') {
                // If server throws any error
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    c.set('v.message', errors[0].message);
                }
            }
            // To open the drop down list of records
            if( $A.util.isEmpty(value) )
               $A.util.addClass(c.find('resultsDiv'),'slds-is-open');
        	$A.util.addClass(c.find("Spinner"), "slds-hide");
        });
        $A.enqueueAction(action);
	}
})