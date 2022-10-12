({
	onInit: function(c, e, h){
		
	},
    initReview: function(c, e, h){
        var product = c.get('v.product');
        $A.createComponent('c:writeReview', {product: product, isReviewed: c.getReference('v.isReviewed')}, function(content, status) {
            if (status === 'SUCCESS') {
                c.find('overlay').showCustomModal({
                    header: ('Write review for: ' + product.name),
                    body: content,
                    showCloseButton: true,
                    cssClass: 'cProductReview fix-close-button'
                })
            }                               
        });
    }
})