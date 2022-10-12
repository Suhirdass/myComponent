({
	setTableContent : function(c,jsonData) {
        var reA = /[^a-zA-Z]/g;
        var reN = /[^0-9]/g;
        
        var jsData = JSON.parse(jsonData);
        var levels = (jsData.level).split(',').sort();
        var tableData = JSON.parse(jsData.tableData);
        console.log('tableData = ',tableData);
        
        var levelsData = [];
        var data = {};
        var rackData = [];
        var racks = Object.keys(tableData).sort(sortAlphaNum);
        
        Handlebars.registerHelper('addOne', function(a) {
            return a+1;
        });
        
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
        
        Handlebars.registerHelper('concatRack', function(a,b) {
            return a+' | '+b;
        });
        
        Handlebars.registerHelper('concatLevel', function(a,b,c) {
            var con1 = '';
            if(b == ''){
                con1 = '<td class="whiteBG"> </td>';
            }else if(b == 'Open'){
                con1 = '<td class="greenBG">Open</td>';
            }else{
                con1 = '<td class="redBG">'+a+' | '+b+' | '+c+'</td>';
            }
            return new Handlebars.SafeString(con1);
        });
        Handlebars.registerHelper('if_eq', function(a, b) {
            debugger;
            if (b.indexOf('Open') != -1) // Or === depending on your needs
                return true;
            else
                return false;
        });
        for(var i=0;i<levels.length;i++){
            levelsData.push({Name : levels[i]});
        }
        c.set('v.levels',levelsData);
        var arr11 = levels;
        for(var i=0;i<racks.length;i++){
            var bins = Object.keys(tableData[racks[i]]).sort(sortAlphaNum);
            var binObj = {};
            var binArr = [];
            for(var j=0;j<bins.length;j++){
                binObj[bins[j]] = tableData[racks[i]][bins[j]];
                var arr33 = [];
                var arr22 = binObj[bins[j]];
                var m = 0;
                for(var l=0;l<arr11.length;l++){
                    if(m == arr22.length){
                        for(var k = m;k < arr11.length;k ++){
                            arr33[k]='';
                        }
                        break;
                    }
                    if(arr11[l] == arr22[m]){
                        arr33[l] = arr22[m];
                        m++;
                    }else if(arr22[m].indexOf('Open') != -1 && arr22[m].split('-')[0] == arr11[l]){
                        arr33[l] = 'Open';
                        m++;
                    }else{
                        arr33[l] = '';
                    }
                    console.log('arr33 = ',arr33);
                }
                binObj[bins[j]] = arr33;
                
                binArr.push({key:bins[j], value: arr33});
            }
            data[racks[i]] = binObj;
            rackData.push({key:racks[i] , value: binArr});
        }
        
        c.set('v.result',rackData);
		
        if(Object.keys(data).length == 0){
            $('#secId').hide();
            $('#noData').show();
        }else{
            $('#secId').show();
            $('#noData').hide();
        }
        
        for (let [key, value] of Object.entries(data)) {
            console.log(`${key}: ${value}`);
        }
 
	},
    
    sortAlphaNum : function(a,b) {
        var aA = a.replace(reA, "");
        var bA = b.replace(reA, "");
        if (aA === bA) {
            var aN = parseInt(a.replace(reN, ""), 10);
            var bN = parseInt(b.replace(reN, ""), 10);
            return aN === bN ? 0 : aN > bN ? 1 : -1;
        } else {
            return aA > bA ? 1 : -1;
        }
    },
})