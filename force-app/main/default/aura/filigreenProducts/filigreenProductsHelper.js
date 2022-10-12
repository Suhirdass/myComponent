({
  getIds: function (c, filters) {
    var h = this;
    h.request(c, 'getIds', { filters: filters }, function (r) {
        console.log("getIds::",r);
      c.set('v.ids', r.ids);
        h.reset(c);
      h.fetchPage(c);
    }, { storable: false });
  },
    getCategories: function(c){
        var h = this;
        h.request(c, 'getCategories', {}, function (r) {
            console.log("getCategories::",r.categories);
            c.set('v.categories',r.categories);
        }, { storable: false });
    },
  getRecords: function (c, ids) {
    var h = this;
    h.request(c, 'getProducts', { ids: ids, filters: c.get('v.filters') }, function (r) {
      c.set('v.isBrand', r.isBrand);
      var records = c.get('v.records');
      records = records.concat(r.records);
      c.set('v.records', records);

      var families = [];
      var exceptionalFamilies = r.exceptionalFamilies;
      for (var i = 0; i < r.families.length; i++) {
        if (exceptionalFamilies.indexOf(r.families[i]) == -1) {
          families.push({ label: r.families[i], value: r.families[i] });
        }
      }

      c.set('v.families', families);
    }, { storable: true });
  }
})