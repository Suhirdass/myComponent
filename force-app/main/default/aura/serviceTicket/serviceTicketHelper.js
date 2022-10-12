({
    submitServiceTickt: function(c,isUpload,isSaveDraft){
        var h = this;
        var recordId = c.get('v.recordId');
        var isParentValid = h.isValid(c);
        
        var MSLines = c.find('multiSelect');
        console.log('MSLines::',MSLines);
        var isMSValid;
        isMSValid = [].concat(MSLines).reduce(function (validSoFar, MS) {
            const isV = MS.validate();
            return validSoFar && isV;
        }, true);
        
            var serviceTicketLines = c.find('serviceTicketLine');
            var isValid;
            isValid = [].concat(serviceTicketLines).reduce(function (validSoFar, serviceTicketLine) {
                return validSoFar && serviceTicketLine.validate();
            }, true);
        if(!isParentValid || !isValid){
            
            return false;
        }
        
        var serviceTicket = c.get('v.newServiceTicket');
        
        if(isSaveDraft){
            serviceTicket.status = 'Draft';
            c.set('v.isSaveDraft',true);
            c.set('v.newServiceTicket',serviceTicket);
        } else {
            serviceTicket.status = 'Pending';
            c.set('v.newServiceTicket',serviceTicket);
        }
        
        if(serviceTicket.transferMethod === 'D2D Transfer'){
            console.log(c.get('v.newServiceTicket.licensePremise'));
            if(c.get('v.newServiceTicket.licensePremise') === '7027 Eton Ave, Los Angeles, California, US, 91303'){
            	serviceTicket.licensePremise = c.get('v.laAddressId');    
            } else if(c.get('v.newServiceTicket.licensePremise') === '2089 Ingalls St. Unit # 3, San Francisco, CA 94124'){
                serviceTicket.licensePremise = c.get('v.defaultLicenseId');   
            }
            c.set('v.newServiceTicket',serviceTicket);
        } else if(serviceTicket.transferMethod != 'Pick-up'){
            serviceTicket.licensePremise = c.get('v.defaultLicenseId');
            c.set('v.newServiceTicket',serviceTicket);
        }
        console.log('reqTempDate',c.get('v.reqTempDate'));
        if(c.get('v.reqTempDate') != undefined && c.get('v.reqTempDate') != '' && c.get('v.reqTempDate') != null){
        	var newServiceTicket = c.get('v.newServiceTicket');
            newServiceTicket.requestDate = c.get('v.reqTempDate');
            c.set('v.newServiceTicket',newServiceTicket);    
        }
        
        h.request(c, 'saveSeriveTicket', {recordId: recordId, serviceTicketData: JSON.stringify(c.get('v.newServiceTicket')), serviceTicketLinesData: JSON.stringify(c.get('v.newServiceTicketLines')), requestDate : c.get('v.requestDateTimeStr'),isServiceTicket:true}, function(r){
            console.log("STLs::",c.get('v.newServiceTicketLines'));
            console.log('saveSeriveTicket::',r);
            /*h.success({message: ('Service ticket ' + (recordId? 'Updated ': 'Created') + ' successfully.')});
            h.redirect('/servicetickets', true);*/
            if(!isUpload){
                c.set('v.isShowSuccess',true);
                window.setTimeout($A.getCallback(function(){
                    const modal = document.getElementById('success-modal');
                    if (modal) modal.classList.add('is-active');
                }),100)
            }else{
                sessionStorage.setItem('serviceTicketId',r.serviceTicket.Id);
                var brd = sessionStorage.getItem('breadCrumb');
                if(brd){
                    brd = JSON.parse(brd);
                    if(brd.breadCrumbString.lastIndexOf(r.serviceTicket.Name) == -1){
                        brd.breadCrumbString += ' > '+r.serviceTicket.Name;
                        brd.breadCrumbIds+=' > ';
                        sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}));
                        $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: brd.breadCrumbString, breadCrumbIds : brd.breadCrumbIds}).fire();
                    }
                }
                h.redirect('/viewserviceticket', true);
            }
            
        });
    },
    applyDate : function(c) {
        var h = this;
        try{
            
        var recordId = c.get('v.recordId');
        var isDataLoaded = c.get('v.isDataLoaded');
            console.log('applyDate...',isDataLoaded);
        if(isDataLoaded){
            
            var cutOffTime = c.get('v.cutOffTime');
            var date = new Date();
            //var date = new Date('2020-05-04 17:23:00');
            var hours = date.getHours();
            var minutes = date.getMinutes();
            
            console.log('dATE = ',date);
            
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
                        ttime = +timeS[0];  
                        tminutes = timeS[1];
                    }    
                }
                
                console.log('ttime = '+ttime);
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
                    if(hours > ttime){
                        date.setDate(date.getDate() + 3);    
                    } else if(hours == ttime){
                    	if(minutes > tminutes) date.setDate(date.getDate() + 5);
                        else date.setDate(date.getDate() + 4);
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
            
            
            
            if(c.get('v.newServiceTicket').requestDate != undefined && c.get('v.newServiceTicket').requestDate != null){
            	
                var requestDate = c.get('v.newServiceTicket').requestDate;
                var datearray = requestDate.split("-");
                var newdate = datearray[1] + '-' + datearray[2] + '-' + datearray[0];
                c.set('v.requestDateTime',newdate); 
                c.set('v.requestDateTimeStr',newdate+ ' 00:00:00');
                var newServiceTicket = c.get('v.newServiceTicket');
                c.set('v.reqTempDate',newServiceTicket.requestDate);
                newServiceTicket.requestDate = newdate;
                c.set('v.newServiceTicket',newServiceTicket);
                
                /*var time = c.get('v.newServiceTicket').requestTime;
                
                if(newdate != '' && newdate != undefined){
                    newdate = newdate; + ' '+time;
                    console.log(newdate);
                    c.set('v.requestDateTimeStr',newdate);   
                }*/
            }
            var disableDates = c.get('v.holidayList');
            if(recordId != '' && recordId != undefined){
                var minDates = c.get('v.newServiceTicket').requestDate;
                if(minDates){
                    var dateP = minDates.split('-');
                    
                    $('#datepickerId').datepicker({
                        dateFormat: 'mm-dd-yy',
                        defaultDate : new Date(dateP[0],parseInt(dateP[1],10)-1,dateP[2]),
                        minDate: date,
                        beforeShowDay: function(mdate){
                            var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                            console.log('dmy:',dmy);
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
                    }); 
                }else{
                    $('#datepickerId').datepicker({
                        dateFormat: 'mm-dd-yy',
                        minDate: date,
                        beforeShowDay: function(mdate){
                            var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                            console.log('dmy:',dmy);
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
                    }); 
                }
                
            } else {
            	$('#datepickerId').datepicker({
                    dateFormat: 'mm-dd-yy',
                    minDate: date,
                    beforeShowDay: function(mdate){
                        var dmy = (mdate.getMonth() + 1) + "-" + mdate.getDate() + "-" + mdate.getFullYear();
                        console.log('dmy:',dmy);
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
                });    
            }
            
            /*
            if(recordId != '' && recordId != undefined){
                minDate = c.get('v.newServiceTicket').requestDate;
            }
            
            if(minDate != undefined){
                console.log('minDate',minDate);
                var dateP = minDate.split('-');
                $('#datepickerId').datepicker({
                    dateFormat: 'mm-dd-yy',
                    minDate: new Date(dateP[0],parseInt(dateP[1],10)-1,dateP[2])
                });    
            } else {
                console.log('today New',today);
              $('#datepickerId').datepicker({
                    dateFormat: 'mm-dd-yy'
                });     
            }*/
            
            
            $("#datepickerId").change(function(){
                if($('#datepickerId').val() != ''){
                    var reqDate = c.get('v.requestDateTime');
                    reqDate = $('#datepickerId').val();
                    c.set('v.requestDateTime',reqDate);
                    
                    reqDate = c.get('v.requestDateTime');
                    
                    var serviceTicket = c.get('v.newServiceTicket');
                    //alert(serviceTicket.id);
            		var reqDateStr = reqDate+'';
                    c.set('v.requestDateTimeStr',reqDateStr+ ' 00:00:00');
                    console.log('reqDate = ',reqDateStr);
                    /*window.setTimeout($A.getCallback(function(){
                        h.request(c, 'calanderEvents', {reqDateTime: reqDateStr,reqTime: ''}, function(r){
                            console.log('Response :: ',r);
                            c.set('v.calendarEvents',r.slots);
                            //h.redirect('/newserviceticket', true);   
                        });
                    }),100);*/
                }
            });
            
        }else{
            window.setTimeout($A.getCallback(function(){
                h.applyDate(c);
            }),100);
        }
        }catch(err){console.log('Error:',err)}
	},
    
    changeDate: function(c) {
        var h = this;
        try{
        	var reqDate = c.get('v.requestDateTime');
            var reqDateStr = reqDate+'';
            console.log('reqDate = ',reqDateStr);
            
            var action = c.get("c.calanderEvents");
            action.setParams({ reqDateTime : reqDateStr });
            action.setCallback(this, function(response) {
                var resp = response.getReturnValue()
                console.log('resp :: ',resp);
            });
            $A.enqueueAction(action);
            /*h.request(c, 'calanderEvents', {reqDateTime: reqDateStr}, function(r){
                console.log('Response :: ',r);
            	//h.redirect('/newserviceticket', true);   
            });*/
            
        } catch(err){
        	console.log('Error:',err)    
        }
    }
})