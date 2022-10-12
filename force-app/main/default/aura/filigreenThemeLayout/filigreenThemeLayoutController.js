({
    init: function (c, e, h) {
        document.addEventListener('contextmenu', event => event.preventDefault());
        try {
            /*var brd = sessionStorage.getItem('breadCrumb');
            if(brd){
                brd = JSON.parse(brd);
                console.log('init:',brd);
                h.updateBreadCrumb(c,brd.breadCrumbString,brd.breadCrumbIds);
            }else{
                c.set("v.breadcrumbs", [{ label: "Home", name: "0" }]);
            }*/
            
            var action = c.get('c.filigreenThemeInit');
            action.setCallback(this, function(response) {
                console.log('response = ',response.getReturnValue());
                var r = response.getReturnValue();
                c.set('v.isBrand',r.data.isBrand);
                c.set('v.isLimited',r.data.isLimited);
                c.set('v.baseUrl',r.data.baseUrl);
                let errMsg = r.data.mobileErr;
                var mobile = (/iphone|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));
                if (mobile) {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": errMsg,
                        "type": 'error'
                    });
                    toastEvent.fire();
                    window.setTimeout($A.getCallback(function(){
                        var baseUrl = c.get('v.baseUrl');
                        sessionStorage.removeItem('breadCrumb');
                        window.location.href = baseUrl + '/secur/logout.jsp';
                    }),500)
                }
            });
            $A.enqueueAction(action);
            
            //const prefix = href => '/filigreenb2b/s' + href
            
        } catch (er) {
            console.log('init Error :', er);
        }
        /*cmp.set("v.breadcrumbs", [
            { label: "Home", href: prefix('/') },
            { label: "Orders", href: prefix('/orders') },
            { label: "View Marketplace", href: prefix('/products') },
        ]);*/
    },
    navigateToCart: function (c, e, h) {
        var isBrand = c.get('v.isBrand');
        console.log('isBrand = ',isBrand);
        sessionStorage.setItem('retailDeliveryTicketId','');
        window.setTimeout($A.getCallback(function(){
            h.updateBreadCrumb(c,(isBrand ? 'Create Order' : 'Cart'));
            $A.get('e.force:navigateToURL').setParams({
            	url: ((isBrand) ? '/newbrandorder' : '/cart'),
            	isredirect: true
        	}).fire();
        }),100);
        
    },
    updateCartTotal: function (c, e, h) {
    	try {
            var cartTotal = e.getParam('cartTotal');
            console.log("updateCartTotal calling...", cartTotal);
            
            c.set('v.cartTotal', cartTotal);
       } catch (er) {
            console.log('updateCartTotal Error :', er);
       }
            
   },
   
});