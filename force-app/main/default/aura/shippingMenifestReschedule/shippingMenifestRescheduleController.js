({
    doInit : function(c, e, h) {
        
        h.request(c, 'getRecordName', {recordId: c.get('v.recordId')}, function(r){
            c.set("v.Err_Msg_For_Past_Date",r.Err_Msg_For_Past_Date);
            c.set('v.recordName',r.recordName);
            c.set('v.status', r.status);
            /*r.ReasonCode.forEach((fa) => {
                fa.id = fa.value;
                fa.name = fa.label;
            });*/
            
            c.set('v.Missed_Delivery_Window_Reason_Code', r.Missed_Delivery_Window_Reason_Code);
            c.set('v.Requires_METRC_Adjustments_Reason_Code', r.Requires_METRC_Adjustments_Reason_Code);
            c.set('v.Route_Compromised_Reason_Code', r.Route_Compromised_Reason_Code);
            c.set('v.Clerical_Error_Reason_Code', r.Clerical_Error_Reason_Code);
            c.set('v.Incorrectly_Entered_Order_config', r.Incorrectly_Entered_Order_config);
            c.set('v.Incorrectly_Packed_Order_config', r.Incorrectly_Packed_Order_config);
            
                c.set('v.ReasonCodes', r.ReasonCode);
                c.set('v.holidayList', r.holidayList);
                c.set('v.cutOffTime',r.cutOffTime);
                console.log('#r.cutOffTime :',r.cutOffTime)
                c.set('v.isDataLoaded',true);
                if(c.get('v.status') == 'Shipment Complete' || c.get('v.status') == 'Rejected' || c.get('v.status') == 'Cancelled'||c.get('v.status') == 'Shipment Pending' ){
                h.error({ message: ('Reschedule is not allowed on SM Status is Shipment Complete,Pending, Rejected or Cancelled.') }); 
            $A.get("e.force:closeQuickAction").fire();	
        } else {
                  if(c.get('v.status') == 'In-Transit'){
            c.set('v.isDisplayPopup', true);
        } else {
            h.error({ message: ('Reschedule is allowed only if SM status is "In-Transit"') }); 
            $A.get("e.force:closeQuickAction").fire();
        }
    }
}); 
},
    
    /*reschedule : function(c, e, h) {
        h.smReschedule(c, e);
    },*/
    
    rescheduleSmLinesByFiligreen : function(c, e, h) {
        let ReasonCode = c.get('v.ReasonCodes');
        var items = [];
         ReasonCode.forEach((fa) => {
            if(fa == c.get('v.Missed_Delivery_Window_Reason_Code') || fa == c.get('v.Requires_METRC_Adjustments_Reason_Code') || fa == c.get('v.Route_Compromised_Reason_Code') || fa == c.get('v.Clerical_Error_Reason_Code') || fa == c.get('v.Incorrectly_Packed_Order_config')){
            //fa.id = fa.value;
            //fa.name = fa.label;
            items.push(fa);
        }
       });
        c.set('v.ReasonCodes', items);
        c.set('v.SM_Type','filigreen');
        c.set('v.isDisplayPopup', false);
          c.set('v.isDisplayPopupOfRBC',true);
        //c.set('v.isDisabledRBW',true);
        //h.rescheduleSmLines(c, e, h,'filigreen');
    },
    rescheduleSmLinesByCustomer : function(c, e, h) {
        let ReasonCode = c.get('v.ReasonCodes');
        var items = [];
         ReasonCode.forEach((fa) => {
            if(fa != c.get('v.Missed_Delivery_Window_Reason_Code') && fa != c.get('v.Route_Compromised_Reason_Code') && fa != c.get('v.Clerical_Error_Reason_Code') && fa != c.get('v.Incorrectly_Packed_Order_config')){
            //fa.id = fa.value;
            //fa.name = fa.label;
            items.push(fa);
        }
       });
        c.set('v.ReasonCodes', items);
        c.set('v.SM_Type','customer');
        c.set('v.isDisplayPopup', false);
          c.set('v.isDisplayPopupOfRBC',true);
        //c.set('v.isDisabledRBC',true);
        //h.rescheduleSmLines(c, e, h,'customer');
    },
    onClickOK : function(c, e, h) {
        console.log('ReasonCodeName : ',c.get('v.ReasonCodeName'));
        if(c.get('v.ReasonCodeName') == ''){
            return false;
        }
        //c.set('v.isDisabledRBC',true);
        c.set('v.isDisplayPopupOfRBC',false);
        c.set('v.isDisplayPopupOfYN',true);
        
        
    },
    onClickYes  :  function (c, e, h) {
        
     	c.set('v.isDisplayPopupOfShipDate',true);
        window.setTimeout($A.getCallback(function(){
                    h.applyDate(c);
                }),100);
        
    },
    onClickNo  :  function (c, e, h) {
     	console.log('ReasonCodeName : ',c.get('v.Planned_Ship_Transfer_Date'));
        console.log('Notes : ',c.get('v.Notes'));
        if(c.get('v.ReasonCodeName') == ''){
            return false;
        }
        if(c.get('v.isDisplayPopupOfShipDate') && c.get('v.Planned_Ship_Transfer_Date') == null){
          
            if(c.get('v.requestDate') != null && c.get('v.requestDate') != '' && c.get('v.requestDate') != undefined){
                var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
                if(c.get('v.requestDate') > today){
                    c.set('v.hasDateError',false);
                }else{
                    h.error({ message: (c.get('v.Err_Msg_For_Past_Date')) });
                    c.set('v.hasDateError',true);
                    return; 
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
                    return;    
                }
            }
        }
        
        if(c.get('v.isDisplayPopupOfShipDate') ){
            let earTime = c.get('v.requestEarTime');
            let strEarTime;
            let strLetTime;
            if(earTime != ''){
                c.set('v.hasEarliestTimeError',false);
                strEarTime = earTime.split(':');
                console.log('##strEarTime',strEarTime[0],' - ',strEarTime[1]);
                
            }else{
                c.set('v.hasEarliestTimeError',true);
                return;
            }
            
            let letestTime = c.get('v.requestLatTime');
            if(letestTime != ''){
                c.set('v.hasLatestTimeError',false);
                strLetTime = letestTime.split(':');
                if(strLetTime.length == 0){
                    c.set('v.hasLatestTimeError',true);
                    return;    
                }
                if(strLetTime[1].indexOf('PM') > -1 && parseInt(strLetTime[0]) != 12){
                    strLetTime[0] += 12;
                }
                if(strEarTime[1].indexOf('PM') > -1 && parseInt(strEarTime[0]) != 12){
                    strEarTime[0] += 12;
                }
                
                if(parseInt(strLetTime[0]) < parseInt(strEarTime[0])){
                    c.set('v.latesDateAfterEarliestDateError',true);
                    
                    return;   
                }else{
                    c.set('v.latesDateAfterEarliestDateError',false);  
                }
            }else{
                c.set('v.hasLatestTimeError',true);
                return; 
            }
        }
        h.rescheduleSmLines(c, e, h,c.get('v.SM_Type'));
    },
    cancel : function(c, e, h) {
        $A.get("e.force:closeQuickAction").fire();
    },
    onScriptsLoaded: function(c, e, h) {
        console.log('onScriptsLoaded...');
               // h.applyDate(c);
    },
    showDatePicker: function(c, e, h) {
        //$("#datepickerId").show(); 
       $("#datepickerId").datepicker("show");
    },
    handleTimePickerEvent: function(c, e, h) {
        let selectedTime = e.getParam("selectedTime");
        let fieldName = e.getParam("fieldName");
        console.log('selectedTime = ',selectedTime);
        console.log('fieldName = ',fieldName);
        c.set('v.'+fieldName,selectedTime);
    },
})