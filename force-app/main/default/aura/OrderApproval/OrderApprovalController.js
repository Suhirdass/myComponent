({
	doInit : function(component, event, helper) {
        console.log('doInit::',component.get("v.recordId"));
        var sURL = window.location.href;
        var Reschedule = sURL.split('reschedule=');
        var RescheduleSplit;
        if(Reschedule.length > 1)
        	RescheduleSplit =Reschedule[1].split('-');
        //alert(RescheduleSplit[1]);
        if(Reschedule.length > 1 && RescheduleSplit[0] == 'true'){
            component.set("v.Reschedule",true);
            if(RescheduleSplit[1] == 'a'){
                //component.set("v.isSample",true);
                component.set("v.isApproveOrRequestDate",true);
                
            }
            if(RescheduleSplit[1] == 'c'){
                component.set("v.isSample",true);
                component.set("v.isCancel",true);
            }
        }else{
            component.set("v.Reschedule",false);
        }
        //alert(component.get("v.Reschedule"));
        helper.request(component, 'getOrderStatus', { 'recordId': component.get("v.recordId") ,'reschedule' : component.get("v.Reschedule")}, function (r) {
            console.log('getOrderStatus::',r);
            if(r.inActiveCalendar){
                component.set("v.inActiveCalendar", r.inActiveCalendar);
                if(r.isLinkAlreadyUsed) component.set("v.isLinkAlreadyUsed",r.isLinkAlreadyUsed);
            }
            component.set("v.Msg_for_Reschedule_Shipment_Complete", r.Msg_for_Reschedule_Shipment_Complete);
            component.set("v.Err_Msg_For_Past_Date",r.Err_Msg_For_Past_Date);
            console.log('r.approved '+r.retailerOrder.Requested_Delivery_Earliest_Time__c);
            component.set("v.alreadyApproved", r.approved);
            component.set("v.allowedToApproved", r.allowedToApproved);
            component.set("v.order", r.retailerOrder);
            if(r.retailerOrder.Sample_Order__c && component.get("v.Reschedule") != true){
                component.set("v.isSample", r.retailerOrder.Sample_Order__c);
            }
            
            component.set('v.cutOffTime',r.cutOffTime);
            component.set('v.holidayList', r.holidayList);
            component.set('v.EARLIEST_DELIVERY_TIME',r.EARLIEST_DELIVERY_TIME);
            component.set('v.LATEST_DELIVERY_TIME',r.LATEST_DELIVERY_TIME);
            if(r.retailerOrder.Request_Ship_Date__c != undefined && r.retailerOrder.Request_Ship_Date__c != null){
                console.log(r.retailerOrder.Request_Ship_Date__c);
                var reqDate = r.retailerOrder.Request_Ship_Date__c;
                var datearray = reqDate.split("-");
                reqDate = datearray[1] + '-' + datearray[2] + '-' + datearray[0];
                console.log('reqDate = ',reqDate);
                //component.set("v.requestDateShow", reqDate);
            }
            
        });
        
        /*helper.request(component, 'approveOrder', { 'recordId': component.get("v.recordId") }, function (r) {
            console.log(r);
            if(r.approved){
                component.set("v.status", "1");
            }else{
                component.set("v.status", "0");
            }
        });*/
	},
    onCancel : function(c, e, h) {
        h.request(c, 'cancelOrder', { 'recordId': c.get("v.recordId")}, function (r) {
                                                      console.log(r);
                                                      c.set("v.order", r.retailerOrder);
                                                      c.set("v.approved", r.approved);
                                                          c.set("v.earTime",  r.retailerOrder.Requested_Delivery_Earliest_Time__c);
                                                          c.set("v.letTime",  r.retailerOrder.Requested_Delivery_Latest_Time__c);
                                                      //component.set("v.isCancel",false);
                                                      
            });
    },
    onClose : function(c, e, h) {
        var customWindow = window.open('', '_blank', '');
    	customWindow.top.close();
    },
    onApprove : function(c, e, h) {
        let earTime = c.get('v.requestEarTime');
            let strEarTime;
            let strLetTime;
            if(earTime != ''){
                c.set('v.hasEarliestTimeError',false);
                strEarTime = earTime.split(':');
                console.log('##strEarTime',strEarTime[0],' - ',strEarTime[1]);
                if(strEarTime.length > 0){
                    if(strEarTime[0] > 12){
                        let eTime = (strEarTime[0] - 12);
                        if(eTime < 10)
                            earTime = '0' + (strEarTime[0] - 12) + ':' + strEarTime[1] + ' PM';	
                        else 
                            earTime = (strEarTime[0] - 12) + ':' + strEarTime[1] + ' PM';	
                    } else {
                        if(strEarTime[0] === '12'){
                            earTime = strEarTime[0] + ':' + strEarTime[1] + ' PM';    
                        } else if(strEarTime[0] === '00'){
                            earTime = 12 + ':' + strEarTime[1] + ' AM';    
                        } else{
                            earTime = strEarTime[0] + ':' + strEarTime[1] + ' AM';    
                        }	    
                    }   
                    c.set("v.earTime", earTime);
                }
            }
            
            let letestTime = c.get('v.requestLatTime');
            if(letestTime != ''){
                c.set('v.hasLatestTimeError',false);
                strLetTime = letestTime.split(':');
                if(strLetTime.length > 0){
                    if(strLetTime[0] > 12){
                        let lTime = (strLetTime[0] - 12);
                        if(lTime < 10 )
                            letestTime = '0' + (strLetTime[0] - 12) + ':' + strLetTime[1] + ' PM';
                        else 
                            letestTime = (strLetTime[0] - 12) + ':' + strLetTime[1] + ' PM';
                    } else {
                        if(strLetTime[0] === '12'){
                            letestTime = strLetTime[0] + ':' + strLetTime[1] + ' PM';    
                        } else if(strLetTime[0] === '00'){
                            letestTime = 12 + ':' + strLetTime[1] + ' AM';    
                        } else{
                            letestTime = strLetTime[0] + ':' + strLetTime[1] + ' AM';  
                        }
                    }   
                    c.set("v.letTime", letestTime);
                }
            }
         h.request(c, 'approveOrder', { 'recordId': c.get("v.recordId"),'reschedule' : c.get("v.Reschedule"),'isApproveOrRequestDate':c.get("v.isApproveOrRequestDate"),
                                                  'requestDate' : c.get('v.requestDate'),
                                                  'requestEarTime':c.get('v.earTime'),
                                                  'requestLatTime':c.get('v.letTime')}, function (r) {
                                                      console.log(r);
                                                      c.set("v.order", r.retailerOrder);
                                                      c.set("v.approved", r.approved);
                                                          c.set("v.earTime",  r.retailerOrder.Requested_Delivery_Earliest_Time__c);
                                                          c.set("v.letTime",  r.retailerOrder.Requested_Delivery_Latest_Time__c);
                                                     
                                                      
            });
    },
    onSubmit : function(c, e, h) {
        //c.set('v.isProcessing',true);
        console.log('requestDate = ',c.get('v.requestDate'));
        console.log('requestEarTime = ',c.get('v.requestEarTime'));
        console.log('requestLatTime = ',c.get('v.requestLatTime'));
        var allValid =false;
        var retailerOrder = c.get('v.order');
        var isSample = c.get('v.order').Sample_Order__c || c.get("v.isSample") ? true :false;
        var isThird_Party_Scheduler = c.get('v.order').Retailer__r.Third_Party_Scheduler__c ? true : false;
        if((isSample != true && isThird_Party_Scheduler != true) || 
          (retailerOrder.Sample_Order__c && retailerOrder.RecordType.Name == 'Transfer'
              && retailerOrder.Retailer__r.Third_Party_Scheduler__c == false && retailerOrder.isPreapproved__c == false && retailerOrder.Piggyback_sample__c == false
              )
          ){
            let timeSlots = c.find('fieldId');
            
            var allValid = [].concat(timeSlots).reduce(function (validSoFar, customLookup) {
                console.log("timeSlots::",JSON.stringify(customLookup));
                console.log("Valid::",validSoFar && customLookup.validate());
                return validSoFar && customLookup.validate();
            }, true);
            
            /*var allValid = [].concat(c.find('fieldId')).reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);*/
          
            
            if(c.get('v.requestDate') != null && c.get('v.requestDate') != '' && c.get('v.requestDate') != undefined){
                if(c.get("v.Reschedule")){
                    var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                    if(c.get('v.requestDate') > today){
                        c.set('v.hasDateError',false);
                    }else{
                        h.error({ message: (c.get('v.Err_Msg_For_Past_Date')) });
                        c.set('v.hasDateError',true);
                        return; 
                    }
                }else{
                    c.set('v.hasDateError',false);
                }
                 
            }else{
                if(c.get('v.requestDateShow') != null && c.get('v.requestDateShow') != '' && c.get('v.requestDateShow') != undefined){
                    var reqDateShow = c.get('v.requestDateShow');
                    var datearrayShow = reqDateShow.split("-");
                    reqDateShow = datearrayShow[2] + '-' + datearrayShow[0] + '-' + datearrayShow[1];
                    console.log('reqDate = ',reqDateShow);
                    c.set("v.requestDate", reqDateShow);
                } else {
                        c.set('v.hasDateError',true);
                        allValid = false;
                        return;   
                
                }
            }  
            
            let earTime = c.get('v.requestEarTime');
            let strEarTime;
            let strLetTime;
            if(earTime != ''){
                c.set('v.hasEarliestTimeError',false);
                strEarTime = earTime.split(':');
                console.log('##strEarTime',strEarTime[0],' - ',strEarTime[1]);
                if(strEarTime.length > 0){
                    if(strEarTime[0] > 12){
                        let eTime = (strEarTime[0] - 12);
                        if(eTime < 10)
                            earTime = '0' + (strEarTime[0] - 12) + ':' + strEarTime[1] + ' PM';	
                        else 
                            earTime = (strEarTime[0] - 12) + ':' + strEarTime[1] + ' PM';	
                    } else {
                        if(strEarTime[0] === '12'){
                            earTime = strEarTime[0] + ':' + strEarTime[1] + ' PM';    
                        } else if(strEarTime[0] === '00'){
                            earTime = 12 + ':' + strEarTime[1] + ' AM';    
                        } else{
                            earTime = strEarTime[0] + ':' + strEarTime[1] + ' AM';    
                        }	    
                    }   
                    c.set("v.earTime", earTime);
                }
            }else{
                c.set('v.hasEarliestTimeError',true);
                allValid = false;
                return;
            }
            
            let letestTime = c.get('v.requestLatTime');
            if(letestTime != ''){
                c.set('v.hasLatestTimeError',false);
                strLetTime = letestTime.split(':');
                console.log('##strLetTime',strLetTime[0],' - ',strLetTime[1]);
                if(strLetTime.length > 0){
                    if(strLetTime[0] > 12){
                        let lTime = (strLetTime[0] - 12);
                        if(lTime < 10 )
                            letestTime = '0' + (strLetTime[0] - 12) + ':' + strLetTime[1] + ' PM';
                        else 
                            letestTime = (strLetTime[0] - 12) + ':' + strLetTime[1] + ' PM';
                    } else {
                        if(strLetTime[0] === '12'){
                            letestTime = strLetTime[0] + ':' + strLetTime[1] + ' PM';    
                        } else if(strLetTime[0] === '00'){
                            letestTime = 12 + ':' + strLetTime[1] + ' AM';    
                        } else{
                            letestTime = strLetTime[0] + ':' + strLetTime[1] + ' AM';  
                        }
                    }   
                    c.set("v.letTime", letestTime);
                }
            }else{
                c.set('v.hasLatestTimeError',true);
                allValid = false;
                return;
            }
            
                if(parseInt(strLetTime[0]) < parseInt(strEarTime[0])){
                    c.set('v.latesDateAfterEarliestDateError',true);
                    allValid = false;
                    return;   
            }else{
                c.set('v.latesDateAfterEarliestDateError',false);  
            }
        }
        
        if(allValid || (isSample || isThird_Party_Scheduler) ){
            h.request(c, 'approveOrder', { 'recordId': c.get("v.recordId"),'reschedule' : c.get("v.Reschedule"),'isApproveOrRequestDate':c.get("v.isApproveOrRequestDate"),
                                                  'requestDate' : c.get('v.requestDate'),
                                                  'requestEarTime':c.get('v.earTime'),
                                                  'requestLatTime':c.get('v.letTime')}, function (r) {
                                                      console.log(r);
                                                      c.set("v.order", r.retailerOrder);
                                                      c.set("v.approved", r.approved);
                                                      //if(c.get("v.isSample")){
                                                          c.set("v.earTime",  r.retailerOrder.Requested_Delivery_Earliest_Time__c);
                                                          c.set("v.letTime",  r.retailerOrder.Requested_Delivery_Latest_Time__c);
                                                      //}
                                                      
            });
        }
    },
    
    handleTimePickerEvent: function(c, e, h) {
        let selectedTime = e.getParam("selectedTime");
        let fieldName = e.getParam("fieldName");
        console.log('selectedTime = ',selectedTime);
        console.log('fieldName = ',fieldName);
        c.set('v.'+fieldName,selectedTime);
    },
    
    onScriptsLoaded: function(c, e, h) {
        console.log('onScriptsLoaded...');
        window.setTimeout(
            $A.getCallback(function() {
                h.applyDate(c);
            }), 1500
        );
    },
    showDatePicker: function(c, e, h) {
        console.log('11');
        //$("#datepickerId").show(); 
        $("#datepickerId").datepicker("show");
    },
})