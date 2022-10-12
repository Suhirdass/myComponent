({
    setPagination : function(c,e,h,fromInit){
        var filters = { orderByField: 'product.name', isASC: true };
        c.set('v.filters', filters);
        let products = c.get('v.allRetailDeliveryTicketLineItems');
        let rdtLineItems = c.get('v.retailDeliveryTicketLineItems');
        let setOfIds = [];
        rdtLineItems.forEach((itemRec) => {
            setOfIds.push(itemRec.Product);
        });
            var arr = [];
            products.forEach((item) => {
            arr.push(item.Product);
        });
            h.initPagination(c, arr, filters);
	},
	searchData : function(c,e,h){
        var searchInput = c.find('searchRec');
        var searchText = searchInput.getElement().value;
        c.set('v.searchString',searchText);
                
        var allData = c.get('v.allRetailDeliveryTicketLineItems');
        
        var searchedData = [];
        for(var i=0; i<allData.length; i++){                
            if(searchText != ''){
                var a = ''+allData[i].salesPrice;
                var b = ''+searchText;
                
                if(allData[i].shortDescription != undefined && allData[i].shortDescription.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }else if(allData[i].brandName != undefined && allData[i].brandName.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }else if(allData[i].productName != undefined && allData[i].productName.toLowerCase().includes(searchText.toLowerCase())){
                    searchedData.push(allData[i]);
                }else if(a != undefined && a.includes(b)){
                    searchedData.push(allData[i]);
                }
            }else{
                searchedData.push(allData[i]);   
            }
        }
        c.set('v.retailDeliveryTicketLineItems',searchedData); 
        let products = c.get('v.retailDeliveryTicketLineItems');
        var filters = { orderByField: 'product.name', isASC: true };
        var arr = [];
        products.forEach((item) => {
            arr.push(item.Product);
        });
		h.initPagination(c, arr, filters);
	},
	sortAllProducts : function(c,e,h,allRetailDeliveryTicketLineItems,sortOrder,currentSortField){
        allRetailDeliveryTicketLineItems.sort(function (a, b) {
            var valueA;
            var valueB;
            if(currentSortField != 'totalPrice'){
            	valueA = a[currentSortField];
             	valueB = b[currentSortField];
                if(currentSortField != 'availableQty' && currentSortField != 'salesPrice'){
                	valueA = valueA.toUpperCase();  
                    valueB = valueB.toUpperCase();
                }
            }else{
				var salesPriceA = a.salesPrice;
             	var salesPriceB = b.salesPrice;
                
                var orderQtyA = a.orderQty;
             	var orderQtyB = b.orderQty;
                
                var MOQA = a.MOQ;
             	var MOQB = b.MOQ;
                
                valueA = salesPriceA * orderQtyA * MOQA;
                valueB = salesPriceB * orderQtyB * MOQB;
            }
            let comparison = 0;
            if (valueA > valueB) {
                comparison = 1;
            } else if (valueA < valueB) {
                comparison = -1;
            }
            if(sortOrder == 'ASC')
                return comparison;
            else
                return comparison * -1;
        }) 
		return allRetailDeliveryTicketLineItems;
	},
})