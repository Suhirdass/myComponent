({
	onLoginClick : function(c, e, h) {
		h.redirect('/');
	},
    onRedirect : function(c, e, h) {
        if(sessionStorage.getItem('publicBrandId') != 'null')
        	h.redirect('/brandproducts?id='+sessionStorage.getItem('publicBrandId'));
        else
            h.redirect('/publicProducts');
    },
    onSignUpClick : function(c, e, h) {
		h.redirect('https://staging-filigreen.cs51.force.com/filigreenb2b/SelfRegister');
	}
})