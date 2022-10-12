({
	doInit : function(c, e, h) {
        console.log('doInit:',c.get('v.recordId'));
        console.log('doInit:',c.get('v.changeFee'));
        console.log('isAllocatedLineItemsToolTip',c.get('v.isAllocatedLineItemsToolTip'))
        let SOLines = c.get('v.SO').Sales_Order_Lines__r ||[];
        let tempSOLIs = [];
        SOLines.forEach((item)=>{ 
            const SOLI = Object.assign({},item,{newQty:item.Qty_Ordered__c,newPrice:item.Retail_Wholesale_Price__c,isZeroQty:false,isSample:item.Is_Sample__c,isSampleDisabled:item.Is_Sample__c});
        	tempSOLIs.push(SOLI);
        });
        c.set('v.SOLines',tempSOLIs);
	},
    onCancel: function(c, e, h) {
        h.navigateToRecord(c,c.get('v.SO').Id,'view');
    },
    onView: function(c, e, h) {
        const id = e.currentTarget.dataset.id;
        h.navigateToRecord(c,id,'view');
    },
    onSubmit: function(c, e, h) {
        let allValid = h.isValid(c);
            
        if(allValid){
            var revisiReason = c.get('v.revisionReason');
            let CountZeroQtySOLIs = c.get('v.CountZeroQtySOLIs');
            if(CountZeroQtySOLIs > 0){
                c.set('v.showCancelSOLI',true);
            }else{
                let totalChangeLines = c.get('v.totalChangeLines');
                if(totalChangeLines == 0){
                    h.error({message:c.get('v.SO_NO_LINES_MODIFIED_FOR_REVISION')});
                    return;
                }
                const SOLines = c.get('v.SOLines');
                let SOLinesToUpdate = [];
                let SOLIVersionMap = c.get('v.SOLIVersionMap');
                var chkCancelAllStatusOfSOLI = true;
                console.log('SOLIVersionMap:',SOLIVersionMap);
                SOLines.forEach((item)=>{
                    if(item.newQty != item.Qty_Ordered__c || item.newPrice != item.Retail_Wholesale_Price__c || item.isZeroQty == true){
                    const totalRevision =  (SOLIVersionMap[item.Id]?(SOLIVersionMap[item.Id]):1);
                    
                    SOLinesToUpdate.push({Id:item.Id,Name:item.Name,Status__c:item.Status__c,Qty_Ordered__c:item.newQty,Retail_Wholesale_Price__c:item.newPrice,Is_Sample__c:item.isSample, Total_SOLI_Revision__c:totalRevision,Total_SOLI_Change_fee__c:(c.get('v.changeFee')*totalRevision)});
            		}
            		if(item.Status__c != 'Cancelled')
                        chkCancelAllStatusOfSOLI = false;
        		});
        
                console.log('revisionReason:',c.get('v.revisionReason'));
        h.request(c, 'createOrderRevisions', {SOLineJSON:JSON.stringify(SOLinesToUpdate), SOId: c.get('v.recordId') ,'revisionReason':c.get('v.revisionReason'),'chkCancelAllStatusOfSOLI':chkCancelAllStatusOfSOLI}, function (r) {
                    if(r.error){
                        h.error({message:r.error});
                    }else if(r.success){
                        h.success({message:r.success});
                        h.navigateToRecord(c,c.get('v.SO').Id,'view');
                    }
                });
            }
        }
    },
    onBlur: function(c, e, h) {
        try{
            let changeCount = 0;
            let CountZeroQtySOLIs = 0;
            const SOLines = c.get('v.SOLines');
            
            SOLines.forEach((item)=>{
                if(item.newQty != item.Qty_Ordered__c || item.newPrice != item.Retail_Wholesale_Price__c || item.isSample != item.Is_Sample__c){
                    if(parseFloat(item.newPrice) != item.Retail_Wholesale_Price__c && parseFloat(item.newPrice) === 0.01){
                        item.newPrice = item.Retail_Wholesale_Price__c;
                        h.error({message:c.get('v.SO_ORDER_REVISION_PRICE_MESSAGE')});
                    }else{
                        changeCount++;
                    }
                      if(item.newQty == 0){
                        CountZeroQtySOLIs += 1;
                    } 
                }
        });
c.set('v.CountZeroQtySOLIs',CountZeroQtySOLIs);
c.set('v.SOLines',SOLines);
        c.set('v.totalChangeLines',changeCount);
}catch(error){
    console.log('Error:',error);
}
    },
        onCancelSOLIYes: function(c, e, h) {
            const SOLines = c.get('v.SOLines');
            SOLines.forEach((item)=>{
                if(item.newQty == 0){
                	item.newQty = item.Qty_Ordered__c;
                	item.Status__c = 'Cancelled';
                	item.isZeroQty = true;
                	item.isSample = item.Is_Sample__c;
            	}
            });
            c.set('v.CountZeroQtySOLIs',0);
            c.set('v.SOLines',SOLines);
            c.set('v.showCancelSOLI',false);
            var action = c.get('c.onSubmit');
        		$A.enqueueAction(action);
        },
            onCancelSOLINo: function(c, e, h) {
                const SOLines = c.get('v.SOLines');
            SOLines.forEach((item)=>{
                if(item.newQty == 0){
                	item.newQty = item.Qty_Ordered__c;
            	}
            });
                c.set('v.CountZeroQtySOLIs',0);
            c.set('v.SOLines',SOLines);
            c.set('v.showCancelSOLI',false);
                //var action = c.get('c.onSubmit');
        		//$A.enqueueAction(action);
            }
})