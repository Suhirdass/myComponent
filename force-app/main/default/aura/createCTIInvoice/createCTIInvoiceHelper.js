({
    getRecords : function(c,idx) {
        var h = this;
        h.request(c, 'SplitCTIByProducerName', {recordId: idx}, function(r){
            c.set('v.oppItems', r.records);
            c.set('v.oppt', r.SOName);
            c.set('v.finalList', r.finalList);
           
            c.set('v.hasLines', r.hasLines);
          console.log(' r.records', r.records);
            console.log(' r.SOName', r.SOName);
            console.log(' r.finalList', r.finalList);
            console.log(' r.records', r.records);
        }); 
    },     
    createRecords : function(c,e) {
       // var recTypeVal = c.get('v.isMulti');
        var h = this;
        h.request(c, 'createQuoteRec', {oppRec: c.get('v.oppt'),wrp: c.get('v.oppItems')}, function(r){
            try{
                console.log('Response:',r);
                var hasError = false;
               
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