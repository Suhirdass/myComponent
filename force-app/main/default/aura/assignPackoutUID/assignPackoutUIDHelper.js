({
	showPopup : function(component) {
      
        var h = this;
        var isDataLoaded = component.get("v.isDataLoaded");
        if(isDataLoaded){
            window.setTimeout($A.getCallback(function(){
            Swal.fire({
              title: component.get('v.recordName'),
              text: 'Assign Packout UID. Are you sure ?',
              type: '',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#6b6161',
              confirmButtonText: 'Yes',
                cancelButtonText: 'No',
                focusCancel:true
            }).then((result) => {
              	if (result.value) {
                	h.assignPackoutUID(component);
            	}else{
                    $A.get("e.force:closeQuickAction").fire();
                    }
            });
                              }),10);
        }else{
            window.setTimeout($A.getCallback(function(){
                h.showPopup(component);
            }),100);
        }
	},
    assignPackoutUID : function(c,e,h) {
        var pickListLine = c.get('v.pickListLine');
        for(let i = 0; i< pickListLine.length; i++){
            delete pickListLine[i].hasPackOut;
            delete pickListLine[i].selectedPackOut;
            delete pickListLine[i].availableQA;
        }
        
        var uidError = c.get('v.UIDuseError');
     
        if(uidError==false){
           
            var JSONStr = JSON.stringify(pickListLine);
           
            h.request(c, 'assignPackout', { jsonLineItem: JSONStr }, function (r) {
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": c.get("v.recordId")
                });
                navEvt.fire();
                $A.get("e.force:closeQuickAction").fire();
            });
        }
    },
    
    handleValues : function(component,selectedRecord,h){
        var selectedPickLineId = component.get('v.selectedPickLineId');
        if(selectedPickLineId != undefined){
            var pickListLine = component.get('v.pickListLine');
            pickListLine.find(function(element) {
                if(element.Id == selectedPickLineId){
                    if(selectedRecord.value == undefined){
                    	element.Pack_out_UID__c = '';    
                    } else {
                    	element.Pack_out_UID__c = selectedRecord.value;
                    }
                }      
            }); 
          
          
            
            
            
            
            var selectedUID = selectedRecord.value;

              var innerError =''; 
            if(selectedUID){
                
                   h.request(component, 'checkRecordInUse', {recordId: selectedUID}, function(r){
                    component.set('v.messages', r.messageactive);
                
                    if(r.messageactive == true)
                    {
                        innerError = 'UID is already in use';
                        component.set('v.UIDuseError',true);  
                        document.getElementById('uiderror'+selectedPickLineId).innerText =innerError; 
                    }else{
                        innerError='';
                        document.getElementById('uiderror'+selectedPickLineId).innerText =innerError; 
                        component.set('v.UIDuseError',false);  
                    }
                    
                });
            }else{
                
                innerError='';
                document.getElementById('uiderror'+selectedPickLineId).innerText =innerError; 
                component.set('v.UIDuseError',false);  
            }
            
            
            component.set("v.errorPicSelId",selectedPickLineId);
            component.set("v.pickListLine",pickListLine);
            component.set("v.selectedPickLineId",undefined);
            
            document.getElementById('uid'+selectedPickLineId).innerText =selectedRecord.value; 
            
            var pName='';
            var price='';
            var batchid='';
            var uid='';
            
            
            pName = document.getElementById(selectedPickLineId).innerText;
            price = document.getElementById('price'+selectedPickLineId).innerText;
            batchid = document.getElementById('batchid'+selectedPickLineId).innerText;
            
            uid = document.getElementById('uid'+selectedPickLineId).innerText;
            var pickListLine = component.get('v.pickListLine');
       
            var k =0;
            var arr = [];
            var arrOfUid = [];
            
            var firstRes =[];
            var SecondRes =[];
            var thirdRes =[];
            var fourthRes =[];
            var fifththRes =[];
            var sixthRes =[];
            var errorId =[];
            /* New Script */
            for(let i = 0; i< pickListLine.length; i++){
           
            
                if(pName==  pickListLine[i].Product_Name__r.Name && price == pickListLine[i].Unit_Price__c && uid== pickListLine[i].Pack_out_UID__c && batchid == pickListLine[i].Harvest_Batch_or_Lot_Code__c )
                {   
                    firstRes.push(pickListLine[i]);
                }
                
                if (pName==  pickListLine[i].Product_Name__r.Name &&  price != pickListLine[i].Unit_Price__c && uid == pickListLine[i].Pack_out_UID__c) {
                    SecondRes.push(pickListLine[i]);
                }
                
                
                if (pName!=  pickListLine[i].Product_Name__r.Name && uid == pickListLine[i].Pack_out_UID__c) {
  
                    thirdRes.push(pickListLine[i]);
                }
                
                
                  
                if ((pName== pickListLine[i].Product_Name__r.Name && price == pickListLine[i].Unit_Price__c  && batchid == pickListLine[i].Harvest_Batch_or_Lot_Code__c) &&  (uid != pickListLine[i].Pack_out_UID__c && pickListLine[i].Pack_out_UID__c!=undefined && pickListLine[i].Pack_out_UID__c!='') ) {
                   
                  
                    fifththRes.push(pickListLine[i]);
                   
                       }
                
                
                if (pName== pickListLine[i].Product_Name__r.Name && uid == pickListLine[i].Pack_out_UID__c   && price != pickListLine[i].Unit_Price__c  && batchid == pickListLine[i].Harvest_Batch_or_Lot_Code__c) {
                    fourthRes.push(pickListLine[i]);
                   
                       }        
                
                 if((pName==  pickListLine[i].Product_Name__r.Name && price == pickListLine[i].Unit_Price__c && uid== pickListLine[i].Pack_out_UID__c)  && batchid != pickListLine[i].Harvest_Batch_or_Lot_Code__c )
                {   
                 
                    sixthRes.push(pickListLine[i]);
                }
               
            }
            
            
            var firstresult =  firstRes.length;
            var seondresult = SecondRes.length;
            var thirdresult  = thirdRes.length;
            var fourthresult  = fourthRes.length;
            var fifthresult = fifththRes.length;
            var sixthresult = sixthRes.length;
            
               var packoutUIDErrorVal = component.get("v.packoutUIDError");
            if( firstresult ==1 && seondresult ==0 && thirdresult==0 && fourthresult==0 && fifthresult ==0 && sixthresult >=1 )
            {
               
                component.set('v.packoutUIDError',true);
                errorId.push(component.get('v.errorPicSelId'));
                component.set('v.errorPicId',component.get('v.errorPicSelId'));
            } 
            
            if( firstresult ==0 && seondresult ==0 && thirdresult==0 && fourthresult==0 && fifthresult ==0 && sixthresult==0 && packoutUIDErrorVal==true)
            {
                
                
                if(component.get("v.errorPicId") == component.get("v.errorPicSelId")  && component.get("v.errorpicMul") =='')
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'')
                } 
                
                if(component.get("v.errorPicId") == component.get("v.errorpicMul")  && component.get("v.errorPicSelId") =='')
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'')
                }
                if(component.get("v.errorPicId") == '' && component.get("v.errorpicMul")== component.get("v.errorPicSelId") )
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'')
                }
                
                if(component.get("v.errorPicId") != component.get("v.errorPicSelId")  && component.get("v.errorpicMul")==undefined )
                {
                    component.set('v.packoutUIDError',true);  
                    
                }
                if(component.get("v.errorPicId") == component.get("v.errorPicSelId")  && component.get("v.errorpicMul")==undefined )
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'');
                    component.set("v.errorPicSelId",'');
                }
                
                if(component.get("v.errorPicId") == undefined && component.get("v.errorPicSelId") == component.get("v.errorpicMul") )
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'');
                    component.set("v.errorPicSelId",'');
                }
                
                if(component.get("v.errorPicId") == component.get("v.errorpicMul") && component.get("v.errorPicSelId") != '')
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'');
                    component.set("v.errorPicSelId",'');
                    component.set("v.errorpicMul",'');
                }
                
            } 
            
            if( firstresult ==0 && seondresult ==0 && thirdresult==0 && fourthresult==0 && fifthresult > 0 && sixthresult==0 && packoutUIDErrorVal==true)
            {
                
                
                if(component.get("v.errorPicId") == component.get("v.errorPicSelId")  && component.get("v.errorpicMul") =='')
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'')
                } 
                
                if(component.get("v.errorPicId") == component.get("v.errorpicMul")  && component.get("v.errorPicSelId") =='')
                {
                    component.set('v.packoutUIDError',false);  
                    component.set("v.errorPicId",'')
                }
                
                if(component.get("v.errorPicId") == component.get("v.errorPicSelId") && component.get("v.errorpicMul") !='')
                {
                    component.set('v.packoutUIDError',true);  
                    component.set("v.errorPicId",'');
                    component.set("v.errorPicSelId",component.get("v.errorpicMul"));
                }
                
                
                if(component.get("v.errorPicId") != component.get("v.errorPicSelId") &&  component.get("v.errorpicMul") ==undefined &&  packoutUIDErrorVal==true) {
                    component.set('v.packoutUIDError',true);  
                    component.set("v.errorPicId",'')
                }
                
            } 
            
            
            if( firstresult ==1 && seondresult >=2 && thirdresult ==0 && fourthresult >=2 && fifthresult ==0 && sixthresult==0 )
            {
                
                component.set('v.packoutUIDError',true);
                component.set('v.errorPicId',component.get('v.errorPicSelId'));
                
            } 
            
            if( firstresult ==1 && seondresult ==0 && thirdresult > 0 && fourthresult==0 && fifthresult ==0 && sixthresult==0 )
            {
                
                errorId.push(component.get('v.errorPicSelId'));
                component.set('v.packoutUIDError',true);
                component.set('v.errorpicMul',component.get('v.errorPicSelId'));
                
            } 
              
            if( firstresult ==1 && seondresult== 1 && thirdresult==0 && fourthresult > 0 && fifthresult == 0 && sixthresult ==0 )
            {
         
                component.set('v.packoutUIDError',true);  errorId.push(component.get('v.errorPicSelId'));
                component.set('v.errorPicId',component.get('v.errorPicSelId'));
            } 
            
            
            
            if( firstresult ==1 && seondresult== 0 && thirdresult==0 && fourthresult == 0 && fifthresult > 0 && sixthresult ==0 )
            {
    
                component.set('v.packoutUIDError',true);  errorId.push(component.get('v.errorPicSelId'));
                component.set('v.errorPicId',component.get('v.errorPicSelId'));
            } 
            
            
              if( firstresult ==1 && seondresult ==0 && thirdresult==0 && fourthresult > 0 && fifthresult ==0 && sixthresult ==0 )
            {
              
                component.set('v.packoutUIDError',true);  errorId.push(component.get('v.errorPicSelId'));
                component.set('v.errorPicId',component.get('v.errorPicSelId'));
            } 
                if( firstresult ==1 && seondresult ==0 && thirdresult==0 && fourthresult==0 && fifthresult== 0 && sixthresult==0 && packoutUIDErrorVal==true)
            {
                component.set('v.packoutUIDError',true);
            }
            
                   if( firstresult ==0 && seondresult ==0 && thirdresult==0 && fourthresult == 0 && fifthresult ==1 && sixthresult ==0 && ( packoutUIDErrorVal!=true || component.get('v.errorPicSelId')!='') )
            {
             
                component.set('v.packoutUIDError',false);  
                
            } 
            
            if( firstresult ==1 && seondresult ==1 && thirdresult==0 && fourthresult == 1&& fifthresult ==1 && sixthresult ==0 )
            {
                component.set('v.packoutUIDError',true);  
            } 
            
            
            var isEmpty =0;
            window.setTimeout(
                $A.getCallback(function() {
                    for(let i = 0; i< pickListLine.length; i++){
                        if(document.getElementById('uiderror'+pickListLine[i].Id).innerHTML =='UID is already in use')
                        {
                            isEmpty++;
                        }
                    }
                    if(isEmpty > 0)
                    {
                        component.set('v.UIDuseError',true);  
                    }else{
                        component.set('v.UIDuseError',false);
                    }
                    
                    
                    
                }), 1500
            );
            
            
            
        } else {
            window.setTimeout($A.getCallback(function(){
                h.handleValues(component,selectedRecord,h);
             
            }),100);
        }   
    },

})