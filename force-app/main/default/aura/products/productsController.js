({
    onInit: function (c, e, h) {
        var searchTerm = '';
        var brandId = '';
        if (sessionStorage.getItem('initSearch')) {
            sessionStorage.removeItem('initSearch');
            searchTerm = sessionStorage.getItem('searchTerm');
            brandId = sessionStorage.getItem('brandId');
            console.log('brandId::',brandId);
        }
        var filters = { orderByField: 'Product2.Name', isASC: true, brandId: brandId };
        c.set('v.selectedFilter', 'Product2.Name ASC');
        c.set('v.filters', filters);
        h.getIds(c, filters);
        h.getCategories(c);
    },
    onScriptsLoaded: function (c, e, h) {
        try{
            //h.initScroller(c);
        }catch(error){
            //$A.get('e.force:refreshView').fire();
        }
    },
    validateKeys: function (c, e, h) {
        if(e.keyCode == 13){
            e.preventDefault();
            return false;
        }
    },
    onSearchProducts: function (c, e, h) {
        var searchRec = c.find('productSearch');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }),100);
        
        /*window.setTimeout($A.getCallback(function(){
            var searchTerm = c.find('productSearch').get('v.value');
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }),100);*/
        
    },
    
    createShortLink: function (c, e, h) {
        let url = window.location.href;
        var lastslashindex = url.lastIndexOf('/');
        
        url = url.substring(0,lastslashindex)+'/brandproducts?id=';
        
        h.request(c, 'getShortURL', {currentURL : url,brndId : c.get('v.brandId')}, function (r) {
            console.log(r.link);            
            let tempInput = document.createElement("input");
            tempInput.value = r.link;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand("copy");
            document.body.removeChild(tempInput);
            h.success({ message: ('The public URL copied in clipboard') }); 
        }, {storable: true });
    },
    
    handleSearch: function (c, e, h) {
        var searchTerm = e.getParam('searchTerm');
        console.log('handleSearch:',searchTerm);
        var filters = c.get('v.filters');
        filters['searchTerm'] = searchTerm;
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    onOrderChange: function (c, e, h) {
        var selectedFilter = c.find('sortOrder').get('v.value')
        var fieldAndOrder = selectedFilter.split(' ');
        var filters = c.get('v.filters');
        filters.orderByField = fieldAndOrder[0];
        filters.isASC = (fieldAndOrder[1] === 'ASC');
        c.set('v.selectedFilter', selectedFilter);
        h.getIds(c, filters);
    },
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        console.log('fetchProducts ids::',ids);
        h.getProducts(c, ids);
    },
    onSearchFiltersChange: function (c, e, h) {
        var filters = c.get('v.filters');
        filters.searchTerm = e.getParam('searchTerm');
        h.getIds(c, filters);
    },
    toggleFilter: function (c, e, h) {
        c.set('v.hasFilter', !c.get('v.hasFilter'));
    },
    setGrid: function (c, e, h) {
        c.set('v.isList', false);
    },
    setList: function (c, e, h) {
        c.set('v.isList', true);
    },
    onCategoryClick: function (c, e, h) {
        console.log("Categories:", e.srcElement.dataset.category);
        var category = e.srcElement.dataset.category;
        var filters = c.get('v.filters');
        filters.families = category;
        h.getIds(c, filters);
        c.set('v.activeCategory', category)
    },
    onNavigate: function (c, e, h) {
        var url = e.srcElement.dataset.url;
        var screenName = e.srcElement.dataset.screen;
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
            if(AllBreadCrumb){
                AllBreadCrumb = JSON.parse(AllBreadCrumb);
            }
            
            var matchedMenu = AllBreadCrumb.find((menu) => {
                return menu.text == screenName;
            })
            console.log('screenName::',matchedMenu);
            if(matchedMenu){
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
            }
            
        }),100);
        h.redirect(url, true);
    },
    applyFilters: function (c, e, h) {
        var selectedFamilies = e.getParam('value');
        var filters = c.get('v.filters');
        filters.families = selectedFamilies.join(',');
        h.getIds(c, filters);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    },
    openStateLicenseFile: function (c, e, h) {
        var id =e.target.dataset.id;// c.get('v.STFiles');//
        if(id){
            id = id.split(',');
            $A.get('e.lightning:openFiles').fire({
                recordIds: id
            });
        }
    },
    onTermsAndCondition:function(c,e,h){
        $A.createComponents([['c:termsAndConditions', { termsAndConditions: c.get('v.termsAndConditions') }], ['c:termsAndConditionsActions', {}]], function (contents, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    body: contents[0],
                    showCloseButton: false,
                    cssClass: 'cUtility slds-modal_medium'
                });
            }
        });
    }
})