({
	init : function(c, e, h) {
        
        var columns = [
            {
                type: 'url',
                fieldName: 'id',
                label: 'Name',
                initialWidth: 300,
                typeAttributes: {
                    label: { fieldName: 'name'},
                    tooltip: {
                        fieldName: 'name'
                    }
                }
            },
            {
                type: 'number',
                fieldName: 'levelF',
                label: 'Level'
            },
            {
                type: 'number',
                fieldName: 'sequence',
                sortable: true,
                label: 'Sequence',
                typeAttributes: {
                    minimumFractionDigits: 2,
                }
            },
            {
                type: 'text',
                fieldName: 'productType',
                label: 'Product Type'
            },
            {
                type: 'url',
                fieldName: 'productId',
                label: 'Product Name',
                typeAttributes: {
                    label: { fieldName: 'productName' },
                    tooltip: {
                        fieldName: 'productName'
                    }
                }
            },
            {
                type: 'text',
                fieldName: 'productDesc',
                label: 'Product Description'
            },
            {
                type: 'number',
                fieldName: 'qtyPer',
                label: 'Qty Per',
                typeAttributes: {
                    minimumFractionDigits: 4,
                }
            },
            {
                type: 'text',
                fieldName: 'uom',
                label: 'UOM'
            },
            {
                type: 'number',
                fieldName: 'availableInventory',
                label: 'Available Inventory',
                typeAttributes: {
                    minimumFractionDigits: 2,
                }
            },
        ];                
        c.set('v.gridColumns', columns);
        
        var action = c.get("c.bomLinesForMakeProductType");  
        action.setParams({  recordId : c.get('v.recordId')  });    
        action.setCallback(this,function(response){           
            var state  = response.getState();            
            if(state == "SUCCESS"){   
                var resultData = response.getReturnValue();
                let jsonStr = JSON.stringify(resultData);
                jsonStr =  jsonStr.replaceAll('items','_children');
                jsonStr =  jsonStr.replaceAll('"_children":[],','');    
                
                resultData = JSON.parse(jsonStr);    
            	console.log(JSON.stringify(resultData));
                c.set('v.gridData', resultData);
            }
        });        
        $A.enqueueAction(action);  
	}
})