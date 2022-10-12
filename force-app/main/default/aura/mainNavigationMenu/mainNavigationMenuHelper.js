({
    navigate: function(c, e){
        var id = e.target.dataset.menuItemId;
        console.log('id-->',id);
        if(id){
            sessionStorage.setItem('serviceTicketId', '');
            sessionStorage.setItem('retailDeliveryTicketId', '');
            sessionStorage.setItem('newProductRequestId', '');
            sessionStorage.setItem('isViewProductRequest', false);
            sessionStorage.setItem('fromBrandProduct', false);
            c.getSuper().navigate(id);
            console.log('Firing BreadCrumb Event');
            window.setTimeout($A.getCallback(function(){
                
                var bradcrumbIds = e.target.dataset.bradcrumbIds;
                var bradcrumb = e.target.dataset.bradcrumb;
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: bradcrumb, breadCrumbIds : bradcrumbIds}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: bradcrumb, breadCrumbIds : bradcrumbIds}).fire();
                
            }),100)
            
            
        }
    },
})