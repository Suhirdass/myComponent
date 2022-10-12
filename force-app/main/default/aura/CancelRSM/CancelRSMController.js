({
	doInit: function(component, event, helper){
     
    	var sParameterValue = component.get('v.recordId');
        var errormsg ='';
        helper.request(component, 'getSmLines', {recordId: component.get("v.recordId")}, function(r){
        	component.set('v.setSM', r.setSM);
        	component.set('v.setRsmLines', r.setRsmLines);
            component.set('v.getRejectionReasonData', r.setRejectionReason);
            
            var result = component.get('v.getRejectionReasonData');
            var rcMap = [];
            for(var key in result){
                rcMap.push({key: key, value: result[key]});
            }
            component.set("v.rejectedReasonData", rcMap);
            
            var smLineLength = r.setRsmLines;
            
            component.set('v.hasServiceInvoice', r.hasServiceInvoice);
        	if(r.setSM.Status__c=='Cancelled'){
        		errormsg='Shipping Manifest already in cancelled status.';
        	}else if(r.setSM.Status__c=='Rejected'){
        		errormsg='Shipping Manifest already in rejected status.';
        	}else if(r.setSM.Status__c=='Shipment Complete'){
        		errormsg='Shipping Manifest already shipped. Cannot cancel now.';
            }else if(smLineLength==0){
                errormsg='Line items not found';
            }
        	if(r.setSM.Status__c=='Shipment Complete' || r.setSM.Status__c=='Cancelled'  || r.setSM.Status__c=='Rejected' || smLineLength==0 ){
        		var action = component.get('c.onReturn');
            	$A.enqueueAction(action);
            	var toastEvent = $A.get("e.force:showToast");
            	toastEvent.setParams({
            		title : 'Error',
                	message: errormsg,
                	duration:' 5000',
                	key: 'info_alt',
                	type: 'Error',
                	mode: 'pester'
             	});
            	toastEvent.fire();
        	}
    	});
	},
    // For count the selected checkboxes. 
    checkboxSelect: function(component, event, helper) {
        // get the selected checkbox value  
    	var selectedRec = event.getSource().get("v.value");
        // get the selectedCount attrbute value(default is 0) for add/less numbers. 
        var getSelectedNumber = component.get("v.selectedCount");
        // check, if selected checkbox value is true then increment getSelectedNumber with 1 
        // else Decrement the getSelectedNumber with 1     
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
        // set the actual value on selectedCount attribute to show on header part. 
        component.set("v.selectedCount", getSelectedNumber);
    },
    
    // For select all Checkboxes 
    selectAll: function(component, event, helper) {
        //get the header checkbox value  
        var selectedHeaderCheck = event.getSource().get("v.value");
        // get all checkbox on table with "boxPack" aura id (all iterate value have same Id)
        // return the List of all checkboxs element 
        var getAllId = component.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array   
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack").set("v.value", true);
                component.set("v.selectedCount", 1);
            }else{
                component.find("boxPack").set("v.value", false);
                component.set("v.selectedCount", 0);
            }
        }else{
            // check if select all (header checkbox) is true then true all checkboxes on table in a for loop  
            // and set the all selected checkbox length in selectedCount attribute.
            // if value is false then make all checkboxes false in else part with play for loop 
            // and select count as 0 
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", true);
                    component.set("v.selectedCount", getAllId.length);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                    component.set("v.selectedCount", 0);
                }
            } 
        }  
        
    },
    onScriptsLoaded : function(component, event, helper) {
        component.set('v.isScriptsLoaded',true);
        helper.applyDataTable(component,event);
    }, //For Delete selected records 
    
    
     cancelRsm : function(c, e, h) {
      // create var for store record id's for selected checkboxes  
        var delId = [];
        // get all checkboxes 
        var getAllId = c.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    delId.push(getAllId[i].get("v.text"));
                }
            }
        } 
        if(delId==''){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning',
                message: ' Please select SM line(s) to cancel.',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }else
        {
         c.set('v.isOpen',true);    
        }
    	   
    },
    
    closeService: function(component, event, helper) {
        component.set("v.isOpenService", false);
    },

    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },
    onYesClick: function(component, event, helper) {
        component.set("v.isOpen", false);
        var delId = [];
        var totalItems = 0;
        // get all checkboxes 
        var getAllId = component.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
                totalItems = 1;
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    delId.push(getAllId[i].get("v.text"));
                }
            }
            totalItems = getAllId.length;
        } 
        if(delId.length == totalItems && component.get('v.hasServiceInvoice')){
        	component.set("v.isOpen", false);
        	component.set("v.isOpenService", true);    
        }else{
        	helper.onCancelSM(component,false,false); 	
        }
        
    },
     tsmCancel: function(c, e, v) {
          c.set('v.isOpen',true);
    },
    
    onCancel: function(component, event, helper) {
      
         component.set("v.isOpen", false);
        var delId = [];
        var totalItems = 0;
        // get all checkboxes 
        var getAllId = component.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
                totalItems = 1;
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    delId.push(getAllId[i].get("v.text"));
                }
            }
            totalItems = getAllId.length;
        } 
    	helper.onCancelSM(component,false,false);  
    },
    onCancelOnlyMileage: function(component, event, helper) {
         component.set("v.isOpenService", false);
        helper.onCancelSM(component, true,false); 
        //helper.onCancelOnlyWMFeeOnly(component);
    },
    onCancelSMOnly: function(component, event, helper) {
         component.set("v.isOpenService", false);
		helper.onCancelSM(component, false,true);      
    },
    onReturn: function(component, event, helper) {
          var url = window.location.href; 
            var value = url.substr(0,url.lastIndexOf('/') + 1);
            window.history.back();
            return false;
    }
})