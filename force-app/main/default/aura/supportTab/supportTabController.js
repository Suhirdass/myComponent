({
	onInit : function(c, e, h) {
        h.request(c, 'isCommunityPlusUser', {}, function (r) {
            console.log("supportTab::",r);
            c.set('v.isBrand',r.isBrand);
            c.set('v.schedulePaymentURL',r.schedulePaymentURL);
        console.log('isBrand:',c.get('v.isBrand'));
        });
	}
})