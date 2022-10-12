({
    onInit : function(c, e, h) {
        var action = c.get("c.getStrainTypesValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(response.getReturnValue());
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({label: key, value: result[key]});
                }
                c.set("v.serviceTypes", fieldMap);
            }
        });
        $A.enqueueAction(action);    
    },
    onSave : function(c, e, h) {
        var isValid = true;
        var inputCmp = c.find('validate');
        var value = inputCmp.get("v.value");
        if(value.length > 80){
            isValid = false; 
            inputCmp.setCustomValidity("Strain name has 80 characters long");
        } else{
            inputCmp.setCustomValidity("");
        }
        inputCmp.reportValidity();
        console.log('##StrainType',c.get('v.StrainType'));
        if(isValid){
            h.request(c, 'insertStrain', {recName: c.get('v.nameStrain'),StrainType :c.get('v.StrainType')}, function(r){
                try{
                    var cmpEvent = $A.get("e.c:batchIdEvent");
                    cmpEvent.setParams( { "selectedRecord" : {value: r.newRec.Id,label: r.newRec.Name},"strainType":r.newRec.Strain_Type__c, "selRec": r.newRec.Strain_Type__c,'selectedIndex':c.get('v.selectedIndex')});
                    cmpEvent.fire();
                    console.log('cmpEvent :',cmpEvent);
                    c.find('overlay').notifyClose();
                } catch(exp){
                    console.log('Exp ',exp);
                }
            });  
        }
    },
    
	onCancel: function(c, e, h) {
        var cmpEvent = $A.get("e.c:serviceStringEvent");
        cmpEvent.setParams( {"selRec": "blank"});
        cmpEvent.fire();
        c.find('overlay').notifyClose();
    },
})