({
    handleDecrement: function(cmp, ev, h) {
        var current = cmp.get('v.value');
        var min = cmp.get('v.min')

        console.log('pre decrement')

        if (min === undefined || current - 1 >= min) {
            console.log('decrement')
            cmp.set('v.value', parseInt(current) - 1)
        }
        
        // call the event   
        let compEvent = cmp.getEvent("numberInputEvt");
        compEvent.setParams({"currentValue" : cmp.get('v.value'), "recordId" : cmp.get('v.recordId'),"index":cmp.get('v.index') });  
        compEvent.fire();
        
    },
    
    itemsChange: function(cmp, evt) {
        if (evt.which == 13){
            let compEvent = cmp.getEvent("numberInputEvt");
            compEvent.setParams({"currentValue" : cmp.get('v.value'), "recordId" : cmp.get('v.recordId'),"index":cmp.get('v.index') });  
            compEvent.fire();
        }
    },
    
    handleIncrement: function(cmp, ev, h) {
        var current = cmp.get('v.value');
        console.log('current = ',current);
        var max = cmp.get('v.max');

        console.log('pre increment')

        if (max === undefined || current + 1 <= max) {
            console.log('increment')
            cmp.set('v.value', parseInt(current) + 1);
        }
		
        // call the event   
        let compEvent = cmp.getEvent("numberInputEvt");
        compEvent.setParams({"currentValue" : cmp.get('v.value'), "recordId" : cmp.get('v.recordId'),"index":cmp.get('v.index') });  
        compEvent.fire();
    },
    onNumberFocus : function(c,e,h){
        c.set('v.oldvalue',c.get('v.value'));
    },
    onNumberBlur : function(c,e,h){
        const value = c.get('v.value')
        const oldvalue = c.get('v.oldvalue')
        if(value != oldvalue && c.get('v.isActive')){
            // call the event   
            let compEvent = c.getEvent("numberInputEvt");
            compEvent.setParams({"currentValue" : c.get('v.value'), "recordId" : c.get('v.recordId') ,"index":cmp.get('v.index')});  
            compEvent.fire();
        }
    }
})