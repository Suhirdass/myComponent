({
	doInit : function(c, e, h) {
        
		h.request(c, 'smDetails', {recId: c.get("v.recordId")}, function(r){
            console.log('init:',r.records);
        	c.set('v.prodRec', r.records);
            c.set('v.isDataLoaded',true);
             // c.set(' v.prodRec.selectedDymoLabelLayout','4 X 6');
           
          
        });	
	},
    onScriptsLoaded : function(c, e, h) {
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
    },
    
	updatePreview : function(c, e, h) {
        var selectedPrinter = c.get('v.prodRec.selectedPrinter');
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
        debugger;
        h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedInventory :c.get("v.prodRec.isSelectedInventory")  }, function(r){
            debugger;  
            c.set('v.prodRec', r.records);
            var selectedRec = c.get('v.prodRec.SMWrapperList[0].SMPos');
             var Rec = c.get('v.prodRec.SMPos');
            var totalrecordtemp =c.get("v.prodRec.imageXml");
              var lstoflabel = [];
              lstoflabel= totalrecordtemp.split('%endslabel%');
             console.log(lstoflabel);
         if(lstoflabel.length>0 && totalrecordtemp !="" && totalrecordtemp !=undefined && totalrecordtemp !=null )
            {
            var label = dymo.label.framework.openLabelXml(lstoflabel[0]);
            var pngData = label.render();
            c.set('v.imagetext', "data:image/png;base64," + pngData);
            
           }
           else
           {
            h.warning({ message: ('Please Add Shipment Manifest Line ') });
            return false;    
           }
        });
                 

    },
    
    printLabel : function(c, e, h) {
    	var selectedPrinter = c.get('v.prodRec.selectedPrinter');
         var selecteDymoprinters = c.get('v.printers.selectedPrinter');
        var JSONStrP = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
          console.log(JSONStrP);
         if(!selecteDymoprinters || selecteDymoprinters == ''){
            h.warning({ message: ('Please select DYMO printer')});
            return false;
        } 
          if(c.get("v.prodRec.selectedDymoLabelLayout") == ''){
           
           h.warning({ message: ('Please select DYMO label') });
            return false;
        }
        
        	h.request(c, 'generateImageXml', {recId: c.get("v.recordId"),wrpJson : JSONStrP,layout : c.get("v.prodRec.selectedDymoLabelLayout"),imageXml :c.get("v.prodRec.imageXml"),isSelectedSM :c.get("v.prodRec.isSelectedSM")  }, function(r){
            var test = r.records;
            c.set('v.prodRec', r.records);
            try{
                  var totalrecordtempprint =c.get("v.prodRec.imageXml");
                 var lstoflabelprint = [];
                lstoflabelprint= totalrecordtempprint.split('%endslabel%');
                 console.log(lstoflabelprint);
                var inventoryRecords = JSON.parse(c.get("v.prodRec.smInfo"));
                console.log(lstoflabelprint.length);
                for(var i=0; i<lstoflabelprint.length; i++){
                    var label = dymo.label.framework.openLabelXml(lstoflabelprint[i].replace(/\\/g, ""));
                    label.print(selecteDymoprinters);
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
     	var JSONStr = JSON.stringify(c.get("v.prodRec.SMWrapperList"));
        h.request(c, 'fetchFilterProducts', {str: c.get('v.searchStr'), JSONStr1: JSONStr, recId: c.get("v.recordId")}, function(r){
            c.set('v.prodRec.SMWrapperList', r.records);
        });   
    },
   

})