({
	doInit :function(c, e, h) {
        h.request(c, 'checkSOStatus', { recordId: c.get('v.recordId') }, function (r) {
            c.set('v.SO',r.SO);
            c.set('v.isAllocatedLineItemsToolTip', r.isAllocatedLineItemsToolTip);
            if(r.error){
                h.error({message:r.error});
                $A.get("e.force:closeQuickAction").fire();
            }else if(r.success){
                if(r.changeFee){
                    c.set('v.changeFee',r.changeFee);
                }
                c.set('v.versionNumber',r.version);
                c.set('v.SO_NO_LINES_MODIFIED_FOR_REVISION',r.SO_NO_LINES_MODIFIED_FOR_REVISION);
                c.set('v.SO_ORDER_REVISION_PRICE_MESSAGE',r.SO_ORDER_REVISION_PRICE_MESSAGE);
                c.set('v.showAlert',true);
                c.set('v.SOLIVersionMap',r.SOLIVersionMap);
            }
        });
    },
    onRevisionYes :function(c, e, h) {
        h.navigateToComponent('c:revisionSODetails',{changeFee:c.get('v.changeFee'),SO:c.get('v.SO'),recordId:c.get('v.recordId'),versionNumber:c.get('v.versionNumber'),SOLIVersionMap:c.get('v.SOLIVersionMap'),SO_NO_LINES_MODIFIED_FOR_REVISION:c.get('v.SO_NO_LINES_MODIFIED_FOR_REVISION'),SO_ORDER_REVISION_PRICE_MESSAGE:c.get('v.SO_ORDER_REVISION_PRICE_MESSAGE'),isAllocatedLineItemsToolTip:c.get('v.isAllocatedLineItemsToolTip')},true);
    },
    onCancel : function(c,e,h){
        $A.get("e.force:closeQuickAction").fire();
    }
})