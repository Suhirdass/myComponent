({
    doInit : function(c, e, h) {
        h.request(c, 'opportunityProductEdit', {recordId: c.get('v.oppId')}, function(r){
            c.set('v.shoppingCart', r.shoppingCart);    
            c.set('v.pickListValues', r.pickListVal);
        });
    },
    onCancel : function(c, e, h) {
        try{
            window.open('/' + c.get('v.oppId'),'_parent');
        } catch(ex){
        }
    },
    onSave : function(c, e, h) {
        var isError = false;
        var shoppingCart = [];
        shoppingCart = c.get('v.shoppingCart');
        var i=0;
        for(var i=0;i<shoppingCart.length;i++){
            if(shoppingCart[i].Quantity==0 || shoppingCart[i].Quantity<=0 || shoppingCart[i].Quantity==''){
                isError = true;
            }
            if(shoppingCart[i].UnitPrice==0 || shoppingCart[i].UnitPrice==0.00 || shoppingCart[i].UnitPrice<=0 || shoppingCart[i].UnitPrice==''){
                isError = true;
            } 
        }
        if(isError == true){
        }   else{
            h.request(c, 'onSaveCart', {shoppingCart: c.get('v.shoppingCart')}, function(r){
                try{
                    window.open('/' + c.get('v.oppId'),'_parent');
                } catch(ex){
                }
            });
            
        }
    },	
    checkVal: function(component, event, helper){
        
        var indexed = event.getSource();
        var indexvar = event.getSource().get("v.name");
        var value = indexed.get("v.value");
        if(value == 0.0 || value == '' || value <=0 || value == 0){
            var elem = component.find(indexvar);
            $A.util.addClass(indexed, "clrRed");  
        }else{
            $A.util.removeClass(indexed, 'clrRed');
        }
        
    }
})