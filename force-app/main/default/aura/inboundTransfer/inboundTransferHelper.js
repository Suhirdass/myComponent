({
    getLicenseOptions : function(c,e,selectedIds){
        let pickupLicenceMap = c.get('v.pickupLicenceMap');
        let filigreenStateLicenseMap = c.get('v.filigreenStateLicenseMap');
        let onSiteContactMap = c.get('v.onSiteContactMap');
        let pickup;
        
        let transMethod = c.get('v.newServiceTicket').transferMethod;
        
        /*if(transMethod === 'Drop-off'){
            console.log('######2',selectedIds);
            console.log('######1',JSON.stringify(filigreenStateLicenseMap));
			pickup = filigreenStateLicenseMap[selectedIds]            
        } else {
            pickup = pickupLicenceMap[selectedIds];
        }*/
        pickup = pickupLicenceMap[selectedIds]; 
        let contact = onSiteContactMap[selectedIds];
        console.log('contact = ',contact);
        
        /*let serviceTicket = c.get('v.newServiceTicket');
        serviceTicket.licenseName = '';
        serviceTicket.licensePremise = '';
        //c.set('v.newServiceTicket',serviceTicket);*/
        console.log('######3',JSON.stringify(pickup));
        let licenseOptions = [];
        if(pickup != undefined){
            if(Array.isArray(pickup)){
            	pickup.forEach((pick) => {
                    console.log('######5');
                    let licenseOpt;
                    if(pick.License_Address__c){
                        licenseOpt = pick.License_Address__c;
                    }
                    if(pick.License_City__c){
                        licenseOpt += ', ' + pick.License_City__c;
                    }
                    if(pick.License_State__c){
                        licenseOpt += ', ' + pick.License_State__c;
                    }
                    if(pick.License_Country__c){
                        licenseOpt += ', ' + pick.License_Country__c;
                    }
                    if(pick.License_Zip__c){
                        licenseOpt += ', ' + pick.License_Zip__c;
                    }
                    licenseOptions.push({id:pick.Id , name: pick.License_Number__c + ' | '+licenseOpt});
                });    	
            } else {
                let licenseOpt;
                if(pickup.License_Address__c){
                    licenseOpt = pickup.License_Address__c;
                }
                if(pickup.License_City__c){
                    licenseOpt += ', ' + pickup.License_City__c;
                }
                if(pickup.License_State__c){
                    licenseOpt += ', ' + pickup.License_State__c;
                }
                if(pickup.License_Country__c){
                    licenseOpt += ', ' + pickup.License_Country__c;
                }
                if(pickup.License_Zip__c){
                    licenseOpt += ', ' + pickup.License_Zip__c;
                }
                licenseOptions.push({id:pickup.Id , name: pickup.License_Number__c + ' | '+licenseOpt});
            }
        }
        
    	c.set('v.licensesOptions',licenseOptions);
    
    	let onSiteContacts = [];
    	if(contact != undefined){
    		contact.forEach((con) => {
            	onSiteContacts.push({id:con.Id , name: con.Name});
        	});
		}
    	c.set('v.onSiteContacts',onSiteContacts);
        
    },
    updateLicensePremise: function(c,licenseId){
        var serviceTicket = c.get('v.newServiceTicket');
        var stateLicenseMap = c.get('v.stateLicenseMap');
        var filigreenStateLicenseMap = c.get('v.filigreenStateLicenseMap');
        //var license = stateLicenseMap[licenseId];
        var license;
        if(serviceTicket.transferMethod != 'Pick-up'){
            //license = c.get('v.defaultStateLicense');
            //license = filigreenStateLicenseMap[licenseId];
            license = stateLicenseMap[licenseId];
        }else{
            license = stateLicenseMap[licenseId];
        }
        console.log('license::',license);
        var lAddress = '';
        if(license){
            if(license.License_Address__c != undefined){
                lAddress = license.License_Address__c;
            }
            if(license.License_City__c != undefined){
                lAddress+= ', ' + license.License_City__c;
            }
            if(license.License_State__c != undefined){
                lAddress+= ', ' + license.License_State__c;
            }
            if(license.License_Country__c != undefined){
                lAddress+= ', ' + license.License_Country__c;
            }
            if(license.License_Zip__c != undefined){
                lAddress+= ', ' + license.License_Zip__c;
            }
        }
        c.set('v.selectedStateAddress',lAddress);
    },
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
        if(!isMSValid){
            //return false;
        }
        
        var serviceTicketLines = c.find('serviceTicketLine');
        var isValid;
        isValid = [].concat(serviceTicketLines).reduce(function (validSoFar, serviceTicketLine) {
            return validSoFar && serviceTicketLine.validate();
        }, true);
        if(!isParentValid || !isValid || !isMSValid){
            
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
        } /*else if(serviceTicket.transferMethod != 'Pick-up'){
            serviceTicket.licensePremise = c.get('v.defaultLicenseId');
            c.set('v.newServiceTicket',serviceTicket);
        }*/
        
        if(c.get('v.reqTempDate') != undefined && c.get('v.reqTempDate') != '' && c.get('v.reqTempDate') != null){
        	var newServiceTicket = c.get('v.newServiceTicket');
            newServiceTicket.requestDate = c.get('v.reqTempDate');
            c.set('v.newServiceTicket',newServiceTicket);    
        }
        console.log('JSON:',JSON.stringify(c.get('v.newServiceTicket')));
        console.log('Lines JSON:',JSON.stringify(c.get('v.newServiceTicketLines')));
        h.request(c, 'saveSeriveTicket', {recordId: recordId, serviceTicketData: JSON.stringify(c.get('v.newServiceTicket')), serviceTicketLinesData: JSON.stringify(c.get('v.newServiceTicketLines')), requestDate : c.get('v.requestDateTimeStr'),isServiceTicket:false}, function(r){
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
                h.redirect('/inboundtransferview', true);
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
                    if(hours > 12 && date.getDay() == 4){
                        date.setDate(date.getDate() + 5);
                    } else if(hours <= ttime && minutes <= tminutes){
                        date.setDate(date.getDate() + 2);
                    } else if(hours > ttime){
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
                
                var newServiceTicket = c.get('v.newServiceTicket');
                c.set('v.reqTempDate',newServiceTicket.requestDate);
                newServiceTicket.requestDate = newdate;
                c.set('v.newServiceTicket',newServiceTicket);
                
                var time = c.get('v.newServiceTicket').requestTime;
                
                if(newdate != '' && newdate != undefined){
                    newdate = newdate + ' '+time;
                    console.log(newdate);
                    c.set('v.requestDateTimeStr',newdate);   
                }
            }
            var disableDates = c.get('v.holidayList');
            console.log('disableDates:',disableDates);
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
                    console.log('reqDate = ',reqDateStr);
                    window.setTimeout($A.getCallback(function(){
                        h.request(c, 'calanderEvents', {reqDateTime: reqDateStr,reqTime: ''}, function(r){
                            console.log('Response :: ',r);
                            c.set('v.calendarEvents',r.slots);
                            //h.redirect('/newserviceticket', true);   
                        });
                    }),100);
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