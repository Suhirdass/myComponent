({
    doInit : function(c, e, h) {
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec', r.records);
            c.set('v.isDataLoaded',true);
            
        });	
    },
    onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    
    
    handleCloseModal: function(c, e, h) {
        var selectedPrinters= c.get('v.printers.selectedPrinter');
        c.set("v.isOpenprint", false);
                c.set("v.isOpenprintbox", false);

        c.set('v.printers.selectedPrinter',selectedPrinters);    
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMrecords', r.records.SMrecords);
        });	
        
    },
    
   PrintbtPreview : function(c, e, h) {
        var selectedPrinters= c.get('v.printers.selectedPrinter');
        if(!selectedPrinters || selectedPrinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        var JSONStrP = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
    
        h.request(c, 'generateImageXmlDynamicBoxCount', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
            var selectedRec = c.get('v.prodRec.SMWrapperList');
            var inputCheckBoxSelected=false;
            for(var i=0; i<selectedRec.length; i++){
                if(selectedRec[i].isSelected){
                    inputCheckBoxSelected = true;
                }    
            }
            if(inputCheckBoxSelected == false &&  c.get("v.prodRec.selectedDymoLabelLayout") =='4 X 6'){
                
                h.warning({ message: ('Please select Shipment Manifest Line  to print label. ') });    
            }
            else
            {
                var selectedRec = c.get('v.prodRec.SMWrapperList[0].SMPos');
                var Rec = c.get('v.prodRec.SMPos');
                var totalrecordtemp =c.get("v.prodRec.imageXml");
                var lstoflabel = [];
                lstoflabel= totalrecordtemp.split('%endslabel%');
                if(lstoflabel.length>0 && totalrecordtemp !="" && totalrecordtemp !=undefined && totalrecordtemp !=null )
                {
                    var label = dymo.label.framework.openLabelXml(lstoflabel[0]);
                    var pngData = label.render();
                    c.set('v.imagetext', "data:image/png;base64," + pngData);
                    c.set('v.printers.selectedPrinter',selectedPrinters);
                    
                }
                
                c.set("v.isOpenprintbox", true);     
            }
        });
        c.set('v.printers.selectedPrinter',selectedPrinters);    
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMrecords', r.records.SMrecords);
        });	
        
    },
     
    
    
    
    
    
    
    PrintAllbtPreview : function(c, e, h) {
        var selectedPrinters= c.get('v.printers.selectedPrinter');
        if(!selectedPrinters || selectedPrinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        var JSONStrP = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
            var selectedRec = c.get('v.prodRec.SMWrapperList');
            var inputCheckBoxSelected=false;
            for(var i=0; i<selectedRec.length; i++){
                if(selectedRec[i].isSelected){
                    inputCheckBoxSelected = true;
                }    
            }
            if( c.get("v.prodRec.selectedDymoLabelLayout") =='4 X 6'){
                
                h.warning({ message: ('Please select Shipment Manifest Line  to print label. ') });    
            }
            else
            {
                var selectedRec = c.get('v.prodRec.SMWrapperList[0].SMPos');
                var Rec = c.get('v.prodRec.SMPos');
                var totalrecordtemp =c.get("v.prodRec.imageXml");
                console.log('totalrecordtemp',totalrecordtemp);
                var lstoflabel = [];
                lstoflabel= totalrecordtemp.split(',');
                console.log('lstoflabel>>',lstoflabel);
                if(lstoflabel.length>0 && totalrecordtemp !="" && totalrecordtemp !=undefined && totalrecordtemp !=null )
                {
                    console.log('inside if>>');
                    var label = dymo.label.framework.openLabelXml(lstoflabel[0]);
                    console.log('inside label>>',label);
                    var pngData = label.render();
                    c.set('v.imagetext', "data:image/png;base64," + pngData);
                    c.set('v.printers.selectedPrinter',selectedPrinters);
                    
                }
                
                c.set("v.isOpenprint", true);     
            }
        });
        c.set('v.printers.selectedPrinter',selectedPrinters);    
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMrecords', r.records.SMrecords);
        });	
        
    },
    
   printLabeldynamic : function(c, e, h) {
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        var selecteDymoprinters = c.get('v.printers.selectedPrinter');
        var JSONStrP = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
        if(!selecteDymoprinters || selecteDymoprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
         var boxcountval= c.find("boxPack").get("v.value");
       if(boxcountval == null || boxcountval == "")
       {
        h.warning({ message: ('Value required to print label.') });
            return false;   
       }
       if(boxcountval > c.get("v.prodRec.SMrecords.Box_Count__c") || c.get("v.prodRec.SMrecords.Box_Count__c") ==undefined ){
         h.warning({ message: ('Value cannot be greater than the Box count value.') });
            return false;   
       }

       
      console.log(c.get("v.prodRec.SMrecords.Box_Count__c"));
        h.request(c, 'printImageXmlDynamicBoxCount', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),boxCount :boxcountval  }, function(r){
   
            var test = r.records;
            c.set('v.prodRec', r.records);
            try{
                var totalrecordtempprint =c.get("v.prodRec.imageXml");
                console.log(totalrecordtempprint);
                
                var lstoflabelprint = [];
                lstoflabelprint= totalrecordtempprint.split('%endslabel%');
                for(var i=0; i<lstoflabelprint.length; i++){
                    var label = dymo.label.framework.openLabelXml(lstoflabelprint[i].replace(/\\/g, ""));
                    label.print(selecteDymoprinters);
                }
                console.log(label);
   
            }
            catch(e){
                console.log(e.message);
            }
        });	
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMrecords', r.records.SMrecords);
        });	
        
    },
     
    
    
    
    
    printLabel : function(c, e, h) {
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        var selecteDymoprinters = c.get('v.printers.selectedPrinter');
        var JSONStrP = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
        if(!selecteDymoprinters || selecteDymoprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            
            h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        
        h.request(c, 'printImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedSM :c.get("v.prodRec.isSelectedSM")  }, function(r){
 
            var test = r.records;
            c.set('v.prodRec', r.records);
            try{
                var totalrecordtempprint =c.get("v.prodRec.imageXml");
                var arr = totalrecordtempprint.split(',');
console.log(arr);
                var lstoflabelprint = [];
                lstoflabelprint= totalrecordtempprint.split(',');
                for(var i=0; i<lstoflabelprint.length; i++){
                    var label = dymo.label.framework.openLabelXml(lstoflabelprint[i].replace(/\\/g, ""));
                    label.print(selecteDymoprinters);
                }
             console.log(label);
   
            }
            catch(e){
                console.log(e.message);
            }
        });	
        h.request(c, 'smLineDetails', {recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMrecords', r.records.SMrecords);
        });	
        
    },
    
    redirectItemDetail : function(c, e, h) {
        var eUrl= $A.get("e.force:navigateToURL");
        eUrl.setParams({
            "url": '/'+ c.get("v.recordId")
        });
        eUrl.fire();
    },
    
    
    // For count the selected checkboxes. 
    checkboxSelect: function(component, event, helper) {
        var selectedRec = event.getSource().get("v.value");
        var getSelectedNumber = component.get("v.selectedCount");
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        component.set("v.selectedCount", getSelectedNumber);
    },
    
    selectAll: function(component, event, helper) {
        var selectedHeaderCheck = event.getSource().get("v.value");
        var getAllId = component.find("boxPack");
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack").set("v.value", true);
                component.set("v.selectedCount", 1);
            }else{
                component.find("boxPack").set("v.value", false);
                component.set("v.selectedCount", 0);
            }
        }else{
            
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", true);
                    component.set("v.selectedCount", getAllId.length);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                    component.set("v.selectedCount", 0);
                }
            } 
        }  
        
    },
})