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
            
            var invoiceId = addressableContext.attributes.recordId
            var addParameter = pageReference.state.additionalParams;   
                
            }
            var recordTypeId = c.get("v.pageReference").state.recordTypeId;
console.log('recordTypeId>>>'+recordTypeId);
            var evt = $A.get("e.force:navigateToComponent");
            evt.setParams({
                componentDef : "c:receivePaymentEditOverride",
                componentAttributes: {
                    recordId : c.get("v.recordId"),
                    additionalParam : addParameter,
                    recordTypeId :recordTypeId,
                    invoiceId:invoiceId
                    
                }
            });
            evt.fire();
        }catch(error){
            console.log('Error:',error);
        }
    }
})