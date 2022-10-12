({
	overAge: function(c, e, h) {
        e.preventDefault();
        sessionStorage.setItem('isVerifyAge', false);
        c.set('v.isVerifyAge', false);
		h.redirect('/publicProducts', true); 
    },
    underAge: function(c, e, h) {
        $(".mainDiv").hide();
        $(".va-underBox").show();
        $(".va-underBox").animate({
            top: '0px'
        });
    },
    goBack: function(c, e, h) {
        //e.preventDefault();
		//h.redirect('/verifyage', true); 
        window.open('https://dev-filigreen.cs190.force.com/filigreenb2b/s/publicProducts','_top')
    },
    onScriptsLoaded: function (c, e, h) {
        try{
            //h.initScroller(c);
        }catch(error){
            //$A.get('e.force:refreshView').fire();
        }
    },
})