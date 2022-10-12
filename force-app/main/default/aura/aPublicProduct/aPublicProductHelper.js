({
    applyZoom: function(c){
        var h = this;
        try{
            window.setTimeout($A.getCallback(function(){
                console.log("applying zoom");
                $('#aPImage').zoom();
                
            }),1000);
            
            
            
        }catch(err){
            console.log("error",err);
        }
    }
})