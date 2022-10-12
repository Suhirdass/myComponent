({
    init : function(c,e,h){
        h.request(c, 'createRecord', {recordId: c.get("v.recordId")}, function(r){
            if(r.showpopup == true){
                c.set('v.showpopup',r.showpopup);
                c.set('v.rlIds',r.alreadyQAIds);
                c.set('v.Confirmation_for_QA_Record',r.Confirmation_for_QA_Record);
            }else{
                h.navigateToRecord(c, c.get('v.recordId'));
            }
        });
       
    },
    handleConfirmDialogNo : function(c, e, h) {
       c.set('v.showpopup',false);
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    handleConfirmDialogYes : function(c, e, h) {
       h.request(c, 'createNewRecord', {recordIds: c.get('v.rlIds')}, function(r){
           	c.set('v.showpopup',false);
             h.navigateToRecord(c, c.get('v.recordId'));
        });
    },
})