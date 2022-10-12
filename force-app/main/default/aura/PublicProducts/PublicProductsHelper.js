({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getIds', { filters: filters}, function (r) {
            console.log('r.ids='+r.ids);
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
      h.request(c, 'getProducts', { ids: ids, filters: c.get('v.filters') }, function (r) {
          c.set('v.isBrand', r.isBrand);
          var records = c.get('v.records');
          records = records.concat(r.records);
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