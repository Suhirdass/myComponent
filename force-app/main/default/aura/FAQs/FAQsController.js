({
	onInit : function(c, e, h) {
        h.request(c, 'getFAQs', {searchTerm:'' }, function (r) {
            console.log("getFAQs:",r);
            c.set('v.FAQs', r.FAQs);
        }, { storable: true });
    },
    onSearchFAQs : function(c, e, h) {
        var searchRec = c.find('faqSearch');
        var searchTerm = searchRec.getElement().value;
        window.setTimeout($A.getCallback(function(){
            //searchTerm = c.find('searchRec').get('v.value');
            console.log('searchTerm:',searchTerm);
            h.request(c, 'getFAQs', {searchTerm:searchTerm }, function (r) {
                console.log("getFAQs:",r);
                c.set('v.FAQs', r.FAQs);
            }, { storable: true });
        }),100);
    },
    expandAnswer :function(c, e, h) {
        try{
            var id = e.srcElement.dataset.id;
            console.log("id::",id);
            var ansId = 'answerSec-'+id;
            var currentElement = $('#'+ansId);
            if(currentElement.is(':visible')){
                console.log('Same Visible');
                currentElement.slideUp();
            }else{
                $('.answerSec').slideUp();
                currentElement.slideDown();
            }
        }catch(err){
            console.log("Error:",err);
        }
        
        
    },
    onCategoryClick :function(c, e, h) {
        c.set("v.isCategorySection",false);
        var id = e.srcElement.dataset.id;
        c.set('v.selectedCategory',id);
        console.log("Id:",id);
        var FAQs = c.get('v.FAQs');
        for(var i=0;i<FAQs.length;i++){
            if(FAQs[i].id === id){
                c.set("v.categoryQuestions",FAQs[i].FQAs);
                c.set("v.sectionFirstItem",FAQs[i].FQAs[0].id);
                
                break;
            }
        }
        
    }
})