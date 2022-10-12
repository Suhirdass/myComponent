({
    doInit : function(c, e, h) {
        h.getRecords(c,e);
    },
    
    changeStr : function(c, e, h) {
        h.fetchProductFilter(c,e);
    },
    
    addToCartShpg : function(c, e, h) {
        var selValue = e.getSource().get("v.value");
        c.set('v.prodSelect',false);
        h.addToProduct(c,e,selValue);
    },
    
    removeFromShoppingCart : function(c, e, h) {
        var priceBookId = e.currentTarget.dataset.id; 
        h.request(c, 'removeProduct', {recordId: c.get('v.oppId'), toSelectId: priceBookId,forDeletion1 : c.get('v.forDeletion'),shoppingCart1: c.get('v.shoppingCart')}, function(r){
            c.set('v.AvailableProducts', r.AvailableProducts);
            c.set('v.forDeletion', r.forDel);
            c.set('v.shoppingCart', r.shoppingCart);
            c.set('v.prodSelect',r.prodSelect);
        });
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
            
        }
        else{
            h.request(c, 'onSaveCart', {shoppingCart: c.get('v.shoppingCart'), forDeletion: c.get('v.forDeletion')}, function(r){
                try{
                    window.location.href = '/' + c.get('v.oppId'); 
                } catch(ex){
                    console.log('Exception '+ex);
                }
            });
        }
    },
    
    onSortOrders : function(c, e, h) {
        try{
            var productId = e.currentTarget.dataset.id;
            h.request(c, 'sortOrderList', {recordId: c.get('v.oppId'), fieldName: productId,orderSort : c.get('v.sortOrder')}, function(r){
                c.set('v.AvailableProducts', r.AvailableProducts);
                c.set('v.sortOrder',r.sortOrder);
                c.set('v.sortField',r.sortField);
            });
        }catch(err){
            console.log('Error:',err);
        }
    },
    
    onCancel : function(c, e, h) {
        try{
            window.location.href = '/' + c.get('v.oppId'); 
        } catch(ex){
            console.log('Exception '+ex);
        }
    }, 
    
    openModel: function(c, e, h) {
        try{
            h.request(c, 'getPriceBook', {}, function(r){
                c.set("v.pricebookList", r.pblist);
                c.set("v.isModalOpen", true);
            });
        }catch(err){
            console.log('Error:',err);
        }
    },
    
    closeModel: function(component, event, helper) {
        component.set("v.isModalOpen", false);
    },
    
    savePBook: function(c, e, h) {
        c.get("v.pbook");
        try{
            h.request(c, 'savePriceBook', { oppId : c.get("v.oppId"), priceBookId :  c.get("v.pbook"),forDeletion1 : c.get('v.forDeletion'),shoppingCart1: c.get('v.shoppingCart') }, function(r){
                if(r.successMessage == "Success"){
                    c.set("v.isModalOpen", false);
                    c.set("v.isToasterOpen", true);
                    window.setTimeout(
                        $A.getCallback(function() {
                            window.location.reload();
                        }), 800
                    ); 
                }
                
            });
        }catch(err){
            console.log('Error:',err);
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