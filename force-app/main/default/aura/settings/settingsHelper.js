({
	formatPhoneNumber: function(c, phone) {
        var s2 = (""+phone).replace(/\D/g, '');
        var m = s2.match(/^(\d{3})(\d{3})(\d{4})$/);
        return (!m) ? phone :m[1] + "-" + m[2] + "-" + m[3];
    },
})