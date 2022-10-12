({
    doInit : function(component, event, helper) {
        
        helper.request(component, 'getPicklist', { picklistId: component.get("v.recordId") }, function (r) {
            console.log("From server: " + r.pickListName);
            component.set("v.recordName", r.pickListName);
            component.set("v.pickListLine", r.lstPicklist);
            component.set("v.lstQaRec", r.QARecords);
            component.set("v.isDataLoaded",true);
            component.set("v.notemessage", r.notemessage);
            component.set("v.notemessageBarCode", r.notemessageBarCode);
            component.set("v.ReceiverName", r.receivernames);
            component.set('v.setPicklist', r.thePicklist);
                        component.set('v.sitemessages', r.errormsgSite);
 var sitevale = component.get("v.LASite");       
            component.set('v.sitemessages', r.errormsgSite);
            if(r.errormsgSite == true)
            {         
                component.set('v.LASite',true);
            }
            var pickListLine = r.lstPicklist;
       
            var QARec = r.QARecords;
            var lstPack = [];
            var listItems = [];
            
            for(let i = 0; i< pickListLine.length; i++){
                let pLine = pickListLine[i];
                if(pLine.Pack_out_UID__c != null && pLine.Pack_out_UID__c != '' && pLine.Pack_out_UID__c != undefined){
                    pLine.selectedPackOut = {label: pLine.Pack_out_UID__r.Name, value : pLine.Pack_out_UID__c};
                    pLine.hasPackOut = true; 
                } else {
                    pLine.hasPackOut = false; 
                    pLine.selectedPackOut = {};
                }
                pLine.availableQA = false;
                for(let j=0; j< QARec.length ; j++){
                    let qa = QARec[j];
                    if(qa.Picklist_Line__c == pLine.Id){
                    	pLine.availableQA = true;    
                        break;
                    }
                }
                console.log('QA = ',pLine.availableQA);
            }
            component.set("v.pickListLine", pickListLine);

        });
        
        component.set('v.customStyle', '<style>.swal2-container{z-index:10000;}</style>');
      

    },
    onScriptsLoaded : function(component, event, helper) {
      
        //helper.showPopup(component);
          
    },
    
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
        var dataset = event.currentTarget.dataset;
        var selectPickLineId = dataset.sortfield;
      
        var qaRecord = component.get('v.qaRecord');
        qaRecord.Picklist_Line__c = selectPickLineId;
        component.set('v.qaRecord',qaRecord);
    },
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
    createQA : function(component, event, helper) {
    	var qaRecord = component.get('v.qaRecord');
        
        var allValid = component.find('BatchID').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        
        if (allValid) {
            helper.request(component, 'createQARec', { qaRecord: JSON.stringify(qaRecord),picklistId: component.get("v.recordId") }, function (r) {
                component.set("v.isOpen", false);
                if(component.get('v.isChange')){
                    var pickListLine = component.get('v.pickListLine');
                    for(let i = 0; i< pickListLine.length; i++){
                        delete pickListLine[i].hasPackOut;
                        delete pickListLine[i].selectedPackOut;
                        delete pickListLine[i].availableQA;
                    }
                    
                    var JSONStr = JSON.stringify(pickListLine);
                   
                    helper.request(component, 'assignPackout', { jsonLineItem: JSONStr }, function (r) {
                        $A.get('e.force:refreshView').fire();
                    });
                } else {
                    $A.get('e.force:refreshView').fire();
                }
            });
        }
    },
    cancel : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId")
        });
        navEvt.fire();
        $A.get("e.force:closeQuickAction").fire();
    },
    
    selectUID : function(component, event, helper) {
        var dataset = event.currentTarget.dataset;
        var selectPickLineId = dataset.sortfield;
       
        component.set('v.selectedPickLineId',selectPickLineId);
    },
    
    handleComponentEvent : function(component, event, helper) {
        var selectedRecord = event.getParam("selectedRecord");
       
        component.set('v.isChange',true);
       helper.handleValues(component,selectedRecord,helper);
       
    },
    
    assignUID : function(c, e, h) {
                var errormsgSite = c.get("v.LASite");
console.log(errormsgSite);
         if (errormsgSite){
                  //  h.navigateToRecord(c, c.get('v.recordId'));
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Warning',
                        message:'User must be active and mapped to this site',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'Warning',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                
			}  
        var packoutUIDError = c.get("v.packoutUIDError");
        var UIDuseError = c.get("v.UIDuseError");
        var pUIDError ='';
        pUIDError += ' Error in Packout ID Assignment, check the following:\n';
        pUIDError += ' - Packout UID must be unique for different (Batch ID, Product, Unit Price) combination.  \n';
        pUIDError += ' - Use same Packout UID for same (Batch ID, Product, Unit Price) combination. ';
         if(packoutUIDError){
            h.error({message: pUIDError});

        }
        if(packoutUIDError == false && UIDuseError==false && errormsgSite == false){
            h.assignPackoutUID(c,e,h);
        }
    },
    
    createMassQA : function(c,e,h){
         h.request(c, 'createQARecord', {recordId: c.get("v.recordId")}, function(r){
            if(r.showpopup == true){
                c.set('v.showpopup',r.showpopup);
                c.set('v.rlIds',r.alreadyQAIds);
                c.set('v.Confirmation_for_QA_Record',r.Confirmation_for_QA_Record);
            }else{
                window.location.reload();
            }
        });
    },
    handleConfirmDialogNo : function(c, e, h) {
       c.set('v.showpopup',false);
        window.location.reload();
    },
    handleConfirmDialogYes : function(c, e, h) {
       h.request(c, 'createNewMassQARecord', {recordIds: c.get('v.rlIds')}, function(r){
           	c.set('v.showpopup',false);
             window.location.reload();
        });
    },
})