({
    getRecords : function(c,e) {
        var h = this;
        h.request(c, 'opportunityProductEntry', {recordId: c.get('v.oppId')}, function(r){
            c.set('v.shoppingCart', r.shoppingCart);    
            c.set('v.AvailableProducts', r.AvailableProducts);
            c.set('v.pickListValues', r.pickListVal);
            c.set('v.oppRecord',r.oppRec);
            c.set('v.theBook',r.theBook);
            c.set('v.prodSelect',r.prodSelect);
        });
    },
    
    fetchProductFilter : function(c,e) {
        var h = this;
        h.request(c, 'fetchFilterProducts', {str: c.get('v.searchStr'), recordId: c.get('v.oppId')}, function(r){
            c.set('v.AvailableProducts', r.AvailableProducts);
            c.set('v.overLimit',r.overLimit);
        });
    },
    
    addToProduct : function(c,e,selValue) {
        var h = this;
        
        try{
            h.request(c, 'addToShoppingCart', {recordId: c.get('v.oppId'), toSelectId: selValue,shoppingCart1: c.get('v.shoppingCart'),fieldName: c.get('v.sortField'),orderSort : c.get('v.sortOrder'),availableList : c.get('v.AvailableProducts')}, function(r){
                c.set('v.AvailableProducts', r.AvailableProducts);
                c.set('v.shoppingCart', r.shoppingCart);
                
            });            
        } catch(exp){
            console.log(exp);
        }
    },    
})