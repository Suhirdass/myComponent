({
    getIds: function (c, filters) {
        var h = this;
        var query = location.search.substr(1);
        var result = {};
        query.split("&").forEach(function(part) {
            var item = part.split("=");
            result[item[0]] = decodeURIComponent(item[1]);
        });
        
		console.log('doInit::',result.id);
        c.set('v.brandId',result.id);
        sessionStorage.setItem('publicBrandId',result.id);
        h.request(c, 'getIds', { filters: filters, brndId: result.id}, function (r) {
            console.log('r.ids='+r.ids);
            console.log('r.isBrand='+r.isBrand);
            h.initPagination(c, r.ids, filters);
        }, { storable: true });
        
    },
    getCategories: function(c){
        var h = this;
        h.request(c, 'getCategories', {}, function (r) {
            console.log("getCategories::",r);
            c.set('v.categories',r.categories);
            c.set('v.termsAndConditions',r.termsAndConditions);
            c.set('v.companyCustomSetting',r.companyCustomSetting );
            c.set('v.STFiles',r.STFiles);
            if(r.STName){
                c.set('v.STName',r.STName);
            }
        }, { storable: true });
    },
    getProducts: function(c, ids) {
		this.getRecords(c, ids);        
    },
  getRecords: function (c, ids) {
    var h = this;
      h.request(c, 'getProducts', { ids: ids, filters: c.get('v.filters'),brndId: c.get('v.brandId') }, function (r) {
          c.set('v.isBrand', r.isBrand);
          var records = c.get('v.records');
          //records = records.concat(r.records);
          c.set('v.records', r.records);
          console.log('Products:',r.records);
          c.set('v.warehouseTotalOrderedMap', r.warehouseTotalOrderedMap);
          //console.log('aaa : ',c.get('v.warehouseTotalOrderedMap')['a0e6A0000033X2sQAE-01t3s0000051pgYAAQ']);
          var families = [];
          var exceptionalFamilies = r.exceptionalFamilies;
          for (var i = 0; i < r.families.length; i++) {
              if (exceptionalFamilies.indexOf(r.families[i]) == -1) {
                  families.push({ label: r.families[i], value: r.families[i] });
              }
          }
          
          c.set('v.families', families);
          c.set('v.hasLoaded', true);
      }, { storable: true });
  }
})