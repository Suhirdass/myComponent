({
    initRating: function(c){
        var h = this;
        var el = c.find('ratingStars').getElement();
        var ratingPlugin = $A.get('$Resource.ratingPlugin')
        $(el).raty({
            starOff: ratingPlugin + '/images/star-off.png',
            starOn: ratingPlugin + '/images/star-on.png',
            starHalf: ratingPlugin + '/images/star-half.png',
            readOnly: !c.get('v.canUpdate'),
            score: c.get('v.rating'),
            click: function(score, e){
                if(score == null){
                    score = 0;
                }
                c.set('v.rating', score);
            }
        });
    }
})