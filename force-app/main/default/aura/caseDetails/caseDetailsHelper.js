({
	generateNewCase : function(c) {
        var h = this;
        c.set('v.caseDetails', {'sobjectType': 'Case', 'Status': 'New'});
        h.request(c, 'getContactInformation', {}, function(r){
            console.log(r);
            var caseDetails = c.get("v.caseDetails");
            console.log(caseDetails);
            caseDetails.ContactEmail = r.ContactInformation.Email;
            caseDetails.ContactPhone = r.ContactInformation.Phone;
            c.set('v.caseDetails', caseDetails);
        }, {storable: true});
    },
    closeCase: function(c) {
        var h = this;
        h.request(c, 'closeMyCase', {'caseId': c.get("v.caseDetails").Id}, function(r){
            if(r.closed){
                c.get("v.caseDetails").Status='Closed';
                h.redirect('/cases', true);
            }
                
        }, {storable: false});
    },
    saveCase: function(component, event) {
        console.log('saveCase');
        var helper = this;
        let caseDetail = component.get('v.caseDetails');
        var subEl = component.find('subjectInput');
        //var sub = subEl.get("v.value");
        var sub = caseDetail.Subject;
        var c_Desc = component.find('DescInput');
        //var v_desc = c_Desc.get("v.value");
        var v_desc = caseDetail.Description;
		var missingRequiredFields = false;

        if ((sub === undefined || sub ===null || sub ==='') ||
            (v_desc === undefined || v_desc ===null || v_desc ==='')
           ){
            subEl.set('v.validity', {valid:false, valueMissing :true});
            subEl.showHelpMessageIfInvalid();
            
            c_Desc.set('v.validity', {valid:false, valueMissing :true});
            c_Desc.showHelpMessageIfInvalid();
            
            missingRequiredFields = true;
        }
        if(!missingRequiredFields){		
            helper.request(component, 'saveCase', { 'caseDetails': component.get('v.caseDetails') }, function (r) {
                component.set('v.isShowSuccess',true);
                window.setTimeout($A.getCallback(function(){
                    const modal = document.getElementById('success-modal');
                    if (modal) modal.classList.add('is-active');
                }),100)
                    //helper.success({ message: ('Ticket has been ' + (component.get('v.caseDetails.Id')!=null ? 'updated ' : 'created') + ' successfully.') });
                    //helper.redirect('/cases', true);
            });
        }
         
    }
})