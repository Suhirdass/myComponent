({
	doInit : function(c, e, h) {
        h.request(c, 'cloneBOM', {recordId: c.get("v.recordId")}, function(r){
          c.set('v.setBom', r.setBom);
          c.set('v.setBOMLines', r.setBOMLines);
          c.set('v.hasBOMLines', r.hasBOMLines);
        });
	},
    
	onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },
    
	selectAllCheckboxes : function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.value");
        var checkContact = c.find("checkContact");

        if(checkContact.length){
            for(var i=0; i<checkContact.length; i++){
                	checkContact[i].set("v.value",checkvalue);
            } 
        } else{
             checkContact.set("v.value",checkvalue); 
        }
    },
    
	saveClone : function(c, e, h){
         var setBOMLines = c.get('v.setBOMLines');
         var anyCheckSelected = 'false';
        setBOMLines.forEach(function (bomli, index){
            if(bomli.isSelected){
                anyCheckSelected = 'true';
            } 
        });
    if(anyCheckSelected == 'false'){
            h.warning({message: 'Please select BOM Line'});
        } 
    else{
       h.request(c, 'cloneBOMLight', 
          { bom : c.get("v.setBom"), setBOMLines : c.get("v.setBOMLines") }, function(r){ 
            if(r.Error != null || r.Error != undefined){
                        h.warning({ message: (r.Error) });
                        return false;      
            } else {
                try{
                window.location.href = '/' + r.redirectId ; 
            } catch(ex){
                console.log('Exception '+ex);
            }
            }
        }); 
     }   
   },
})