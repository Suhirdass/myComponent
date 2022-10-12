({
	onInit : function(c, e, h) {
        console.log(c.get('v.customerInsight'));
		try {
            var insight = c.get('v.customerInsight');
            h.request(c, 'getInsightTypes', {retailerId : c.get('v.retailerId'),linecard : c.get('v.lineCardId')}, function (r) {
                console.log('R = ',r);
                [].concat(r.insightTypes).forEach((b)=>{
                    b.id=b.value;b.name=b.label;
                });
                c.set('v.types',r.insightTypes);
                [].concat(r.contacts).forEach((b)=>{
                    b.id=b.Id;b.name=b.Name;
                });
                c.set('v.contacts',r.contacts);
                if(insight == null){
                    console.log(JSON.stringify(r.insight));
                	c.set('v.customerInsight',r.insight); 
                }
                c.set('v.isDataLoaded',true);
            });
        } catch (err) { console.log('Error:',err);}	
	},
    handleMultiSelectEvent  :  function (c, e, h) {
        var selectedIds = e.getParam("selectedIds");
        var fieldName = e.getParam("fieldName");
        if(selectedIds)
            selectedIds = selectedIds.slice(0, -1);
        console.log('fieldName = ',fieldName);
        console.log('selectedIds = ',selectedIds);
        var customerInsight = c.get('v.customerInsight');
        if(fieldName === 'Type'){
            customerInsight.Insight_Type__c = selectedIds;
            c.set('v.customerInsight',customerInsight);
        }else if(fieldName === 'Contact'){
            customerInsight.Contact__c = selectedIds;
            c.set('v.customerInsight',customerInsight);
        }
        
    },
    onSave:function(c,e,h){
        var record = c.get('v.customerInsight');
        var linecardId = c.get('v.lineCardId');
        var isRetailer = c.get('v.isRetailer');
        
        var allValid = c.find('fieldId').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        
        console.log('allValid ',allValid);
        console.log('linecardId ',JSON.stringify(record));
        if(allValid){
            h.request(c, 'saveInsight', {linecard : linecardId, recordStr : JSON.stringify(record)}, function (r) {
                if(c.get('v.isUpdate'))
                	h.success({message:'Insight updated successfully'});    
                else
                    h.success({message:'Insight created successfully'});    
                
                if(isRetailer){
                    h.redirect('/retailer', true);
                }else{
                    h.redirect('/brand', true);
                }
            });      
        }
    },
    
    onCancel:function(c,e,h){
        c.find("overlay").notifyClose();
    }
})