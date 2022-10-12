({
    // To prepopulate the seleted value pill if value attribute is filled
	doInit : function( component, event, helper ) {
        console.log('Value:',component.get('v.value'));
    	$A.util.toggleClass(component.find('resultsDiv'),'slds-is-open');
		if( !$A.util.isEmpty(component.get('v.value')) ) {
			helper.searchRecordsHelper( component, event, helper, component.get('v.value') );
		}
	},
    validate: function (c, e, h) {
        var selectedRecord = c.get('v.selectedRecord');
        console.log("selectedRecord::",!selectedRecord.value,'::',JSON.stringify(selectedRecord));
        return selectedRecord.value;
    },
    // When a keyword is entered in search box
	searchRecords : function( component, event, helper ) {
        if( !$A.util.isEmpty(component.get('v.searchString')) ) {
		    helper.searchRecordsHelper( component, event, helper, '' );
        } else {
            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
        }
	},

    // When an item is selected
	selectItem : function( component, event, helper ) {
        if(!$A.util.isEmpty(event.currentTarget.id)) {
    		var recordsList = component.get('v.recordsList');
    		var index = recordsList.findIndex(x => x.value === event.currentTarget.id)
            if(index != -1) {
                var selectedRecord = recordsList[index];
            }
            component.set('v.selectedRecord',selectedRecord);
            component.set('v.value',selectedRecord.value);
            var compEvent = $A.get("e.c:selectedRecordLookupEvent");
            // set the Selected Account to the event attribute.  
            compEvent.setParams({"selectedRecord" : selectedRecord ,"objectName":component.get('v.objectName')}); 
            
            // fire the event  
            compEvent.fire();
            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
        }
	},
    
    
    // Create batch ID
    onNewBatchId : function(c,e,h){
        if(c.get('v.allowCreate') == false){
            return;
        }
		var batchName = e.currentTarget.dataset.id;    
        var brandIds = c.get("v.brandId");
        var brandnm = c.get("v.brandName");
        var selRec = c.get("v.changeIds");
        var iUID = false;
        if(c.get("v.changeIds") == 'uids'){
        	iUID = true;    
        }
            //selRecord
        $A.createComponent('c:newBatchID', {nameBatch : batchName,brandId : brandIds,brandName : brandnm,selRecord : selRec,isUid : iUID}, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    header: 'Create New',
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button'
                });
            } 
        });
    },
    
    // To remove the selected item.
	removeItem : function( component, event, helper ){
        component.set('v.selectedRecord','');
        component.set('v.value','');
        component.set('v.searchString','');
        var compEvent = $A.get("e.c:selectedRecordLookupEvent");
        // set the Selected Account to the event attribute.  
        compEvent.setParams({"selectedRecord" : '' ,"objectName":component.get('v.objectName')}); 
        
        // fire the event  
        compEvent.fire();
        setTimeout( function() {
            component.find( 'validate' ).focus();
        }, 250);
    },

    // To close the dropdown if clicked outside the dropdown.
    blurEvent : function( component, event, helper ){
    	$A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
    },
    
    updateRecId : function( c, e, h ){
    	var item = e.getParam('newStr');
		c.set('v.searchString',null);
        c.set('v.message','');
    }
})