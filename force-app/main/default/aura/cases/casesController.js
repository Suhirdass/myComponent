({
    onInit: function (c, e, h) {
        c.set('v.perPage',10);
        console.log('onInit');
        var searchTerm = '';
        var filters = { orderByField: 'CaseNumber', isASC: false, searchTerm: searchTerm };
        c.set('v.filters', filters);
        h.request(c,'getCaseCategories',{},
			function (r) {
                var caseStatus = r.categories;
                c.set('v.caseStatus', caseStatus);
			},
			{ storable: false }
		);
        h.getCases(c, filters);
        //h.getTopHeight(c);
    },
  fetchCases: function (c, e, h) {
      console.log('fetchCases');
    var ids = e.getParam('ids');
    h.getCaseDetails(c, ids);
  },
  onScriptsLoaded: function (c, e, h) { 
        h.initScroller(c); 
    },
  onSearchCases: function (c, e, h) {
        var searchRec = c.find('searchRec');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            console.log('searchTerm:',searchTerm);
            var filters = c.get('v.filters');
            filters['searchTerm'] = searchTerm;
            c.set('v.filters', filters);
            h.getIds(c, filters);
        }),100);
    },
    newCase: function (c, e, h) { 
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > Create Case';
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
      sessionStorage.setItem('caseId', null);
      h.redirect('/casedetails', true);
    },
    gotoCase : function(component, event, helper) {
        var recordId = event.currentTarget.dataset.id;
        var ticketnumber = event.currentTarget.dataset.ticketnumber;
        console.log("recordId:",recordId);
        sessionStorage.setItem('caseId', recordId);
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > '+ticketnumber;
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        helper.redirect('/viewcasedetails', true);
    },
  onEdit: function (c, e, h) {
      var recordId = e.getSource().get('v.value');
      var ticketnumber = e.getSource().get('v.alternativeText');
      sessionStorage.setItem('caseId', recordId);
      var brd = sessionStorage.getItem('breadCrumb');
      if(brd){
          brd = JSON.parse(brd);
          brd.breadCrumbString += ' > '+ticketnumber;
          brd.breadCrumbIds+=' > ';
          sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
          $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
      }
      h.redirect('/casedetails', true);
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
    h.getCases(c, filters);
    },
    scrollToTop: function (c, e, h) {
        h.scrollToTop(c);
    },
    onCategorySelect: function (c, e, h) {
        var STStatus = e.getSource().get("v.label");
        console.log('STStatus',STStatus);
        if(STStatus == 'In Progress'){
            STStatus = 'In_Progress';
        }
        c.set('v.selectedStatus',STStatus);
        var filters = c.get('v.filters');
        filters['status'] = STStatus;
        console.log('Filters on select>>>>',filters);
        c.set('v.filters', filters);
        h.getCases(c, c.get('v.filters'));
    },
    onPrintSelect: function (c, e, h) {
        var selectedFormat = e.getSource().get("v.value");
        if(selectedFormat == 'csv'){
            //h.getRecordsForFile(c);
            h.fetchPageForFile(c);
        }else if(selectedFormat == 'pdf'){
            var filters = c.get('v.filters');
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/cases','/apex/printCases?filters='+JSON.stringify(c.get('v.filters')));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');
        }
    }
})