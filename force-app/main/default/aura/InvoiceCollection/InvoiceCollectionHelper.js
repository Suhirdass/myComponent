({
    showToast: function (toastType, params) {
        params['type'] = toastType;
        params['mode'] = 'dismissible';
        $A.get('e.force:showToast').setParams(params).fire();
    },
    info: function (params) {
        this.showToast('info', params);
    },
    success: function (params) {
        this.showToast('success', params);
    },
    warning: function (params) {
        this.showToast('warning', params);
    },
    error: function (params) {
        this.showToast('error', params);
    },
    escapeRegExp: function (string){
        return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    },
    replaceAll:function(str, term, replacement) {
        var h =  this;
        return str.replace(new RegExp(h.escapeRegExp(term), 'g'), replacement);
    },
    navigateToRecord : function(c,recordId,type){
        console.log('recordId::',recordId);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "slideDevName":type
        });
        navEvt.fire();
    }
})