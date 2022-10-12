({
	doInit : function(c, e, h) {
		var caseId = sessionStorage.getItem('caseId');
        c.set('v.recordId', caseId);
        
        h.request(c, 'getCaseFullDetails', { 'caseId': caseId }, function (r) {
            console.log(r);
            c.set('v.caseDetails', r.record);
            c.set('v.isBrand', r.isBrand);
            c.set('v.fileDet', r.fileDet);
            console.log('fileDet 123>>>',r.fileDet);
        });
	},
    onCancel: function(component, event, helper) {
        helper.redirect('/cases', true);
    },
    gotoAllCases: function(component, event, helper) {
        helper.redirect('/cases', true);
    },
    editCase: function(component, event, helper) {
        var brd = sessionStorage.getItem('breadCrumb');
        if(brd){
            brd = JSON.parse(brd);
            brd.breadCrumbString += ' > Edit Case';
            brd.breadCrumbIds+=' > ';
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
        }
        var recordId = component.get('v.recordId');
        sessionStorage.setItem('caseId', recordId);
        helper.redirect('/casedetails', true);
    },
    printDetails: function (c, e, h) {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/viewcasedetails','/apex/printCaseDetailsView?recordId='+c.get('v.recordId'));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');        
   },
    onViewCompliance:function(c,e,h){
            var complianceFileIds = [];
            complianceFileIds.push(e.currentTarget.dataset.id);
            console.log("recordId:", complianceFileIds);
            $A.get('e.lightning:openFiles').fire({
                recordIds: complianceFileIds
            });
        }  
})