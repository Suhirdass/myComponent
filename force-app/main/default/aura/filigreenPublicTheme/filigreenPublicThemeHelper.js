({
    redirect: function (url, isRedirect) {
        $A.get('e.force:navigateToURL').setParams({
            url: url,
            isredirect: (isRedirect === true)
        }).fire();
    }
})