({
	handleValues : function(component,selectedRecord,h){
        var selectRecConId = component.get('v.selectRecConId');
        console.log('Callling Done...',selectRecConId);
        if(selectRecConId != undefined){
            var Invoice = component.get('v.Invoice');
            if(selectedRecord.value == undefined){
                Invoice.Receiver_Contact__c = '';    
            } else {
                var email = component.find("email"); 
                var phone = component.find("phone");
                h.request(component, 'getInvoiceReceiverContact', {'recordId':selectedRecord.value}, function (r) {
                    Invoice.Receiver_Contact__c = selectedRecord.value;
                    console.log('email : ',Invoice.Receiver_Contact__c);
                    console.log('email : ',selectedRecord.value);
                    if(r.ReceiverCon.Email != undefined){
                        email.set("v.value",r.ReceiverCon.Email);
                    }else{
                        email.set("v.value",'');
                    }
                    if(r.ReceiverCon.Phone != undefined){
                        phone.set("v.value",r.ReceiverCon.Phone);
                    }else{
                        phone.set("v.value",'');
                    }
                    
                    
                });
                
            } 
        } else {
            window.setTimeout($A.getCallback(function(){
                h.handleValues(component,selectedRecord,h);
                console.log('Callling...');
            }),100);
        }   
    },
})