({
	onInit: function (c, e, h) {
		c.set('v.applyCultivationTaxToggle', true);

		console.log(
			'newProductInit:',
			sessionStorage.getItem('isViewProductRequest')
		);
        var isClone=sessionStorage.getItem('isCloneProduct');
        var ProdRecordId = '';
        if(isClone == 'True'){
            c.set('v.isClone','True');
            ProdRecordId = sessionStorage.getItem('newProductRequestId');
            c.set('v.isView', sessionStorage.getItem('isViewProductRequest')); 
            sessionStorage.setItem('isCloneProduct', 'False');
        }else{
            isClone='False' ;
            c.set('v.recordId', sessionStorage.getItem('newProductRequestId'));
            c.set('v.isView', sessionStorage.getItem('isViewProductRequest')); 
        }
		console.log('##isCloneProduct::', isClone);
		console.log('recordId::', c.get('v.recordId'));
        h.request(c, 'newProductInit', { recordId: ProdRecordId !='' ? ProdRecordId : c.get('v.recordId') ,isClone:isClone}, function (
			r
		) {
			console.log('newProductInit::', r.FRTMap);
            if(r.FRTMap.length > 0){
                c.set('v.FRTMap',r.FRTMap);
            }
            if(r.product.strainId != undefined && r.product.strainId != ''){
                c.set('v.selectedStrain', { label: r.product.strainName, value: r.product.strainId });
            }
            if(r.product.safetyStockContact != undefined && r.product.safetyStockContact != ''){
                c.set('v.selectedContact', { label: r.product.safetyStockContactName, value: r.product.safetyStockContact });
            }
            if(r.product.strainType != undefined && r.product.strainType != ''){
                c.set('v.strainType',r.product.strainType);
            }
            r.product.marketplaceBrand = r.product.brandName;
			if (!c.get('v.recordId')) {
				//r.product.quantityType = r.quantityType[0].value;
				//r.product.productFamily = r.productFamily[0].value;
				//r.product.cultivationMethod = r.cultivationType[0].value;
				// r.product.cannabisWeightUOM = r.cannabisWeightUOM[0].value;
				
				r.product.applyCultivationTax = r.applyCultivationTax[0].value;
				r.product.applyExciseTax = r.applyExciseTax[0].value;
				r.product.cannabisCategory1 = r.cannabisCategory1[0].value;
				r.product.cannabisCategory2 = r.cannabisCategory2[0].value;
				//r.product.retailUnitFormFactor = r.retailUnitFormFactor[0].value;
				//r.product.stockingUOM = r.stockingUOM[0].value;
				//r.product.supplierUOM = r.supplierUOM[0].value;
				if (!r.product.producerId) {
					r.product.producerId = r.brandId;
				}
                if(r.isFINInterest){
                    r.product.producerId = '';
                }
            }else{
                c.set('v.applyCultivationTaxToggle', (r.product.applyCultivationTax =='Yes'));
            }
			
			c.set('v.brandName', r.brandName);
			c.set('v.brandId', r.brandId);
            console.log('r.product::',r.product);
            c.set('v.Msg_for_RetailWholesalePrice_Tooltip',r.Msg_for_RetailWholesalePrice_Tooltip);
            c.set('v.Certifications_Tooltip',r.Certifications_Tooltip);
            c.set('v.External_Id_Tooltip',r.External_Id_Tooltip);
			c.set('v.MOQ_Tooltip',r.MOQ_Tooltip);
            r.productFamily.forEach((pf)=>{pf.id=pf.value;pf.name=pf.label;});
			c.set('v.productFamily', r.productFamily);
            c.set('v.notificationContacts',r.notificationContacts);
            c.set('v.productFamilyDependency', r.productFamilyDependency);
            c.set('v.productFamilyDependencyStockingUOM', r.productFamilyDependencyStockingUOM);
            c.set('v.productFamilyDependencyCultivationType', r.productFamilyDependencyCultivationType);
			//c.set('v.quantityType', r.quantityType);
			//c.set('v.cultivationType', r.cultivationType);
			c.set('v.cannabisWeightUOM', r.cannabisWeightUOM);
			c.set('v.applyCultivationTax', r.applyCultivationTax);
			c.set('v.applyExciseTax', r.applyExciseTax);
			c.set('v.cannabisCategory1', r.cannabisCategory1);
			c.set('v.cannabisCategory2', r.cannabisCategory2);
            r.retailUnitFormFactor.forEach((pf)=>{pf.id=pf.value;pf.name=pf.label;})
			c.set('v.retailUnitFormFactor', r.retailUnitFormFactor);
			//c.set('v.stockingUOM', r.stockingUOM);
			c.set('v.supplierUOM', r.supplierUOM);
            c.set('v.certificationOptions', r.certificationOptions);
            r.marketplaceBrandOptions.forEach((pf)=>{pf.id=pf.value;pf.name=pf.label;})
            c.set('v.marketplaceBrandOptions', r.marketplaceBrandOptions);
            c.set('v.appellationOptions', r.appellationOptions);
                                           console.log('#$# : ',r.isFINInterest);
            if(!r.isFINInterest){
                                
               c.set('v.selectedRecord', { label: r.brandName, value: r.brandId });                            
             }                               
			
            
            if(r.product.productFamily != '' && r.product.productFamily != undefined){
                var productFamilyDependency = c.get('v.productFamilyDependency');
                var quantityType = productFamilyDependency[r.product.productFamily];
                var options = [];
                quantityType.forEach((item) => {
                    options.push({id:item,name:item,selected:(r.product.quantityType == item)});
            	})
            	c.set('v.quantityType',options);
            console.log('quantityType:',options);
            	var productFamilyDependencyCultivationType = c.get('v.productFamilyDependencyCultivationType');
                var cultivationType = productFamilyDependencyCultivationType[r.product.productFamily];
                var coptions = [];
                cultivationType.forEach((item) => {
                    coptions.push({id:item,name:item,selected:(r.product.cultivationMethod == item)});
                })
        		console.log('cultivationType:',coptions);
                c.set('v.cultivationType',coptions);
            }
            if(r.product.quantityType  != '' && r.product.quantityType  != undefined){
                var productFamilyDependency = c.get('v.productFamilyDependencyStockingUOM');
                var stockingUOM = productFamilyDependency[r.product.quantityType ];
                console.log('Stocking UOM::',stockingUOM);
                var options = [];
                stockingUOM.forEach((item) => {
                    options.push({id:item,name:item,selected:(r.product.stockingUOM == item)});
                })
                c.set('v.stockingUOM',options);
        	}
                c.set('v.product', r.product);
                c.set('v.isDataLoaded',true);
                window.setTimeout($A.getCallback(function(){
                    c.set('v.initializationCompleted',true);
                }),500)
				
            
		});
	},
    onQuantityTypeChange: function (c, e, h) {
        var product = c.get('v.product');
        var quantityType = product.quantityType;//e.getSource().get('v.value');
        var productFamilyDependency = c.get('v.productFamilyDependencyStockingUOM');
        console.log('productFamilyDependency:',JSON.stringify(productFamilyDependency));
        var stockingUOM = productFamilyDependency[quantityType];
        console.log('Stocking UOM::',stockingUOM);
        var options = [];
        stockingUOM.forEach((item) => {
            options.push({id:item,name:item});
        })
    	c.set('v.stockingUOM',options);
    },
    handleMultiSelectEvent  :  function (c, e, h) {
    	var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
        	selectedIds = selectedIds.slice(0, -1);
        console.log('fieldName = ',fieldName);
        console.log('selectedIds = ',selectedIds);
        var product = c.get('v.product');
        if(fieldName === 'Brand'){
            product.marketplaceBrand = selectedIds;
            c.set('v.product',product);
        }else if(fieldName === 'Product Category'){
            product.productFamily = selectedIds;
            c.set('v.product',product);
            if(c.get('v.initializationCompleted')){
            	var a = c.get('c.onProductFamilyChange');
                $A.enqueueAction(a);
            }
        }else if(fieldName === 'Final Form Factor'){
            product.retailUnitFormFactor = selectedIds;
            c.set('v.product',product);
        }else if(fieldName === 'Cultivation Type'){
            product.cultivationMethod = selectedIds;
            c.set('v.product',product);
        }else if(fieldName === 'Quantity Type'){
            product.quantityType = selectedIds;
            c.set('v.product',product);
            if(c.get('v.initializationCompleted')){
            	var a = c.get('c.onQuantityTypeChange');
                $A.enqueueAction(a);
            }
        }else if(fieldName === 'Unit of Measure'){
            product.stockingUOM = selectedIds;
            c.set('v.product',product);
        }else if(fieldName === 'Notification Contact'){
            product.safetyStockContact = selectedIds;
            c.set('v.product',product);
        }
        
    },
    onProductFamilyChange: function (c, e, h) {
        var product = c.get('v.product');
        var family = product.productFamily;//e.getSource().get('v.value');
        console.log('family:',family);
        var productFamilyDependency = c.get('v.productFamilyDependency');
        var quantityType = productFamilyDependency[family];
        var options = [];
        quantityType.forEach((item) => {
            options.push({id:item,name:item});
        })
    	c.set('v.quantityType',options);
        /*var productFamilyDependency = c.get('v.productFamilyDependencyStockingUOM');
        console.log('productFamilyDependency:',JSON.stringify(productFamilyDependency));
        var stockingUOM = productFamilyDependency['Quantity'];
        console.log('Stocking UOM::',stockingUOM);
        var options = [{label:'Select',value:''}];
        stockingUOM.forEach((item) => {
            options.push({label:item,value:item});
        })
    	c.set('v.stockingUOM',options);*/
        var productFamilyDependencyCultivationType = c.get('v.productFamilyDependencyCultivationType');
        console.log('productFamilyDependencyCultivationType:',productFamilyDependencyCultivationType);
            var cultivationType = productFamilyDependencyCultivationType[family];
        console.log('cultivationType::',cultivationType);
        var coptions = [];
        cultivationType.forEach((item) => {
            coptions.push({id:item,name:item});
        })
    	c.set('v.cultivationType',coptions);
    	
    },
        onProductNameChange: function (c, e, h) {
            var product = c.get('v.product');
            c.set('v.productName',product.shortDescription);
        },
	onEdit: function (c, e, h) {
		c.set('v.isView', false);
	},
	onSave: function (c, e, h) {
        var product = c.get('v.product');
        h.saveProduct(c,product.status == 'Active'?product.status:'Pending');
	},
    onSaveDraft: function (c, e, h) {
		h.saveProduct(c,'Draft');
	},
	onCancel: function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'My Product List';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
                }
                }
        }),100);
		h.redirect('/product-list', true);
	},
	onChangeAlert: function (c, e, h) {
		console.log('Checkbox:', e.getSource().get('v.value'));
	},
	handleSelectedRecord: function (c, e, h) {
		var objectName = e.getParam('objectName');
		var selectedRecord = e.getParam('selectedRecord');
        console.log('selectedRecord = ',selectedRecord);
        console.log('objectName = ',objectName);
        
		if (selectedRecord == '') {
			//selectedRecord = {label:c.get('v.brandName'),value:c.get('v.brandId')};
		}
		if (objectName == 'Account') {
            c.set('v.selectedRecord', selectedRecord);
            var notificationContacts = [];
            if(selectedRecord.value){
                h.request(c, 'getContacts', { producerId: selectedRecord.value }, function (r) {
                    console.log('getContacts::',r);
                    let contacts =  [];
                    [].concat(r.contacts).forEach((c)=>contacts.push({id:c.id,name:c.name}));
                    notificationContacts = contacts;
                    c.set('v.notificationContacts',notificationContacts);
                    console.log('notificationContacts::',c.get('v.notificationContacts'));
                    
                });
            }else{
                c.set('v.notificationContacts',notificationContacts);
            }
            var product = c.get('v.product');
            product.safetyStockContact = '';
            c.set('v.product',product);
            
		} else if (objectName == 'Contact') {
            c.set('v.selectedContact', selectedRecord);
		} else {
            c.set('v.selectedStrain', selectedRecord);
            if(selectedRecord.value){
                h.request(c, 'getStrainDetails', { recordId: selectedRecord.value }, function (r) {
                    console.log('getStrainDetails::',r);
                    c.set('v.strainType',r.strain.Strain_Type__c);
                });
            }else{
                c.set('v.strainType','');
            }
		}
		//console.log(e.getParam("selectedRecord").label,'==>',e.getParam("objectName"));
	},
	// handleApplyCultivationTax: function (c, e, h) {
	// 	var applyTax = c.get('v.applyCultivationTaxToggle');
	// 	c.set('v.applyCultivationTaxToggle', !applyTax);
	// },
	showSuccessModal: function (c, e, h) {
		const modal = document.getElementById('success-modal');
		modal.classList.add('is-active');
	},
                    onDuplicate: function (c, e, h) {
        var recordId = c.get('v.product');
         sessionStorage.setItem('isViewProductRequest',false);
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'Create New Product';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        
        }),100);
                    sessionStorage.setItem('newProductRequestId', recordId.id);
        sessionStorage.setItem('isCloneProduct', 'True');
        h.redirect('/newproduct', true);
    },
    handleStrainIdEvent :function(c,e,h){
         var selectedRecord = e.getParam('selectedRecord');   
        console.log('##selectedRecord:',selectedRecord.value);
        var selRec = e.getParam('selRec');
        console.log(selRec);
        var product = c.get('v.product');
        product.strainId = selectedRecord.value;
        c.set('v.selectedStrain',selectedRecord);
        c.set('v.product',product);
        c.set('v.strainType',selRec);
        
	}
});