({
	onInit : function(c, e, h) {
        
        c.set('v.perPage',10);
        sessionStorage.setItem('newProductRequestId', '');
        h.request(
			c,
			'getCategories',{ },
			function (r) {
				console.log('newProductRequestInit::', r);
                
                const userAgent = navigator.userAgent.toLowerCase();
				const isTablet = /(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent);
				console.log('isTablet = ',isTablet)
                c.set('v.productFamiliesAll',r.categories);
                if(isTablet){
                    var productFamilies = r.categories.slice(0, 3);
                    c.set('v.productFamilies', productFamilies);
                    c.set('v.groupedFamilies', r.categories.slice(3, r.categories.length));
                } else {
                    var productFamilies = r.categories.slice(0, 6);
                    c.set('v.productFamilies', productFamilies);
                    c.set('v.groupedFamilies', r.categories.slice(6, r.categories.length));
                }
			},
			{ storable: false }
		);
        
        var filters = { orderByField: 'CreatedDate', isASC: false };
        c.set('v.filters', filters);
        h.getIds(c, filters);
	},
    onCategorySelect: function (c, e, h) {
        var category = e.getSource().get("v.label");
        var family = e.getSource().get("v.value");
        c.set('v.selectedStatus',category);
        console.log('category:',category,'==>family:',family);
        var filters = c.get('v.filters');
        filters['families'] = family;
        c.set('v.filters',filters);
        h.getIds(c, filters);
    },
    onGroupCategorySelect: function (c, e, h) {
        console.log('json data',e.getParam("value"));
        var details = e.getParam("value").split('|');		
        var family = details[0];
        var category = details[1];
        console.log('family:',family);
        c.set('v.selectedStatus',category);
        var filters =  c.get('v.filters');
        filters['families'] = family;
        c.set('v.filters',filters);
        h.getIds(c, filters);
    },
    onScriptsLoaded: function (c, e, h) {
        //h.initScroller(c);
    },
    validateKeys: function (c, e, h) {
        if(e.keyCode == 13){
            e.preventDefault();
            return false;
        }
    },
    onSearchProducts: function (c, e, h) {
        var searchRec = c.find('searchRec');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            //searchTerm = c.find('searchRec').get('v.value');
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            //h.reset(c);
            h.getIds(c, filters);
        }),100);
    },
    fetchNewProductRequests: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onEdit: function (c, e, h) {
        var recordId = e.getSource().get('v.value');
        var ticketnumber = e.getSource().get('v.alternativeText');
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        sessionStorage.setItem('newProductRequestId', recordId);
        sessionStorage.setItem('isViewProductRequest',false);
        h.redirect('/newproduct', true);
    },
    onDuplicate: function (c, e, h) {
        var recordId = e.getSource().get('v.value');
         sessionStorage.setItem('isViewProductRequest',false);
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'Create New Product';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
                }
                }
        }),100);
                    sessionStorage.setItem('newProductRequestId', recordId);
        sessionStorage.setItem('isCloneProduct', 'True');
        h.redirect('/newproduct', true);
    },
    onView: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        var ticketnumber = e.currentTarget.dataset.name;
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        sessionStorage.setItem('newProductRequestId', recordId);
        sessionStorage.setItem('isViewProductRequest',true);
        h.redirect('/newproduct', true);
    },
    onCancel: function(c, e, h) {
        h.redirect('/cases', true);
    },
    onNewProduct: function(c, e, h) {
        sessionStorage.setItem('isViewProductRequest',false);
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = 'Create New Product';
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
                }
                }
        }),100);
        h.redirect('/newproduct', true);
    },
    onSortOrders: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters = { orderByField: sortfield, isASC: (!filters.isASC) };
        } else {
            filters = { orderByField: sortfield, isASC: true };
        }
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    },
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        console.log('selectedFormat:',selectedFormat);
        if(selectedFormat == 'csv'){
            h.getRecordsForFile(c);
        }else if(selectedFormat == 'pdf'){
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/product-list','/apex/printProducts?filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    }
})