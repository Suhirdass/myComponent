({
	prepareBreadCrumb:function(c,screenName,id,removeIdsFromCache){
        try{
        var h = this;
         console.log('screenName::',screenName);
        var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('matchedMenu::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            h.updateBreadCrumb(c,matchedMenu.label,matchedMenu.value);
            //$A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => sessionStorage.removeItem(id))
            }
        }
        if(id){
            console.log(typeof id);
            console.log('id::',id);
            if(id == '-1'){
                $A.get('e.force:navigateToURL').setParams({
                    url: '/globalsearch',
                    isredirect: true
                }).fire();
            }else{
                $A.get('e.force:refreshView').fire();
            c.getSuper().navigate(id); 
            }
              
            
        }
        }catch(error){
            console.log('Error:',error);
        }
    },
    updateBreadCrumb : function(c,breadCrumbString,breadCrumbId) {
        try{
            console.log('breadCrumbString:',breadCrumbString);
            console.log('breadCrumbId:',breadCrumbId);
                if(breadCrumbString){
                    var breadCrumbParts = breadCrumbString.split(' > ');
                    var breadCrumbIds = breadCrumbId.split(' > ');
                    var breadCrumbs = [];
                    if(breadCrumbParts.length){
                        console.log("onChangeBreadCrumb calling...", breadCrumbString , '--->',breadCrumbId);
                        breadCrumbs = breadCrumbParts.map(function(item, index ) {
                            return {label:item, name : breadCrumbIds[index]}
                        })
                        window.setTimeout($A.getCallback(function(){
                            console.log('update timeout calling...');
                            c.set("v.breadcrumboptions",breadCrumbs);
                            console.log('breadcrumbs:',c.get("v.breadcrumboptions"));
                            
                        }),100)
                        
                        
                        
                    }else{
                        c.set("v.breadcrumboptions", [{ label: "Home", name: "0" }]);
                    }
                }
            
        }catch(error){
            console.log('error:',error);
        }
    }
})