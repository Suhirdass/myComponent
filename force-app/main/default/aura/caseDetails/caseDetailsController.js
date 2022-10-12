({
	doInit : function(c, e, h) {
		var caseId = sessionStorage.getItem('caseId');
        c.set('v.recordId', caseId);
        console.log('The Record ID>>>',c.get("v.recordId"));
        if(caseId===null || caseId==="null"){
           h.generateNewCase(c); 
        	c.set('v.isDataLoaded',true);
        }else
            h.request(c, 'getCaseFullDetails', { 'caseId': caseId }, function (r) {
                console.log('CaseDetails 123>>>',r.record);
                c.set('v.caseDetails', r.record);
                c.set('v.fileDet', r.fileDet);
                c.set('v.isDataLoaded',true);
                //c.set('v.isBrand', r.isBrand);
            });
	},
    handleMultiSelectEvent  :  function (c, e, h) {
    	var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
            selectedIds = selectedIds.slice(0, -1);
        
        var caseDetails = c.get('v.caseDetails');
        if(fieldName === 'Type'){
            caseDetails.Type = selectedIds;
            c.set('v.caseDetails',caseDetails);
        }else if(fieldName === 'Priority'){
            caseDetails.Priority = selectedIds;
            c.set('v.caseDetails',caseDetails);
        }else if(fieldName === 'Contact Preference'){
            caseDetails.Contact_Preference__c = selectedIds;
            c.set('v.caseDetails',caseDetails);
        }
    },
    onSave: function(component, event, helper) {
        console.log('onSave');
        helper.saveCase(component, event);
    },
    gotoAllCases: function(component, event, helper) {
        if(component.get("v.caseDetails.Status") === "Closed")
            helper.redirect('/cases', true);
        else
        	component.set("v.popupOpen", "true");
    },
    closeModel : function(component, event, helper) {
        console.log('closeModel');
        component.set("v.popupOpen", "false");
    },
    onCancel: function(component, event, helper) {
        window.setTimeout($A.getCallback(function(){
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
            if(AllBreadCrumb){
                AllBreadCrumb = JSON.parse(AllBreadCrumb);
            }
            
            var screenName = 'Support Cases';
            var matchedMenu = AllBreadCrumb.find((menu) => {
                return menu.text == screenName;
            })
            console.log('screenName::',matchedMenu);
            if(matchedMenu){
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
            }
            var removeIdsFromCache = 'caseId';
            console.log('removeIdsFromCache:',removeIdsFromCache);
            if(removeIdsFromCache){
                var Ids = removeIdsFromCache.split(',');
                if(Ids.length){
                    Ids.forEach((id) =>sessionStorage.removeItem(id))
                }
            }
        }),100);
        helper.redirect('/cases', true);
    },
    onClose: function(component, event, helper) {
        //component.get("v.caseDetails").
        console.log('onClose');
        component.set("v.caseDetails.Status", "Closed");
        helper.saveCase(component, event);
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