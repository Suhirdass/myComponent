({
	doInit : function(c, e, h) {
        
		h.request(c, 'inventoryDetails', {recId: c.get("v.recordId")}, function(r){
            console.log('init:',r.records);
        	c.set('v.prodRec', r.records);
            c.set('v.isDataLoaded',true);
        });	
	},
    onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    updatePreview : function(c, e, h) {
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        console.log('selectedPrinter::',selectedPrinter);
        if(!selectedPrinter || selectedPrinter == ''){
            Swal.fire({
                title: 'Please Select the Printer',
                text: 'Please Select the Printer',
                type: '',
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Ok'
            }).then((result) => {
                
            });
            //h.warning({ message: ('Please Select the Printer')});
            return false;
        }
        console.log('Hello = ',c.get('v.prodRec.selectedDymoLabelLayout'));
        if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
            Swal.fire({
                title: 'Please Select the layout',
                text: 'Please Select the layout',
                type: '',
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Ok'
            }).then((result) => {
                
            });
            //h.warning({ message: ('Please Select the layout') });
            return false;
        }
        
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
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
                Swal.fire({
                    title: 'Please Select inventory position to print',
                    text: 'Please Select inventory position to print',
                    type: '',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Ok'
                }).then((result) => {
                    
                });
                //h.warning({ message: ('Please Select inventory position to print') });
                //return false;
            }
        });
    },
    
    printLabel : function(c, e, h) {
    	var selectedPrinter = c.get('v.prodRec.selectedPrinter');
        
        var JSONStrP = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        if(selectedPrinter == ''){
            Swal.fire({
                title: 'Please Select the Printer',
                text: 'Please Select the Printer',
                type: '',
                showCancelButton: false,
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Ok'
            }).then((result) => {
                
            });
            //h.warning({ message: ('Please Select the Printer')});
            return false;
        }
        if(c.get("v.prodRec.selectedDymoLabelLayout") == 'Select Layout'){
                Swal.fire({
                    title: 'Please Select the layout',
                    text: 'Please Select the layout',
                    type: '',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Ok'
                }).then((result) => {
                    
                });
                //h.warning({ message: ('Please Select the layout')});
                return false;
            }
            if(c.get("v.prodRec.isSelectedInventory") == false){
                Swal.fire({
                    title: 'Please Select inventory position to print',
                    text: 'Please Select inventory position to print',
                    type: '',
                    showCancelButton: false,
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'Ok'
                }).then((result) => {
                    
                });
                //h.warning({ message: ('Please Select inventory position to print')});
                return false;
            }
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            c.set('v.prodRec', r.records);
            
            
            try{
                var inventoryRecords = JSON.parse(c.get("v.prodRec.inventoryInfo"));
                console.log(inventoryRecords.length);
                for(var i=0; i<inventoryRecords.length; i++){
                    var label = dymo.label.framework.openLabelXml(inventoryRecords[i].replace(/\\/g, ""));
                    label.print(selectedPrinter);
                }
            }
            catch(e){
                console.log(e.message);
            }
        });	
    },
    
    redirectItemDetail : function(c, e, h) {
        var eUrl= $A.get("e.force:navigateToURL");
        eUrl.setParams({
            "url": '/'+ c.get("v.recordId")
        });
        eUrl.fire();
    },
    
    changeStr : function(c, e, h) {
     	var JSONStr = JSON.stringify(c.get("v.prodRec.invPositionWrappList"));
        h.request(c, 'fetchFilterProducts', {str: c.get('v.searchStr'), JSONStr1: JSONStr, recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.invPositionWrappList', r.records);
        });   
    },
})