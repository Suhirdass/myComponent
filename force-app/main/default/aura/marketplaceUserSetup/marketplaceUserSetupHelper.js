({
	getIds: function (c, filters) {
        var h = this;
        h.request(c, 'getIds', { filters: filters}, function (r) {
            c.set('v.allIds', r.ids);
            h.initPagination(c, r.ids, filters);
        }, { storable: false });
    },
    getRecords: function (c, ids) {
        try{
        var h = this;
        h.request(c, 'getUsers', { ids: ids, filters: c.get('v.filters') }, function (r) {
            window.setTimeout($A.getCallback(function(){
                let records = r.users;
                c.set('v.records', records);
                c.set('v.Err_Msg_Select_User', r.Err_Msg_Select_User);
                c.set('v.Tooltip_For_Marketplace_User_Search_Box', r.Tooltip_For_Marketplace_User_Search_Box);
            }),100)
        }, { storable: false });
        }catch(error){}
    },
    resetUsers: function (c, resetTerms) {
        var h = this;
        let selectedIds = [];
        let records = c.get('v.records');
        for(let i = 0 ; i<records.length ; i++){
            if(records[i].flag){
                selectedIds.push(records[i].usr.Id);
            }
        }
        if(selectedIds.length > 0){
            h.request(c, 'resetUsers', {resetTerms: resetTerms,selectedUsr : selectedIds}, function (r) {
                //h.getIds(c, c.get('v.filters'));
                h.success({message:r.ErrorMsg});
                window.setTimeout($A.getCallback(function(){
                	
                	location.reload();
                }),2000)
            });   
        } else {
            h.error({message:c.get('v.Err_Msg_Select_User')});
        }
    }
})