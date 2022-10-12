({
	searchRec : function(c, e, h) {
		try{
            let masterInventoryPositions = c.get('v.masterInventoryPositions');
            console.log('masterInventoryPositions',masterInventoryPositions.length);
            let searchValue = c.get('v.searchValue');
            var setInventoryPositions = [];
            if(searchValue != ''){
                masterInventoryPositions.find(function(element) {
                    let invRec = element.invPositionSO;
                    let supplierName = '';
                    if(invRec.Product_Name__c != null && invRec.Product_Name__c != undefined){
                        if(invRec.Product_Name__r.Name.toLowerCase().includes(searchValue.toLowerCase())){
                            setInventoryPositions.push(element);
                        } 
                    }if(invRec.Producer_Name__c != null && invRec.Producer_Name__c != undefined){
                        if(invRec.Producer_Name__c.toLowerCase().includes(searchValue.toLowerCase())){
                            setInventoryPositions.push(element);
                        } 
                    }console.log('invRec = ',invRec);
                    if(invRec.Receiving_Line__c != undefined && invRec.Receiving_Line__r != undefined && invRec.Receiving_Line__r.Purchase_Order_Line__c != undefined && invRec.Receiving_Line__r.Purchase_Order_Line__r != undefined && invRec.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c != undefined){
                        let poNumber = invRec.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name;
                        console.log('poNumber1 = ');
                        if(poNumber.toLowerCase().includes(searchValue.toLowerCase())){
                            setInventoryPositions.push(element);
                        }
                        if(invRec.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__c != null){
                            let supplierName = invRec.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name;
                            if(supplierName.toLowerCase().includes(searchValue.toLowerCase())){
                                setInventoryPositions.push(element);
                            }
                        }
                    }
                });	   
            } else {
                console.log('masterInventoryPositions',masterInventoryPositions);
                  console.log('setInventoryPositions',setInventoryPositions);
            	setInventoryPositions = masterInventoryPositions;    
            }
            
            
            console.log('SIZE = '+setInventoryPositions.length);
            if(setInventoryPositions.length==0)
            {
                c.set('v.showtable',false);
                c.set('v.tableerror',true);
             console.log('SIZE = '+c.get('v.showtable'));
   
            }else
            {
                 c.set('v.showtable',true);
                 c.set('v.tableerror',false);
            }
            c.set('v.setInventoryPositions',setInventoryPositions);
            c.set('v.inventoryPositions',setInventoryPositions);
            
            let totalRecountCount = setInventoryPositions.length; 
            let totalPage = Math.ceil(totalRecountCount / c.get('v.pageSize'));
            let setInvPositions = setInventoryPositions.slice(0,c.get('v.pageSize'));
            let endingRecord = c.get('v.pageSize');
            c.set('v.page ',1);
            c.set('v.startingRecord ',1);
            c.set('v.totalRecountCount ',totalRecountCount);
            c.set('v.totalPage ',totalPage);
            c.set('v.setInventoryPositions ', setInvPositions);
            c.set('v.endingRecord ',endingRecord);
            
        } catch(error){
            console.log('ERROR = ', error);
        }	
	}
})