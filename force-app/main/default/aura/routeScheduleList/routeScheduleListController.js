({
    doInit : function(c, e, h) {        
      c.set('v.isDataLoaded',true);
       window.setTimeout($A.getCallback(function(){
                h.applyDate(c);
            }),1000);     
        
        
         
        var dselectedDay = ''; 
        var todaydd = new Date(); 
        var selectedDay =  c.get("v.selectedDay"); 
    //   alert(c.get("v.requestDateShow"));
        // alert('selectedDay<'+selectedDay);
        if((c.get("v.shredirectDate") && c.get("v.shredirectDate")!='') && selectedDay===undefined  ){
            c.set("v.requestDateShow",c.get("v.shredirectDate"));
         
                 
           
        }else{
          // c.set("v.requestDateShow",selectedDay);  
        }

        
        if(c.get("v.checkClick")== true)
        { // alert(1);
           /* var selectedDay =  c.get("v.selectedDay"); 
            dselectedDay=selectedDay;
            var str1 = selectedDay.replace("/", "-");
            var str2 = str1.replace("/", "-");
            var smonth = str2.slice(0, 2);
            var sdate = str2.slice(3, 5);
            var syear = str2.slice(6, 10);
            selectedDay=syear+'-'+smonth+'-'+sdate;*/
        }else{  //alert(2);
            if(c.get("v.shredirectDate") && c.get("v.shredirectDate")!=''  ){
                selectedDay =c.get("v.shredirectDate");
            }else{
                var today = new Date();
                var  tdate = today.getDate(); 
               var datelength =tdate.toString().length;
                if(datelength>1)
                {
                    selectedDay = today.getFullYear() + "-" + ('0'+(today.getMonth() + 1) )+  "-" +(today.getDate());
                }else{
                    selectedDay = today.getFullYear() + "-" + ('0'+(today.getMonth() + 1) )+  "-" +('0'+ today.getDate());
                }
                
            }
        }
        var datStr = selectedDay;
       // alert('doinit datStr##'+datStr);
        console.log('datStrdatStr',datStr);
        var result = [];
        var result1 = [];
        for (var i=0; i<=4; i++) {
            var d = new Date();
            d.setDate(d.getDate() - i);
            result.push( formatDate(d) )
        }
        for (var k=0; k<3; k++) {
            var s = new Date();
            s.setDate(s.getDate() + (k+1));
            result1.push( formatDate(s) )
        }
        var dtval = result.concat(result1);
        
        function formatDate(date){
            var dd = date.getDate();
            var mm = date.getMonth()+1;
            var yyyy = date.getFullYear();
            if(dd<10) {dd='0'+dd}
            if(mm<10) {mm='0'+mm}
            date = mm+'/'+dd+'/'+yyyy;
            return date
        }
       
        var startDate = result.sort();
        c.set("v.dateValues", startDate.concat(result1));
      
        if(c.get("v.checkClick")== false)
        { //alert(3);
            if(c.get("v.shredirectDate")){
               // alert(4);
                var rdDate=c.get("v.shredirectDate");
                var syear = rdDate.slice(0, 4);
                var smonth= rdDate.slice(5, 7);
                var  sdate = rdDate.slice(8, 10);
                var ddselectedDay=smonth+'/'+sdate+'/'+syear;
                c.set("v.shDate", ddselectedDay);
            }else{
                //alert(5);
                dselectedDay=  ('0' + (today.getMonth()+1)).slice(-2) + '/' + ('0' + today.getDate()).slice(-2) +'/'+ today.getFullYear();
                c.set("v.shDate",dselectedDay);
            }
            
        }else{
            
            c.set("v.shDate", dselectedDay);
        }
     
     
        console.log('datStrdatStr>>',datStr);
        h.request(c, 'getRouteSchedule', {selectedDays: datStr}, function(r){

            c.set('v.setShipLines', r.setShipLines);
              c.set('v.holidayList', r.holidayList);
           
             var getsetShipLines = c.get("v.setShipLines");
            
          /*  
            window.setTimeout(
                $A.getCallback(function() {
                    alert(getsetShipLines.length);
                     for(  var k=1;k<getsetShipLines.length;k++){
                         
                        alert( c.find("index"+k).get("v.value"));
                     }
                    
                }), 1000
            );
            */
            console.log('r.setShipLines>>>',r.setShipLines);
            
        

            
            
        }); 
        
     var tt = c.find('errormessage');     
    

      
    },onScriptsLoaded : function(c, e, h) {
        
        c.set('v.isScriptsLoaded',true);
            
      //  h.applyDataTable(c,e);
        
    }, onRouteSchedule: function(c, e, h) {
          var scheduleDate =  c.get("v.dataInValue"); 
         // alert(scheduleDate);
       h.request(c, 'doPostRouteInfo', {scheduleDates: scheduleDate}, function(r){
            
           // c.set('v.setShipLines', r.setShipLines);
            ///console.log('r.setShipLines>>>',r.setShipLines);
            
           var a = c.get('c.getRecords');
           $A.enqueueAction(a);
        }); 
       
 	}, getRecords: function(c, e, h) {
          var scheduleDate =  c.get("v.dataInValue"); 
         // alert(scheduleDate);
       h.request(c, 'getRouteSchedule', {scheduleDates: scheduleDate}, function(r){
             var a = c.get('c.doInit');
            $A.enqueueAction(a);
           // c.set('v.setShipLines', r.setShipLines);
            ///console.log('r.setShipLines>>>',r.setShipLines);
        }); 
       
 	}, onDateChange:function (c, e, h) {
        
        var selectedDate= e.getSource().get("v.value");
        c.set("v.checkClick", true);
        var selectedDay=c.set("v.selectedDay", selectedDate);
        var a = c.get('c.doInit');
        $A.enqueueAction(a);
     
	}, onChange:function (c, e, h) {
              //var selectedDate= c.get('v.requestDateShow');
        
           var reqDateShow = c.get('v.requestDateShow');
                var datearrayShow = reqDateShow.split("-");
                reqDateShow = datearrayShow[2] + '-' + datearrayShow[0] + '-' + datearrayShow[1];
        

        c.set("v.checkClick", true);
       var selectedDay=c.set("v.selectedDay", reqDateShow);
          c.set("v.dataInValue",selectedDay);
   
        var a = c.get('c.doInit');
        $A.enqueueAction(a);
     
	},getrouteDetail : function(c, e, h) { 
    
        var btnValue = e.getSource().get("v.value");
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:routeScheduleDetail",
            isredirect : true,
            componentAttributes: {
                recordId : btnValue,
                prefereshval : 0,
            }
        });
        evt.fire();
    
    },
    dcError : function(c, e, h) { 
        
        h.error({ message:'Please complete Depart Confirm and try again to Ship Confirm' });   
        var cmpTarget = c.find('dcbtns');
        $A.util.removeClass(cmpTarget, 'dcbtn');
        var cmpTarget = c.find('dcbtns');
        $A.util.addClass(cmpTarget, 'dft');
        window.setTimeout(
            $A.getCallback(function() {
                var a = c.get('c.doInit');
                $A.enqueueAction(a);
                
            }), 2000
        );
    },
    // For count the selected checkboxes. 
    selectSmLine: function(c, e, h) {
        // get the selected checkbox value  
        var selectedRec = e.getSource().get("v.value");
      
        // get the selectedCount attrbute value(default is 0) for add/less numbers. 
        var getSelectedNumber = c.get("v.selectedCount");
        // check, if selected checkbox value is true then increment getSelectedNumber with 1 
        // else Decrement the getSelectedNumber with 1     
        if (selectedRec == true) {
            getSelectedNumber++;
        } else {
            getSelectedNumber--;
        }
      
        
        // set the actual value on selectedCount attribute to show on header part. 
        c.set("v.selectedCount", getSelectedNumber);
        if(getSelectedNumber>=1)
        { 
            var cmpTarget = c.find('dcbtns');
            $A.util.addClass(cmpTarget, 'dcbtn');
            var cmpTarget = c.find('dcbtns');
            $A.util.removeClass(cmpTarget, 'dft');
        }else{
            var cmpTarget = c.find('dcbtns');
            $A.util.removeClass(cmpTarget, 'dcbtn');
            var cmpTarget = c.find('dcbtns');
            $A.util.addClass(cmpTarget, 'dft');
        }
        
        
         
        // Checkbox grouping Start 
        var seletedRowId = e.getSource().get("v.class");
        var splitData = seletedRowId.split("|");
        var setShipLinescheckbox = c.get("v.setShipLines");
        var lineAddress = '';

      
        
         if(setShipLinescheckbox.length==1)
        {
            for( var k=1;k<setShipLinescheckbox.length;k++){
                
                if(setShipLinescheckbox[k].shipLine.Status__c!='In-Transit')
                {
                    lineAddress = setShipLinescheckbox[k].shipLine.Receiver_Address__c+', '+ setShipLinescheckbox[k].shipLine.Receiver_City_State_Zip__c;
                    
                    if(splitData[1] == lineAddress &&  selectedRec == true)
                    {
                       
                        c.find("boxPack")[k].set("v.value", true);
                    }
                    if(splitData[1] == lineAddress &&  selectedRec == false)
                    {
                        c.find("boxPack")[k].set("v.value", false); 
                        
                    }
                }
            }
        }
        
        
        if(setShipLinescheckbox.length > 1)
        {
            for( var k=0;k<setShipLinescheckbox.length;k++){
                
                if(setShipLinescheckbox[k].shipLine.Status__c!='In-Transit')
                {
                    lineAddress = setShipLinescheckbox[k].shipLine.Receiver_Address__c+', '+ setShipLinescheckbox[k].shipLine.Receiver_City_State_Zip__c;
                    
                    if(splitData[1] == lineAddress &&  selectedRec == true)
                    {
                       
                        c.find("boxPack")[k].set("v.value", true);
                    }
                    if(splitData[1] == lineAddress &&  selectedRec == false)
                    {
                        c.find("boxPack")[k].set("v.value", false);
                        
                    }
                }
            }
        }
        
        // Checkbox grouping End 
        
    },
    reInit: function(c, e, h) {
        
    $A.get("e.force:refreshView").fire();
        
  	},
    // For select all Checkboxes 
 selectAll: function(c, event, helper) {
  //get the header checkbox value  
  var selectedHeaderCheck = event.getSource().get("v.value");
  // get all checkbox on table with "boxPack" aura id (all iterate value have same Id)
  // return the List of all checkboxs element 
  var getAllId = c.find("boxPack");
  // If the local ID is unique[in single record case], find() returns the component. not array   
     if(! Array.isArray(getAllId)){
       if(selectedHeaderCheck == true){ 
          c.find("boxPack").set("v.value", true);
          c.set("v.selectedCount", 1);
       }else{
           c.find("boxPack").set("v.value", false);
           c.set("v.selectedCount", 0);
       }
     }else{
       // check if select all (header checkbox) is true then true all checkboxes on table in a for loop  
       // and set the all selected checkbox length in selectedCount attribute.
       // if value is false then make all checkboxes false in else part with play for loop 
       // and select count as 0 
        if (selectedHeaderCheck == true) {
               var cmpTarget = c.find('dcbtns');
            $A.util.addClass(cmpTarget, 'dcbtn');
            var cmpTarget = c.find('dcbtns');
            $A.util.removeClass(cmpTarget, 'dft');
            
        for (var i = 0; i < getAllId.length; i++) {
  		  c.find("boxPack")[i].set("v.value", true);
   		 c.set("v.selectedCount", getAllId.length);
            
         
            
        }
        } else {
               var cmpTarget = c.find('dcbtns');
            $A.util.removeClass(cmpTarget, 'dcbtn');
            var cmpTarget = c.find('dcbtns');
            $A.util.addClass(cmpTarget, 'dft');
          for (var i = 0; i < getAllId.length; i++) {
    		c.find("boxPack")[i].set("v.value", false);
   			 c.set("v.selectedCount", 0);
              
  	    }
       } 
     }  
 
 }, showDatePicker: function(c, e, h) {
     
              $("#datepickerId").datepicker("show");
     
    }, onClickNo  :  function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            if(c.get('v.requestDateShow') != null && c.get('v.requestDateShow') != '' && c.get('v.requestDateShow') != undefined){
                
                var reqDateShow = c.get('v.requestDateShow');
                var datearrayShow = reqDateShow.split("-");
                reqDateShow = datearrayShow[2] + '-' + datearrayShow[0] + '-' + datearrayShow[1];
                console.log('reqDate = ',reqDateShow);
               
                c.set("v.requestDate", reqDateShow);
                
                
            } else {
                c.set('v.hasDateError',true);
                return;    
            }
        }),1000);   
      
    }
})