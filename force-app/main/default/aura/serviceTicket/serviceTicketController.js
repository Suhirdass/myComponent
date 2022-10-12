({
    onInit: function(c, e, h) {
        try{
            c.set('v.recordId', sessionStorage.getItem('serviceTicketId'));
        }catch(err){}
        h.request(c, 'init', {recordId: c.get('v.recordId')}, function(r){
            console.log('ST Init:',r);
            let toolTips = {
                Service_Type_Tooltip: r.Service_Type_Tooltip,
                Product_Name_Tooltip: r.Product_Name_Tooltip,
                Product_SKU_Tooltip: r.Product_SKU_Tooltip,
                Batch_ID_Tooltip: r.Batch_ID_Tooltip,
                Total_Qty_Tooltip: r.Total_Qty_Tooltip,
                Units_per_Case_Tooltip: r.Units_per_Case_Tooltip,
                Special_Instructions_Tooltip: r.Special_Instructions_Tooltip
            };
            c.set('v.toolTips', toolTips);
            c.set('v.perUnitWeights', r.perUnitWeights);
            c.set('v.desiredRetailReadyForms', r.desiredRetailReadyForms);
            c.set('v.preRollPackagings', r.preRollPackagings);
            c.set('v.tamperTypes', r.tamperTypes);
            r.packageTypes.forEach((p)=>{p.id=p.value;p.name = p.label;});
            c.set('v.packageTypes', r.packageTypes);
            c.set('v.THCCBDClaim_Labels', r.THCCBDClaim_Labels);
            c.set('v.Cone_Size', r.Cone_Size);
            c.set('v.bodyTubeLabels', r.bodyTubeLabels);
            c.set('v.bottomBackLabels', r.bottomBackLabels);
            c.set('v.topFrontLabels', r.topFrontLabels);
            c.set('v.licenses', r.licenses);
            c.set('v.stateLicenseMap', r.stateLicenseMap);
            c.set('v.defaultStateLicense', r.defaultStateLicense);
            c.set('v.products', r.products);
            c.set('v.productPriceBooks', r.productPriceBooks);
            c.set('v.contacts', r.contacts);
            c.set('v.newSTL', r.tmpServiceTicketLine);
            c.set('v.newServiceTicket', r.serviceTicket);
            c.set('v.newServiceTicketLines', r.serviceTicketLines);
            c.set('v.selectedTime',r.serviceTicket.requestTime);
            c.set('v.holidayList', r.holidayList);
            
            c.set('v.cutOffTime',r.cutOffTime);
            
            c.set('v.laAddress',r.laAddress);
            c.set('v.laAddressId',r.laAddressId);
            c.set('v.defaultLicenseId',r.defaultLicense.value);
            var license = c.get('v.defaultStateLicense');
            var lAddress = license.License_Address__c;
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
            c.set('v.selectedStateAddress',lAddress);
                                         
            [].concat(r.activeSites).forEach((l)=>{l.id=l.value;l.name=l.label});
            c.set('v.sites', r.activeSites);  
            c.set('v.siteMap', r.activeSiteMap);                             
            
            if(r.slots != undefined){
                c.set('v.calendarEvents',r.slots);
            }
            if(r.serviceTicket.requestDate != null){
            	var strList = r.serviceTicket.requestDate.split('-');
            }
            window.setTimeout($A.getCallback(function(){
                c.set('v.isDataLoaded',true);
            }),100);
        });
    },
    handleMultiSelectEvent  :  function (c, e, h) {
    	var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
        	selectedIds = selectedIds.slice(0, -1);
        console.log('fieldName = ',fieldName);
        console.log('selectedIds = ',selectedIds);
        var serviceTicket = c.get('v.newServiceTicket');
        if(fieldName === 'Brand Contact'){
            serviceTicket.brandContactId = selectedIds;
            c.set('v.newServiceTicket',serviceTicket);
        } else if( fieldName === 'Destination Site'){
            serviceTicket.destinationSiteId = selectedIds;
            c.set('v.newServiceTicket',serviceTicket);
        }
        
    },
    onTransferSelect: function(c, e, h) {
        var tranferType = e.getSource().get('v.value');
        var stateLicenseMap = c.get('v.stateLicenseMap');
        var serviceTicket = c.get('v.newServiceTicket');
        var licenseId = serviceTicket.licensePremise;
        var license;
        if(tranferType != 'Pick-up'){
            license = c.get('v.defaultStateLicense');
        }else if(licenseId){
            license = stateLicenseMap[licenseId];
        }
        console.log('license::',license);
        var lAddress = '';
        if(license){
            lAddress = license.License_Address__c;
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
        var serviceTicket = c.get('v.newServiceTicket');
        var stateLicenseMap = c.get('v.stateLicenseMap');
        var license;
        if(serviceTicket.transferMethod != 'Pick-up'){
            license = c.get('v.defaultStateLicense');
        }else{
            license = stateLicenseMap[licenseId];
        }
        console.log('license::',license);
        var lAddress = license.License_Address__c;
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
        c.set('v.selectedStateAddress',lAddress);
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
            h.warning({message: 'Atleast a Service Ticket line is required.'});
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
        
        var screenName = 'View Service Tickets';
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
        h.redirect('/servicetickets', true);
    }
})