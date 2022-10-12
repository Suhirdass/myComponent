({
    doInit : function(c, e, h) {
        var sParameterValue = c.get('v.recordId');
        h.request(c, 'updateSorting', {recordId: c.get("v.recordId")}, function(r){
            window.setTimeout(
                $A.getCallback(function() {
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/apex/Picklistpdf?id="+c.get('v.recordId')
                        
                    });
                    urlEvent.fire();
                }), 2000
            );
        
            
            
        });
        
    }
    
})