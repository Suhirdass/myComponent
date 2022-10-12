({
    onInit: function (c, e, h) {
        var fromBrandProduct = sessionStorage.getItem('fromBrandProduct');
        fromBrandProduct = fromBrandProduct != null && fromBrandProduct != undefined ? fromBrandProduct : 'false';
        c.set('v.fromBrandProduct',fromBrandProduct);
	},
	zoomIn: function (c, e, h) {
        console.log("zoomIn");
        var element = document.getElementById("myresult");
        element.style.display = "inline-block";
        element = document.getElementById("img-zoom-lens");
        element.style.display = "inline-block";
        h.imageZoom('myimage','myresult');
        /*var img = document.getElementById("imgZoom").getBoundingClientRect() ;
        console.log("e.offsetX",e.offsetX);
        console.log("e.offsetY",e.offsetY);
        var posX =  e.pageX - img.left;
        var posY = e.pageY - img.top;
        console.log("posX:posY",posX,':',posY);
        element.style.backgroundPosition = (-posX *4) + "px " + (-posY * 4) + "px";*/
    },
	zoomOut: function (c, e, h) {
        e.stopPropagation();
        console.log("zoomOut",e.srcElement.id);
        if(e.srcElement.id !== 'myimage'){
            var element = document.getElementById("myresult");
            element.style.display = "none";
            element = document.getElementById("img-zoom-lens");
            element.style.display = "none";

        }

	},
	onScriptsLoaded: function (c, e, h) {
        console.log("applying Zoom");
        try{
            window.setTimeout($A.getCallback(function(){
                $('#myimage').zoom();
            }),100);



        }catch(error){
            console.log("Zoom error");
        }

        //h.imageZoom('myimage','myresult');
        //console.log($('.xzoom').length);
        //$('.xzoom').xzoom();
    },
    onProductDetailsForPublic: function(c, e, h) {
        e.preventDefault();

        var product = c.get('v.product');

        sessionStorage.setItem('pricebookEntry', product.price.id);
		h.redirect('/PublicProduct?id='+product.encryptPriceBookId, true); 
    },
})