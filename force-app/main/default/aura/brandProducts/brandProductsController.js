({
	onInit : function(c, e, h) {
		var filters = { orderByField: 'Product2.Brand_Name__c', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);	
	},
    fetchBrandProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    sortProducts: function (c, e, h) {
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
    onViewBrand:function(c,e,h){
		var brandId = e.target.dataset.id;
        sessionStorage.setItem('brandId', brandId);
        h.redirect('/brand', true);
    },
    onProductDetail :function(c,e,h){
        var priceId = e.target.dataset.id;  
        sessionStorage.setItem('pricebookEntry', priceId);
        sessionStorage.setItem('fromBrandProduct', c.get('v.isBrand'));
        var productName = e.target.dataset.name;  
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+productName;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        h.redirect('/product', true);
    }
})