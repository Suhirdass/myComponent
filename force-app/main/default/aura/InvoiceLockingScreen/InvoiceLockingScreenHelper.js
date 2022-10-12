({
    getInvoiceList: function(component, pageNumber, pageSize) {
        var action = component.get("c.getInvoiceData");
        action.setParams({
            "pageNumber": pageNumber,
            "pageSize": pageSize,
            "year":component.get('v.Year'),
            "month":component.get('v.Month')
        });
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = result.getReturnValue();
                component.set("v.InvoiceList", resultData.invoiceList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
            }
        });
        $A.enqueueAction(action);
    }
})