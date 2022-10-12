({
	doInit : function(c, e, h) {
		var artId = c.get("v.recordId");
        h.getRecords(c, artId);  
	},
    cancelBtn : function(c, e, h) {
        try{
            window.location.href = '/' + c.get('v.recordId'); 
        } catch(ex){
            console.log('Exception '+ex);
        }
	},
    createQuote : function(c, e, h) {
    	h.createRecords(c,e);
    }
})