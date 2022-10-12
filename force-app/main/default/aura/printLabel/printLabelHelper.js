({
	applyDataTable : function(c,e) {
        try{
            console.log('applyDataTable..');
            console.log('Data Table:',$('table.dataTable'));
            var h = this;
            var isDataLoaded = c.get('v.isDataLoaded');
            if(isDataLoaded){
                console.log('Applying data table');
                var table = $('table.dataTable').DataTable();
                if(table) table.destroy();
                $('table.dataTable').dataTable({
                    sPaginationType: "full_numbers",
                    scroller:true,
                    
                });//"lengthMenu": [[5, 25, 50, 100], [5, 25, 50, 100]]
                window.setTimeout($A.getCallback(function(){
                    dymo.label.framework.init(function(){
                        if(dymo.label.framework.init){
                            var printers = dymo.label.framework.getPrinters();
                            console.log('printers:',printers.length);
                            var dymos = [];
                            printers.forEach((item) => {
                                console.log(JSON.stringify(item));
                                if (item.printerType == "LabelWriterPrinter"){
                                        dymos.push({label:item.name,value:item.name});
                                }
                            })
                            
                            c.set('v.printers',dymos);
                		}else{
                              window.setTimeout($A.getCallback(function(){
                                  console.log('Waiting for Dymo Printer Init...');
                                  h.applyDataTable(c,e);
                                }),100)               
                       } 
                    });
                }),100)
            }else{
                window.setTimeout($A.getCallback(function(){
                    h.applyDataTable(c,e);
                }),100)
                
            }
        }catch(error){
            console.log('Error in applying datatable:',error);
        }
	}
})