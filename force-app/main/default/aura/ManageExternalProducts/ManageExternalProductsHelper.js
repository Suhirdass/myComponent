({
    fetchData: function (c) {
    	//fetch product Data
    	var action = c.get("c.getProductList");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log(result.products);
                c.set('v.productList', result.products);
                c.set('v.productPriceBook', result.productPriceBookMap);
            }
        });
        $A.enqueueAction(action);    
    },
    
    initScroller : function (c,container) {
        var h = this;
        var infiniteLoading = c.find(container || 'psContainer');
        var el = infiniteLoading.getElement();
        window.setTimeout(
            $A.getCallback(function() {
                var ps = new PerfectScrollbar(el, {
                    wheelSpeed: 2,
                    wheelPropagation: true
                });
            }),1000);    
        h.getTopHeight(c, container);
    },
    
    getTopHeight: function (c, container) {
        window.setTimeout($A.getCallback(function () {
            try {
                var infiniteLoading = c.find(container || 'psContainer');
                var bounds = infiniteLoading.getElement().getBoundingClientRect();
                c.set('v.topHeight', (bounds.top + 'px'));
            } catch (e) { }
        }), 250);
    },
    
    saveRecords: function (c,e,h) {
        try{
            var h = this;
            h.showSpinner(c);
            h.request(c, 'saveProducts', {productList: c.get("v.productList")}, function (r) {
                console.log("saveNewProduct:::",r.isValid);
                if(r.isValid == true){
                	h.success({ message: ('Successfully products updated') });    
                }	
                h.hideSpinner(c);
            });
        } catch(error){
            console.log("Error:",error);
        }
    },
    showSpinner: function (c, e, h) {
        var spinner = c.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
    
    hideSpinner: function (c, e, h) {
        var spinner = c.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    }
})