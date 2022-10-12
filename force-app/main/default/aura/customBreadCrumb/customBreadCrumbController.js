({
    init : function(c, e, h) {
        try{
            var brd = sessionStorage.getItem('breadCrumb');
            if(brd){
                brd = JSON.parse(brd);
                console.log('init:',brd);
                h.updateBreadCrumb(c,brd.breadCrumbString,brd.breadCrumbIds);
            }else{
                c.set("v.breadcrumboptions", [{ label: "Home", name: "0" }]);
            }
        }catch(error){
            console.log('onBreadcrumbs Init Error:',error);
        }
		console.log('onBreadcrumbs Init ::',c.get('v.breadcrumboptions'));
        
	},
    onChangeBreadCrumb: function (c, e, h) {
    	try {
            window.setTimeout($A.getCallback(function(){
               c.set("v.breadcrumbs", [{ label: "Home", name: "0" }]);
           }),10)
            /*window.setTimeout($A.getCallback(function(){
                $A.get('e.force:refreshView').fire();
            }),100)*/
            console.log('onChangeBreadCrumb:');
            var breadCrumbString = e.getParam('breadCrumbString');
            var breadCrumbId = e.getParam('breadCrumbIds');
            
            h.updateBreadCrumb(c,breadCrumbString,breadCrumbId);
            
       } catch (er) {
            console.log('onChangeBreadCrumb Error :', er);
       }
            
   },
    onBreadCrumbClick: function (c, e, h) {
        e.preventDefault();
       console.log('onBreadCrumbClick....');
        var id = e.getSource().get('v.name');
        var label = e.getSource().get('v.label');
        console.log('label::',label);
       h.prepareBreadCrumb(c,label,id);
       /*try{
           
        var id = e.getSource().get('v.name');//e.currentTarget.dataset.id;
       console.log('id::',id);
        if(id){
            var brd = sessionStorage.getItem('breadCrumb');
            if(brd){
                brd = JSON.parse(brd);
                console.log('init:',brd);
                if(brd.breadCrumbString){
                    var breadCrumbParts = brd.breadCrumbString.split(' > ');
                    var breadCrumbIds = brd.breadCrumbIds.split(' > ');
                    var breadCrumbs = [];
                    var newBCIds = '';
                    var newBCString = '';
                    var separator = '';
                    var matchedIndex = 0;
                    if(breadCrumbIds.length){
                        for(let i=0;i< breadCrumbIds.length;i++){
                            const bi = breadCrumbIds[i];
                            if(bi == id){
                                matchedIndex = i;
                                if(id != '0'){
                                    newBCIds += separator+bi; 
                                }
                            	break;
                            }else{
                            	newBCIds += separator+bi;    
                                separator = ' > ';
                            }
                        }
                        separator = '';
                        for(let i=0;i<= matchedIndex;i++){
                            const bs = breadCrumbParts[i];
                            newBCString += separator+bs;  
                            separator = ' > ';
                        }
                        if(newBCIds == ''){
                            newBCIds = '0';
                        }
                        console.log('newBCString=>[',newBCString,']  newBCIds=>[',newBCIds+']');
                        sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: newBCString, breadCrumbIds : newBCIds}));
                        window.setTimeout($A.getCallback(function(){
                            h.updateBreadCrumb(c,newBCString,newBCIds);
                        }),10)
                        
                    }
                }
            }else{
                c.set("v.breadcrumbs", [{ label: "Home", name: "0" }]);
            }
            c.getSuper().navigate(id);
            
        }
       }catch(error){
           console.log('Error:',error);
       }*/
   },
})