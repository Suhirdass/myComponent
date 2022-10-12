({
    toggleHelper : function(component,event) {
        var helpText = component.get('v.helpText');
        if(helpText !== ''){
            var toggleText = component.find("tooltip");
            $A.util.toggleClass(toggleText, "toggleme");
        }
        
    }
})