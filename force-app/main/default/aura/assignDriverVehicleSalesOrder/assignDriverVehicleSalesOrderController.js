({
    updateColumnSorting: function (cmp, event, helper) {
        var data = helper.sortData(cmp, event, cmp.get("v.rsmList"));
        cmp.set("v.rsmList", data);
    },
    updateColumnSortingtsm: function (cmp, event, helper) {       
        var data = helper.sortData(cmp, event, cmp.get("v.tsmList"));
        cmp.set("v.tsmList", data);
    },     
    doInit : function(c, e, h) {
        c.set('v.dataLoaded',false);
        c.set('v.isDataLoaded',true);
        
        window.setTimeout($A.getCallback(function(){
            h.applyDate(c);
           
        }),1000);     
        
        
        h.request(c, 'init', {recordId: c.get('v.recordId')}, function(r){
            c.set('v.refProductCount',r.refProductCount);
            c.set('v.assignedVehicleId',r.assignedVehicleId);
            c.set('v.assignedDriverId',r.assignedDriverId);
            c.set('v.assignedDate',r.assignedDate);
             c.set('v.requestEarTime', r.earTime);
            c.set('v.requestLatTime', r.latTime);
            c.set('v.EARLIEST_DELIVERY_TIME', r.EARLIEST_DELIVERY_TIME);
            c.set('v.LATEST_DELIVERY_TIME', r.LATEST_DELIVERY_TIME);
             c.set('v.holidayList', r.holidayList);
            if(r.rsmObj.Vehicle__c){
                c.set('v.selectedVehicle',{label:r.rsmObj.Vehicle__r.Name,value:r.rsmObj.Vehicle__c});
            } 
            if(r.rsmObj.Driver__c){
                c.set('v.selectedDriver',{label:r.rsmObj.Driver__r.Name,value:r.rsmObj.Driver__c});
            }
            
            c.set('v.requestDateShow',r.rsmObj.Planned_Ship_Date__c);
            
            h.setValues(c, r);
        });
        h.setTableColumns(c);
    },    
    onCancel : function(c, e, h) {
        h.navigateToRecord(c, c.get('v.recordId'));
    },      
    assignDriverVehicleValues : function(c, e, h) {
 
        if(c.get('v.requestDate') == null){
    h.showErrorMsg('Error', 'error', c.get('v.Err_Msg_Select_Planned_Ship_Date'));     
          }
        
         
        let earTime = c.get('v.requestEarTime');
            let strEarTime;
            let strLetTime;
            if(earTime != '' && earTime != 'None'){
                c.set('v.hasEarliestTimeError',false);
                strEarTime = earTime.split(':');
                console.log('##strEarTime',strEarTime[0],' - ',strEarTime[1]);
                
            }else{
                h.showErrorMsg('Error', 'error', 'Window Start Time field is required.');
              
            }
             
            let letestTime = c.get('v.requestLatTime');
            if(letestTime != '' && letestTime != 'None'){
                c.set('v.hasLatestTimeError',false);
                strLetTime = letestTime.split(':');
          
             
            }else{
                 h.showErrorMsg('Error', 'error', 'Window End Time field is required.');
                
            }
                  
        if((c.get('v.requestEarTime') != ''  && c.get('v.requestEarTime') != 'None') && (c.get('v.requestLatTime') != '' && c.get('v.requestEarTime') != 'None')
           &&  (c.get('v.requestDate') != undefined && c.get('v.requestDate') != null && c.get('v.requestDate') != 'null')){ 
        	h.request(c, 'assignDriverVehicle', {order: c.get('v.rsmObj'),'startTime':c.get('v.requestEarTime'),
                                                 'endTime':c.get('v.requestLatTime'),pDate:c.get('v.requestDate')}, function(r){   
                h.navigateToRecord(c, c.get('v.recordId'));
                h.showErrorMsg('Success', 'success', c.get('v.Success_Msg_Assigned_Driver_Vehicle'));     
        	});
        }
    },    
    retrieveDriverVehicleAndRelatedRSMTSMs: function(c,e,h){ 
        if(c.get('v.dataLoaded')){
            h.request(c, 'retrieveDriverVehicleAndRelated', {order: c.get('v.rsmObj'),assignedVehicleId: c.get('v.assignedVehicleId'),assignedDriverId: c.get('v.assignedDriverId'),assignedDateStr: c.get('v.assignedDate')}, function(r){            
                h.setValues(c, r);
            });        
            h.setTableColumns(c);
        }
    },
    onSalesOrderClick: function (c, e, h) {
        var id = e.currentTarget.dataset.id;
        h.navigateToRecord(c,id,'view')
    },
    handleTimePickerEvent: function(c, e, h) {
        let selectedTime = e.getParam("selectedTime");
        let fieldName = e.getParam("fieldName");
        console.log('selectedTime = ',selectedTime);
        console.log('fieldName = ',fieldName);
        c.set('v.'+fieldName,selectedTime);
    }, showDatePicker: function(c, e, h) {
              $("#datepickerId").datepicker("show");
    },onScriptsLoaded : function(c, e, h) {
        
        c.set('v.isScriptsLoaded',true);

    }, onClickNo  :  function (c, e, h) {
        window.setTimeout($A.getCallback(function(){
            if(c.get('v.requestDateShow') != null && c.get('v.requestDateShow') != '' && c.get('v.requestDateShow') != undefined){
                
                var reqDateShow = c.get('v.requestDateShow');
                var datearrayShow = reqDateShow.split("/");
                reqDateShow = datearrayShow[2] + '-' + datearrayShow[0] + '-' + datearrayShow[1];
                c.set("v.requestDate", reqDateShow);
            } else {
                c.set('v.hasDateError',true);
                return;    
            }
        }),1000);   
      
    },onChange:function (c, e, h) {
        
        var reqDateShow = c.get('v.requestDateShow'); 
        var datearrayShow = reqDateShow.split("/");
        reqDateShow = datearrayShow[2] + '-' + datearrayShow[0] + '-' + datearrayShow[1];
         c.set("v.requestDate", reqDateShow);
	}
})