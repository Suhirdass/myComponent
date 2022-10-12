({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'Name', isASC: true };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
	},
    fetchBrandContacts: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onContactClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
    sortBrandContact: function (c, e, h) {
        var sortfield = e.currentTarget.dataset.field;
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  (!filters.isASC);
        } else {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  true;
        }
        c.set('v.filters', filters);
        h.getIds(c, filters); 
    },
    onNewContact:function(c,e,h){
        
        
        $A.createComponent('c:newContact', {recordTypeId: c.get('v.contactRTId'), accountId:c.get('v.retailerId')}, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button slds-modal_medium'
                });
            }                               
        });
    },
})