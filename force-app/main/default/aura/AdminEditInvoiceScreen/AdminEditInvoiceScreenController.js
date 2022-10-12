({
	onInit : function(c, e, h) {
        console.log('onInit:',c.get('v.Invoice'));
        var inv = c.get('v.Invoice');
        c.set("v.InvoiceBalance", inv.Invoice_Balance__c);
        
        console.log('RC : ',inv.Receiver_Contact__c);
                if(inv.Receiver_Contact__c != null && inv.Receiver_Contact__c != '' && inv.Receiver_Contact__c != undefined){
                    inv.selectedRC = {label: inv.Receiver_Contact__r.Name, value : inv.Receiver_Contact__c};
                    inv.hasReciCon = true; 
                } else {
                    inv.hasReciCon = false; 
                    inv.selectedRC = {};
                }

            c.set("v.Invoice", inv);
		
	},
    onChangeAmt : function(c,e,h) {
        var passAmt = c.find("passAmt"); 
        var avlAmt = c.find("avlAmt");
        console.log(avlAmt);
        var inv = c.get('v.Invoice');
        var fixamtValue = Array.isArray(avlAmt) ? avlAmt[i].get("v.value") : avlAmt.get("v.value");
        var payAmount = c.get('v.payAmount');
        if(payAmount != undefined ){
            var amt = 0;
            amt = fixamtValue - payAmount;
                passAmt.set("v.value",amt);
        }else{
            c.set('v.payAmount',0);
        }
          
    },
    onSubmit: function(c, e, h) {
        var inv = c.get('v.Invoice');
        console.log('Invoice ',JSON.stringify(inv));
        console.log('Invoice Contact ',inv.Receiver_Contact__c);
        console.log('Invoice Email ',inv.Receiver_Contact__r.Email);
        console.log('Invoice Phone ',inv.Receiver_Contact__r.Phone);
        var payAmount = c.get('v.payAmount');
        console.log('payAmount ',payAmount);
        if(payAmount > inv.Invoice_Balance__c){
            h.error({message:'Receive Payment Amount is greater than Invoice Balance.'});
            return;
        }
        if(payAmount < 0 ){
            h.error({message:'Receive Payment Amount is less than 0.'});
            return;
        }
        h.request(c, 'onSaveInvoice', {'invJSONStr':JSON.stringify(inv),'ReciCon':inv.Receiver_Contact__c,'conEmail':inv.Receiver_Contact__r.Email,'conPhone':inv.Receiver_Contact__r.Phone,'payAmt':payAmount}, function (r) {
            console.log('#Success');
        });
    },
    onCancel: function(c, e, h) {
        var inv = c.get('v.Invoice');
        console.log('Invoice ',inv);
        /*var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": inv.id
        });
        navEvt.fire();
        h.navigateToRecord(c,inv.id,'view');*/
    },
    onView: function(c, e, h) {
        const id = e.currentTarget.dataset.id;
        h.navigateToRecord(c,id,'view');
    },
    selectContact : function(component, event, helper) {
        var dataset = event.currentTarget.dataset;
        var selectRecConId = dataset.sortfield;
        console.log('Helloo ',selectRecConId);
        component.set('v.selectRecConId',selectRecConId);
    },
    handleComponentEvent : function(component, event, helper) {
        var selectedRecord = event.getParam("selectedRecord");
        console.log('Hello '+selectedRecord.label);
        console.log(selectedRecord.value);
        component.set('v.isChange',true);
        helper.handleValues(component,selectedRecord,helper);
    },
})