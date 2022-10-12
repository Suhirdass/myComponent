({
    onInit: function (c, e, h) {
        const userAgent = navigator.userAgent.toLowerCase();
        c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
        c.set('v.perPage',10);
        var searchTerm = '';
        var filters = { orderByField: 'DBA__c', isASC: true, searchTerm: searchTerm,retailerFilter:'My Retailers' };
        c.set('v.filters', filters);
        h.getIds(c, filters);
    },
    onScriptsLoaded: function (c, e, h) {
        //h.initScroller(c);
    },
    handleSearch: function (c, e, h) {
        window.setTimeout(
            $A.getCallback(function() {
                var searchRec = c.find('searchRec');
                var searchTerm = searchRec.getElement().value;
                var filters = c.get('v.filters');
                filters['searchTerm'] = searchTerm;
                console.log('##searchTerm : ',searchTerm);
                c.set('v.filters', filters);
                h.getIds(c, c.get('v.filters'));
            }), 100
        );
    },
    onOrderChange: function (c, e, h) {
        var fieldAndOrder = (e.getSource().get('v.value')).split(' ');
        var filters = c.get('v.filters');
        filters.orderByField = fieldAndOrder[0];
        filters.isASC = (fieldAndOrder[1] === 'ASC');
        h.getIds(c, filters);
    },
    changeRetailers: function (c, e, h) {
    	var selectedFilter = e.getSource().get("v.label");
        c.set('v.selectedFilter',selectedFilter);
        var filters = c.get('v.filters');
        filters['retailerFilter'] = selectedFilter;
        c.set('v.filters', filters);
        h.getIds(c, c.get('v.filters'));  
    },
    fetchRetailers: function (c, e, h) {
        var ids = e.getParam('ids');
        h.getRecords(c, ids);
    },
    onViewReialer: function (c, e, h) {
        var recordId = e.currentTarget.dataset.id;
        sessionStorage.setItem('retailerId', recordId);
        sessionStorage.setItem('selectedFilter', c.get('v.selectedFilter'));
        h.redirect('/retailer', true);
    },
    onSearchFiltersChange: function (c, e, h) {
        var filters = c.get('v.filters');
        filters.searchTerm = e.getParam('searchTerm');
        h.getIds(c, filters);
    },
    handleKeyUp: function (c, e,h) {
        try{
            window.clearTimeout(h.inProgress);
        }catch(err){}
        
        h.inProgress = window.setTimeout($A.getCallback(function(){
            /*var searchTerm = c.find('retailerSearch').get('v.value');
            console.log('Searched for "' + searchTerm + '"!');*/
            var filters = { orderByField: 'DBA__c', isASC: true, searchTerm: c.get('v.searchTerm') };
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }), 750);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    },
    setGrid: function (c, e, h) {
        //c.set('v.perPage',16);
        //var filters = c.get('v.filters');
        //h.getIds(c, filters);
        c.set('v.isList', false);
        
    },
    setList: function (c, e, h) {
        //c.set('v.perPage',50);
        //var filters = c.get('v.filters');
        //h.getIds(c, filters);
        c.set('v.isList', true);
        
    },
    onView:function(c,e,h){
		var retailerId = e.currentTarget.dataset.id;        
        sessionStorage.setItem('retailerId', retailerId);
        h.redirect('/retailer', true);
    },
    onNewContact:function(c,e,h){
		var retailerId = e.currentTarget.dataset.id;    
        console.log('Record Type Id:',c.get('v.contactRTId'));
        /*var createAcountContactEvent = $A.get("e.force:createRecord");
        createAcountContactEvent.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues": {
                'RecordTypeId':c.get('v.contactRTId'),
                'AccountId' : retailerId
            }
        });
        createAcountContactEvent.fire();*/
        $A.createComponent('c:newContact', {recordTypeId: c.get('v.contactRTId'), accountId:retailerId}, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    header: 'New Retailer Contact',
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button'
                });
            }                               
        });
    },
    onSortOrders: function (c, e, h) {
        try{
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters.orderByField =  sortfield;
            filters.isASC= (!filters.isASC);
        } else {
            filters.orderByField =  sortfield;
            filters.isASC= true;
        }
            
        console.log('filters::',JSON.stringify(filters));
        c.set('v.filters', filters);
        h.getIds(c, filters);
        }catch(err){
            console.log('Error:',err);
        }
    },
    
    openContacts : function (c, e, h) {
    	var index = e.currentTarget.dataset.id;
        if(parseInt(index,10) == c.get('v.selectedCIndex')){
        	c.set('v.selectedCIndex',-1);    
        } else{
        	c.set('v.selectedCIndex',parseInt(index,10));    
        } 	    
    },
    openLicences : function (c, e, h) {
        var index = e.currentTarget.dataset.id;
        if(parseInt(index,10) == c.get('v.selectedLIndex')){
        	c.set('v.selectedLIndex',-1);    
        } else{
        	c.set('v.selectedLIndex',parseInt(index,10));    
        }   
    },
})