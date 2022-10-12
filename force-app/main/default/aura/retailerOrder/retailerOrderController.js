({
    onInit: function (c, e, h) {
        try {
            c.set('v.recordId', sessionStorage.getItem('retailorderId'));
        } catch (err) { }
        
        h.request(c, 'getRetailOrder', { recordId: c.get('v.recordId') }, function (r) {
            console.log("getRetailOrder:",r);
            c.set('v.Retail_MOV_Fee',r.Retail_MOV_Fee);
            c.set('v.retailOrder', r.retailOrder);
            var isDisabled = true;
            if(r.retailOrder.SMId != '' && r.retailOrder.SMStatus === 'Shipment Complete' && (r.retailOrder.status === 'Approved' || r.retailOrder.status === 'Shipped')){
                isDisabled = false;
            }
            c.set('v.isDisabled',isDisabled);
            c.set('v.RMAList',r.returnOrders);
            c.set('v.invoices',r.invoices);
            var invFile = [];
            for(var key in r.invoiceFileIds){
                invFile.push({value:r.invoiceFileIds[key], key:key});
            }
            c.set('v.invoicesIdsList', invFile);
            
            var smFile = [];
            for(var key in r.SMFileIds){
                smFile.push({value:r.SMFileIds[key], key:key});
            }
            c.set('v.smIdsList', smFile);
            
            c.set('v.shipManifests',r.shipManifests);
            c.set('v.products',r.retailOrder.items);
            c.set('v.allProducts',r.retailOrder.items);
            var filters = { orderByField: 'product.shortDescription', isASC: true };
            let items = r.retailOrder.items;
            let arr = [];
            items.forEach((item) => {
                arr.push(item.id);
            });
            h.initPagination(c, arr, filters);
        });
    },
                 
    fetchProducts: function (c, e, h) {
        var ids = e.getParam('ids');
        var arr = [];
        let products = c.get('v.allProducts');
        for(let i = 0; i< products.length; i++){
            if(ids.includes(products[i].id)){
                arr.push(products[i]);
            }
        }
        c.set('v.products',arr);
    },
                
    onViewInvoice : function(c,e,h){
        var dataset = e.currentTarget.dataset;
        try{
            var complianceFileIds = dataset.id.split(',');
            console.log('complianceFileIds = '+complianceFileIds.slice(0, -1));
            $A.get('e.lightning:openFiles').fire({
                recordIds: complianceFileIds.slice(0, -1)
            });
        } catch(error){
            console.log('Error = '+complianceFileIds);
        }
    },            
                
    onChangeSearchProduct: function (c, e, h) {
        var searchInput = c.find('searchRec');
        var searchText = searchInput.getElement().value;
        c.set('v.searchString',searchText);
        let searchedData = [];
        let products = c.get('v.allProducts');
        
        for(var i=0; i<products.length; i++){                
            if(searchText != '' || searchText != null || searchText != undefined){
                var b = ''+searchText;
                var unitPrice = ''+ products[i].unitPrice;
                var excTex = ''+ products[i].lineTotalExciseTax;
                if(products[i].name != undefined && products[i].name.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(products[i]);
                } else if(products[i].producerName != undefined && products[i].producerName.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(products[i]);
                } else if(products[i].shortDescription != undefined && products[i].shortDescription.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(products[i]);
                } else if(unitPrice != undefined && unitPrice.includes(b)){
                    searchedData.push(products[i]);
                } else if(excTex != undefined && excTex.includes(b)){
                    searchedData.push(products[i]);
                }
            } else{
                searchedData.push(allData[i]);   
            }
        }
        let arr = [];
        searchedData.forEach((item) => {
            arr.push(item.id);
        });
        c.set('v.products',searchedData);
        h.initPagination(c, arr, c.get('v.filters'));
    },
            
    sortProducts: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        var sortType = c.get('v.sortType');
        if(sortType == 'ASC')
            sortType = 'DESC';
        else
            sortType = 'ASC';
        c.set('v.sortType',sortType);
        c.set('v.sortField',sortfield);
        
        c.set('v.searchString','');
        let products = c.get('v.allProducts');
        products.sort(function (a, b) {
            let bandA = a.shortDescription.toUpperCase();
            let bandB = b.shortDescription.toUpperCase();   
            if(sortfield == 'brandName'){
                console.log('sortfield = ',sortfield);
                bandA = a.name.toUpperCase();
                bandB = b.name.toUpperCase();   
            } else if(sortfield == 'producerName'){
                bandA = a.producerName.toUpperCase();
                bandB = b.producerName.toUpperCase();   
            } else if(sortfield == 'total'){
                bandA = a.total;
                bandB = b.total;   
            } else if(sortfield == 'unitPrice'){
                bandA = a.unitPrice;
                bandB = b.unitPrice;   
            } else if(sortfield == 'lineTotalQty'){
                bandA = a.lineTotalQty;
                bandB = b.lineTotalQty;   
            }
            
            let comparison = 0;
            if (bandA > bandB) {
                comparison = 1;
            } else if (bandA < bandB) {
                comparison = -1;
            }
            if(sortType == 'ASC')
                return comparison;
            else
            	return comparison * -1;
        });
        let arr = [];
        products.forEach((item) => {
            arr.push(item.id);
        });
        c.set('v.products',products);
        h.initPagination(c, arr, c.get('v.filters'));
    },   
            
    printDetails: function (c, e, h) {
        var currentUrl = window.location.href;
        currentUrl = currentUrl.replace('/s/viewretailorder','/apex/printRetailOrderDetails?recordId='+c.get('v.recordId'));
        console.log('currentUrl::',currentUrl);
        window.open(currentUrl,'_blank');   
    },
                
    onSMClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        h.navigateToRecord(c,dataset.id, "detail");
    },
    onOrderCancel: function (c, e, h) {
        var orderId = e.getSource().get('v.value');
        c.set('v.isShowConfirm',true);
        window.setTimeout($A.getCallback(function(){
            const modal = document.getElementById('confirm-modal');
        	if (modal) modal.classList.add('is-active');
        }),100);
        
        /*if (confirm("Are you sure, you want to Cancel Order?")) {
            h.request(c, 'cancelOrder', { orderId: orderId }, function (r) {
                h.success({ message: 'Order cancelled successfully.' });
                h.request(c, 'getOrders', {}, function (r) {
                    c.set('v.orders', r.orders);
                });
            });
        }*/
    },
            onClone: function (c,e,h){
         //alert('1');
         try{
             var newRO = c.get('v.retailOrder');
             var roProducts =c.get('v.allProducts');
             console.log('newRO:', JSON.stringify(newRO));
             console.log('roProducts:', roProducts.length);
             var LicenseAddress ='';
             h.request(c, 'checkStateLicenseForCloneRO', {retailerOrderId: newRO.id}, function(r){
                     LicenseAddress = r.LicenseAddress;
                     sessionStorage.setItem('LicenseAddress', LicenseAddress[0].id);
                 });
             var Retail_MOV_Fee = c.get('v.Retail_MOV_Fee');
             for (var i = 0; i < roProducts.length; i++) {
                 if(roProducts[i].name != Retail_MOV_Fee){
                     var addToCartData = {productId: roProducts[i].productId,
                                          pricebookId: roProducts[i].pricebookId,
                                          quantity:  roProducts[i].quantity,
                                          MOQ: roProducts[i].MOQ,
                                          unitPrice: roProducts[i].unitPrice,
                                          isUpdate: false,
                                          isSample: false};
                     
                     h.request(c, 'addToCart', {addToCartData: JSON.stringify(addToCartData)}, function(r){
                         
                     });
                 }
                 if(i == roProducts.length-1){
                     h.redirect('/cart', true);
                     
                     //console.log('LicenseAddress:', LicenseAddress);
                 }
             }
             
         } catch (error) {
             console.log('Error:', error);
         }
      },
    handleConfirmEvent :function(c,e,h){
        var isConfirm = e.getParam("isConfirm");
        if(isConfirm){
            h.request(c, 'cancelOrder', { orderId: c.get('v.retailOrder').id }, function (r) {
                //h.success({ message: 'Order cancelled successfully.' });
                h.request(c, 'getOrders', {}, function (r) {
                    const modal = document.getElementById('confirm-modal');
                    if (modal) modal.classList.remove('is-active');
                    window.location.reload();
                    c.set('v.isShowConfirm',false);
                });
            });
        }
    },       
    onViewRMA:function(c,e,h){
        var dataset = e.currentTarget.dataset;
        sessionStorage.setItem('RMAId', dataset.id);
        h.redirect('/rmadetails', true);
    },
    onEditRMA:function(c,e,h){
        sessionStorage.setItem('RMAId', e.getSource().get('v.value'));
        h.redirect('/rmaedit', true);
    },
    onNewRMA:function(c,e,h){
        var orderId = e.getSource().get('v.value');
        sessionStorage.setItem('retailRMAorderId', orderId);
        h.redirect('/newrmarequest', true);
    },
    onProductClick: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        //sessionStorage.setItem('pricebookEntry', dataset.id);
        //h.redirect('/product', true);
        $A.createComponent('c:productDetails', {
            priceId: dataset.id,
            brandId:'',
            isBrand: true,
            isPublic:false,
            fromPublicProducts: false,
            fromOnClickProduct:true,
            isModalDisplay: true
        }, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    // header: product.name,
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cUtility fix-close-button productDetailsModal'
                });
            }
        });
    },
        
    onBrandClick : function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        sessionStorage.setItem('brandId', dataset.id);
        h.redirect('/brand', true);
    },       
    onContinueShopping: function (c, e, h) {
        h.redirect('/products', true);
    },
    onViewCompliance:function(c,e,h){
        var fileIds = e.target.dataset.id;//e.getSource().get('v.value');
        console.log("fileIds::",fileIds);
        if(fileIds){
            fileIds = fileIds.split(',');
            $A.get('e.lightning:openFiles').fire({
                recordIds: fileIds
            });
        }
        
    }
})