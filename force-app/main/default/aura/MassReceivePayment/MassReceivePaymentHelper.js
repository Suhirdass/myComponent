({

     /*
     * Method will be called when use clicks on next button and performs the 
     * calculation to show the next set of records
     */
    next : function(component, event){
                            var datainv = component.get('v.alldata');
  let page = component.get('v.page');
      //  var sObjectList = component.get("v.setinvoice");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(datainv.length > i){
                Paginationlist.push(datainv[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        
          var x = (page+1);
        
        console.log('x',x);
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.setinvoice', Paginationlist);
         component.set('v.page ',x);
    },
    /*
     * Method will be called when use clicks on previous button and performs the 
     * calculation to show the previous set of records
     */
    previous : function(component, event){
        let page = component.get('v.page');
        var datainv = component.get('v.alldata');
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(datainv[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
         var x = (page-1);
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.setinvoice', Paginationlist);
         component.set('v.page ',x);
    },
      /*
     * Method will be called when use clicks on next button and performs the 
     * calculation to show the next set of records
     */
    nextPO : function(component, event){
                            var datainv = component.get('v.alldataPO');
let page = component.get('v.page');
      //  var sObjectList = component.get("v.setinvoice");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(datainv.length > i){
                Paginationlist.push(datainv[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
          var x = (page+1);
           component.set('v.page ',x);
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.setBilPays', Paginationlist);
    },
    /*
     * Method will be called when use clicks on previous button and performs the 
     * calculation to show the previous set of records
     */
    previousPO : function(component, event){
        let page = component.get('v.page');

                            var datainv = component.get('v.alldataPO');
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(datainv[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
          var x = (page-1);
           component.set('v.page ',x);
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.setBilPays', Paginationlist);
    }
    
    
      
      
    
})