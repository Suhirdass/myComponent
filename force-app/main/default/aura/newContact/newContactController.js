({
    onInit : function(c, e, h) {
		try {
            h.request(c, 'initNewContact', {accountId : c.get('v.accountId'),recordTypeId : c.get('v.recordTypeId')}, function (r) {
                
                c.set('v.accountName',r.accountName);
                if(r.newContact.Lastname){
                    c.set('v.newContact',r.newContact);
                } else {
                    let cont = r.newContact;
                    cont.Lastname = 'Unknown';
                    c.set('v.newContact',cont);
                }
            });
        } catch (err) { console.log('Error:',err);}
    },
    onSave:function(c,e,h){
        var record = c.get('v.newContact');
        var allValid = c.find('fieldId').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            let isValid = true;
            if(inputCmp.get('v.value') == ' '){
                inputCmp.setCustomValidity("Complete this field.");
                inputCmp.reportValidity();
                isValid = false;
            }
            return validSoFar && !inputCmp.get('v.validity').valueMissing && isValid;
        }, true);
        if(allValid){
            h.request(c, 'saveContact', {recordStr : JSON.stringify(record)}, function (r) { 
                if(r.alreadyExists){
                	var con = r.contact; 
                    h.error({message:'Contact '+con.Name+' already exists with Email '+con.Email});
                }else{
                	h.success({message:'Retailer Contact created successfully'});    
                    h.redirect('/retailer',true);
                }
            });   
        }
    },
    onCancel: function(cmp, event, helper) {
        cmp.find('overlay').notifyClose();
    },
    onPhoneChange: function(c, e, h) {
        try{
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        c.set('v.newContact.Phone',formattedPhone);
        e.getSource().showHelpMessageIfInvalid();
        }catch(error){
            console.log('Error:',error);
        }
    },
})