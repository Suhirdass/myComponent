({
    
    
    formatDate: function (fullDate) {
        return ('0' + (fullDate.getMonth() + 1)).slice(-2) + '/' + ('0' + (fullDate.getDate())).slice(-2) + '/' + fullDate.getFullYear();
    },
    parseCSV: function (c, files) {
        var h = this;
        
        var file = files[0];
        if (file.name.split('.').pop().toLowerCase() !== 'csv') {
            h.warning({ message: 'Please import only .csv files.' });
            return;
        }
        c.set('v.isProcessing', true);
        
        Papa.parse(file, {
            header: false,
            skipEmptyLines: 'greedy',
            dynamicTyping: true,
            complete: function (results, file) {
                var records = results.data;
                
                var datatableConfig = c.get('v.datatableConfig');
                var paymentType = c.get('v.paymentType');
                var payments = [];
                
                var headers = records.shift();
                var isSupplierBills = false;
                datatableConfig.columnByType = {
                    PONumber: 'text',
                    ChartofAccount: 'text',
                    paymentReceiveDate: 'date',
                    ReconciliationDate: 'date',
                    paymentReceiveDatePost:'date',
                    PaymentForm: 'text',
                    Amount: 'number',
                    RecordType: 'text',
                    InvoiceNumber: 'text',
                    PaymentMemo: 'text',
                    Reference: 'text',
                    ReconciliationNotes: 'text',
                    CreditToAccount: 'text',
                    DebitToAccount: 'text',
                    Billpaysupplier:'text',
                };
                if (paymentType === 'purchaseOrders' && headers.indexOf('Purchase Order') > -1) {
                    //PO
                    datatableConfig.columns = [
                        { label: 'Purchase Order', fieldName: 'PONumber', type: 'text', editable: false },
                        { label: 'Supplier Bills', fieldName: 'Billpaysupplier', type: 'text',editable: false },
                        { label: 'Payment Amount', fieldName: 'Amount', type: 'number', editable: true },
                        { label: 'Payment Form', fieldName: 'PaymentForm', editable: true },
                        { label: 'Payment Date', fieldName: 'ReconciliationDate', type: 'date', editable: true },
                        { label: 'Post Date', fieldName: 'paymentReceiveDate', type: 'date', editable: true },
                        { label: 'Reconciliation Notes', fieldName: 'ReconciliationNotes', type: 'Text', editable: true },                           
                        { label: 'Payment Memo ', fieldName: 'PaymentMemo', type: 'Text', editable: true },
                        { label: 'Chart of Account  ', fieldName: 'ChartofAccount', editable: false },
                        { label: 'Debit From Account', fieldName: 'DebitToAccount', editable: true }
                        
                        
                    ];
                    isSupplierBills = true;
                    
                } else if (paymentType === 'invoices' && headers.indexOf('Invoice: Invoice') > -1) {
                    
                    
                    datatableConfig.columns = [{ label: 'Record Type', fieldName: 'RecordType', editable: true },
                                               { label: 'Invoice: Invoice', fieldName: 'InvoiceNumber', editable: false },
                                               { label: 'Payment Amount', fieldName: 'Amount', type: 'number', editable: true },
                                               { label: 'Payment Form', fieldName: 'PaymentForm', editable: true },
                                               { label: 'Payment Received Date', fieldName: 'ReconciliationDate', type: 'date', editable: true },
                                               { label: 'Reference', fieldName: 'Reference', editable: true },
                                               { label: 'Reference	Payment Memo', fieldName: 'PaymentMemo', editable: true },
                                               { label: 'Reconciliation Date', fieldName: 'paymentReceiveDatePost', type: 'date', editable: true },
                                               { label: 'Reconciliation Notes', fieldName: 'ReconciliationNotes', type: 'Text', editable: true },                           
                                               { label: 'Credit to Account', fieldName: 'CreditToAccount', editable: true }];
                } else {
                    h.warning({ message: 'Please cross check the file records and selected payment type, and try again.' });
                    c.set('v.payments', payments);
                    c.set('v.isProcessing', false);
                    return true;
                }
                
                var selectPayments = [];
                records.forEach(function (record, paymentIndex) {
                    selectPayments.push('index' + paymentIndex);
                    var payment = { paymentIndex: ('index' + paymentIndex) };
                    datatableConfig.columns.forEach(function (column, index) {
                        var value = record[index];
                        
                        if (column.type === 'number') {
                            value = (value + '').replace(/US|USD|\$|\,/g, '-');
                        }
                        
                        if(value != null)
                        {
                            payment[column.fieldName] =(value + '').trim();
                        }
                        
                    });
                    
                    payments.push(payment);
                });
                c.set("v.alldatas", payments); 
                
                c.set("v.totalPages", Math.ceil(payments.length/c.get("v.pageSize")));
                c.set("v.allData", payments);
                c.set("v.currentPageNumber",1);
                h.setPageDataAsPerPagination(c, h);
                c.set('v.datatableConfig', datatableConfig);
                //  c.set('v.selectedPayments', payments);
                c.set('v.isProcessing', false);
                c.set('v.isSupplierBills', isSupplierBills);
                c.set('v.selectPayments', selectPayments);
                
            }
        });
    },
    setPageDataAsPerPagination : function(component, helper) {
        var data = [];
        var pageNumber = component.get("v.currentPageNumber");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        var x = (pageNumber-1)*pageSize;
        //creating data-table data
        for(; x<=(pageNumber)*pageSize; x++){
            if(allData[x]){
                data.push(allData[x]);
            }
        }
        component.set("v.payments", data);
        component.set('v.isButtonActive',false);
        
        
        helper.generatePageList(component, pageNumber);
    },   
    generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];
        var totalPages = component.get("v.totalPages");
        if(totalPages > 1){
            if(totalPages <= 10){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                } 
            } else{
                if(pageNumber < 5){
                    pageList.push(2, 3, 4, 5, 6);
                } else{
                    if(pageNumber>(totalPages-5)){
                        pageList.push(totalPages-5, totalPages-4, totalPages-3, totalPages-2, totalPages-1);
                    } else{
                        pageList.push(pageNumber-2, pageNumber-1, pageNumber, pageNumber+1, pageNumber+2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    },
    
    savePayments: function (c) {
        var h = this;
        var selectedPayments = c.get('v.selectedPayments');
        var isSupplierBills = c.get('v.isSupplierBills');
        var invalidRows = [];
        var selectedPaymentIdsList = [];
        var removePaymentsIDS = [];
        var  paymentAmount =[];
        if (isSupplierBills) {
            selectedPayments.forEach(function (payment, rowIndex) {
                if ( !payment.PONumber || !payment.Billpaysupplier || !payment.Amount || !payment.paymentReceiveDate  || !payment.paymentReceiveDate  || !payment.PaymentForm   ) {
                    
                    invalidRows.push(rowIndex + 1);
                    
                }
                
                
            });
            
        } else {
            selectedPayments.forEach(function (payment, rowIndex) {
                if (!payment.RecordType || !payment.InvoiceNumber || !payment.Amount ||  !payment.PaymentForm || !payment.ReconciliationDate || !payment.CreditToAccount) {
                    invalidRows.push(rowIndex + 1);
                }
                
                
                
            });
        }
        if (invalidRows.length > 0) {
            h.warning({ message: ' Please update data properly and upload the file again ' + invalidRows.join() });
            return true;
        }
        
        
        
        
        h.request(c, 'savePayments', { paymentsData: JSON.stringify(selectedPayments), isSupplierBills: isSupplierBills }, function (r) {
            
            
            
            
            if (r.successBillSuppliers && r.successBillSuppliers.length > 0  ) {
                
                var a=[];
                a = c.get('v.alldatasremainingPayments1').filter(function (item){
                    return item.PONumber;
                });
                
                if(c.get('v.paymentType') == 'invoices' &&  a.length >0  )
                {
                    c.set("v.alldatasremainingPayments1",  []);   
                    
                }
                var a2=[];
                a2 = c.get('v.alldatasremainingPayments1').filter(function (item){
                    return item.InvoiceNumber;
                });
                
                if(c.get('v.paymentType') == 'purchaseOrders' &&  a2.length >0  )
                {
                    c.set("v.alldatasremainingPayments1",  []);   
                    
                }
                
                
                var finaldatacheckcondition  = c.get('v.alldatasremainingPayments1');
                
                if(finaldatacheckcondition .length == 0)
                {
                    var  payments = c.get('v.alldatas');   
                }
                else
                {
                    var payments = finaldatacheckcondition;  
                }
                var remainingPayments = [];
                var finalresult = [];
                var remainingPayments2 =[];
                payments.forEach(function (payment, paymentIndex) {
                    
                    
                    if((!r.successBillSuppliers.includes(payment.Billpaysupplier) )&& (!r.successBillSuppliers.includes(payment.InvoiceNumber) ) )
                    {  
                        remainingPayments.push(payment);
                        
                    }
                    
                    
                });
                var remainingPayments1 = remainingPayments.map((item, index) => { 
                    var container = {};
                                                               
                                                               container.paymentIndex = 'index'+ index;
                                                               container.PONumber = item.PONumber;
                                                               container.Billpaysupplier = item.Billpaysupplier;
                                                               container.Amount = item.Amount;
                                                               container.ChartofAccount= item.ChartofAccount;
                                                               container.DebitToAccount= item.DebitToAccount;
                                                               container.PaymentForm= item.PaymentForm;
                                                               container.PaymentMemo= item.PaymentMemo;
                                                               container.ReconciliationDate= item.ReconciliationDate;
                                                               container.ReconciliationNotes= item.ReconciliationNotes;
                                                               container.paymentReceiveDate= item.paymentReceiveDate;
                                                               container.RecordType= item.RecordType;
                                                               container.InvoiceNumber= item.InvoiceNumber;
                                                               container.paymentReceiveDatePost= item.paymentReceiveDatePost;
                                                               container.CreditToAccount= item.CreditToAccount;
                                                               return container;
                                                               
                                                               })    
                
                c.set('v.payments', []);  
                c.set('v.selectedPayments', []);
                c.set('v.selectPayments', []);
                c.set('v.payments', remainingPayments1);  
                if( r.message > 0 )
                {
                    c.set('v.sucessmessage', r.message ); 
                    var succesmessage = c.get('v.sucessmessage')+' record created successfully.' + ' ' + + c.get('v.payments') .length + ' records remaining ' ;
                    c.set('v.sucessmessage', succesmessage );  
                    
                }
                if( r.messagePayments > 0 && c.get('v.paymentType') == 'invoices')
                {
                    c.set('v.sucessmessagepayments', r.messagePayments ); 
                    var succesmessagepayment = c.get('v.sucessmessagepayments')+' record created successfully.' + ' ' + + c.get('v.payments') .length + ' records remaining ' ;
                    c.set('v.sucessmessagepayments', succesmessagepayment );  
                    
                }
                else
                {
                    c.set('v.sucessmessagepayments', ' ' );  
                } 
                
                
                var paymentsremain = c.get('v.payments');
                paymentsremain.forEach(function (payment, paymentIndex) {
                    
                    if((!r.successBillSuppliers.includes(payment.Billpaysupplier) )&& (!r.successBillSuppliers.includes(payment.InvoiceNumber) ) )
                    {  
                        remainingPayments2.push(payment);
                        
                    }
                    
                    
                });
                c.set("v.alldatasremainingPayments1", remainingPayments2);   
                c.set("v.totalPages", Math.ceil(c.get('v.alldatasremainingPayments1').length/c.get("v.pageSize")));
                c.set("v.allData", c.get('v.alldatasremainingPayments1'));
                c.set("v.currentPageNumber",1);
                
                h.setPageDataAsPerPagination(c, h);
                
            }
            
            
            if (r.error.length > 0) {
                var finalerror = r.error.split(',');
                c.set('v.Errormessage', finalerror);
                
            }
            else
            {
                c.set('v.Errormessage', ' ');  
                
            }
            if (r.errorinv.length > 0) {
                var finalerrorerrorinv = r.errorinv.split(',');
                
                c.set('v.Errormessageinv', finalerrorerrorinv);
                
            }
            else
            {
                c.set('v.Errormessageinv', ' ');  
                
            }  
            
            
            if( r.warning != undefined)
            {
                h.warning({ message: r.warning  });  
                
            }   
            
        });
        
    }
    
})