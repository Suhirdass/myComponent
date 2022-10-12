({
    doInit : function(c, e, h) {
        h.request(c,'getRecordDetails',{ recordId: c.get('v.recordId')}, function (r) {
            if(r.Error){
                h.error({message:r.Error});
            }else{
                c.set('v.record', r.record);
                c.set('v.hasFactoringDetails',r.hasFactoringDetails);
            }
        })
    },
    onCreateServiceInvoice : function(c, e, h) {
        const hasFactoringDetails = c.get('v.hasFactoringDetails');
        if(!hasFactoringDetails){
            h.error({message: 'Cannot create Service Invoice if Factoring Assignee, Factoring Contact and Factoring Rate are blank.'});
            $A.get("e.force:closeQuickAction").fire();
        }else{
            h.request(c, 'createFactoringServiceInvoice', { recordId: c.get('v.recordId') }, function (r) {
                if(r.invoiceId){
                    h.navigateToRecord(c,r.invoiceId,'detail');
                    $A.get("e.force:closeQuickAction").fire();
                }
            });  
        }
         
    },
    onCancel : function(c, e, h) {
        $A.get("e.force:closeQuickAction").fire();
    }
})