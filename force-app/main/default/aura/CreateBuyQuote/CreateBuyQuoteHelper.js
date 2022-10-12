({
    getRecords : function(c,idx) {
        var h = this;
        h.request(c, 'splitBQByProducerName', {recordId: idx}, function(r){
            c.set('v.oppItems', r.records);
            c.set('v.serviceTicket', r.serviceTicket);
            console.log('r.records',r.records);
            c.set('v.oppt', r.oppName);
            c.set('v.finalList', r.finalList);
            console.log('r.finalList',r.finalList);
            c.set('v.hasLines', r.hasLines);
            if(r.OrderRetailerContactError)
                h.warning({message:r.OrderRetailerContactErrorMsg});
            if(r.OrderStateLicenseError)
                h.warning({message:r.OrderStateLicenseErrorMsg});
            if(r.STBrandContactError)
                h.warning({message:r.STBrandContactErrorMsg});
            if(r.STStateLicenseError)
                h.warning({message:r.STStateLicenseErrorMsg});
            
        }); 
    },
    
    createRecords : function(c,e) {
        var recTypeVal = c.get('v.isMulti');
        var h = this;
        
        h.request(c, 'createQuoteRec', {oppRec: c.get('v.oppt'),wrp: c.get('v.oppItems'),multi: c.get('v.isMulti'),type : c.get('v.type')}, function(r){
            c.set('v.Error', r.Error);
            try{
                if(r.hasError){
                	if(r.OrderRetailerContactError)
                        h.error({message:r.OrderRetailerContactErrorMsg});
                    if(r.OrderStateLicenseError)
                        h.error({message:r.OrderStateLicenseErrorMsg});
                    if(r.STBrandContactError)
                        h.error({message:r.STBrandContactErrorMsg});
                    if(r.STStateLicenseError)
                        h.error({message:r.STStateLicenseErrorMsg});    
                }else{
                	if(r.Error)
                        h.error({ message: r.Error });        
                    else
                        window.location.href = '/' + r.redirectId ;   
                }                                  
            } catch(ex){
                console.log('Exception '+ex);
            }
        });
    },
})