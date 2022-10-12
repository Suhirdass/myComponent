({
	applyDate : function(c) {
        var h = this;
        try{
            var cutOffTime = c.get('v.cutOffTime');
            var date = new Date();
            //var date = new Date('2022-02-03 17:02:00');
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
                    if(date.getDay() == 5){
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
                        
                        if(hours > 12 && date.getDay() == 4){
                            date.setDate(date.getDate() + 5);
                        } else if(hours <= ttime && minutes <= tminutes){
                            date.setDate(date.getDate() + 2);
                        } else if(hours > ttime){
                            date.setDate(date.getDate() + 3);
                        } else if(hours == ttime){
                            if(minutes > tminutes) date.setDate(date.getDate() + 5);
                            else {
                                date.setDate(date.getDate() + 4);
                            }
                        } else {
                            date.setDate(date.getDate() + 2);
                        }
                    }  
            } else {
                    if(date.getDay() == 5){
                        date.setDate(date.getDate() + 5);      
                    } else {
                        date.setDate(date.getDate() + 2);      
                    } 
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
           
        }catch(err){console.log('Error:',err)}
	},
})