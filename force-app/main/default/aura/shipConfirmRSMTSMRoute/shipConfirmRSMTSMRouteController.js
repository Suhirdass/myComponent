({
    doInit : function(c, e, h) {        
      
        var dselectedDay = ''; 
        var todaydd = new Date(); 
        var selectedDay =  c.get("v.selectedDay"); 
        
        
        if(c.get("v.checkClick")== true)
        {
            var selectedDay =  c.get("v.selectedDay"); 
            dselectedDay=selectedDay;
            var str1 = selectedDay.replace("/", "-");
            var str2 = str1.replace("/", "-");
            var smonth = str2.slice(0, 2);
            var sdate = str2.slice(3, 5);
            var syear = str2.slice(6, 10);
            selectedDay=syear+'-'+smonth+'-'+sdate;
        }else{ 
            if(c.get("v.shredirectDate") && c.get("v.shredirectDate")!=''  ){
                selectedDay =c.get("v.shredirectDate");
            }else{
                var today = new Date();
                selectedDay = today.getFullYear() + "-" + (today.getMonth() + 1) +  "-" + today.getDate();
            }
        }
        var datStr = selectedDay;
        
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
        {
            if(c.get("v.shredirectDate")){
                
                var rdDate=c.get("v.shredirectDate");
                var syear = rdDate.slice(0, 4);
                var smonth= rdDate.slice(5, 7);
                var  sdate = rdDate.slice(8, 10);
                var ddselectedDay=smonth+'/'+sdate+'/'+syear;
                c.set("v.shDate", ddselectedDay);
            }else{
                dselectedDay=  ('0' + (today.getMonth()+1)).slice(-2) + '/' + ('0' + today.getDate()).slice(-2) +'/'+ today.getFullYear();
                c.set("v.shDate",dselectedDay);
            }
            
        }else{
            
            c.set("v.shDate", dselectedDay);
        }
     
        h.request(c, 'shipConfirmRoute', {selectedDays: datStr}, function(r){

             console.log('setRoutedata>>', r.setRoutedata);
            
            
            c.set('v.setShipLines', r.setRoutedata);
            
                    window.setTimeout(
            $A.getCallback(function() {
  
              var getsetShipLines = c.get("v.setShipLines");
                console.log('getsetShipLines>>',getsetShipLines);
                
                 for(  var k=0;k<getsetShipLines.length;k++){
                 
                     
                     document.getElementById("ws"+k).innerHTML = moment.tz(getsetShipLines[k].Window_Start__c, 'America/New_York').format('hh:mm A');
                     document.getElementById("we"+k).innerHTML = moment.tz(getsetShipLines[k].Window_End__c, 'America/New_York').format('hh:mm A');
                   //  document.getElementById("pa"+k).innerHTML = moment.tz(getsetShipLines[k].Planned_Arrival_Time__c, 'America/New_York').format('hh:mm A');
                    // document.getElementById("pd"+k).innerHTML = moment.tz(getsetShipLines[k].Planned_Departure_Time__c, 'America/New_York').format('hh:mm A');
                     
                 }
                       
                
            }), 500
        );
            
           
        
            var  getgeolocation = r.getLocation;
            console.log('getgeolocation>>>',getgeolocation);
            c.set('v.smLinecount',getgeolocation.length);
               
             var pushAllAddress = [];
            
            for (var k = 0; k < getgeolocation.length; k++) {
                var adrow = getgeolocation[k];
                console.log('adrow>>>',adrow.rsAddress);
                pushAllAddress.push(adrow.rsAddress);
            }
            
              
            
            function removeDups(fullAddress) {
                let unique = {};
                fullAddress.forEach(function(i) {
                    if(!unique[i]) {
                        unique[i] = true;
                    }
                });
                return Object.keys(unique);
            }
            
            
            var finalAddress = removeDups(pushAllAddress);
             console.log('finalAddress>>>',finalAddress);
            if(finalAddress){
                
                    console.log('finalAddress str>>>',finalAddress);
                var str ='';
                var sap ='';
                for (var j = 0; j < finalAddress.length; j++) {
                    
                    if(j == 0) {
                        str += getgeolocation[0]['description']+'SEPERATOR'+finalAddress[j].replace('#','%23');
                    }else{
                        str +='SEPERATOR'+finalAddress[j].replace('#','%23'); 
                    }
                }
                  console.log('getgeolocation str>>>',str);
                c.set("v.addVal", encodeURIComponent(str));
                
            }
            
            
        }); 
        
        
        
        

      
    },onScriptsLoaded : function(c, e, h) {
        
        c.set('v.isScriptsLoaded',true);
        h.applyDataTable(c,e);
        
    }, onDepartConfirm: function(c, e, h) {
        
        // create var for store record id's for selected checkboxes  
        var delId = [];
        // get all checkboxes 
        var getAllId = c.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array
        if(! Array.isArray(getAllId)){
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
            }
        }else{
            // play a for loop and check every checkbox values 
            // if value is checked(true) then add those Id (store in Text attribute on checkbox) in delId var.
            
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    delId.push(getAllId[i].get("v.text"));
                    
                }
            }
        } 
    
        var cmpTarget = c.find('dcbtns');
        $A.util.removeClass(cmpTarget, 'dcbtn');
        var cmpTarget = c.find('dcbtns');
        $A.util.addClass(cmpTarget, 'dft');
        h.request(c, 'updateManifest', {lstRecordId: delId}, function(r){
            h.success({ message:' Depart confirmed successfully' });  
            var a = c.get('c.doInit');
            $A.enqueueAction(a);
        });
        
 
 	}, onDateChange:function (c, e, h) {
        
        var selectedDate= e.getSource().get("v.value");
        c.set("v.checkClick", true);
        var selectedDay=c.set("v.selectedDay", selectedDate);
        c.set("v.soId",'');
        var a = c.get('c.doInit');
        $A.enqueueAction(a);
     
	},getSmDetail : function(c, e, h) { 
    
        var btnValue = e.getSource().get("v.value");
        var parts = btnValue.split('#', 2);
        var rcId = parts[0];
        var soId  = parts[1];
      
        var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:ShipConfirmRsmTsmDetail",
            isredirect : true,
            componentAttributes: {
                recordId : rcId,
                prefereshval : 0,
                soId:soId,
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
 
 }
})