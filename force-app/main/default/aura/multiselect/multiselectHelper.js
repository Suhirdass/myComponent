({
    /**
     * This function will close all multi-select drop down on the page
     * @author - Manish Choudhari
     * */
    closeAllDropDown: function() {
        //Close drop down by removing slds class
        Array.from(document.querySelectorAll('#ms-picklist-dropdown')).forEach(function(node){
            node.classList.remove('slds-is-open');
        });
    },
    isRunning : false,

	/**
     * This function will be called on drop down button click
     * It will be used to show or hide the drop down
     * @author - Manish Choudhari
     * */
    onDropDownClick: function(dropDownDiv) {
        //Getting classlist from component
        var classList = Array.from(dropDownDiv.classList);
        if(!classList.includes("slds-is-open")){
            //First close all drp down
            this.closeAllDropDown();
            //Open dropdown by adding slds class
            dropDownDiv.classList.add('slds-is-open');
        } else{
           //Close all drp down
            this.closeAllDropDown();
        }

    },

    /**
     * This function will handle clicks on within and outside the component
     * @author - Manish Choudhari
     * */
    handleClick: function(component, event, where) {
        //getting target element of mouse click
        var tempElement = event.target;

        var outsideComponent = true;
        //click indicator
        //1. Drop-Down is clicked
        //2. Option item within dropdown is clicked
        //3. Clicked outside drop-down
        //loop through all parent element
        while(tempElement){
            if(tempElement.id === 'ms-list-item'){
                //2. Handle logic when picklist option is clicked
                //Handling option click in helper function
                if(where === 'component'){
                	this.onOptionClick(component, event.target);
                }
                outsideComponent = false;
                break;
            } else if(tempElement.id === 'ms-dropdown-items'){
                //3. Clicked somewher within dropdown which does not need to be handled
                //Break the loop here
                outsideComponent = false;
                break;
            } else if(tempElement.id === 'ms-picklist-dropdown'){
                //1. Handle logic when dropdown is clicked
                if(where === 'component'){
                	this.onDropDownClick(tempElement);
                }
                outsideComponent = false;
                break;
            }
            //get parent node
            tempElement = tempElement.parentNode;
        }
        if(outsideComponent){
            this.closeAllDropDown();
        }
    },

    /**
     * This function will be used to filter options based on input box value
     * @author - Manish Choudhari
     * */
    rebuildPicklist: function(component) {
        var allSelectElements = component.getElement().querySelectorAll("li");
        Array.from(allSelectElements).forEach(function(node){
            node.classList.remove('slds-is-selected');
        });
    },

    /**
     * This function will be used to filter options based on input box value
     * @author - Manish Choudhari
     * */
    filterDropDownValues: function(component, inputText) {
        let count = 0;
        var allSelectElements = component.getElement().querySelectorAll("li");
        Array.from(allSelectElements).forEach(function(node){
            if(!inputText){
                node.style.display = "block";
            }
            else if(node.dataset.name && node.dataset.name.toString().toLowerCase().indexOf(inputText.toString().trim().toLowerCase()) != -1){
                node.style.display = "block";
            } else{
                count++;
                node.style.display = "none";
            }
        });
        var norecordsEle = component.getElement().querySelector("#ms-list-item-no-record");
        if(norecordsEle){
            if(allSelectElements.length == count){
                norecordsEle.style.display = "block";
            }else {
                norecordsEle.style.display = "none";
            }
        }
    },

    /**
     * This function clear the filters
     * @author - Manish Choudhari
     * */
    resetAllFilters : function(component) {
        this.filterDropDownValues(component, '');
    },

    /**
     * This function will set text on picklist
     * @author - Manish Choudhari
     * */
    setPickListName : function(component, selectedOptions) {
        console.log('setPickListName..');
        console.log('setPickListName..',selectedOptions.length);
			const maxSelectionShow = component.get("v.maxSelectedShow");
        	var selectedIds = '';
            //Set drop-down name based on selected value
            if(selectedOptions.length < 1){
                component.set("v.selectedLabel", component.get("v.msname"));
            } else if(selectedOptions.length > maxSelectionShow){
                if(!component.get('v.isMultiSelect')){
                    var selections = '';
                    selectedOptions.forEach(option => {
                        selections += option.name;
                    });
                    component.set("v.selectedLabel",selections);
                } else {
                    component.set("v.selectedLabel", selectedOptions.length+' Options Selected');
                }
            } else{
                var selections = '';
                selectedOptions.forEach(option => {
                    selections += option.name+',';
                });
                component.set("v.selectedLabel", selections.slice(0, -1));
            }
			selectedOptions.forEach(option => {
				selectedIds += option.id+',';
			});
            console.log('selectedIds == ',selectedIds);       
                       // alert('sdsdsadad');
			component.set("v.selectedIds", selectedIds);
            const isRequired = component.get('v.isRequired');
            if(isRequired && component.get("v.initializationCompleted")){
                component.set('v.showInRed',(selectedIds == '' || selectedIds == null || selectedIds == undefined));
            }
            // call the event   
        	var compEvent = component.getEvent("multiSelectEvent");
                        compEvent.setParams({"selectedIds" : selectedIds, "fieldName" : component.get('v.mslabel') ,"index":component.get('v.MSIndex')});  
        	compEvent.fire();        
    },

    /**
     * This function will be called when an option is clicked from the drop down
     * It will be used to check or uncheck drop down items and adding them to selected option list
     * Also to set selected item value in input box
     * @author - Manish Choudhari
     * */
    onOptionClick: function(component, ddOption) {
        	console.log('onOptionClick = ');
            //get clicked option id-name pair
            var clickedValue = {"id":ddOption.closest("li").getAttribute('data-id'),
                                "name":ddOption.closest("li").getAttribute('data-name')};
            //Get all selected options
            var selectedOptions = component.get("v.selectedOptions");
            //Boolean to indicate if value is alredy present
            var alreadySelected = false;
            //Looping through all selected option to check if clicked value is already present
            selectedOptions.forEach((option,index) => { 
                if(option.id.trim() === clickedValue.id.trim()){
                    //Clicked value already present in the set
                    selectedOptions.splice(index, 1);
                    //Make already selected variable true
                    alreadySelected = true;
                    //remove check mark for the list item
                    ddOption.closest("li").classList.remove('slds-is-selected');
                }
            });
            //If not already selected, add the element to the list
            if(!alreadySelected){
                if(!component.get('v.isMultiSelect')){
                    this.rebuildPicklist(component);
                    selectedOptions.forEach((option,index) => { 
                        selectedOptions.splice(index, 1);
                        ddOption.closest("li").classList.remove('slds-is-selected');
                    });
                }       
                selectedOptions.push(clickedValue);
                //Add check mark for the list item
                ddOption.closest("li").classList.add('slds-is-selected');
            }
            console.log('selectedOptions = ',selectedOptions); 
        //Set picklist label
        this.setPickListName(component, selectedOptions);
        if(!component.get('v.isMultiSelect')){
            this.closeAllDropDown();
        }
    },

})