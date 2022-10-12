({
    onInit : function(c, e, h) {
        console.log('onInit....');
        try{
        const startTime = c.get('v.startTime');
        let startTimes = startTime.split(':');
        const endTime = c.get('v.endTime');
        let endTimes = endTime.split(':');
        let startHours = parseInt(startTimes[0],10);
        let startMinutes = parseInt(startTimes[1],10);
        let endHours = parseInt(endTimes[0],10);
        let endMinutes = parseInt(endTimes[1],10);
        let flag = true;
        let timeSlots = [];
            timeSlots.push({label:'None',value:''}) 
        while(flag){
            const timeSlot = (startHours > 9 ? (startHours > 12 ? ((startHours - 12)>9?startHours:'0'+(startHours - 12)):startHours) : '0'+(startHours > 12 ? (startHours - 12):startHours))+':'+(startMinutes>9?startMinutes:'0'+startMinutes)+' '+(startHours < 12?'AM':'PM');
            timeSlots.push({label:timeSlot,value:startHours+':'+startMinutes}) 
            //startHours++;
                              
            
            //timeSlots.push(timeSlot);
            const sH = (startHours > 12 ? (startHours - 12) : startHours)
            if(sH == endHours && startMinutes == endMinutes){
                flag = false;
            }
            startMinutes += 30;
            if(startMinutes == 60){
                startHours++;
                startMinutes = 0;
            } 
        }
        console.log('timeSlots:',timeSlots);
            c.set('v.timeSlots',timeSlots);
        }catch(error){
            console.log('Error:',error);
        }
    },
	onChangeTime : function(c, e, h) {
        console.log('onChangeTime');
		// call the event   
        let compEvent = c.getEvent("timePickerEvt");
        compEvent.setParams({"selectedTime" : c.get('v.selectedTime'), "fieldName" : c.get('v.fieldName') });  
        compEvent.fire();
	},
    validate: function (c, e, h) {
        var input = c.find("timeSlot");
        var isValid = true;
        if(input && !c.get('v.selectedTime')){
            input.showHelpMessageIfInvalid();
            var validity = input.get('v.validity');
            if(validity)
                isValid =  validity.valid;
        }
        return isValid;
    },
    openCloseDropdown : function(c, e, h) {
        console.log('openCloseDropdown...');
        //$A.util.addClass(c.find('resultsDiv'),'slds-is-open');
        $A.util.toggleClass(c.find('resultsDiv'),'slds-is-open');
    },
    selectItem : function( c, e, h ) {
        const value = e.currentTarget.dataset.value;
        const label = e.currentTarget.dataset.label;
        $A.util.removeClass(c.find('resultsDiv'),'slds-is-open');
        c.set('v.selectedTimeLabel',label);
        c.set('v.selectedTime',value);
        let compEvent = c.getEvent("timePickerEvt");
        compEvent.setParams({"selectedTime" : c.get('v.selectedTime'), "fieldName" : c.get('v.fieldName') });  
        compEvent.fire();
	},
})