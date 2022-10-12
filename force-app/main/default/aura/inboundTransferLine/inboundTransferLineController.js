({
    onInit: function(c, e, h){
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var productPriceBooks = c.get('v.productPriceBooks');
        const IT_DISABLE_BATCH_UID_FAMILIES = c.get('v.IT_DISABLE_BATCH_UID_FAMILIES')||'';
        let disbaledFamilies = IT_DISABLE_BATCH_UID_FAMILIES.split(';');
        const IT_DISABLE_COA_NUMBER_STATUSES = c.get('v.IT_DISABLE_COA_NUMBER_STATUSES')||'';
        let disbaledTestStatuses = IT_DISABLE_COA_NUMBER_STATUSES.split(',');
        if(serviceTicketLine.New_Packaged_Product){
            var PBE = productPriceBooks[serviceTicketLine.New_Packaged_Product];
            serviceTicketLine.New_Packaged_ProductName = PBE.Product2.Product_Short_Description__c;
            serviceTicketLine.Retail_Wholesale_Price = PBE.UnitPrice;
            serviceTicketLine.productDescription = PBE.Product2.Name;
            serviceTicketLine.Qty_Per_Multi_Unit = PBE.Product2.MOQ__c;
            c.set('v.DISABLE_BATCH_UID',(disbaledFamilies.indexOf(PBE.Product2.Family) != -1));
            var products = c.get('v.products');
            products.forEach((p)=>p.selected = p.id == serviceTicketLine.New_Packaged_Product);
            c.set('v.products',products);
        }
        c.set('v.DISABLE_COA',(disbaledTestStatuses.indexOf(serviceTicketLine.testStatus) != -1));
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
        }),500);
    },
    handleMultiSelectEvent  :  function (c, e, h) {
    	var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        var index = e.getParam("index");
        if(index == c.get('v.SLIndex')){
            if(selectedIds)
                selectedIds = selectedIds.slice(0, -1);
            
            var serviceTicketLine = c.get('v.serviceTicketLine');
            if(fieldName === 'Product Name'){
                serviceTicketLine.New_Packaged_Product = selectedIds;
                c.set('v.serviceTicketLine',serviceTicketLine);
                if(c.get('v.initializationCompleted')){
                    var a = c.get('c.onProductChange');
                    $A.enqueueAction(a);
                }
            }else if(fieldName === 'Test Required'){
                serviceTicketLine.Test_Required = selectedIds;
                c.set('v.serviceTicketLine',serviceTicketLine);
            }else if(fieldName === 'Test Status'){
                const IT_DISABLE_COA_NUMBER_STATUSES = c.get('v.IT_DISABLE_COA_NUMBER_STATUSES')||'';
                let disbaledTestStatuses = IT_DISABLE_COA_NUMBER_STATUSES.split(',');
                serviceTicketLine.testStatus = selectedIds;
                c.set('v.DISABLE_COA',(disbaledTestStatuses.indexOf(serviceTicketLine.testStatus) != -1));
                c.set('v.serviceTicketLine',serviceTicketLine);
            }
        }
    },
    onExpendCollapse: function(c, e, h) {
        var isCollapsed = c.get('v.isCollapsed');
        c.set('v.isCollapsed',!isCollapsed);
    },
    onPerRollChange: function(c, e, h) {
        var desiredRetailReadyForm = e.getSource().get('v.value');
        c.set('v.isPreRoll', (desiredRetailReadyForm.indexOf('Pre-Rolling') > -1));
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
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var productId = serviceTicketLine.New_Packaged_Product;// e.getSource().get('v.value');
        var productPriceBooks = c.get('v.productPriceBooks');
        var PBE = productPriceBooks[productId];
        const IT_DISABLE_BATCH_UID_FAMILIES = c.get('v.IT_DISABLE_BATCH_UID_FAMILIES')||'';
        let disbaledFamilies = IT_DISABLE_BATCH_UID_FAMILIES.split(';');
        console.log('disbaledFamilies::',disbaledFamilies);
        var serviceTicketLine = c.get('v.serviceTicketLine');
        serviceTicketLine.ProductName = PBE.Product2.Product_Short_Description__c;
        serviceTicketLine.Retail_Wholesale_Price = PBE.UnitPrice;
        serviceTicketLine.productDescription = PBE.Product2.Name;
        serviceTicketLine.Qty_Per_Multi_Unit = PBE.Product2.MOQ__c;
        console.log('Family:',PBE.Product2.Family);
        c.set('v.DISABLE_BATCH_UID',(disbaledFamilies.indexOf(PBE.Product2.Family) != -1));
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
	},
    validate: function(c, e, h){
        var serviceTicketLine = c.get('v.serviceTicketLine');
        var isValid = h.isValid(c);
        var MSLines = c.find('multiSelect');
        console.log('MSLines::',MSLines);
        var isMSValid;
        isMSValid = [].concat(MSLines).reduce(function (validSoFar, MS) {
            const isV = MS.validate();
            return validSoFar && isV;
        }, true);
        if(!isMSValid){
            return false;
        }
        var batchCmp = c.find('Harvest_Batch_IDCustomLookup');
        var isBatchValid = true;
        if(batchCmp){
            isBatchValid = batchCmp.validate();
        }
        var UIDCustomLookup = c.find('UIDCustomLookup');
        var isUIDValid = true;
        if(UIDCustomLookup){
            isUIDValid= UIDCustomLookup.validate();
        }
        /*var isNewBatchValid = true;
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
        return (isValid && isBatchValid && isUIDValid);
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