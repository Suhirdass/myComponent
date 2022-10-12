({
	onInit: function(c, e, h){
	},
    onRating: function(c, e, h){
        if(!h.isValid(c, 'rating')){
            h.error({message: 'Correct the error(s).'});
            return;
        }
        
        var rating = parseInt(c.get('v.rating'), 10);
        if(1 > rating){
            h.warning({message: 'Please provide your rating.'});
            return;
        }
        
        var product = c.get('v.product');
        var reviewData = {productId: product.id, review: c.get('v.review'), rating: rating};
        h.request(c, 'saveReview', {reviewData: JSON.stringify(reviewData)}, function(r){
            h.success({message: 'Review submitted successfully.'});
            c.set('v.isReviewed', true);
            c.find('overlay').notifyClose();
        });
    }
})