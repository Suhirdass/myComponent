({
	onInit : function(c, e, h) {
		c.set('v.perPage',25);
        var filters = { orderByField: 'FirstName', isASC: true,IsActive: true };
        c.set('v.filters', filters);
        h.getIds(c, filters);
	},
    fetchUsers: function (c, e, h) {
        var ids = e.getParam('ids');
        console.log('ids::',ids);
        h.getRecords(c, ids);
    },
    onChangeSearchUser: function (c, e, h) {
        let searchRec = c.find('searchRec');
        let searchTerm = searchRec.getElement().value;
        let filters = c.get('v.filters');
        filters['searchTerm'] = searchTerm;
        c.set('v.filters', filters);
        c.find("selectAll").set("v.value", false);
        h.getIds(c, filters);
    },
    onTypeChange: function (c, e, h) {
        var selectedType = e.getSource().get("v.value");
        var filters = c.get('v.filters');
        if(selectedType == 'Active')
            filters['IsActive'] = true;
        else
            filters['IsActive'] = false;
		c.set('v.filters', filters);
        c.find("selectAll").set("v.value", false);
        window.setTimeout($A.getCallback(function(){
        	h.getIds(c, filters);
		}),100);
    },
    onSortUsers: function (c, e, h) {
    	var dataset = e.currentTarget.dataset;
        var sortfield = dataset.sortfield;
        var filters = c.get('v.filters');
        if (filters.orderByField.toLowerCase() === sortfield.toLowerCase()) {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  (!filters.isASC);
        } else {
            filters["orderByField"] =  sortfield;
            filters["isASC"] =  true;
        }
        c.set('v.filters', filters);
        c.find("selectAll").set("v.value", false);
        h.getIds(c, filters);
    },
    resetNews: function (c, e, h) {
    	h.resetUsers(c,false);
    },
    resetTerms: function (c, e, h) {
    	h.resetUsers(c,true);    
    },
    selectAll: function (c, e, h) {
        let selectedHeaderCheck = e.getSource().get("v.value");
        let getAllId = c.find("selectUser");
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                c.find("selectUser").set("v.value", true);
            }else{
                c.find("selectUser").set("v.value", false);
            }
        }else{
            if (selectedHeaderCheck == true) {
                for (let i = 0; i < getAllId.length; i++) {
                    c.find("selectUser")[i].set("v.value", true);
                }
            } else {
                for (let i = 0; i < getAllId.length; i++) {
                    c.find("selectUser")[i].set("v.value", false);
                }
            } 
        }  
    },    
    onViewRecord: function (c, e, h) {
    	h.navigateToRecord(c, e.currentTarget.dataset.id, 'detail');    
    }
})