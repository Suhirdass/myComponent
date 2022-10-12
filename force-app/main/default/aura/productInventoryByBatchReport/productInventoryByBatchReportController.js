({
    doInit : function(c, event, h) {
        c.set('v.searchString','');
        h.getProdcutInvtory(c, event, h, 'Product_Name__r.Product_Short_Description__c','ASC','',10);    
    },
    next : function(c, event, h) {
        var totalRec = c.get('v.totelRec');
        var endRec = c.get('v.endRec');
        if(endRec < totalRec){
            var p = c.get('v.pageSize');
            var s = c.get('v.startRec') + p;
            var e = s + p;
            h.request(c, 'changePageRecords', {
                productInventoryWrapperData: JSON.stringify(c.get('v.totleProductInventoryWrapperList')),
                productListData: JSON.stringify(c.get('v.productList')),
                pageSize: p,
                startRec: s,
                endRec: e,
            }, function(r){
                h.setValues(c, event, h, r);
                var pageNumbers  = c.get('v.pageNumbers');
                if(r.cuurentPage > pageNumbers[pageNumbers.length-1]){
                    pageNumbers = [];
                    for (var i = r.cuurentPage; i <= r.totelPage; i++) {
                        if(pageNumbers.length < 5)
                            pageNumbers.push(i);
                    }
                    c.set('v.pageNumbers', pageNumbers);
                }
            });  
        }
    },
    prev : function(c, event, h) {
        var s = c.get('v.startRec');
        if(s != 1){
            var p = c.get('v.pageSize');
            var t = c.get('v.totelRec');
            var e = c.get('v.endRec');        
            if(e == t){
                e = (c.get('v.totelPage') * p) - p;	 
                s = e - p + 1;
            }else{
                s = s - p;
                e = e - p;
            }
            h.request(c, 'changePageRecords', {
                productInventoryWrapperData: JSON.stringify(c.get('v.totleProductInventoryWrapperList')),
                productListData: JSON.stringify(c.get('v.productList')),
                pageSize: p,
                startRec: s,
                endRec: e,
            }, function(r){
                h.setValues(c, event, h, r);
                var pageNumbers  = c.get('v.pageNumbers');
                if(r.cuurentPage < pageNumbers[0]){
                    pageNumbers = [];
                    for (var i = r.cuurentPage-4; i <= r.cuurentPage; i++) {
                        if(pageNumbers.length < 5)
                            pageNumbers.push(i);
                    }
                    c.set('v.pageNumbers', pageNumbers);
                }
            });   
        }
    },
    handleChange : function(c, event, h) {
        var p = event.getParam("value");
        var s = 1; 
        var e = s + parseInt(p) - 1;
        h.request(c, 'changePageRecords', {
            productInventoryWrapperData: JSON.stringify(c.get('v.totleProductInventoryWrapperList')),
            productListData: JSON.stringify(c.get('v.productList')),
            pageSize: p,
            startRec: s,
            endRec: e,
        }, function(r){
            h.setValues(c, event, h, r);
            var pageNumbers = [];
            for (var i = 1; i <= r.totelPage; i++) {
                if(pageNumbers.length < 5)
            		pageNumbers.push(i);
        	}
            c.set('v.pageNumbers', pageNumbers);
        });     
    },
    sortInventory : function(c, event, h) {
        var dataset = event.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        var oldSortField = c.get('v.sortField');
        var sortOrder = c.get('v.sortOrder');
        if(sortfield != oldSortField)
        	sortOrder = 'ASC';
        else{
            if(sortOrder == 'ASC')
                sortOrder = 'DESC';
            else
                sortOrder = 'ASC';
        }
        var searchText = c.get('v.searchString');
        var p = c.get('v.pageSize');
        h.getProdcutInvtory(c, event, h, sortfield,sortOrder,searchText,p);    
    },
    exportData : function(c, event, h) {
        var sortfield = c.get('v.sortField');
        var sortOrder = c.get('v.sortOrder');
        var searchText = c.get('v.searchString'); 
        var currentUrl = window.location.href; 
        if(c.get('v.isCommunityPlusUser'))
        	currentUrl = currentUrl.replace('/s/Inventory-by-Site-Batch','/apex/productInventoryBatchReportExport?sortfield='+sortfield+'&sortOrder='+sortOrder+'&searchText='+searchText);
        else
            currentUrl = currentUrl.replace('/lightning/n/Product_Inventory_By_Batch_Report','/apex/productInventoryBatchReportExport?sortfield='+sortfield+'&sortOrder='+sortOrder+'&searchText='+searchText);
            
        window.open(currentUrl, '_self');     
    },
    changeChartDataSortField : function(c, event, h) {
        var chartSortField = event.getParam("value");
        var chartSortOrder = c.get('v.chartSortOrder');
        c.set('v.chartSortField',chartSortField);
        h.sortChart(c, event, h, chartSortField,chartSortOrder);
    },
    changeChartDataSortOrder : function(c, event, h) {
        var chartSortOrder = event.getParam("value");
        var chartSortField = c.get('v.chartSortField');
        c.set('v.chartSortOrder',chartSortOrder);
        h.sortChart(c, event, h, chartSortField,chartSortOrder);
    },
    changeChartType : function(c, event, h) {
    	var chartType = event.getParam("value");  
        c.set('v.chartType',chartType);
        var data = c.get('v.data');
        h.showChangedChartType(c, event, h,data);
    },
    onProductDetail :function(c,e,h){
        if(c.get('v.isCommunityPlusUser')){
        	var priceId = e.currentTarget.dataset.id;  
        	sessionStorage.setItem('pricebookEntry', priceId);
        	h.redirect('/product', true);    
        }else{
        	var productId = e.currentTarget.dataset.productid;  
            var currentUrl = window.location.href; 
            currentUrl = currentUrl.replace('lightning/n/Product_Inventory_By_Batch_Report','/'+productId);
            window.open(currentUrl, '_self'); 
        }
    },
    onViewSite: function (c, e, h) {
        var dataset = e.currentTarget.dataset;
        if(c.get('v.isCommunityPlusUser'))
        	h.navigateToRecord(c,dataset.id, "detail");
        else{ 
            var currentUrl = window.location.href; 
            currentUrl = currentUrl.replace('lightning/n/Product_Inventory_By_Batch_Report','/'+dataset.id);
            window.open(currentUrl, '_self'); 
        }
    },
    searchProduct: function (c, e, h) {
        var searchInput = c.find('searchRec');
        var searchText = searchInput.getElement().value;
        c.set('v.searchString',searchText);
        var sortfield = c.get('v.sortField');
        var sortOrder = c.get('v.sortOrder');
        var p = c.get('v.pageSize');
        h.getProdcutInvtory(c, e, h, sortfield,sortOrder,searchText,p);    
    },
    onPageChange: function (c, e, h) {
    	var pageNo = parseInt(e.getSource().get('v.value'), 10);
        if (pageNo !== c.get('v.currentPage')) {
        	var p = c.get('v.pageSize');
            var s = 1;
            for(var i=pageNo-1;i>0;i--){
                s = s+p;
            }
            var e = s + p-1;
            h.request(c, 'changePageRecords', {
                productInventoryWrapperData: JSON.stringify(c.get('v.totleProductInventoryWrapperList')),
                productListData: JSON.stringify(c.get('v.productList')),
                pageSize: p,
                startRec: s,
                endRec: e,
            }, function(r){
                h.setValues(c, event, h, r);
            });     
        }    
    }
})