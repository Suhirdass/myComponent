({
    doInit : function(c, e, h) {
        h.request(c, 'inventoryDetails', {recId: c.get("v.recordId"), srchPageRender2: 'true'}, function(r){
            c.set('v.isDataLoaded',true);
            c.set('v.prodRec', r.records);
            c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList'));
        });
        
    },
    onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    
    submitTransfer : function(c, e, h) {
        var getQtyToPutAway = c.get("v.prodRec.inventoryPositions");
        var callController = 'true';
        getQtyToPutAway.forEach(function (IP, index){
            if(IP.qtyToPutAway == null || IP.qtyToPutAway == ''){
                callController = 'false';
            } 
        });
        if(callController == 'false'){
            h.warning({message: 'Qty to transfer must not be empty for inventory position'});
        } 
        else{
            var JSONStrP = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
            var JSONStr = JSON.stringify(c.get("v.inventoryList"));
            
            h.request(c, 'updateInventoryLocations', {invPos: JSONStrP,jsonStr1: JSONStr, recId: c.get("v.recordId")}, function(r){
                if(r.Error != null || r.Error != undefined){
                    h.warning({ message: (r.Error.errorMsg) });
                    return false;      
                } else {
                    c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList'));
                    c.set('v.prodRec.invPosSectionRender',r.invPosSectionRender);
                    c.set('v.prodRec.showMassTransferBlock',r.showMassTransferBlock); 
                    c.set('v.prodRec.miscIssueSectionRender',r.miscIssueSectionRender);
                    c.set('v.prodRec', r.records);
                    var table = $('table.dataTable').DataTable();
                    if(table) table.destroy();
                    window.setTimeout($A.getCallback(function(){
                        h.applyDataTable(c,e);
                    }),100)
                } 
            });
        }
    },
    
    onSave : function(c, e, h){
        var getQtyToAdjust = c.get("v.prodRec.invPositionWrappList");
        var callController = 'true';
        var cbx = 'true';
        getQtyToAdjust.forEach(function (IP, index){
            if(IP.qtyToAdjust == null || IP.qtyToAdjust == ''){
                callController = 'false';
            } 
            if(!IP.isSelected){
                cbx = 'false';
            } 
        });
        if(cbx == 'false'){
            h.warning({message: 'Check action checkbox'});
        } 
        else{
            if(callController == 'false'){
                h.warning({message: 'Qty to adjust must not be empty or zero for inventory position'});
            } 
            else{
                debugger;
                let masterInventoryPositions = c.get('v.inventoryList');
                masterInventoryPositions.find(function(element) {
                    var text = element.qtyToAdjust;
                    var pointNum = parseFloat(text);
                    element.qtyToAdjust = pointNum;    
                });
                
                var JSONStr = JSON.stringify(masterInventoryPositions);   
                var check = c.find('a_opt4').get('v.validity').valueMissing;
                var check2 = c.find('a_opt3').get('v.validity').valueMissing;
                
                c.find('a_opt3').showHelpMessageIfInvalid();
                c.find('a_opt4').showHelpMessageIfInvalid();
                
                if(!check){
                    if(!check2){
                        h.request(c, 'SaveRecord', {jsonStr1: JSONStr, invPer: c.get('v.prodRec.invPerAdj'), recId: c.get("v.recordId")}, function(r){
                            
                            if(r.Error != null || r.Error != undefined){
                                h.warning({ message: (r.Error) });
                                return false;      
                            } else {
                                c.set('v.prodRec', r.records);
                                c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList')); 
                                
                                $A.get('e.force:refreshView').fire();
                            }  
                        });     
                    }
                }
            }
        }
    },
    
    redirectItemDetail : function(c, e, h) {
        var eUrl= $A.get("e.force:navigateToURL");
        eUrl.setParams({
            "url": '/'+ c.get("v.recordId")
        });
        eUrl.fire();
    },
    
    miscIssue : function(c, e, h) {
        var selectedRec = c.get('v.prodRec.invPositionWrappList');
        var inputCheckBoxSelected=false;
        for(var i=0; i<selectedRec.length; i++){
            if(selectedRec[i].isSelected){
                inputCheckBoxSelected = true;
            }    
        }
        var JSONStr = JSON.stringify(c.get("v.inventoryList")); 
        if(inputCheckBoxSelected){
            h.request(c, 'redirectToMiscIssue', {jsonStr1: JSONStr, recId: c.get("v.recordId")}, function(r){
                c.set('v.prodRec', r.records);
                c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList'));
                var table = $('table.dataTable').DataTable();
                if(table) table.destroy();
                window.setTimeout($A.getCallback(function(){
                    h.applyDataTable(c,e);
                }),100)
            });
        }else{
            h.warning({ message: 'Please select the Inventory Position record.' });
        }
    },
    
    loadBalanceQtyToPutAway : function(c, e, h) {
        var jsonInv = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
        var selIds = e.getSource().get("v.label");
        var binIds = e.getSource().get("v.value");
        var jsonBin = JSON.stringify(c.get("v.prodRec.binConsumedCapacityById"));
        
        h.request(c, 'loadBalanceQtyToPutAwayLight', {selectedInvPositionId: selIds, inventoryPos: jsonInv, binConsume: jsonBin, selectedBinLocationId: binIds}, function(r){
            c.set('v.prodRec.inventoryPositions', r.records);	
        });
    },
    
    loadBinLocations : function(c, e, h) {
        var recIds = e.getSource().get("v.name");
        var jsonInv = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
        var jsonBinLevel = JSON.stringify(c.get("v.prodRec.binLocationsByRackLevelId"));
        var jsonBin = JSON.stringify(c.get("v.prodRec.binConsumedCapacityById"));
        
        h.request(c, 'loadBinLocationsLight', {selectedInvPositionId: recIds.invPositionSO.Id, inventoryPos: jsonInv, binLocationsByRackLevel : jsonBinLevel, selectedRackLevelId: recIds.invPositionSO.Rack_Level__c,
                                               binConsume: jsonBin, selectedBinLocationId: recIds.invPositionSO.Bin_Location__c}, function(r){
                                                   c.set('v.prodRec.inventoryPositions', r.records);	
                                               });
    },
    
    loadRackLevels : function(c, e, h) {
        var jsonInv = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
        var jsonRackLevel = JSON.stringify(c.get("v.prodRec.rackLevelsByRackId"));
        var jsonBinLevel = JSON.stringify(c.get("v.prodRec.binLocationsByRackLevelId"));
        var jsonBin = JSON.stringify(c.get("v.prodRec.binConsumedCapacityById"));
        var selIds = e.getSource().get("v.label");
        var recIds = e.getSource().get("v.name");
        var rackId = recIds.invPositionSO.Rack__c ;
        
        h.request(c, 'loadRackLevelsLight', {selectedInvPositionId: selIds, inventoryPos: jsonInv, rackLevelsByRack: jsonRackLevel,binLocationsByRackLevel : jsonBinLevel, selectedRackId: rackId,
                                             binConsume: jsonBin, selectedBinLocationId: recIds.invPositionSO.Bin_Location__c}, function(r){
                                                 c.set('v.prodRec.inventoryPositions', r.records);	
                                             });
    },
    
    loadIPSites : function(c, e, h) {
        
        let jsonInv = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
        let selIds = e.getSource().get("v.label");
        let recIds = e.getSource().get("v.name");
        let siteId = e.getSource().get("v.value");
        let jsonLocations = JSON.stringify(c.get("v.prodRec.inventoryLocationBySiteId")); 
        let jsonRackLocations = JSON.stringify(c.get("v.prodRec.rackByLocationId"));
        
        let jsonRackLevel = JSON.stringify(c.get("v.prodRec.rackLevelsByRackId"));
        let jsonBinLevel = JSON.stringify(c.get("v.prodRec.binLocationsByRackLevelId"));
        let jsonBin = JSON.stringify(c.get("v.prodRec.binConsumedCapacityById"));
        h.request(c, 'loadIPSitesRec', {selectedInvPositionId: selIds, inventoryPos: jsonInv, selectedSiteId: siteId,
                                        locations: jsonLocations,racks : jsonRackLocations,rackLevel : jsonRackLevel,
                                        binLevel : jsonBinLevel,binConsume : jsonBin,selectedBinLocationId: recIds.invPositionSO.Bin_Location__c}, function(r){
                                            c.set('v.prodRec.inventoryPositions', r.records);
                                        });
    },
    
    loadIPLocations: function(c, e, h) {
        var jsonInv = JSON.stringify(c.get("v.prodRec.inventoryPositions"));
        var selIds = e.getSource().get("v.label");
        var recIds = e.getSource().get("v.name");
        var locationId = e.getSource().get("v.value");
        var jsonRackLocations = JSON.stringify(c.get("v.prodRec.rackByLocationId"));
        var jsonRackLevel = JSON.stringify(c.get("v.prodRec.rackLevelsByRackId"));
        var jsonBinLevel = JSON.stringify(c.get("v.prodRec.binLocationsByRackLevelId"));
        var jsonBin = JSON.stringify(c.get("v.prodRec.binConsumedCapacityById"));
        h.request(c, 'loadIPLocationRec', {selectedInvPositionId: selIds, inventoryPos: jsonInv, selectedLocationId: locationId,
                                           racks : jsonRackLocations,rackLevel : jsonRackLevel,binLevel : jsonBinLevel,
                                           binConsume : jsonBin,selectedBinLocationId: recIds.invPositionSO.Bin_Location__c}, function(r){
                                               c.set('v.prodRec.inventoryPositions', r.records);
                                           });
        
    },
    
    redirectToMiscReceipt : function(c, e, h) {
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:miscReceipt",
            componentAttributes: {
                recordId : c.get("v.recordId")
            }
        });
        evt.fire();
    },
    
    onCancel : function(c, e, h) {
        $A.get('e.force:refreshView').fire();
    },
    
    massTransfer : function(c, e, h) {
        var JSONStr = JSON.stringify(c.get("v.inventoryList"));
        h.request(c, 'massTransferAction', {jsonStr1: JSONStr, recId: c.get("v.recordId")}, function(r){
            if(r.Error != null || r.Error != undefined){
                h.warning({ message: (r.Error.errorMsg) });
                return false;      
            } else {
                c.set('v.prodRec', r.records);
                c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList'));               
            } 
        });
    },
    
    mergeConfirm : function(c, e, h) {
        c.set('v.isOpen',true);    
    },
    
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },
    
    likenClose: function(c, e, h) {
        var selectedIds = new Array();
        if(c.get('v.inventoryList').length != 1){
            for(var cmp in c.find("checkbx")){
                
                if(c.find("checkbx")[cmp].get("v.checked")){
                    selectedIds.push(c.find("checkbx")[cmp].get("v.value"));
                }
            }
        }else{
            selectedIds.push(c.find("checkbx").get("v.value"));
        }
        if(selectedIds.length > 0){
            if(selectedIds.length < 2){
                h.warning({ message: ('Please select atleast 2 items to merge.') });   
                c.set("v.isOpen", false);
            } else {
                selectedIds.join(',');
                h.request(c, 'mergeIPs', {selectedIds1: JSON.stringify(selectedIds), recId: c.get("v.recordId")}, function(r){
                    if(r.Error != null || r.Error != undefined){
                        h.warning({ message: (r.Error) });
                        c.set("v.isOpen", false);
                        return false;      
                    } else {
                        c.set('v.prodRec', r.records);
                        c.set('v.inventoryList',c.get('v.prodRec.invPositionWrappList'));
                        c.set("v.isOpen", false);
                        $A.get('e.force:refreshView').fire();
                    }   
                }); 
            }
        } else {
            h.warning({ message: ('Please select the items to merge.') });
            c.set("v.isOpen", false);
            return false;    
        }
    },
    
    holdIps :  function(c, e, h) {
        var selectedIds = new Array();
        if(c.get('v.inventoryList').length != 1){
            for(var cmp in c.find("checkbx")){
                if(c.find("checkbx")[cmp].get("v.checked")){
                    selectedIds.push(c.find("checkbx")[cmp].get("v.value"));
                }
            }
        }else{
            selectedIds.push(c.find("checkbx").get("v.value"));
        }
        if(selectedIds.length > 0){
            selectedIds.join(','); 
            h.request(c, 'holdUnHoldIps', {selectedIds1: JSON.stringify(selectedIds), type: 'Hold',recId: c.get("v.recordId")}, function(r){
                if(r.Error != null || r.Error != undefined){
                    h.warning({ message: (r.Error.errorMsg) });
                    return false;      
                } else {
                    c.set('v.prodRec.invPositionWrappList', r.records.invPositionWrappList);
                    c.set('v.inventoryList',r.records.invPositionWrappList);
                    
                    $A.get('e.force:refreshView').fire();
                }   
            });    
        } else {
            h.warning({ message: ('Please select the items.') });
            return false;    
        }
        
        
    },
    
    unHoldIPs : function(c, e, h) {
        var selectedIds = new Array();
        if(c.get('v.inventoryList').length != 1){
            for(var cmp in c.find("checkbx")){
                
                if(c.find("checkbx")[cmp].get("v.checked")){
                    selectedIds.push(c.find("checkbx")[cmp].get("v.value"));
                }
            }
        }else{
            selectedIds.push(c.find("checkbx").get("v.value"));
        }
        if(selectedIds.length > 0){
            selectedIds.join(','); 
            h.request(c, 'holdUnHoldIps', {selectedIds1: JSON.stringify(selectedIds), type: 'UnHold',recId: c.get("v.recordId")}, function(r){
                if(r.Error != null || r.Error != undefined){
                    h.warning({ message: (r.Error.errorMsg) });
                    return false;      
                } else {
                    c.set('v.prodRec.invPositionWrappList', r.records.invPositionWrappList);
                    c.set('v.inventoryList',r.records.invPositionWrappList);
                    $A.get('e.force:refreshView').fire();
                }   
            });    
        } else {
            h.warning({ message: ('Please select the items.') });
            return false;    
        }  
    },
    handleOpenModalQR: function(component, event, helper) {
        component.set("v.isOpenprintQR", true);
    },
    
    handleCloseModalQR: function(component, event, helper) {
        component.set("v.isOpenprintQR", false);
        $A.get('e.force:refreshView').fire();
        component.set('v.imagetext',null);
    },
    handleOpenModal: function(component, event, helper) {
        component.set("v.isOpenprint", true);
    },
    
    handleCloseModal: function(component, event, helper) {
        component.set("v.isOpenprint", false);
        $A.get('e.force:refreshView').fire();
        component.set('v.imagetext',null);
    },
    
    updatePreviewQR : function(c, e, h) {
        var selectedPrinterprinters = c.get('v.printers.selectedPrinter');
        if(!selectedPrinterprinters || selectedPrinterprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        debugger;
        c.set("v.prodRec.selectedDymoLabelLayout",'2 X 4'  );
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        
        
        h.request(c, 'generateImageXmlQR', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout :c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
            try{
                var selectedRec = c.get('v.prodRec.invPositionWrappList');
                var inputCheckBoxSelected=false;
                for(var i=0; i<selectedRec.length; i++){
                    if(selectedRec[i].isSelected){
                        inputCheckBoxSelected = true;
                    }   
                    
                }
                if(inputCheckBoxSelected){
                    var label = dymo.label.framework.openLabelXml(c.get('v.prodRec.imageXml'));
                    var pngData = label.render();
                    c.set('v.imagetext', "data:image/png;base64," + pngData);
                }
                else {
                    h.warning({ message: ('Please select Inventory Position record to generate QR label') });
                }
                
            }
            catch(e){
                
            }     
            
        });
    },
    printLabelQR : function(c, e, h) {
        e.preventDefault();
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        var selecteDymoprinters = c.get('v.printers.selectedPrinter');
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        //  for(integer i=0;i<2;i++){
        
        //  }
        if(!selecteDymoprinters || selecteDymoprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        c.set("v.prodRec.selectedDymoLabelLayout",'2 X 4'  );
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        if(c.get("v.prodRec.isSelectedInventory") == false){
            
            h.warning({ message: ('Please select Inventory Position record to generate QR label')});
        }
        
        h.request(c, 'generateImageXmlQR', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory"),dymoPrinters:c.get("v.printers.selectedPrinter")  }, function(r){
            c.set('v.prodRec', r.records);
            
            try{
                var inventoryRecords = JSON.parse(c.get("v.prodRec.inventoryInfo")); 
                
                for(var i=0; i<inventoryRecords.length; i++){
                    var label = dymo.label.framework.openLabelXml(inventoryRecords[i].replace(/\\/g, ""));
                    
                    label.print(selecteDymoprinters);
                }
            }
            catch(e){
                
            }
        });	
        
        h.request(c, 'inventoryDetails', {recId: c.get("v.recordId"), srchPageRender2: 'true'}, function(r){
            c.set('v.prodRec.invPosSectionRender',true);
            c.set('v.prodRec.prod',r.records.prod);
            var table = $('table.dataTable').DataTable();
            if(table) table.destroy();
            window.setTimeout($A.getCallback(function(){
            }),100)
            
            
        });
        
        
    },
    
    
    updatePreview : function(c, e, h) {
        var selectedPrinterprinters = c.get('v.printers.selectedPrinter');
        if(!selectedPrinterprinters || selectedPrinterprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        debugger;
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        var noOfCopy = c.get("v.noofcopies");
        if(noOfCopy == undefined ||  noOfCopy ==""){
            h.warning({ message: ('Please select Print Qty') });
            return false;    
        }
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
            try{
                var selectedRec = c.get('v.prodRec.invPositionWrappList');
                var inputCheckBoxSelected=false;
                for(var i=0; i<selectedRec.length; i++){
                    if(selectedRec[i].isSelected){
                        inputCheckBoxSelected = true;
                    }   
                    
                }
                if(inputCheckBoxSelected){
                    var label = dymo.label.framework.openLabelXml(c.get('v.prodRec.imageXml'));
                    var pngData = label.render();
                    c.set('v.imagetext', "data:image/png;base64," + pngData);
                }
                else {
                    h.warning({ message: ('Please select Inventory Position record to print label') });
                }
                
            }
            catch(e){
                
            } 
            
        });
        
        h.request(c, 'inventoryDetails', {recId: c.get("v.recordId"), srchPageRender2: 'true'}, function(r){
            c.set('v.prodRec.invPosSectionRender',true);
            c.set('v.prodRec.prod',r.records.prod);
            var table = $('table.dataTable').DataTable();
            if(table) table.destroy();
            window.setTimeout($A.getCallback(function(){
            }),100)
            
            
        });
        
        
    },
    printLabel : function(c, e, h) {
        e.preventDefault();
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        var selecteDymoprinters = c.get('v.printers.selectedPrinter');
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        var noOfCopy = c.get("v.noofcopies");
        if(noOfCopy == undefined ||  noOfCopy ==""){
            h.warning({ message: ('Please select Print Qty') });
            return false;    
        }
        
        
        if(!selecteDymoprinters || selecteDymoprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        if(c.get("v.prodRec.isSelectedInventory") == false){
            
            h.warning({ message: ('Please select Inventory Position record to print label')});
        }
        
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory"),dymoPrinters:c.get("v.printers.selectedPrinter")  }, function(r){
            c.set('v.prodRec', r.records);
            
            try{
                
                var inventoryRecords = JSON.parse(c.get("v.prodRec.inventoryInfo")); 
                var noOfCopy = c.get("v.noofcopies");
                for(var i=0; i<inventoryRecords.length; i++){
                    for(var j=0; j<noOfCopy; j++){
                        
                        var label = dymo.label.framework.openLabelXml(inventoryRecords[i].replace(/\\/g, ""));
                        label.print(selecteDymoprinters);
                    }
                }
            }
            catch(e){
                
            }
        });	
        
        h.request(c, 'inventoryDetails', {recId: c.get("v.recordId"), srchPageRender2: 'true'}, function(r){
            c.set('v.prodRec.invPosSectionRender',true);
            c.set('v.prodRec.prod',r.records.prod);
            var table = $('table.dataTable').DataTable();
            if(table) table.destroy();
            window.setTimeout($A.getCallback(function(){
            }),100)
            
            
        });
        
        
    },
    
    
})