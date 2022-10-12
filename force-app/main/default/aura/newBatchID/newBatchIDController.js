({
    onSave : function(c, e, h) {
        if(! c.get('v.isUid')){
            var isValid = h.isValid(c);
            if(isValid){
                h.request(c, 'insertBatchId', {recName: c.get('v.nameBatch'),BrandId : c.get('v.brandId')}, function(r){
                    try{
                        var cmpEvent = $A.get("e.c:batchIdEvent");
                        cmpEvent.setParams( { "selectedRecord" : {value: r.newRec.Id,label: r.newRec.Name}, "selRec": c.get('v.selRecord'),'selectedIndex':c.get('v.selectedIndex')});
                        cmpEvent.fire();
                        c.find('overlay').notifyClose();
                    } catch(exp){
                        console.log('Exp ',exp);
                    }
                },{handleErrors:false,error:function(err){
                    console.log('Error:',JSON.stringify(err));
                    var message = err[0].pageErrors[0].message;
                    console.log(message);
                    const recordId = message.substr(message.indexOf('<a href=')+9,18);
                   	const htmlText = message.substr(message.indexOf(' in record'));
                    let finalText = message.replace(htmlText,'')
                    h.error({message:finalText});
                }});    
            }
        } else if(c.get('v.isUid')){
            var isValid = true;//h.isValid(c);
            var inputCmp = c.find('validate');
            var value = inputCmp.get("v.value");
            if(value.length < 24){
                isValid = false; 
                inputCmp.setCustomValidity("UID must be 24 characters long");
            }else{
                //isValid = true;
                inputCmp.setCustomValidity("");
            }
            console.log('isValid:',isValid);
            inputCmp.reportValidity();
            if(isValid){
                h.request(c, 'insertUId', {recName: c.get('v.nameBatch')}, function(r){
                    try{
                        
                        var cmpEvent = $A.get("e.c:batchIdEvent");
                        cmpEvent.setParams( { "selectedRecord" : {value: r.newRec.Id,label: r.newRec.Name}, "selRec": c.get('v.selRecord'),'selectedIndex':c.get('v.selectedIndex')});
                        cmpEvent.fire();
                        c.find('overlay').notifyClose();
                    } catch(exp){
                        console.log('Exp ',exp);
                    }
                });  
            }
        }
        
    },
    onCancel: function(c, e, h) {
        var cmpEvent = $A.get("e.c:serviceStringEvent");
        cmpEvent.setParams( {"selRec": "blank"});
        cmpEvent.fire();
        c.find('overlay').notifyClose();
    },
})