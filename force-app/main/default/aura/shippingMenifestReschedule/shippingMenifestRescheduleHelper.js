({
    smReschedule : function(c, e) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/apex/SMReschedule?id=" + c.get("v.recordId")
            
        });
        urlEvent.fire();
    },
    
    rescheduleSmLines : function(c, e, h,scheduleBy) {
        //if(scheduleBy == 'customer'){
            /*var MSLines = c.find('multiSelect');
            var isMSValid;
            isMSValid = [].concat(MSLines).reduce(function (validSoFar, MS) {
                const isV = MS.validate();
                return validSoFar && isV;
            }, true);*/
            c.set('v.isDisabledRBC',true);
            
        h.request(c, 'rescheduleByCustomer', {recordId: c.get('v.recordId'),schedule: scheduleBy,ReasonCodeStr :c.get('v.ReasonCodeName') ,NotesStr :c.get('v.Notes'),shipDate :c.get('v.requestDate'),'startTimeStr':c.get('v.requestEarTime'),'endTimeStr':c.get('v.requestLatTime')/*c.get('v.Planned_Ship_Transfer_Date')*/}, function(r){
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            var message = r.messagelightning;
            c.set('v.messagelightning',r.messagelightning);
            if(message){
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                h.error({ message:r.messagelightning });    
            }else {
                c.set('v.isDisabledRBC',false);
                h.success({ message:'Shipping Manifest has been rescheduled successfully.' });    
            }
            $A.get('e.force:refreshView').fire();  
        });
        /*}else{
            h.request(c, 'smRescheduleLight', {recordId: c.get('v.recordId'),schedule: scheduleBy}, function(r){
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            var message = r.messagelightning;
            c.set('v.messagelightning',r.messagelightning);
            if(message){
                var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
                dismissActionPanel.fire();
                h.error({ message:r.messagelightning });    
            }else {
                h.success({ message:'Shipping Manifest has been rescheduled successfully.' });    
            }
            $A.get('e.force:refreshView').fire();  
        });
        }*/
        
    },
    applyDate : function(c) {
        var h = this;
        try{
            var isDataLoaded = c.get('v.isDataLoaded');
            if(isDataLoaded){
            var cutOffTime = c.get('v.cutOffTime');
            var date = new Date();
            //var date = new Date('2020-05-07 10:29:00');
            var hours = date.getHours();
            var minutes = date.getMinutes();
            
            console.log('dATE = ',minutes);
            
            if(cutOffTime != '' && cutOffTime != undefined && cutOffTime != null){
                var timeSlot = cutOffTime.split(" ");
                var tFormat = timeSlot[0].substring(timeSlot[0].length - 2);
                var ttime = timeSlot[0].substring(0,timeSlot[0].length - 2);
                
                var tminutes;
                if(tFormat == 'PM'){
                    if(ttime.includes(":")){
                        let timeS = ttime.split(":"); 
                        ttime = +timeS[0] + 12;
                        tminutes = timeS[1];
                        //ttime = ttime + ':'+timeS[1];
                    } else{
                    	ttime = +ttime + 12;  
                    }	    
                } else {
                    if(ttime.includes(":")){
                    	let timeS = ttime.split(":"); 
                        tminutes = timeS[1];
                        ttime = +timeS[0];    
                    }    
                }
                date.setDate(date.getDate() + 1);
                /*if(date.getDay() == 5){
                    if(hours > ttime){
                        date.setDate(date.getDate() + 5);       
                    } else if(hours == ttime){
                    	if(minutes > tminutes) date.setDate(date.getDate() + 5);
                        else date.setDate(date.getDate() + 4);
                    } else {
                        date.setDate(date.getDate() + 4);    
                    }
                } else if(date.getDay() == 6 || date.getDay() == 0){
                	if(date.getDay() == 6) date.setDate(date.getDate() + 4);
                    if(date.getDay() == 0) date.setDate(date.getDate() + 3);
                } else {
                    if(hours <= ttime && minutes <= tminutes){
                        date.setDate(date.getDate() + 2);
                        console.log('date.getDay() ',date.getDay());
                    } else if(hours > ttime){
                        date.setDate(date.getDate() + 3);
                        console.log('date.getDay() ',date.getDay());
                    } else if(hours == ttime){
                    	if(minutes > tminutes) date.setDate(date.getDate() + 5);
                        else date.setDate(date.getDate() + 4);
                    } else {
                        date.setDate(date.getDate() + 2); 
                    }
                }   */ 
            } else {
                /*if(date.getDay() == 5){
                	date.setDate(date.getDate() + 5);      
                } else {*/
                	date.setDate(date.getDate() + 1);      
                //}    
            }
            
            var disableDates = c.get('v.holidayList');
            
            $('#datepickerId').datepicker({
                dateFormat: 'mm-dd-yy',
                minDate: date,
                beforeShowDay: 
                function(mdate){
                    var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                    console.log('dmy:',dmy);
                    console.log('disableDates:',disableDates);
                    if(mdate.getDay() == 0 || mdate.getDay()== 6){
                        return [false, '', ''];    
                    }
                    if(disableDates.indexOf(dmy) != -1){
                        return [false, '', ''];//return false;
                    }
                    else{
                        return [true,'',''];
                    }
                }
                //$.datepicker.noWeekends
            });
            
            $("#datepickerId").change(function(){
                if($('#datepickerId').val() != ''){
                    console.log('reqDate = ',$('#datepickerId').val());
                    c.set('v.requestDateShow',$('#datepickerId').val());
                    var reqDate = c.get('v.requestDate');
                    reqDate = $('#datepickerId').val();
                    
                    var datearray = reqDate.split("-");
                	reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];
                    
                    console.log('reqDate = ',reqDate);
                    c.set('v.requestDate',reqDate);
                }
            });
            }else{
                window.setTimeout($A.getCallback(function(){
                    h.applyDate(c);
                }),100);
            }
           
        }catch(err){console.log('Error:',err)}
	},
})