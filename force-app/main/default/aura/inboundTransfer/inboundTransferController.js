({
    onInit: function(c, e, h) {
        try{
            c.set('v.recordId', sessionStorage.getItem('serviceTicketId'));
            console.log('RecordId = ',c.get('v.recordId'));
        }catch(err){}
        h.request(c, 'init', {recordId: c.get('v.recordId')}, function(r){
            console.log('Inbound Transfer INIT :',r);
            let toolTips = {
                Service_Type_Tooltip: r.Service_Type_Tooltip,
                Product_Name_Tooltip: r.Product_Name_Tooltip,
                Product_SKU_Tooltip: r.Product_SKU_Tooltip,
                Batch_ID_Tooltip: r.Batch_ID_Tooltip,
                Total_Qty_Tooltip: r.Total_Qty_Tooltip,
                Units_per_Case_Tooltip: r.Units_per_Case_Tooltip,
                Special_Instructions_Tooltip: r.Special_Instructions_Tooltip,
                UID_Tooltip: r.UID_Tooltip,
                Test_Status_Tooltip: r.Test_Status_Tooltip,
                Test_Required_Tooltip: r.Test_Required_Tooltip,
                COA_Number_Tooltip: r.COA_Number_Tooltip
            };
            c.set('v.toolTips', toolTips);
            c.set('v.IT_DISABLE_BATCH_UID_FAMILIES', r.IT_DISABLE_BATCH_UID_FAMILIES);
            c.set('v.IT_DISABLE_COA_NUMBER_STATUSES', r.IT_DISABLE_COA_NUMBER_STATUSES);
            c.set('v.perUnitWeights', r.perUnitWeights);
            c.set('v.desiredRetailReadyForms', r.desiredRetailReadyForms);
            c.set('v.preRollPackagings', r.preRollPackagings);
            c.set('v.tamperTypes', r.tamperTypes);
            
            [].concat(r.testStatus).forEach((t)=>{t.id=t.value;t.name=t.label;});
            c.set('v.testStatus', r.testStatus);
            c.set('v.packageTypes', r.packageTypes);
            c.set('v.THCCBDClaim_Labels', r.THCCBDClaim_Labels);
            c.set('v.Cone_Size', r.Cone_Size);
            c.set('v.bodyTubeLabels', r.bodyTubeLabels);
            c.set('v.bottomBackLabels', r.bottomBackLabels);
            c.set('v.topFrontLabels', r.topFrontLabels);
            [].concat(r.activeSites).forEach((l)=>{l.id=l.value;l.name=l.label});
            c.set('v.sites', r.activeSites);                                      
            [].concat(r.licenses).forEach((l)=>{l.id=l.value;l.name=l.label});
            c.set('v.licenses', r.licenses);
            [].concat(r.filigreenLicenses).forEach((l)=>{l.id=l.value;l.name=l.label});
            [].concat(r.transporterLicenses).forEach((l)=>{l.id=l.value;l.name=l.label});
            [].concat(r.pickupTransporterLicenses).forEach((l)=>{l.id=l.value;l.name=l.label});
            [].concat(r.pickUpFromDBA).forEach((l)=>{l.id=l.value;l.name=l.label});
                                                  
            c.set('v.pickUptransportLicenses',r.pickupTransporterLicenses);
            c.set('v.dropOfftransportLicenses',r.transporterLicenses);                                      
            c.set('v.pickUpfrom', r.pickUpFromDBA); 
            c.set('v.pickupLicenceMap',r.pickUpFromMap);     
            c.set('v.onSiteContactMap',r.onSiteContactMap);                                      
                                                 
			console.log('r.filigreenLicenses ',r.filigreenLicenses);
			c.set('v.filigreenLicenses', r.filigreenLicenses); 
            if(r.serviceTicket.transferMethod == 'Drop-off'){
				c.set('v.licensesOptions',r.licenses);
                //c.set('v.licensesOptions',[{id:r.defaultStateLicense.Id,name:r.defaultStateLicense.License_Number__c+'-'+r.defaultStateLicense.License_Type__c}]);
            }else{
                c.set('v.licensesOptions',r.licenses);
            }
            c.set('v.transferMethods',[{id:'Drop-off',name:'Drop-off'},{id:'Pick-up',name:'Pick-up'}]);                                       
            /*if(r.isDropOffAvailable){
            	c.set('v.transferMethods',[{id:'Drop-off',name:'Drop-off'},{id:'Pick-up',name:'Pick-up'}]);                                      
        	} else {
            	c.set('v.transferMethods',[{id:'Pick-up',name:'Pick-up'}]);      
            } */                                                 
            //c.set('v.licensesOptions',r.licenses); 
            c.set('v.siteMap', r.activeSiteMap);                                     
            c.set('v.stateLicenseMap', r.stateLicenseMap);
			c.set('v.filigreenStateLicenseMap', r.filigreenStateLicenseMap);
            console.log('filigreenStateLicenseMap ',JSON.stringify(c.get('v.filigreenStateLicenseMap')));                                      
            c.set('v.defaultStateLicense', r.defaultStateLicense);
            c.set('v.products', r.products);
            c.set('v.productPriceBooks', r.productPriceBooks);
            c.set('v.contacts', r.contacts);
            c.set('v.newSTL', r.tmpServiceTicketLine);
            c.set('v.newServiceTicket', r.serviceTicket);
            console.log('Lines::',r.serviceTicketLines);
            console.log('Lines2::',r.serviceTicket);
            c.set('v.newServiceTicketLines', r.serviceTicketLines);
            //c.set('v.requestDateTime',r.serviceTicket.requestDate);
            console.log('Dates ',r.serviceTicket.requestDate);
            c.set('v.selectedTime',r.serviceTicket.requestTime);
            c.set('v.holidayList', r.holidayList);
            c.set('v.cutOffTime',r.cutOffTime);
            
            c.set('v.laAddress',r.laAddress);
            c.set('v.laAddressId',r.laAddressId);
            c.set('v.defaultLicenseId',r.defaultLicense.value);
            if(r.slots != undefined){
                c.set('v.calendarEvents',r.slots);
            }
            if(r.serviceTicket.requestDate != null){
            	var strList = r.serviceTicket.requestDate.split('-');
            }

            if(c.get('v.recordId') == undefined || c.get('v.recordId') == ''){
            	c.set('v.newServiceTicket.transferMethod','Pick-up');
                c.set('v.transportLicenses',r.pickupTransporterLicenses); 
            }else{
                if(r.serviceTicket.transferMethod === 'Drop-off'){
                    c.set('v.transportLicenses',r.transporterLicenses);
                } else {
                    c.set('v.transportLicenses',r.pickupTransporterLicenses); 
                }
                h.getLicenseOptions(c, e,r.serviceTicket.pickupFromDBA);
                h.updateLicensePremise(c,r.serviceTicket.licensePremise);
            }

            if(r.serviceTicket.destinationSiteName != undefined && r.serviceTicket.destinationSiteName != null){
                let serviceTicket = c.get('v.newServiceTicket');
                serviceTicket.licenseName = r.serviceTicket.licenseName;
                //serviceTicket.pickupFromDBA = r.serviceTicket.brandDBA;
                c.set('v.newServiceTicket',serviceTicket);
            }	
            if(r.serviceTicket.destinationSiteAddress != undefined && r.serviceTicket.destinationSiteAddress != null){
                c.set('v.selectedSiteAddress',r.serviceTicket.destinationSiteAddress);
            }

			c.set('v.isDataLoaded',true);
			window.setTimeout($A.getCallback(function(){
                c.set('v.initializationCompleted',true);
            }),500)
        });
    },
    handleMultiSelectEvent  :  function (c, e, h) {
    	var selectedIds = e.getParam("selectedIds");
        let stateLicenseMap = c.get('v.stateLicenseMap');
        let pickupLicenceMap = c.get('v.pickupLicenceMap');
        let filigreenStateLicenseMap = c.get('v.filigreenStateLicenseMap');
        let siteMap = c.get('v.siteMap');
        
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
        	selectedIds = selectedIds.slice(0, -1);
        console.log('fieldName = ',fieldName);
        console.log('selectedIds = ',selectedIds);
        var serviceTicket = c.get('v.newServiceTicket');
        if(fieldName === 'Transfer Method'){
            serviceTicket.transferMethod = selectedIds;
            c.set('v.newServiceTicket',serviceTicket);
            if(c.get('v.initializationCompleted')){
                var a = c.get('c.onTransferSelect');
                $A.enqueueAction(a);
            }
        } else if(fieldName === 'Pick Up From' || fieldName === 'Originating Entity'){
            if(c.get('v.initializationCompleted')){
                h.getLicenseOptions(c, e,selectedIds);
            }
        } else if(fieldName ==='Transporter'){
            serviceTicket.transportLicenseId = selectedIds;
            c.set('v.newServiceTicket',serviceTicket);
        } else if( fieldName === 'Destination Site'){
            serviceTicket.destinationSiteId = selectedIds;
            let siteDetail = siteMap[selectedIds];
            if(siteDetail){
                serviceTicket.destinationSiteName = siteDetail.Name;
                let lAddress = '';
                if(siteDetail.License_ID__c){
                    lAddress = siteDetail.License_ID__r.License_Number__c + ' | ';
                    if(siteDetail.License_ID__r.License_Address__c != undefined){
                        lAddress += siteDetail.License_ID__r.License_Address__c;
                    }
                    
                    if(siteDetail.License_ID__r.License_City__c != undefined){
                        lAddress+= ', ' + siteDetail.License_ID__r.License_City__c;
                    }
                    if(siteDetail.License_ID__r.License_State__c != undefined){
                        lAddress+= ', ' + siteDetail.License_ID__r.License_State__c;
                    }
                    if(siteDetail.License_ID__r.License_Country__c != undefined){
                        lAddress+= ', ' + siteDetail.License_ID__r.License_Country__c;
                    }
                    if(siteDetail.License_ID__r.License_Zip__c != undefined){
                        lAddress+= ', ' + siteDetail.License_ID__r.License_Zip__c;
                    }
                }
                serviceTicket.destinationSiteAddress = lAddress;
                c.set('v.selectedSiteAddress',lAddress);
            }
            
        } else if(fieldName === 'Pick Up Address' || fieldName === 'Originating Address' || fieldName === 'License Premise'){
            console.log('aaaaaaaa');
            serviceTicket.licensePremise = selectedIds;
            console.log('serviceTicket.licensePremise ',serviceTicket.licensePremise);
            var license;
            if(serviceTicket.transferMethod == 'Pick-up'){
                if(serviceTicket.licensePremise){
                    license = stateLicenseMap[serviceTicket.licensePremise];
                }
            }else{
                if(serviceTicket.licensePremise){
                    //license = filigreenStateLicenseMap[serviceTicket.licensePremise];
                    license = stateLicenseMap[serviceTicket.licensePremise];
                }
            }
            var lAddress = '';
            if(license){
                console.log('license - ',license);
                if(license.License_Address__c != undefined){
                    lAddress = license.License_Address__c;
                }
                
                if(license.License_City__c != undefined){
                    lAddress+= ', ' + license.License_City__c;
                }
                if(license.License_State__c != undefined){
                    lAddress+= ', ' + license.License_State__c;
                }
                if(license.License_Country__c != undefined){
                    lAddress+= ', ' + license.License_Country__c;
                }
                if(license.License_Zip__c != undefined){
                    lAddress+= ', ' + license.License_Zip__c;
                }
            }
            c.set('v.selectedStateAddress',lAddress);
            c.set('v.newServiceTicket',serviceTicket);
            
        }else if(fieldName === 'Brand Contact' || fieldName === 'On-Site Contact'){
            serviceTicket.brandContactId = selectedIds;
            c.set('v.newServiceTicket',serviceTicket);
        }
        
    },
    onTransferSelect: function(c, e, h) {
        var serviceTicket = c.get('v.newServiceTicket');
        var tranferType = serviceTicket.transferMethod;//e.getSource().get('v.value');
        var stateLicenseMap = c.get('v.stateLicenseMap');
        var filigreenStateLicenseMap = c.get('v.filigreenStateLicenseMap');
        var serviceTicket = c.get('v.newServiceTicket');
        var licenseId = serviceTicket.licensePremise;
        var defaultStateLicense = c.get('v.defaultStateLicense');
        console.log('tranferType = ',tranferType);
        console.log('tranferType = ',c.get('v.licenses'));
        serviceTicket.licenseName = '';
        serviceTicket.licensePremise = '';
        c.set('v.newServiceTicket',serviceTicket);
        var license;
        if(tranferType != 'Pick-up'){
            /*license = c.get('v.defaultStateLicense');
            window.setTimeout($A.getCallback(function(){
                if(defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c != null && defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c != undefined){
                    c.set('v.licensesOptions',[{id:defaultStateLicense.Id,name:defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c+ ' - '+defaultStateLicense.License_Number__c+'-'+defaultStateLicense.License_Type__c,selected:true}]);
                } else {
                    c.set('v.licensesOptions',[{id:defaultStateLicense.Id,name:defaultStateLicense.License_Number__c+'-'+defaultStateLicense.License_Type__c,selected:true}]);
                }
            	
            }),100);
            if(defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c != null && defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c != undefined){
                serviceTicket.licenseName = defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c+ ' - '+defaultStateLicense.License_Number__c+'-'+defaultStateLicense.License_Type__c;
                serviceTicket.destinationSiteName = defaultStateLicense.Default_Warehouse__r.Warehouse_Name__c;
                serviceTicket.destinationSiteId = defaultStateLicense.Default_Warehouse__c;
            } else {
                serviceTicket.licenseName = defaultStateLicense.License_Number__c+'-'+defaultStateLicense.License_Type__c;
            }
            
            serviceTicket.licensePremise = defaultStateLicense.Id;
            c.set('v.newServiceTicket',serviceTicket);*/
            //license = filigreenStateLicenseMap[licenseId];
            license = stateLicenseMap[licenseId];
        }else if(licenseId){
            license = stateLicenseMap[licenseId];
        }
        
        if(tranferType == 'Pick-up'){
            c.set('v.transportLicenses',c.get('v.pickUptransportLicenses'));
            c.set('v.licensesOptions',c.get('v.licenses'));
            c.set('v.selectedSiteAddress','');
            c.set('v.selectedStateAddress','');
        }else{
            c.set('v.transportLicenses',c.get('v.dropOfftransportLicenses'));
            c.set('v.selectedSiteAddress','');
            c.set('v.selectedStateAddress','');
        	c.set('v.licensesOptions',c.get('v.licenses'));    
        }
        //c.set('v.licensesOptions',c.get('v.licenses'));
        console.log('license::',license);
        var lAddress = '';
        if(license){
            if(license.License_Address__c != undefined){
                lAddress = license.License_Address__c;
            }
            if(license.License_City__c != undefined){
                lAddress+= ', ' + license.License_City__c;
            }
            if(license.License_State__c != undefined){
                lAddress+= ', ' + license.License_State__c;
            }
            if(license.License_Country__c != undefined){
                lAddress+= ', ' + license.License_Country__c;
            }
            if(license.License_Zip__c != undefined){
                lAddress+= ', ' + license.License_Zip__c;
            }
        }
        c.set('v.selectedStateAddress',lAddress);
    },
    onLicenseSelect: function(c, e, h) {
        var licenseId = e.getSource().get('v.value');
        h.updateLicensePremise(c,licenseId);
    },
    onScriptsLoaded: function(c, e, h) {
        console.log('onScriptsLoaded...');
        h.applyDate(c);
    },
    showDatePicker: function(c, e, h) {
        //$("#datepickerId").show(); 
        $("#datepickerId").datepicker("show");
    },
    getSlotTime: function(c, e, h) {
    	var time = e.currentTarget.dataset.time;
        var dateStr = c.get('v.requestDateTime');
        
        c.set('v.selectedTime',time);
        if(dateStr != '' && dateStr != undefined){
         	dateStr = dateStr + ' '+time;
            console.log(dateStr);
        	c.set('v.requestDateTimeStr',dateStr);   
        }
        //alert(dateStr);
    },
    onAddRow: function(c, e, h) {
        var newServiceTicketLines = c.get('v.newServiceTicketLines');

        newServiceTicketLines.push(Object.assign({},c.get('v.newSTL')));
        c.set('v.newServiceTicketLines', newServiceTicketLines);
    },
    onRemoveRow: function(c, e, h) {
        console.log('onRemoveRow...',e.getParam('index'));
        var rowIndex = e.getParam('index');//e.getSource().get('v.value');
        var newServiceTicketLines = c.get('v.newServiceTicketLines');
        
        if(newServiceTicketLines.length == 1){
            h.warning({message: 'Atleast a Inbound Transfer line is required.'});
        }else{
            newServiceTicketLines.splice(rowIndex, 1);
            c.set('v.newServiceTicketLines', newServiceTicketLines);    
        }
    },
    onSaveDraft: function(c, e, h) {
        console.log("onSave:");
        
        h.submitServiceTickt(c,false,true);
    },    
    onSave: function(c, e, h) {
        console.log("onSave:");
        
        h.submitServiceTickt(c,false,false);
    },
    onSaveAndUpload: function(c, e, h) {
        console.log("onSaveAndUpload:");
        
        h.submitServiceTickt(c,true,false);
    },
    onCancel: function(c, e, h) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'View Inbound Transfers';
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
        
        h.redirect('/inboundtransfers', true);
    },
                    
    handleChange: function(c,e,h){
        console.log('check call');
        var check = document.getElementById("check").checked;
        console.log('check',check);
                        
    }
})