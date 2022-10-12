({
    onView : function(c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        h.navigateToRecord(c,recordId,'detail');
    },
    validateKeys: function (c, e, h) {
        if(e.keyCode == 69){
            e.preventDefault();
			return false;
        }
    },
	searchInvoice : function(c, e, h) {
        window.setTimeout($A.getCallback(function(){
            c.set("v.loaded",true); 
            var searchInput = c.find('searchInput');
            var searchText = searchInput.getElement().value;
            console.log('searchText::',searchText);
            var action = c.get("c.fatchInvoice");
            action.setParams({ 
                "searchText" : searchText
            });
            action.setCallback(this, function(response) {
                c.set("v.loaded",false);
                var state = response.getState();
                console.log('Invoice List:',response.getReturnValue());
                c.set("v.invoiceList",response.getReturnValue());  
                
            });
            $A.enqueueAction(action);
        }),900);
        
	},
    submitInvoices : function(c, e, h) {
        var validateFields = c.find('validate');
        var isValid = true;
        if (validateFields) {
            isValid = [].concat(validateFields).reduce(function (validSoFar, input) {
                var allValid = true;
                if(input){
                    input.showHelpMessageIfInvalid();
                    var validity = input.get('v.validity');
                    if(validity)
                        allValid = validity.valid;
                }
                return validSoFar && allValid;
            }, true);
        }
        if(!isValid)
            return false;
        c.set("v.loaded",true); 
        var searchInput = c.find('searchInput');
        var searchText = searchInput.getElement().value;
        var invoiceList = c.get("v.invoiceList");
        console.log("jsonString:",jsonString);
        var jsonString = h.replaceAll(JSON.stringify(invoiceList),',"taxAmount":""','')
        jsonString = h.replaceAll(JSON.stringify(invoiceList),',"productAmount":""','')
        console.log("jsonString:",jsonString);
        var action = c.get("c.updateInvoices");
            action.setParams({ 
                "invoiceJSON" : jsonString,
                "searchText":searchText
            });
            action.setCallback(this, function(response) {
                c.set("v.loaded",false);
                var state = response.getState();
                if(state == 'SUCCESS'){
                    var r = response.getReturnValue();
                    console.log('updateInvoices:',r); 
                    if(r.error){
                        for(var i=0;i<r.error.length;i++){
                            h.error({'message':r.error[i]});
                        }
                        
                    }else if(r.warning){
                        h.warning({'message':r.warning});
                    }else{
                        h.success({'message':r.success});
                        c.set('v.invoiceList',r.invoices);
                        $A.get('e.force:refreshView').fire();
                    }
                }else{
                    h.error({'message':'Some error occured'});
                }
                
                
            });
            $A.enqueueAction(action);
        
    }
})