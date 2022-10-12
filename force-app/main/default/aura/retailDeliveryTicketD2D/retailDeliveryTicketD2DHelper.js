({
    processCalculations:function(c,isFromButton){
        var h = this;
        try{
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            if(isFromButton){
                if(!c.get('v.isDateChanged')){
                    var reqDate = c.get('v.reqTempDate');
                    newRetailDeliveryTicket.requestShipDate = reqDate;   	    
                } else {
                    var reqDate = c.get('v.requestDateTimeHide');
                    newRetailDeliveryTicket.requestShipDate = reqDate;    
                }    
            }
            var selectedStateLicenseId = c.get('v.newRetailDeliveryTicket').stateLicense;
            h.request(c, 'calculateOrderProcessingFee', { satateLicenseId: selectedStateLicenseId,itemsJSON: JSON.stringify(c.get('v.newRetailDeliveryTicketLineItems')),orderJSON: JSON.stringify(newRetailDeliveryTicket),productJSON:JSON.stringify(c.get('v.products'))}, function (r) {
                try{
                    console.log('calculateOrderProcessingFee = ',r);
                    c.set('v.pickPackfee',r.totalPickPack.toFixed(2));
                    c.set('v.QAFee',r.totalQAReview.toFixed(2)); 
                    c.set('v.orderBookingFee',r.retailDeliveryTicket.orderBookingFee.toFixed(2));
                    c.set('v.stageAndManifestFee',r.retailDeliveryTicket.stageManifestFee.toFixed(2));
                    var packOutFee = r.retailDeliveryTicket.packOutFee;
                    var orderProcessingFee = r.totalPickPack + r.totalQAReview + r.retailDeliveryTicket.orderBookingFee + r.retailDeliveryTicket.stageManifestFee + r.retailDeliveryTicket.packOutFee;
                    var shippingFee = r.retailDeliveryTicket.scheduleDispatchFee + r.retailDeliveryTicket.totalMileageFee + r.retailDeliveryTicket.totalWeightFee;
                    var totalServicesfee = orderProcessingFee + shippingFee;
                    c.set('v.shippingFee',shippingFee.toFixed(2));
                    c.set('v.orderProcessingFee',orderProcessingFee.toFixed(2));
                    c.set('v.totalServicesfee',totalServicesfee.toFixed(2));
                    var subTotal = c.get('v.subTotal');
                    subTotal = subTotal.replace(/,/g, "");
                    var distribution = totalServicesfee/parseFloat(subTotal);
                    distribution = distribution * 100;
                    c.set('v.distribution',distribution.toFixed(1));
                    var orderInfo = '<table>';
                    orderInfo += '<tr><td style="text-align:right">Order Booking: &nbsp;</td><td> $'+r.retailDeliveryTicket.orderBookingFee.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Pack Out Fee: &nbsp;</td><td> $'+r.retailDeliveryTicket.packOutFee.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Pick & Pack: &nbsp;</td><td> $'+r.totalPickPack.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">QA Review: &nbsp;</td><td> $'+r.totalQAReview.toFixed(2)+'</td></tr>';
                    orderInfo += '<tr><td style="text-align:right">Stage & Manifest: &nbsp;</td><td> $'+r.retailDeliveryTicket.stageManifestFee.toFixed(2)+'</td></tr>';
                    orderInfo += '</table>';
                    c.set('v.orderInfo',orderInfo);
                    c.set('v.newRetailDeliveryTicket',r.retailDeliveryTicket);
                    c.set('v.newRetailDeliveryTicketLineItems',r.retailDeliveryTicketLineItems);
                    window.setTimeout($A.getCallback(function(){
                        c.set('v.isEnable',true);
                    }),500)
                }catch(err){
                    console.log('err:',err);
                }
            });
            
        }catch(err){
            console.log('Error:',err);
        }
    },
    calculateMiles : function(c,sourceAddress,destination){
        /*console.log('sourceAddress ',sourceAddress);
        console.log('destination ',destination);
        this.request(c, 'getDistance', { sAddress: sourceAddress,dAddress: destination}, function (r) {
            try{
            console.log('getDistance:',r);
            
            if(r.miles)c.set('v.routeMiles',r.miles);
            var routeMiles = c.get('v.routeMiles');
            var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
            newRetailDeliveryTicket.Route_Miles = routeMiles;
            console.log('routeMiles:',routeMiles);
            c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            }catch(err){console.log('Error:',err);}
        });*/
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
                        console.log('date.getDay() ',date.getDay());
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
            
            if(c.get('v.newRetailDeliveryTicket').requestShipDate != undefined && c.get('v.newRetailDeliveryTicket').requestShipDate != null){
            	
                var requestShipDate = c.get('v.newRetailDeliveryTicket').requestShipDate;
                console.log('requestShipDate'+requestShipDate);
                var datearray = requestShipDate.split("-");
                var newdate = datearray[1] + '-' + datearray[2] + '-' + datearray[0];
                c.set('v.requestDateTime',newdate); 
                var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                c.set('v.reqTempDate',newRetailDeliveryTicket.requestShipDate);
                newRetailDeliveryTicket.requestShipDate = newdate;
                c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);
            }
            var disableDates = c.get('v.holidayList');
            if(recordId != '' && recordId != undefined){
                var minDates = c.get('v.newRetailDeliveryTicket').requestShipDate;
                console.log('minDates = '+minDates);
                $('#datepickerId').datepicker({
                    dateFormat: 'mm-dd-yy',
                    defaultDate : minDates,
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
                
                $('#datepickerId').datepicker("setDate",minDates);
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
            
            
            
            $("#datepickerId").change(function(){
                if($('#datepickerId').val() != ''){
                    var reqDate = c.get('v.requestDateTime');
                    reqDate = $('#datepickerId').val();
                    c.set('v.requestDateTime',reqDate);
                    console.log('reqDate = ',reqDate)
                    var datearray = reqDate.split("-");
                	reqDate = datearray[2] + '-' + datearray[0] + '-' + datearray[1];
                    
                    console.log('reqDate = ',reqDate);
                    c.set('v.requestDateTimeHide',reqDate);
                    c.set('v.isDateChanged',true);
                    
                    /*var newRetailDeliveryTicket = c.get('v.newRetailDeliveryTicket');
                    newRetailDeliveryTicket.requestShipDate = reqDate;
                    c.set('v.newRetailDeliveryTicket',newRetailDeliveryTicket);*/
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