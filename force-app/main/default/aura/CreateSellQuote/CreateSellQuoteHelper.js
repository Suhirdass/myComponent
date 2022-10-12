({
    getRecords : function(c,idx) {
        var h = this;
        h.request(c, 'splitBQByProducerName', {recordId: idx,type : c.get('v.type')}, function(r){
            c.set('v.oppItems', r.records);
            c.set('v.oppt', r.oppName);
            c.set('v.finalList', r.finalList);
            c.set('v.serviceTicket', r.serviceTicket);
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
            try{
                console.log('Response:',r);
                var hasError = false;
                if(r.OrderRetailerContactError){
                    hasError = true;
                    h.warning({message:r.OrderRetailerContactErrorMsg});
                }
                if(r.OrderStateLicenseError){
                    hasError = true;
                    h.warning({message:r.OrderStateLicenseErrorMsg});
                }
                if(r.STBrandContactError){
                    hasError = true;
                    h.warning({message:r.STBrandContactErrorMsg});
                }
                if(r.STStateLicenseError){
                    hasError = true;
                    h.warning({message:r.STStateLicenseErrorMsg});
                }
                if(r.Error){
                    h.error({message:r.Error});
                }else if(!hasError){
                    h.navigateToRecord(c, r.redirectId,'detail')
                }
                //window.location.href = '/' + r.redirectId ; 
            } catch(ex){
                console.log('Exception '+ex);
            }
        });
    },
    
})