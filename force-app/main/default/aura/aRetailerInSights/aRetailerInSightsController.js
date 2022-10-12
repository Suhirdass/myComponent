({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'CreatedDate', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
        
	},
    fetchinSights: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onContactClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
    sortInSights: function (c, e, h) {
        var sortfield = e.currentTarget.dataset.field;
        //console.log('---enter---'+sortfield);
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
    onNewInsight: function (c, e, h) {
        $A.createComponent('c:customerInsight', {lineCardId: c.get('v.lineCardId'), retailerId: c.get('v.retailerId'), isRetailer:true}, function (content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button slds-modal_medium'
                });
            }
        });
	},
    onEdit : function (c, e, h) {
        //alert('Hello');
        var insight = e.getSource().get('v.value');
        var insightDate;
        
        $A.createComponent('c:customerInsight', {lineCardId: c.get('v.lineCardId'),retailerId: c.get('v.retailerId'),customerInsight : insight,isRetailer:true,isUpdate:true}, function(content, status) {
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