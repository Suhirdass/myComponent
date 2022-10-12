({
	init : function(c, e, h) {
        
        var columns = [
            {
                type: 'url',
                fieldName: 'id',
                label: 'Brand Name',
                initialWidth: 200,
                typeAttributes: {
                    label: { fieldName: 'name'},
                    tooltip: {
                        fieldName: 'name'
                    },
                    target: '_blank'
                }
            },
            {
                type: 'text',
                fieldName: 'membership',
                label: 'Membership'
            },
            {
                type: 'text',
                fieldName: 'platform',
                label: 'Platform'
            },
            {
                type: 'number',
                fieldName: 'totalFee',
                label: 'Total Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'totalDistro',
                label: 'Total Distro %',
                type: 'percent',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'orderBookingFee',
                label: 'Order booking Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            
            {
                type: 'number',
                fieldName: 'pickPackFee',
                label: 'Pick & Pack Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'qaReviewFee',
                label: 'QA Review Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'packOutFee',
                label: 'Pack-Out Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'listingFee',
                label: 'Listing Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'scheduleAndDispatchFee',
                label: 'Schedule & Dispatch Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'stageAndManifestFee',
                label: 'Stage & Manifest Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'mileageFee',
                label: 'Mileage Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            {
                type: 'number',
                fieldName: 'weightFee',
                label: 'Weight Fee',
                type: 'currency',
                typeAttributes: {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                }
            },
            
        ];                
        c.set('v.gridColumns', columns);
            
		var action = c.get("c.brandDistributionFee");  
        action.setParams({  recordId : c.get('v.recordId')  });    
        action.setCallback(this,function(response){           
            var state  = response.getState();            
            if(state == "SUCCESS"){   
            	var resultData = response.getReturnValue();
                let jsonStr = JSON.stringify(resultData);
                jsonStr =  jsonStr.replaceAll('items','_children');
                jsonStr =  jsonStr.replaceAll('"_children":[],','');    
                
                resultData = JSON.parse(jsonStr); 
                for (const val of resultData) { // You can use `let` instead of `const` if you like
    				console.log(val);
				}
            	console.log(JSON.stringify(resultData));
                c.set('v.gridData', resultData);
            }
        });        
        $A.enqueueAction(action);  
	}
})