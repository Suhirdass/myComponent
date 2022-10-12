({
    onInit: function(c, e, h){
        try{
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var productPriceBooks = c.get('v.productPriceBooks');
        var packageTypes = c.get('v.packageTypes'); 
        let toolTips = c.get('v.toolTips');  
        c.set('v.totalQtyTooltip',toolTips.Total_Qty_Tooltip);    
        packageTypes.forEach((p)=>p.selected = p.id == serviceTicketLine.Package_Type);
        c.set('v.packageTypes',packageTypes);
        if(serviceTicketLine.New_Packaged_Product){
            let PBE = productPriceBooks[serviceTicketLine.New_Packaged_Product];
            serviceTicketLine.New_Packaged_ProductName = PBE.Product2.Product_Short_Description__c;
            serviceTicketLine.Retail_Wholesale_Price = PBE.UnitPrice;
            serviceTicketLine.productDescription = PBE.Product2.Name;
            if(serviceTicketLine.Qty_Per_Multi_Unit == undefined || serviceTicketLine.Qty_Per_Multi_Unit == null){
                serviceTicketLine.Qty_Per_Multi_Unit = PBE.Product2.MOQ__c;
            }
            //console.log('PBE.Product2.MOQ__c = ',PBE.Product2.MOQ__c);
            let products = c.get('v.products');
            products.forEach((pre)=>pre.selected = pre.id == serviceTicketLine.New_Packaged_Product);
            c.set('v.products',products);
        } 
        if(serviceTicketLine.Product_Packaged_From){
            let PBEVal = productPriceBooks[serviceTicketLine.Product_Packaged_From];
            serviceTicketLine.Product_Packaged_FromSKU = PBEVal.Product2.Name;
            serviceTicketLine.Product_Packaged_MOQ = PBEVal.Product2.MOQ__c;
            serviceTicketLine.Product_Packaged_FromName = PBEVal.Product2.Product_Short_Description__c;
            let productsFrom = c.get('v.productsFrom');
            productsFrom.forEach((p)=>p.selected = p.id == serviceTicketLine.Product_Packaged_From);
            c.set('v.productsFrom',productsFrom);
        }
        c.set('v.serviceTicketLine',serviceTicketLine);
        var Total_Units = serviceTicketLine.Total_Units || 0;
        var Qty_Per_Multi_Unit  = serviceTicketLine.Qty_Per_Multi_Unit || 0;
        console.log('Qty_Per_Multi_Unit::',Qty_Per_Multi_Unit);
        if(Qty_Per_Multi_Unit == 0){
            c.set('v.totalCases',0);
        }else{
            var totalCases = Total_Units/Qty_Per_Multi_Unit;
            totalCases = totalCases.toFixed(2);
            c.set('v.totalCases',totalCases);
        }
        //c.set('v.isPreRoll', ((serviceTicketLine.Package_Type || '').indexOf('Pre-Rolling') > -1));
        window.setTimeout($A.getCallback(function(){
                    c.set('v.initializationCompleted',true);
            		c.set('v.isOnLoad',true);
                }),500);
        }catch(error){
            console.log('Error:',error);
        }
    },
    handleMultiSelectEvent  :  function (c, e, h) {
    	let selectedIds = e.getParam("selectedIds");
        let fieldName = e.getParam("fieldName");
        let index = e.getParam("index");
        if(index == c.get('v.SLIndex')){
            if(selectedIds)
                selectedIds = selectedIds.slice(0, -1);
            
            let serviceTicketLine = c.get('v.serviceTicketLine');
            if(fieldName === 'Service Type'){
                serviceTicketLine.Package_Type = selectedIds;
                c.set('v.serviceTicketLine',serviceTicketLine);
                let toolTips = c.get('v.toolTips');
                if(selectedIds == 'Casing'){
                    toolTips.Total_Qty_Tooltip = 'Please enter the total qty of units to case';
                } else if(selectedIds == 'Labeling'){
                    toolTips.Total_Qty_Tooltip = 'Please enter the total qty of units to Label';
                } else if(selectedIds == 'Sample Conversion' || selectedIds == 'Product Conversion'){
                    toolTips.Total_Qty_Tooltip = 'Please enter the total qty of units to convert';
                } else {
                    toolTips.Total_Qty_Tooltip = c.get('v.totalQtyTooltip');
                }
                c.set('v.toolTips',toolTips);
            }else if(fieldName === 'Product'){
                if(c.get('v.initializationCompleted')){
                    serviceTicketLine.New_Packaged_Product = selectedIds;
                	c.set('v.serviceTicketLine',serviceTicketLine);
                    let a = c.get('c.onProductChange');
                    $A.enqueueAction(a);
                }
            } else if(fieldName === 'ConvertProduct'){
                serviceTicketLine.Product_Packaged_From = selectedIds;
                c.set('v.serviceTicketLine',serviceTicketLine);
                if(c.get('v.initializationCompleted')){
                    let productPriceBooks = c.get('v.productPriceBooks');
                    let PBEValue = productPriceBooks[selectedIds];
                    if(PBEValue != undefined){
                        console.log('productId::',PBEValue,'==>',JSON.stringify(PBEValue));
                        serviceTicketLine.Product_Packaged_FromSKU = PBEValue.Product2.Name;
                        serviceTicketLine.Product_Packaged_MOQ = PBEValue.Product2.MOQ__c;
                    	c.set('v.serviceTicketLine',serviceTicketLine);
                    }
                }
            }
        }
        
        
    },
    onExpendCollapse: function(c, e, h) {
        var isCollapsed = c.get('v.isCollapsed');
        c.set('v.isCollapsed',!isCollapsed);
    },
    onPerRollChange: function(c, e, h) {
        var desiredRetailReadyForm = e.getSource().get('v.value');
        //c.set('v.isPreRoll', (desiredRetailReadyForm.indexOf('Pre-Rolling') > -1));
	},
    onTotalUnitsChange: function(c, e, h) {
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var Total_Units = serviceTicketLine.Total_Units || 0;
        var Qty_Per_Multi_Unit  = serviceTicketLine.Qty_Per_Multi_Unit || 0;
         console.log('Qty_Per_Multi_Unit::',Qty_Per_Multi_Unit);
        if(Qty_Per_Multi_Unit == 0){
            c.set('v.totalCases',0);
        }else{
            var totalCases = Total_Units/Qty_Per_Multi_Unit;
            totalCases = totalCases.toFixed(2);
            c.set('v.totalCases',totalCases);
        }
        //c.set('v.totalCases',Total_Units/Qty_Per_Multi_Unit);
    },
    onProductChange: function(c, e, h) {
        let serviceTicketLine = c.get('v.serviceTicketLine');
        //serviceTicketLine.Qty_Per_Multi_Unit = 0;
        let productId = serviceTicketLine.New_Packaged_Product;//e.getSource().get('v.value');
        let productPriceBooks = c.get('v.productPriceBooks');
        let PBE = productPriceBooks[productId];
        console.log('productId::',productId,'==>',JSON.stringify(PBE));
        
        serviceTicketLine.ProductName = PBE.Product2.Product_Short_Description__c;
        serviceTicketLine.Retail_Wholesale_Price = PBE.UnitPrice;
        serviceTicketLine.productDescription = PBE.Product2.Name;
        if(serviceTicketLine.id != undefined && serviceTicketLine.id != null && serviceTicketLine.id != ''){
            if(c.get('v.isOnLoad')){
                c.set('v.isOnLoad',false);
                console.log('on load');
                serviceTicketLine.newProductQty = PBE.Product2.MOQ__c;
            } else {
                serviceTicketLine.Qty_Per_Multi_Unit = PBE.Product2.MOQ__c;
                serviceTicketLine.newProductQty = PBE.Product2.MOQ__c;
                console.log('after load');
            }
        } else {
            serviceTicketLine.Qty_Per_Multi_Unit = PBE.Product2.MOQ__c;
            serviceTicketLine.newProductQty = PBE.Product2.MOQ__c;
        }
        
        c.set('v.serviceTicketLine',serviceTicketLine);
        let Total_Units = serviceTicketLine.Total_Units || 0;
        let Qty_Per_Multi_Unit  = serviceTicketLine.Qty_Per_Multi_Unit || 0;
        console.log('Qty_Per_Multi_Unit1::',Qty_Per_Multi_Unit);
        if(Qty_Per_Multi_Unit == 0){
            c.set('v.totalCases',0);
        }else{
            var totalCases = Total_Units/Qty_Per_Multi_Unit;
            totalCases = totalCases.toFixed(2);
            c.set('v.totalCases',totalCases);
        }
	},
    validate: function(c, e, h){
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var isValid = h.isValid(c);
        var batchCmp = c.find('Harvest_Batch_IDCustomLookup');
        var isBatchValid = true;
        if(batchCmp){
            isBatchValid = batchCmp.validate();
        }
        var isMSValid;
        var MSLines = c.find('multiSelect');
        console.log('MSLines::',MSLines);
        isMSValid = [].concat(MSLines).reduce(function (validSoFar, MS) {
            const isV = MS.validate();
            return validSoFar && isV;
        }, true);
        if(!isMSValid){
            return false;
        }
        /*var UIDCustomLookup = c.find('UIDCustomLookup');
        var isUIDValid = true;
        if(UIDCustomLookup){
            isUIDValid= UIDCustomLookup.validate();
        }
        var isNewBatchValid = true;
        console.log('Harvest = '+serviceTicketLine.Harvest_Batch_ID);
        console.log('New_Batch_ID = '+serviceTicketLine.New_Batch_ID);
        if(serviceTicketLine.Package_Type == 'Bagging' || serviceTicketLine.Package_Type == 'Blending' || serviceTicketLine.Package_Type == 'Pre-Roll Packing'|| serviceTicketLine.Package_Type == 'Jarring' || serviceTicketLine.Package_Type == 'Pre-Rolling'){
            var NewBatchCustomLookup = c.find('New_Batch_IDCustomLookup');
            isNewBatchValid = NewBatchCustomLookup.validate();
             
        }*/
        /*if( serviceTicketLine.New_Batch_ID === undefined || serviceTicketLine.New_Batch_ID === ''){
            isValid = false;
        }*/
        console.log('isValid:',isValid,isBatchValid);
        return (isValid && isBatchValid);
    },
    updateRecId :function(c,e,h){
        console.log('updateRecId...',c.get('v.SLIndex'));
        var item = e.getParam('selectedRecord');
        var selectedIndex = e.getParam('selectedIndex');
        console.log('selectedIndex:',selectedIndex);
        
        var selRec = e.getParam('selRec');
        console.log(selRec);
        if(selectedIndex != c.get('v.SLIndex')){
            return;
        }
        if(selRec == 'sourceBatch'){
            if(item.value != 'BLANK'){
            	c.set('v.selectedHarvestBatchCode',item); 
            	c.set('v.serviceTicketLine.Harvest_Batch_ID',item.value);    
            } else {
            	c.set('v.serviceTicketLine.Harvest_Batch_ID',''); 
                c.set('v.selectedHarvestBatchCode',null); 
            }
        	
        } else if(selRec == 'convertBatch'){
            if(item.value != 'BLANK'){
            	c.set('v.selectedHarvestBatchCodeConvert',item); 
            	c.set('v.serviceTicketLine.Harvest_Batch_ID_Convert',item.value);    
            } else {
            	c.set('v.serviceTicketLine.Harvest_Batch_ID_Convert',''); 
                c.set('v.selectedHarvestBatchCodeConvert',null); 
            }
        } else if(selRec == 'newBatch'){
        	c.set('v.selectedNewBatchCode',item);  
            c.set('v.serviceTicketLine.New_Batch_ID',item.value);
        } else if(selRec == 'uids'){
            c.set('v.selectedUID',item);    
            c.set('v.serviceTicketLine.UID',item.value);
        }
    },
    onRemoveRow : function(c,e,h){
        try{
            $A.get('e.c:removeServiceTicketLine').setParams({index: c.get('v.SLIndex')}).fire();
        }catch(error){
            console.log('Error:',error);
        }
    },
    onInventory_HOLD:function(c, e, h){
       /*var serviceTicketLine = c.get('v.serviceTicketLine');
        if(serviceTicketLine.Transfer_of_Custody){
            serviceTicketLine.Tamper_Label_Required = false;
            serviceTicketLine.CRP_Required = false;
            serviceTicketLine.PreRoll_Packing_Required = false;
            serviceTicketLine.Test_Required = false;
            serviceTicketLine.Qty_Per_Multi_Unit = 0;
            serviceTicketLine.Labels_Qty = 0;
            serviceTicketLine.Retail_Wholesale_Price = 0;
            serviceTicketLine.Desired_Retail_Ready_Form = '';
            serviceTicketLine.Tamper_Type = '';
            serviceTicketLine.Package_Type = '';
            c.set('v.isPreRoll',false);
            c.set('v.serviceTicketLine',serviceTicketLine);
        }*/
    }
})