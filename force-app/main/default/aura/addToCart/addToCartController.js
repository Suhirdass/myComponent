({
    onInit : function(c, e, h) {
    },
    onAddToCart: function(c, e, h){
        if(c.get('v.isPublic')){
            h.redirect('/', true);    
        }else{
            h.addToCart(c, false);
        }
        
    },
    onProductDetails: function(c, e, h){
        console.log('isPublic::',c.get('v.isPublic'));
        var product = c.get('v.product');
        sessionStorage.setItem('pricebookEntry', product.price.id);
        if(c.get('v.isPublic')){
            h.redirect('/filigreenproduct', true);    
        }else{
            h.redirect('/product', true);        
        }
    },
    
    orderNow: function(c, e, h){
        h.redirect('/product', true);  
    },
    
    onSampleRequest: function(c, e, h){
        h.addToCart(c, true);
    },
    onNotifyMe: function(c, e, h){
        var product = c.get('v.product');
        h.request(c, 'notifyMe', {productId: product.id}, function(r){
            product.notifyRequested = true;
            c.set('v.product', product);
            h.success({message: 'We will notify you.'});
        });
    },
    onViewCompliance:function(c,e,h){
        var product = c.get('v.product');
        if(product.complianceFileId){
            try{
                var complianceFileIds = product.complianceFileId.split(',');
                console.log('complianceFileIds = '+complianceFileIds.slice(0, -1));
                $A.get('e.lightning:openFiles').fire({
                    recordIds: complianceFileIds.slice(0, -1)
                });    
            } catch(error){
                console.log('Error = '+complianceFileIds);
            }
        }
        
        /*c.find("navService").navigate({
            type: "standard__recordPage",
            attributes: {
                objectApiName: "Document",
                recordId: "015g0000000w4XjAAI",
                actionName: "view"
            }
        }, true);*/
    }
})