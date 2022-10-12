({
	applyDataTable : function(c,e) {
        try{
         
                window.setTimeout($A.getCallback(function(){
                    dymo.label.framework.init(function(){

                        var printers = dymo.label.framework.getPrinters();
                        var dymos = [];
                        printers.forEach((item) => {
                            console.log(JSON.stringify(item));
                            if (item.printerType == "LabelWriterPrinter"){
                                dymos.push({label:item.name,value:item.name});
                            }
                        })
                        
                        c.set('v.printers',dymos);
                    });
                }),100)
          
        }catch(error){
            console.log('Error in applying datatable:',error);
        }
	}
})