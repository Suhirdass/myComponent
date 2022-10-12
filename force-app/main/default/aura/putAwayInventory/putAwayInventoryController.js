({
	doInit : function(c, e, h) {
            h.request(c, 'putAwayInventoryCtrl', {}, function(r){
            c.set('v.setInventoryPositions',r.putAway);
            
            c.set('v.masterInventoryPositions',r.masterInventoryPositions);
            c.set('v.inventoryPositions',r.masterInventoryPositions);
            c.set('v.siteOptions',r.siteOptions);
            c.set('v.hasInventoryPosition',r.hasInventoryPosition);
                   c.set('v.DisplayEyeIcon',r.DisplayEyeIcon);
            console.log('DisplayEyeIcon',r.DisplayEyeIcon);
            console.log('setInventoryPositions',r.putAway);    
            console.log('masterInventoryPositions',r.masterInventoryPositions);            

            var setInventoryPositionslst = c.get('v.setInventoryPositions');
                var datacon
     		 var setinv = c.get('v.setInventoryPositions');
               
                
                
                
     /*  setinv.forEach(function (poli, index){
           if(poli.DisplayEyeIconvalues){
               datacon = (poli.DisplayEyeIconvalues).replace(',','\n');
              poli.DisplayEyeIconvalues = datacon;
               console.log(poli.DisplayEyeIconvalues);
           }
          
  
       });*/
            
            var invPosition = r.inventoryPositionById;
            var invPositionById = [];
            for ( var key in invPosition ) {
                invPositionById.push({value:invPosition[key], key:key});
            }
            c.set("v.inventoryPositionById", invPositionById);
            
            var rackLevels = r.rackLevelsByRackId;
            var rackLevelsById = [];
            for ( var key in rackLevels ) {
                rackLevelsById.push({value:rackLevels[key], key:key});
            }
            c.set("v.rackLevelsByRackId", rackLevelsById);
            
            var binLocations = r.binLocationsByRackLevelId;
            var binLocationById = [];
            for ( var key in binLocations ) {
                binLocationById.push({value:binLocations[key], key:key});
            }
            c.set("v.binLocationsByRackLevelId", binLocationById);
            
            
            var binConsumedCapacityById = r.binConsumedCapacityById;
            var binConsumedById = [];
            for ( var key in binConsumedCapacityById ) {
                binConsumedById.push({value:binConsumedCapacityById[key], key:key});
            }
            c.set("v.binConsumedCapacityById", binConsumedById);
            
            var reA = /[^a-zA-Z]/g;
            var reN = /[^0-9]/g;
            
            for(var i =0 ; i< r.masterInventoryPositions.length ; i++){
                var rackArr = r.masterInventoryPositions[i].rackOptionsL;
                var rackValue = [];
                let rackMap = new Map();
                for(let j = 0; j < rackArr.length; j++){
                    rackValue.push(rackArr[j].value);
                    rackMap.set(rackArr[j].value,rackArr[j].label);
                }
                
                var rack = rackValue.sort(sortAlphaNum);
                var rackNewValue = [];
                let location = [];
                for(let j=0 ; j< rack.length ; j++){
                    let rackName = rack[j].split('-');
                    
                    if(location.includes(rack[j])){
                    	continue;   
                    }
                    
                    //console.log('rackName = '+rackName);
                    for(let k=0 ; k< rack.length ; k++){
                        let rkName = rack[k].split('-');
                        if(rackName[0] == rkName[0]){
                            rackNewValue.push({label: rackMap.get(rack[k]), value : rack[k]});	  
                            location.push(rack[k]);
                        }
                    }   
                }
                r.masterInventoryPositions[i].rackOptionsL = rackNewValue;
            }
            
            function sortAlphaNum(a, b) {
                var aA = a.replace(reA, "");
                var bA = b.replace(reA, "");
                if (aA === bA) {
                    var aN = parseInt(a.replace(reN, ""), 10);
                    var bN = parseInt(b.replace(reN, ""), 10);
                    return aN === bN ? 0 : aN > bN ? 1 : -1;
                } else {
                    return aA > bA ? 1 : -1;
                }
            }
            
            let totalRecountCount = r.masterInventoryPositions.length; 
            let totalPage = Math.ceil(totalRecountCount / c.get('v.pageSize'));
            let setInventoryPositions = r.masterInventoryPositions.slice(0,c.get('v.pageSize'));
            let endingRecord = c.get('v.pageSize');
            c.set('v.totalRecountCount ',totalRecountCount);
            c.set('v.totalPage ',totalPage);
            c.set('v.setInventoryPositions ', setInventoryPositions);
            c.set('v.endingRecord ',endingRecord);
            
        });
	},
    showToolTip : function(c, e, h) {
        c.set("v.tooltip" , true);
        
    },
    HideToolTip : function(c,e,h){
        c.set("v.tooltip" , false);
    },
    onWarehouseChange : function(c, e, h) {
    	console.log(c.find("warehouse").get("v.value")); 
        c.set('v.selectedSiteId',c.find("warehouse").get("v.value"));
        h.request(c, 'onSiteChange', {siteId : c.find("warehouse").get("v.value"),direction: c.get('v.direction'), orderField : c.get('v.orderField')}, function(r){
            console.log('putAwayInventoryCtrl::',r.siteOptions);
            c.set('v.setInventoryPositions',r.putAway);
            c.set('v.hasInventoryPosition',r.hasInventoryPosition);
            c.set('v.masterInventoryPositions',r.masterInventoryPositions);
            c.set('v.inventoryPositions',r.masterInventoryPositions);
            
            var reA = /[^a-zA-Z]/g;
            var reN = /[^0-9]/g;
            
            for(var i =0 ; i< r.masterInventoryPositions.length ; i++){
                var rackArr = r.masterInventoryPositions[i].rackOptionsL;
                var rackValue = [];
                let rackMap = new Map();
                for(let j = 0; j < rackArr.length; j++){
                    rackValue.push(rackArr[j].value);
                    rackMap.set(rackArr[j].value,rackArr[j].label);
                }
                
                var rack = rackValue.sort(sortAlphaNum);
                var rackNewValue = [];
                let location = [];
                for(let j=0 ; j< rack.length ; j++){
                    let rackName = rack[j].split('-');
                    
                    if(location.includes(rack[j])){
                    	continue;   
                    }
                    
                    //console.log('rackName = '+rackName);
                    for(let k=0 ; k< rack.length ; k++){
                        let rkName = rack[k].split('-');
                        if(rackName[0] == rkName[0]){
                            rackNewValue.push({label: rackMap.get(rack[k]), value : rack[k]});	  
                            location.push(rack[k]);
                        }
                    }   
                }
                r.masterInventoryPositions[i].rackOptionsL = rackNewValue;
            }
            
            function sortAlphaNum(a, b) {
                var aA = a.replace(reA, "");
                var bA = b.replace(reA, "");
                if (aA === bA) {
                    var aN = parseInt(a.replace(reN, ""), 10);
                    var bN = parseInt(b.replace(reN, ""), 10);
                    return aN === bN ? 0 : aN > bN ? 1 : -1;
                } else {
                    return aA > bA ? 1 : -1;
                }
            }
            
            
            let totalRecountCount = r.masterInventoryPositions.length; 
            let totalPage = Math.ceil(totalRecountCount / c.get('v.pageSize'));
            let setInventoryPositions = r.masterInventoryPositions.slice(0,c.get('v.pageSize'));
            let endingRecord = c.get('v.pageSize');
            c.set('v.totalRecountCount ',totalRecountCount);
            c.set('v.totalPage ',totalPage);
            c.set('v.setInventoryPositions ', setInventoryPositions);
            c.set('v.endingRecord ',endingRecord);
            c.set("v.selectedSiteId", r.selectedSiteId);
            //c.set('v.siteOptions',r.siteOptions);
        });
    },
    
    updateInvLocation : function(c, e, h) {
    	let masterInventoryPositions = c.get('v.masterInventoryPositions');
        var JSONStr; 
        let masterInventoryPositionselect = [];
        masterInventoryPositions.find(function(element) {
         //   if(element.isSelected == true){
            if(element.qtyToPutAway == '' || element.qtyToPutAway == undefined || element.qtyToPutAway == null){
                element.qtyToPutAway = 0.00;    
                
            }  
            //}
            if(element.isSelected == true){
               // c.set('v.masterInventoryPositions',element);
                masterInventoryPositionselect.push(element);
            }
        });
       // console.log('masterInventoryPositionselect'.masterInventoryPositionselect.length);
        JSONStr = JSON.stringify(masterInventoryPositionselect); 
       // var JSONStr = JSON.stringify(masterInventoryPositionselect);
       h.request(c, 'updateInventoryPositions', {jsonInvPos: JSONStr}, function(r){
            if(r.Error != null || r.Error != undefined){
                h.error({ message: (r.Error) });
                return false;
            } else {
            	$A.get('e.force:refreshView').fire();       
            }	    
        });
    },
    
    onNext : function(c, e, h) {
        let page = c.get('v.page');
        let totalPage = c.get('v.totalPage');
        let startingRecord = c.get('v.startingRecord');
        let endingRecord = c.get('v.endingRecord');
        let totalRecountCount = c.get('v.totalRecountCount');
        let pageSize = c.get('v.pageSize');
        let masterInventoryPositions = c.get('v.inventoryPositions');
        if((page < totalPage) && page !== totalPage){
            page = page + 1; //increase page by 1
            startingRecord = ((page -1) * pageSize) ;
            endingRecord = (pageSize * page);
            endingRecord = (endingRecord > totalRecountCount) ?   totalRecountCount : endingRecord; 
            let setInventoryPositions = masterInventoryPositions.slice(startingRecord, endingRecord);
            startingRecord = startingRecord + 1;  
            
            c.set('v.page ',page);
            c.set('v.startingRecord ',startingRecord);
            c.set('v.setInventoryPositions ', setInventoryPositions);
            c.set('v.endingRecord ',endingRecord);
        }
    },

    onFirst : function(c, e, h) {
		let page = c.get('v.page');
        let totalPage = c.get('v.totalPage');
        let startingRecord = c.get('v.startingRecord');
        let endingRecord = c.get('v.endingRecord');
        let totalRecountCount = c.get('v.totalRecountCount');
        let pageSize = c.get('v.pageSize');
        let masterInventoryPositions = c.get('v.inventoryPositions');        
        
    	startingRecord = 1;
        page = 1;
        totalRecountCount = masterInventoryPositions.length; 
        totalPage = Math.ceil(totalRecountCount / pageSize);
        let setInventoryPositions = masterInventoryPositions.slice(0,pageSize);
        endingRecord = pageSize;
        
        c.set('v.page ',page);
        c.set('v.totalRecountCount ',totalRecountCount);
        c.set('v.totalPage ',totalPage);
        c.set('v.startingRecord ',startingRecord);
        c.set('v.setInventoryPositions ', setInventoryPositions);
        c.set('v.endingRecord ',endingRecord);
        
    },
    
    onPrevious : function(c, e, h){
    	let page = c.get('v.page');
        let totalPage = c.get('v.totalPage');
        let startingRecord = c.get('v.startingRecord');
        let endingRecord = c.get('v.endingRecord');
        let totalRecountCount = c.get('v.totalRecountCount');
        let pageSize = c.get('v.pageSize');
        let masterInventoryPositions = c.get('v.inventoryPositions');
        if(page > 1){
            page = page - 1; //increase page by 1
            startingRecord = ((page -1) * pageSize) ;
            endingRecord = (pageSize * page);
            endingRecord = (endingRecord > totalRecountCount) ?   totalRecountCount : endingRecord; 
            let setInventoryPositions = masterInventoryPositions.slice(startingRecord, endingRecord);
            startingRecord = startingRecord + 1;  
            
            c.set('v.page ',page);
            c.set('v.startingRecord ',startingRecord);
            c.set('v.setInventoryPositions ', setInventoryPositions);
            c.set('v.endingRecord ',endingRecord);
        }    
    },
    
    onLast : function(c, e, h) {
        let page = c.get('v.page');
        let totalPage = c.get('v.totalPage');
        let startingRecord = c.get('v.startingRecord');
        let endingRecord = c.get('v.endingRecord');
        let totalRecountCount = c.get('v.totalRecountCount');
        let pageSize = c.get('v.pageSize');
        let masterInventoryPositions = c.get('v.inventoryPositions');
        
        totalRecountCount = masterInventoryPositions.length;
        totalPage = Math.ceil(totalRecountCount / pageSize);
        page = totalPage;
        startingRecord = (pageSize * (totalPage - 1))+1;
        let setInventoryPositions = masterInventoryPositions.slice(startingRecord-1,totalRecountCount);
        endingRecord = totalRecountCount;
        
        c.set('v.totalRecountCount ',totalRecountCount);
        c.set('v.totalPage ',totalPage);
        c.set('v.page ',page);
        c.set('v.startingRecord ',startingRecord);
        c.set('v.setInventoryPositions ', setInventoryPositions);
        c.set('v.endingRecord ',endingRecord);
    },
    
    onSelectAllChange: function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.checked"); 
        console.log(checkvalue);
        var setInventoryPositions = c.get("v.setInventoryPositions");
        if(checkvalue == true){
        	for(var i=0; i < setInventoryPositions.length; i++){
                setInventoryPositions[i].isSelected = true;
            }    
        } else {
        	for(var i=0; i < setInventoryPositions.length; i++){
                setInventoryPositions[i].isSelected = false;
            }    
        }
        c.set('v.setInventoryPositions',setInventoryPositions);
    },
    
    searchRecords : function(c, e, h) {
        h.searchRec(c, e, h);
    },
    
    onHeatMapView : function(c, e, h) {
        /*var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/heatMapGeneratorLight"
        });
        urlEvent.fire();*/
        window.open('/one/one.app#/alohaRedirect/apex/HeatMap');
    },
    
    onCancel : function(c, e, h) {
    	$A.get('e.force:refreshView').fire();    
    },
    
    onSortOrders : function(c, e, h) {
    	var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        
        let orderField = c.get('v.orderField');
        let direction = c.get('v.direction');
        if(sortfield != orderField){
        	c.set('v.orderField',sortfield); 
            c.set('v.direction','ASC'); 
        } else {
            if(direction == 'ASC'){
            	c.set('v.direction','DESC');     
            } else {
            	c.set('v.direction','ASC');      
            }
        }
        h.request(c, 'onOrderSort', {direction: c.get('v.direction'), orderField : c.get('v.orderField'), selectedSiteId: c.get('v.selectedSiteId')}, function(r){
            c.set('v.setInventoryPositions',r.putAway);
            c.set('v.siteOptions',r.siteOptions);
            c.set('v.hasInventoryPosition',r.hasInventoryPosition);
            c.set("v.selectedSiteId", r.selectedSiteId);
            
            var invPosition = r.inventoryPositionById;
            var invPositionById = [];
            for ( var key in invPosition ) {
                invPositionById.push({value:invPosition[key], key:key});
            }
            c.set("v.inventoryPositionById", invPositionById);
            
            var rackLevels = r.rackLevelsByRackId;
            var rackLevelsById = [];
            for ( var key in rackLevels ) {
                rackLevelsById.push({value:rackLevels[key], key:key});
            }
            c.set("v.rackLevelsByRackId", rackLevelsById);
            
            var binLocations = r.binLocationsByRackLevelId;
            var binLocationById = [];
            for ( var key in binLocations ) {
                binLocationById.push({value:binLocations[key], key:key});
            }
            c.set("v.binLocationsByRackLevelId", binLocationById);
            
            
            var binConsumedCapacityById = r.binConsumedCapacityById;
            var binConsumedById = [];
            for ( var key in binConsumedCapacityById ) {
                binConsumedById.push({value:binConsumedCapacityById[key], key:key});
            }
            c.set("v.binConsumedCapacityById", binConsumedById);
            c.set('v.masterInventoryPositions',r.masterInventoryPositions);
            c.set('v.inventoryPositions',r.masterInventoryPositions);
            
            var reA = /[^a-zA-Z]/g;
            var reN = /[^0-9]/g;
            
            for(var i =0 ; i< r.masterInventoryPositions.length ; i++){
                var rackArr = r.masterInventoryPositions[i].rackOptionsL;
                var rackValue = [];
                let rackMap = new Map();
                for(let j = 0; j < rackArr.length; j++){
                    rackValue.push(rackArr[j].value);
                    rackMap.set(rackArr[j].value,rackArr[j].label);
                }
                
                var rack = rackValue.sort(sortAlphaNum);
                var rackNewValue = [];
                let location = [];
                for(let j=0 ; j< rack.length ; j++){
                    let rackName = rack[j].split('-');
                    
                    if(location.includes(rack[j])){
                    	continue;   
                    }
                    
                    //console.log('rackName = '+rackName);
                    for(let k=0 ; k< rack.length ; k++){
                        let rkName = rack[k].split('-');
                        if(rackName[0] == rkName[0]){
                            rackNewValue.push({label: rackMap.get(rack[k]), value : rack[k]});	  
                            location.push(rack[k]);
                        }
                    }   
                }
                r.masterInventoryPositions[i].rackOptionsL = rackNewValue;
            }
            
            function sortAlphaNum(a, b) {
                var aA = a.replace(reA, "");
                var bA = b.replace(reA, "");
                if (aA === bA) {
                    var aN = parseInt(a.replace(reN, ""), 10);
                    var bN = parseInt(b.replace(reN, ""), 10);
                    return aN === bN ? 0 : aN > bN ? 1 : -1;
                } else {
                    return aA > bA ? 1 : -1;
                }
            }
            
            let totalRecountCount = r.masterInventoryPositions.length; 
            let totalPage = Math.ceil(totalRecountCount / c.get('v.pageSize'));
            let setInventoryPositions = r.masterInventoryPositions.slice(0,c.get('v.pageSize'));
            let endingRecord = c.get('v.pageSize');
            c.set('v.totalRecountCount ',totalRecountCount);
            c.set('v.totalPage ',totalPage);
            c.set('v.setInventoryPositions ', setInventoryPositions);
            c.set('v.endingRecord ',endingRecord);
            h.searchRec(c, e, h);
        });
    },
    
    onPageSizeChange : function(c, e, h) {
        console.log(c.find("selectPageSize").get("v.value"));
        let page = c.get('v.page');
        let totalPage = c.get('v.totalPage');
        let startingRecord = c.get('v.startingRecord');
        let endingRecord = c.get('v.endingRecord');
        let totalRecountCount = c.get('v.totalRecountCount');
        let pageSize = c.get('v.pageSize');
        let masterInventoryPositions = c.get('v.inventoryPositions');
        
    	pageSize = c.find("selectPageSize").get("v.value");
        totalRecountCount = masterInventoryPositions.length; 
        totalPage = Math.ceil(totalRecountCount / pageSize);
        let setInventoryPositions = masterInventoryPositions.slice(0,pageSize);
        endingRecord = pageSize;
        
        c.set('v.pageSize ',pageSize);
        c.set('v.page ',1);
        c.set('v.startingRecord ',1);
        c.set('v.totalRecountCount ',totalRecountCount);
        c.set('v.totalPage ',totalPage);
        c.set('v.setInventoryPositions ', setInventoryPositions);
        c.set('v.endingRecord ',endingRecord);
    },
    
    loadRackLevels : function(c, e, h) {
    	var so = e.getSource().get("v.name");
        var recIds = e.getSource().get("v.value");
        var setInventoryPositions = c.get('v.setInventoryPositions');
        var rackLevelsByRackId = c.get('v.rackLevelsByRackId');
       
        c.set('v.selectedRackId',recIds);
        
        for(let i=0; i < rackLevelsByRackId.length ; i++){
            if(rackLevelsByRackId[i].key == recIds){
                c.set('v.selectedRackLevelId',rackLevelsByRackId[i].key);                    
                so.invPositionSO.Rack__c = recIds;
            	let racklevel =  rackLevelsByRackId[i].value
                so.rackLevelOptionsL = rackLevelsByRackId[i].value;
                so.balanceQtyToPutAway = 0.0;
                console.log('RackLevelId = '+so.rackLevelOptionsL[0].Id);
                let binLocationsByRackLevelId = c.get('v.binLocationsByRackLevelId');
                for(let j=0; j < binLocationsByRackLevelId.length ; j++){
                    if(binLocationsByRackLevelId[j].key == so.rackLevelOptionsL[0].Id){
                    	c.set('v.selectedBinLocationId',binLocationsByRackLevelId[j].key);	
                        so.invPositionSO.Rack_Level__c = so.rackLevelOptionsL[0].Id;
                        so.binLocationOptionsL = binLocationsByRackLevelId[j].value;
                        
                        let binConsumedCapacityById = c.get('v.binConsumedCapacityById');
                        for(let k=0; k < binConsumedCapacityById.length ; k++){
                            if(binConsumedCapacityById[k].key == so.binLocationOptionsL[0].Id){
                                so.invPositionSO.Bin_Location__c = so.binLocationOptionsL[0].Id;
                            	let availableBinLocationCapacity =  binConsumedCapacityById[k].value;
                                let unitProductVoume = so.invPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                                if(availableBinLocationCapacity != null && availableBinLocationCapacity != undefined && availableBinLocationCapacity != 0.0 && unitProductVoume != undefined && unitProductVoume != null && unitProductVoume != 0){
                                	so.balanceQtyToPutAway = (availableBinLocationCapacity / unitProductVoume) ; 
                                    so.balanceQtyToPutAway = so.balanceQtyToPutAway.toFixed(2);
                                }
                                break;
                            }	    
                        }
                        break;
                    }    
                }
                break;
            }	        
        }
        
        for(let i=0; i < setInventoryPositions.length ; i++){
            if(setInventoryPositions[i].invPositionSO.Id === so.invPositionSO.Id){
            	console.log('SO = '+so.invPositionSO.Rack__c);
                setInventoryPositions[i] = so;
            }    
        }
        c.set('v.setInventoryPositions',setInventoryPositions);
    },
    
    loadbinLocation : function(c, e, h) {
    	var so = e.getSource().get("v.name");
        var recLevelIds = e.getSource().get("v.value");   
        var setInventoryPositions = c.get('v.setInventoryPositions');
        var binLocationsByRackLevelId = c.get('v.binLocationsByRackLevelId');
        c.set('v.selectedRackLevelId',recLevelIds);
        
        for(let i=0; i < binLocationsByRackLevelId.length ; i++){
            if(binLocationsByRackLevelId[i].key == recLevelIds){
                so.invPositionSO.Rack_Level__c = recLevelIds;
                let binLocation =  binLocationsByRackLevelId[i].value
            	so.binLocationOptionsL = binLocationsByRackLevelId[i].value;
                so.balanceQtyToPutAway = 0.0;
                let binConsumedCapacityById = c.get('v.binConsumedCapacityById');
                for(let k=0; k < binConsumedCapacityById.length ; k++){
                    if(binConsumedCapacityById[k].key == so.binLocationOptionsL[0].Id){
                        so.invPositionSO.Bin_Location__c = so.binLocationOptionsL[0].Id;
                        let availableBinLocationCapacity =  binConsumedCapacityById[k].value;
                        let unitProductVoume = so.invPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                        if(availableBinLocationCapacity != null && availableBinLocationCapacity != undefined && availableBinLocationCapacity != 0.0 && unitProductVoume != undefined && unitProductVoume != null && unitProductVoume != 0){
                            so.balanceQtyToPutAway = (availableBinLocationCapacity / unitProductVoume) ; 
                            so.balanceQtyToPutAway = so.balanceQtyToPutAway.toFixed(2);
                        }
                        break;
                    }	    
                }
                break;
            }	        
        }
        
        for(let i=0; i < setInventoryPositions.length ; i++){
            if(setInventoryPositions[i].invPositionSO.Id === so.invPositionSO.Id){
            	console.log('SO = '+so.invPositionSO.Rack__c);
                setInventoryPositions[i] = so;
            }    
        }
        c.set('v.setInventoryPositions',setInventoryPositions);
        
    },
    
    loadBalanceQtyToPutAway : function(c, e, h) {
    	var so = e.getSource().get("v.name");
        var binlocationId = e.getSource().get("v.value");    
        var setInventoryPositions = c.get('v.setInventoryPositions');
        var binConsumedCapacityById = c.get('v.binConsumedCapacityById');

		so.balanceQtyToPutAway = 0.0;        
        for(let k=0; k < binConsumedCapacityById.length ; k++){
            if(binConsumedCapacityById[k].key == binlocationId){
                so.invPositionSO.Bin_Location__c = binlocationId;
                let availableBinLocationCapacity =  binConsumedCapacityById[k].value;
                let unitProductVoume = so.invPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                if(availableBinLocationCapacity != null && availableBinLocationCapacity != undefined && availableBinLocationCapacity != 0.0 && unitProductVoume != undefined && unitProductVoume != null && unitProductVoume != 0){
                    so.balanceQtyToPutAway = (availableBinLocationCapacity / unitProductVoume) ; 
                    so.balanceQtyToPutAway = so.balanceQtyToPutAway.toFixed(2);
                }
                break;
            }	    
        }
        
        for(let i=0; i < setInventoryPositions.length ; i++){
            if(setInventoryPositions[i].invPositionSO.Id === so.invPositionSO.Id){
            	console.log('SO = '+so.invPositionSO.Rack__c);
                setInventoryPositions[i] = so;
            }    
        }
        c.set('v.setInventoryPositions',setInventoryPositions);
    },
})