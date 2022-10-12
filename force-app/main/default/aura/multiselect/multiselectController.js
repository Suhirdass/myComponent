({
    onRender : function(component, event, helper) {
        if(!component.get("v.initializationCompleted")){
            var selectedValuesName = component.get("v.selectedValuesName");
            var selectedOptions = component.get("v.selectedOptions");
            
            if(selectedValuesName != undefined && selectedValuesName != ''){
            	var selectedValuesId = component.get("v.selectedValuesId"); 
                if(component.get('v.isMultiSelect')){
                    var selectedValuesNameList = selectedValuesName.split(',');
                    
                    var selectedValuesIdList = selectedValuesId.split(',');
                    for(var i=0; i<selectedValuesNameList.length;i++){
                        if(selectedValuesName[i] != undefined && selectedValuesName[i] != '' && selectedValuesIdList[i] != undefined){
                            var fArray={
                                'id':selectedValuesIdList[i],
                                'name':selectedValuesNameList[i].trim(),
                            };
                            selectedOptions.push(fArray); 
                        }
                    }
                }else{
                    var fArray={
                        'id':selectedValuesId,
                        'name':selectedValuesName,
                    };
                    selectedOptions.push(fArray);
                }
                let msoptions = component.get("v.msoptions");
                let msoptions1 = [...msoptions];
                if(msoptions1 != undefined){
                    let selectedValuesIds = [];
                    if(component.get('v.isMultiSelect')){
                        selectedValuesIds = selectedValuesId.split(',');
                    }
                    msoptions1.forEach((item) => {
                        if(component.get('v.isMultiSelect')){
                            if(selectedValuesId.indexOf(item.id) != -1){
                                item.selected = true;
                            } else {
                                item.selected = false;              
                            }
                       }else{
                             if(selectedValuesId == item.id){
                                item.selected = true;
                            } else {
                                item.selected = false;              
                            }
                       }
                	});

                    component.set("v.msoptions",msoptions1);
                }
            }
            //Attaching document listener to detect clicks
            component.getElement().addEventListener("click", function(event){
                //handle click component
                helper.handleClick(component, event, 'component');
            });
            //Document listner to detect click outside multi select component
            document.addEventListener("click", function(event){
                helper.handleClick(component, event, 'document');
            });
            //Set picklist name
            helper.setPickListName(component, component.get("v.selectedOptions")); 
            //Marking initializationCompleted property true
            component.set("v.initializationCompleted", true);
            
            
        }

    },

    onChange: function(component, event, helper){
        console.log('msOPTIONS == ',component.get('v.msoptions'));
        console.log('msLabel == ',component.get('v.mslabel'));
        if(helper.isRunning)return;
        if(component.get("v.initializationCompleted")){
            var selectedValuesName = component.get("v.selectedValuesName");
            var selectedValuesId = component.get("v.selectedValuesId"); 
            console.log('selectedValuesName = ',selectedValuesName);
            console.log('selectedValuesId = ',selectedValuesId);
            if(selectedValuesName == '' && selectedValuesId == ''){
                component.set("v.selectedLabel", component.get("v.msname"));
                component.set("v.selectedIds", '');
                var selectedOptions = [];
                component.set("v.selectedOptions",selectedOptions);
                helper.rebuildPicklist(component);
                helper.setPickListName(component, component.get("v.selectedOptions"));
            }else{
                if(selectedValuesId == ''){
                    selectedValuesName =  component.get("v.msname");
                }
                component.set("v.selectedIds", selectedValuesId);
                component.set("v.selectedLabel", selectedValuesName);
                let msoptions = component.get("v.msoptions");
                let msoptions1 = [...msoptions];
                if(msoptions1 != undefined){
                    let selectedValuesIds = [];
                    if(component.get('v.isMultiSelect')){
                        selectedValuesIds = selectedValuesId.split(',');
                    }
                    msoptions1.forEach((item) => {
                        if(component.get('v.isMultiSelect')){
                            if(selectedValuesId.indexOf(item.id) != -1){
                                item.selected = true;
                            } else {
                                item.selected = false;              
                            }
                       }else{
                             if(selectedValuesId == item.id){
                                item.selected = true;
                            } else {
                                item.selected = false;              
                            }
                       }
                	});
					helper.isRunning = true;
                    component.set("v.msoptions",msoptions1);
            window.setTimeout($A.getCallback(function(){helper.isRunning = false}),100);
                }
            }   
        }
        
    },
    
    validate: function(c, e, h){
        let isRequired = c.get('v.isRequired');
        console.log('Selected Ids:',c.get('v.selectedIds'));
        if(isRequired){
            c.set('v.showInRed',(c.get('v.selectedIds') == '' || c.get('v.selectedIds') == null || c.get('v.selectedIds') == undefined));
        }
        console.log('showInRed:',!c.get('v.showInRed'));
        return !c.get('v.showInRed');
    },
    
    /**
     * This function will be called when input box value change
     * @author - Manish Choudhari
     * */
    onInputChange : function(component, event, helper) {
      
        //get input box's value
        var inputText = event.target.value;
        //Filter options
        helper.filterDropDownValues(component, inputText);
    },

    /**
     * This function will be called when refresh button is clicked
     * This will clear all selections from picklist and rebuild a fresh picklist
     * @author - Manish Choudhari
     * */
    onRefreshClick : function(component, event, helper) {
        //clear selected options
        component.set("v.selectedOptions", []);
        //Clear check mark from drop down items
        helper.rebuildPicklist(component);
        //Set picklist name 
        alert('ddd');
        helper.setPickListName(component, component.get("v.selectedOptions"));
    },
    /**
     * This function will be called when clear button is clicked
     * This will clear any current filters in place
     * @author - Manish Choudhari
     * */
    onClearClick : function(component, event, helper) {
        //clear filter input box
        component.getElement().querySelector('.ms-filter-input').value = '';
        //reset filter
        helper.resetAllFilters(component);
    },
})