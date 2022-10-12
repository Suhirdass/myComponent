({
    updateBreadCrumb : function(c,screenName) {
        try{
            var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
            if(AllBreadCrumb){
                AllBreadCrumb = JSON.parse(AllBreadCrumb);
            }
            var matchedMenu = AllBreadCrumb.find((menu) => {
                return menu.text == screenName;
            })
            console.log('screenName::',matchedMenu);
            if(matchedMenu){
                sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
                $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
            }
            
        }catch(error){
            console.log('error:',error);
        }
    }
})