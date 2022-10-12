({
    onInit: function (c, e, h) {
        
		h.request(c,'getTrainingVideos',{},function (r) {
                console.log('trainingVideosData',r.trainingVideos);
                c.set('v.trainingVideosData',r.trainingVideos) ;
                //c.set('v.navigationConfig', r.data.navigationConfig);
			});
	}
})