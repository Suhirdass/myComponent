({
	applyDataTable : function(c,e) {
        try{
            console.log('applyDataTable..');
            console.log('Data Table:',$('table.mydataTable'));
            var h = this;
            var isDataLoaded = c.get('v.isDataLoaded');
            if(isDataLoaded){
                console.log('Applying data table');
                var table = $('table.mydataTable').DataTable();
                console.log('Hello - ',table);
                if(table) {
                	table.destroy();
                }
                $('table.mydataTable').dataTable({
        				dom: '<"pull-left"f><"pull-right"l>tip',
                    sPaginationType: "full_numbers",
                    scroller:true,
                    order:[[1,"asc"]],
                     columnDefs:[{
                        targets:[0],
                        orderable:false
                    }]
                    
                });//"lengthMenu": [[5, 25, 50, 100], [5, 25, 50, 100]]
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