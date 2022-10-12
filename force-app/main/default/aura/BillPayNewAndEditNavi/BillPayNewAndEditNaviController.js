({
	 navigate : function(c, e, h) {
        try{
            
            var pageReference = c.get("v.pageReference"); 
            var base64Context = pageReference.state.inContextOfRef;	
            if(base64Context !=undefined)
            {
               if (base64Context.startsWith("1\.")) {	            
                base64Context = base64Context.substring(2);	            
            }	        
            var addressableContext = JSON.parse(window.atob(base64Context));	        
            
            var SupplierId = addressableContext.attributes.recordId;
                console.log('SupplierId>>>',SupplierId);
            var addParameter = pageReference.state.additionalParams;   
                
            }
                console.log('SupplierId>>>',c.get("v.recordId"));
           var evt = $A.get("e.force:navigateToComponent");
            evt.setParams({
                componentDef : "c:BillPayNewAndEdit",
                componentAttributes: {
                   recordId : c.get("v.recordId"),
                    additionalParam : addParameter,
                    SupplierId:SupplierId
                    
                }
            });
            evt.fire();
        }catch(error){
            console.log('Error:',error);
        }
    }
})