({
    onCancelPickLines: function(c,isCancelWMFeeOnly,h){
		var checkVal = c.get('v.pickLines');
        var isAllow = false;
        for(var i =0 ; i< checkVal.length; i++){
            if(checkVal[i].isSelect){
                isAllow = true;    
                break;
            }
        }
        
        if(isAllow){
            h.request(c, 'saveLineItems', {listToSaveString: JSON.stringify(c.get('v.pickLines')),isIncludeServiceInvoices : isCancelWMFeeOnly}, function(r){
                try{
                 h.success({ message: ('Picklist Line Items cancelled successfully. ') });  
                var url = window.location.href; 
                var value = url.substr(0,url.lastIndexOf('/') + 1);
                window.history.back();
                setTimeout(
                    $A.getCallback(function() {
                      window.location.reload();
                    }), 3000
                );
                } catch(ex){
                    console.log(ex);
                }
            });    
        } 
	}
})