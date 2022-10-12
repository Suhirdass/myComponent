({
  onInit: function (c, e, h) {
                 console.log(c.get('v.paymentType')) 
    c.set('v.datatableConfig', {
      showRowNumberColumn: true,
      columns: []

    });
  },
  onFileChange: function (c, e, h) {
    var files = e.getSource().get('v.files');
           console.log(c.get('v.paymentType')) 
       h.parseCSV(c, files);
         
   
  },
  onPaymentTypeChange: function (c, e, h) {
    c.set('v.payments', []);
          console.log('ttt',c.get('v.isButtonActive'));
    console.log('sss',c.get('v.selectedPayments'));

  },
  onCreatePayments: function (c, e, h) {
    h.savePayments(c);
      
  },
  setSelectedPayments: function (c, e, h) {
                 console.log(c.get('v.paymentType'));
                 console.log('sss',c.get('v.selectedPayments'));
                       //console.log(c.get({!empty (v.selectedPayments)}));


    c.set('v.selectedPayments', e.getParam('selectedRows'));
  },
    

    onValuesUpdate: function (c, e, h) {
    var draftValues = e.getParam('draftValues');
    var paymentData = draftValues[0];
    var newValue = '';

    var datatableConfig = c.get('v.datatableConfig');
    Object.keys(paymentData).forEach(function (column) {
      switch (datatableConfig.columnByType[column]) {
        case 'date':
          paymentData[column] = h.formatDate(new Date(paymentData[column]));
          break;
      }
      if (column !== 'paymentIndex') {
        newValue = { [column]: paymentData[column] };
      }
    });

    var payments = c.get('v.payments');
    var selectedPayments = c.get('v.selectedPayments');
    draftValues.forEach(function (payment) {
      var paymentIndex = payment.paymentIndex.split('index')[1];
      payments[paymentIndex] = Object.assign(payments[paymentIndex], newValue);

      for (var i = 0, j = selectedPayments.length; i < j; i++) {
        if (selectedPayments[i].paymentIndex === payment.paymentIndex) {
          selectedPayments[i] = Object.assign({}, payments[paymentIndex]);
        }
      }
    });

    c.set('v.payments', payments);
    c.set('v.selectedPayments', selectedPayments);
  },
  onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.setPageDataAsPerPagination(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.setPageDataAsPerPagination(component, helper);
    },
    
    selectedPagination : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.getSource().get('v.name'))); //event.target.name
        helper.setPageDataAsPerPagination(component, helper);
                    component.set('v.isButtonActive',false);

    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.setPageDataAsPerPagination(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPageDataAsPerPagination(component, helper);
    }, 
})