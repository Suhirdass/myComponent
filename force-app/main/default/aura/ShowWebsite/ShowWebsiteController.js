({
	resizeIframe : function(component, event, helper) {
        window.addEventListener('resize', $A.getCallback(function(){
            debugger;
            if(component.isValid()) {
                console.log("Resize");
                var h = window.screen.availHeight-25;
                console.log("h::",h);
                document.getElementById("websiteId").style.height = h+"px";
            }
        }));
        window.setTimeout($A.getCallback(function(){
            var h = window.screen.availHeight-25;
            console.log("h::",h); 
            document.getElementById("websiteId").style.height = h+"px";
        }),1000);
        
	}
})