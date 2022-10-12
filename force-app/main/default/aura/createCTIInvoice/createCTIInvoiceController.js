({
	doInit : function(c, e, h) {
        h.request(c, 'getSalesOrderDetails', {recordId: c.get("v.recordId")}, function(r){
            if(r.statusSOerror != null || r.statusSOerror != undefined){
                h.error({ message: r.statusSOerror });
                   h.navigateToRecord(c,c.get("v.recordId"),'detail');
            } else {
                c.set('v.salesOrderSO',r.salesOrder);
                c.set('v.producerSOLines', r.producerSOLines);
                console.log('r.producerSOLines>>>>>',r.producerSOLines);
            }	
        });
	},
    cancelBtn : function(c, e, h) {
        h.navigateToRecord(c,c.get("v.recordId"),'detail');
    },
    createInvoice : function(c, e, h) {
                var recTypeVal = c.get('v.isMulti');
console.log('recTypeVal',recTypeVal);
        
        h.request(c, 'createInvoices', {recordId: c.get('v.recordId'),salesOrderLineData: JSON.stringify(c.get('v.producerSOLines')),multi: c.get('v.isMulti') }, function(r){
            
      			
                if(r.statusSOerror){
                    var statusSOerror = r.statusSOerror;    
                    if(statusSOerror == 'Error1'){ 
                        h.error({message:r.ErrMsgSubmitSOForApprovalToCreateCTI});
                     }else if(statusSOerror == 'Error2'){    
                        h.error({message:r.ErrMsgCan_tCreateCTIForCancelledSO});
                    }else if(statusSOerror == 'Error3'){    
                        h.error({message:r.ErrMsgCan_tCreateCTIForRejectedSO}); 
                    }else if(statusSOerror == 'Error4'){    
                        h.error({message:r.ErrMsgCan_tCreateCTIForNonApproved});
                    }else if(statusSOerror == 'Error5'){    
                        h.error({message:r.ErrMsgCTIAlreadyCreated});   
                    }else if(statusSOerror == 'Error6'){    
                        h.error({message:r.ErrMsgBillableCultivationTaxIP});   
                    }else{ 
                        h.error({message: r.Success_Msg_CTI_Created});
                    } 
                    //h.error({message:r.statusSOerror});
                }  else if(r.Error){
                    h.error({ message: r.Error });
                }
                    else{
                        h.navigateToRecord(c,r.recordId,'detail');
                    }
        });
	},
    checkProducts : function(c, e, h) {
        var dataset = e.currentTarget.dataset;
        var isSelected = dataset.info;
        var productId = e.currentTarget.dataset.id;
        var solChild = c.find("checkProduct"); 
        if(solChild.length){
            for(var i=0; i<solChild.length; i++){
                if(solChild[i].get('v.name') === productId){
                    if(isSelected == 'true')
                    	solChild[i].set("v.value",true);
                	else
                        solChild[i].set("v.value",false);
                }
            } 
        }else {
            if(isSelected == 'true')
                solChild[i].set("v.value",true);
            else
                solChild[i].set("v.value",false);
        }
    },
    selectAllCheckboxes : function(c, e, h) {
        var checkvalue = c.find("selectAll").get("v.value");
        
        var salesOrder = c.find("checkContact");
        if(salesOrder.length){
            for(var i=0; i<salesOrder.length; i++){
                salesOrder[i].set("v.value",checkvalue);
            } 
        }else {
            salesOrder.set("v.value",checkvalue);
        }
        
        /*var solChild = c.find("checkProduct"); 
        if(solChild.length){
            for(var i=0; i<solChild.length; i++){
                solChild[i].set("v.value",checkvalue);
            } 
        }else {
            solChild.set("v.value",checkvalue);
        }*/
    }
    
})