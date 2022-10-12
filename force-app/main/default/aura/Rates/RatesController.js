({
	 onInit: function (c, e, h) {
         if(c.get('v.ratesType') == 'SRTRates'){
             c.set('v.activeTab','SRTRates');
             h.request(c, 'getSRTRates', {loginId: c.get('v.loginUserId')}, function (r) {
                 
                 var arrayMapKeys = [];
                var result = r.SRT;
                for(var key in result){
                    arrayMapKeys.push({key: key, value: result[key]});
                }
                  c.set('v.SRTList',arrayMapKeys);
             });
         }
         
	},
    handleActive: function (c, e, h) {
        var tab = e.getSource();
        c.set('v.activeTab',tab.get('v.id'));
        h.request(c, 'getFRTRates', {loginId: c.get('v.loginUserId'),FRTServiceType:tab.get('v.id')}, function (r) {
            console.log('r.FRT:',r.FRT);
            if(tab.get('v.id') == 'Others'){
                c.set('v.FRTList', r.FRT);
            }else{
                c.set('v.MOQsHeader', r.MOQsHeader);
                var arrayMapKeys = [];
                var result = r.FRT;
                for(var key in result){
                    arrayMapKeys.push({key: key, value: result[key]});
                }
                  c.set('v.FRTList', arrayMapKeys);
            }
            
        });
    },
    printDetails: function (c, e, h) {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.replace('/s/settings','/apex/PrintRates?recordId='+c.get('v.loginUserId')+'&Type='+c.get('v.activeTab'));
            console.log('currentUrl::',currentUrl);
            window.open(currentUrl,'_blank');        
        } ,
})