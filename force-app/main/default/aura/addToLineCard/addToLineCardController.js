({
	onInit : function(c, e, h) {
		var retailer = c.get('v.retailer');
        h.request(c, 'addLineCardInit', {retailerId: retailer.id,lineCardId:c.get('v.recordId'),isReailer:c.get('v.isRetailer')}, function (r) {
            console.log('addLineCardInit::',r);
            [].concat(r.brandAccountRating).forEach((b)=>{b.id=b.value;b.name=b.label});
            c.set('v.brandAccountRating',r.brandAccountRating);
            [].concat(r.retailAccountRating).forEach((b)=>{b.id=b.value;b.name=b.label});
            c.set('v.brandAccountRating',r.brandAccountRating);
            var retailAccountRating = r.retailAccountRating;//[{label:'Standard',value:'Standard'},{label:'Strategic',value:'Strategic'},{label:'Preferred',value:'Preferred'},{label:'Problematic',value:'Problematic'}];
            c.set('v.retailAccountRating',retailAccountRating);
            [].concat(r.mutualPaymentTerms).forEach((b)=>{b.id=b.value;b.name=b.label});
            c.set('v.mutualPaymentTerms',r.mutualPaymentTerms);
            
            if(c.get('v.isRetailer') && !c.get('v.recordId')){
                console.log('Default values...');
                r.lineCard.brandAccountRating = 'Standard';
                r.lineCard.mutualPaymentTerms = r.mutualPaymentTerms[0].value;
            }
            var salesReps = [];
            r.salesReps.forEach((item) => {
                salesReps.push({label:item.Name,value:item.Id,name:item.Name,id:item.Id});
            });
            console.log(salesReps);
            c.set('v.lineCard',r.lineCard);
        	c.set('v.salesReps',salesReps);
        c.set('v.isDataLoaded',true);
        });
	},
     handleMultiSelectEvent  :  function (c, e, h) {
        var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
            selectedIds = selectedIds.slice(0, -1);
        console.log('fieldName = ',fieldName);
        console.log('selectedIds = ',selectedIds);
        var lineCard = c.get('v.lineCard');
        if(fieldName === 'Brand Account Rating'){
            lineCard.brandAccountRating = selectedIds;
            c.set('v.lineCard',lineCard);
        }else if(fieldName === 'Retailer Account Rating'){
            lineCard.retailAccountRating = selectedIds;
            c.set('v.lineCard',lineCard);
        }else if(fieldName === 'Mutual Payment Terms'){
            lineCard.mutualPaymentTerms = selectedIds;
            c.set('v.lineCard',lineCard);
        }else if(fieldName === 'Sales Rep'){
            lineCard.salesPersonId = selectedIds;
            c.set('v.lineCard',lineCard);
        }
        
    },
    onSave:function(c,e,h){
        try{
            var isRetailer = c.get('v.isRetailer');
            console.log("isRetailer::",isRetailer);
            var lineCard = c.get('v.lineCard');
            console.log("lineCard:",JSON.stringify(lineCard));
            var isValid = h.isValid(c);
            console.log("isValid::",isValid);
            if(!isValid){
                return false;
            }
            if(!lineCard.minimumOrderValue){
                lineCard.minimumOrderValue =0.0;
            }
            h.request(c, 'addLineCardSave', {lineCardData: JSON.stringify(lineCard)}, function (r) {
                c.find("overlay").notifyClose();
                if(lineCard.id == undefined){
                    h.success({ message: ('Successfully added '+(isRetailer?lineCard.retailerName:lineCard.brandName) +' to Line Card.') });
                }else{
                    h.success({ message: ('Successfully updated '+(isRetailer?lineCard.retailerName:lineCard.brandName) +'.') });
                }
                
                console.log("isRetailer2222::",isRetailer);
                if(isRetailer){
                    h.redirect('/retailer', true);
                }else{
                    h.redirect('/brand', true);
                }
                
            });
        }catch(err){
            console.log("Error:",err);
        }
        
    },
    onCancel:function(c,e,h){
        c.find("overlay").notifyClose();
    }
    
})