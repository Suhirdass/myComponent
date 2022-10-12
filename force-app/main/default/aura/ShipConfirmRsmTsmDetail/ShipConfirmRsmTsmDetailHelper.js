({
    
    isCanvasBlank:function (canvas) {
        var blank = document.createElement('canvas');
        blank.width = canvas.width;
        blank.height = canvas.height;
        return canvas.toDataURL() == blank.toDataURL();
    },
    applyDataTable : function(c,e) {
        try{
            
            var h = this;
            var isDataLoaded = c.get('v.isDataLoaded');
            if(isDataLoaded){
                var table = $('table.mydataTable').DataTable();
                if(table) {
                    table.destroy();
                }
                $('table.mydataTable').dataTable({
                    sPaginationType: "full_numbers",
                    scroller:true,
                    
                });
                
            }else{
                window.setTimeout($A.getCallback(function(){
                    h.applyDataTable(c,e);
                }),100)
                
            }
        }catch(error){
            console.log('Error in applying datatable:',error);
        }
    },
    
    loadSigpad : function(c, e, h) {
        var canvas, ctx, flag = false,
            prevX = 0,
            currX = 0,
            prevY = 0,
            currY = 0,
            dot_flag = false;
        
        var x = "black",
            y = 2,
            w,h;
        var saasdas= 'can';
        canvas=c.find('can').getElement();
        var ratio = Math.max(window.devicePixelRatio || 1, 1);
        w = canvas.width*ratio;
        h = canvas.height*ratio;
        ctx = canvas.getContext("2d");
        
        console.log('ctx:='+ctx);
        
        canvas.addEventListener("mousemove", function (e) {
            findxy('move', e)
        }, false);
        canvas.addEventListener("mousedown", function (e) {
            findxy('down', e)
        }, false);
        canvas.addEventListener("mouseup", function (e) {
            findxy('up', e)
        }, false);
        canvas.addEventListener("mouseout", function (e) {
            findxy('out', e)
        }, false);
        // Set up touch events for mobile, etc
        canvas.addEventListener("touchstart", function (e) {
            
            var touch = e.touches[0];
            
            var mouseEvent = new MouseEvent("mousedown", {
                clientX: touch.clientX,
                clientY: touch.clientY
            });
            canvas.dispatchEvent(mouseEvent);
            e.preventDefault();
        }, false);
        canvas.addEventListener("touchend", function (e) {
            
            var mouseEvent = new MouseEvent("mouseup", {});
            canvas.dispatchEvent(mouseEvent);
        }, false);
        canvas.addEventListener("touchmove", function (e) {
            
            var touch = e.touches[0];
            var mouseEvent = new MouseEvent("mousemove", {
                clientX: touch.clientX,
                clientY: touch.clientY
            });
            canvas.dispatchEvent(mouseEvent);
            e.preventDefault();
            
        }, false);
        
        // Get the position of a touch relative to the canvas
        function getTouchPos(canvasDom, touchEvent) {
            var rect = canvasDom.getBoundingClientRect();
            return {
                x: touchEvent.touches[0].clientX - rect.left,
                y: touchEvent.touches[0].clientY - rect.top
            };
        }
        
        function findxy(res, e){
            const rect = canvas.getBoundingClientRect();
            if (res == 'down') {
                
                prevX = currX;
                prevY = currY;
                currX = e.clientX - rect.left ;
                currY = e.clientY -  rect.top;
                
                flag = true;
                dot_flag = true;
                if (dot_flag) {
                    ctx.beginPath();
                    ctx.fillStyle = x;
                    ctx.fillRect(currX, currY, 2, 2);
                    ctx.closePath();
                    dot_flag = false;
                }
            }
            if (res == 'up' || res == "out") {
                flag = false;
            }
            if (res == 'move') {
                if (flag) {
                    prevX = currX;
                    prevY = currY;
                    currX = e.clientX -  rect.left;
                    currY = e.clientY - rect.top;
                    draw(c,ctx);
                }
            }
        }
        function draw() {
            c.set('v.signPad',true);
            ctx.beginPath();
            ctx.moveTo(prevX, prevY);
            ctx.lineTo(currX, currY);
            ctx.strokeStyle = x;
            ctx.lineWidth = y;
            ctx.stroke();
            ctx.closePath();
        }
        
    },
    eraseHelper: function(c, e, h){
        var canvas=c.find('can').getElement();
        var ctx = canvas.getContext("2d");
        var w = canvas.width;
        var h = canvas.height;
        ctx.clearRect(0, 0, w, h);
        ctx.fillStyle = "#FFFFFF";
        c.set('v.signPad',false);
    }
})