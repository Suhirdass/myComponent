({
     onInit : function(c,e,h){
        const userAgent = navigator.userAgent.toLowerCase();
        c.set('v.isTablet',/(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent));
    },
    handleClick : function(c, e, h) {
        var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var screenName = e.currentTarget.dataset.screenName;
        var additionalSN = '';
        if(screenName == 'Create Ticket'){
            additionalSN = 'Create Ticket';
            screenName = 'Support Cases';
        }
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            if(additionalSN == 'Create Ticket'){
                matchedMenu.label += ' > Create Ticket';
            }
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        var removeIdsFromCache = e.currentTarget.dataset.removeIdsFromCache;
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
            }
        }
    }
})