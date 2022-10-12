({
    onInit: function (c, e, h) {
        c.set('v.datatableConfig', {
            showRowNumberColumn: true,
            columns: []
        }); 
        c.set('v.datatableConfigexist', {
            showRowNumberColumn: true,
            columns: []
        });
        h.request(c, 'getActiveSite',{}, function(r){ 
                 console.log(r);
                  c.set('v.getSite', r.getSite);

            console.log('r.getSite',r.getSite); 
                 
              var resultrecs = c.get('v.getSite');
            console.log('resultrecs',resultrecs);
            var labTestMapbank = [];
            for(var key in resultrecs){
                labTestMapbank.push({key: key, value: resultrecs[key]});
            }
           c.set("v.labTestMapbank", labTestMapbank);     
                 
   });
    },
        mySelectSite: function(component,helper,event){
        var selectValue= component.find('bankPicklist').get('v.value');
            if(selectValue != null){
                         component.set("v.showupload", true);     
  
            }
         console.log(selectValue); 
        },
    setSelectedPayments: function (c, e, h) {
      c.set('v.selectedPayments', e.getParam('selectedRows'));
   
    },
    
    onFileChange: function (c, e, h) {
        var files = e.getSource().get('v.files');
        h.parseCSV(c, files);
    },
    Cancel : function (c, e, h) {
        $A.get('e.force:refreshView').fire();  
    },
       
    handleClick : function(component,event,helper){
        var elements = document.getElementsByClassName("errorMsg");
        elements[0].style.display = 'none';    
    },
     handleClick2 : function(component,event,helper){
            component.set("v.paginationOpen", false);      
  
    },
    onValuesUpdate: function (c, e, h) {
        var draftValues = e.getParam('draftValues');
        var paymentData = draftValues[0];
        var newValue = '';
            var selectedPayments = c.get('v.selectedPayments');

        var datatableConfig = c.get('v.datatableConfig');
        Object.keys(paymentData).forEach(function (column) {
            
            if (column !== 'paymentIndex') {
                newValue = { [column]: paymentData[column] };
            }
        });
        
        var paymentsdata = c.get('v.payments');
        draftValues.forEach(function (payments) {
            var paymentIndex = payments.paymentIndex.split('row-')[1];
            if(paymentIndex != undefined)
            {
                paymentsdata[paymentIndex] = Object.assign(paymentsdata[paymentIndex], newValue);
            }else
            {
                var paymentIndex = payments.paymentIndex.split('index')[1];
                paymentsdata[paymentIndex] = Object.assign(paymentsdata[paymentIndex], newValue);
            }
        });
        
        c.set('v.payments', paymentsdata);
           c.set('v.selectedPayments', selectedPayments);
 
    },
    /* Saving tag into uid object*/
    
    Save : function (c, e, h) {
        var selectedPayments = c.get('v.selectedPayments');
        var sites;
                var selectValue= c.find('bankPicklist').get('v.value');
        

        if(selectedPayments.length > 0 && selectValue != "")
        {
            if(selectValue == "" ){
            h.warning({ message: 'Please select Site Name.' });
            
        }
            h.request(c, 'Savetags', {tagsvalues: JSON.stringify(c.get("v.selectedPayments")),Siteids :selectValue }, function (r) { 
                var elements = document.getElementsByClassName("errorMsg");
                var remainingTags =[];
                if (r.successBillSuppliers && r.successBillSuppliers.length > 0  ) {
                    var remainingTagCompare = [];
                    var finalresult = [];
                    var remainingTags =[];
                    var  payments = c.get('v.allData');   
                    payments.forEach(function (payment, paymentIndex) {
                        if((!r.successBillSuppliers.includes(payment.Tag)))
                        {  
                            remainingTagCompare.push(payment);
                            
                        }
                        
                    });
                    var remainingTagResult = remainingTagCompare.map((item, index) => { 
                        var container = {};
                                                                     
                                                                     container.paymentIndex = 'index'+ index;
                                                                     container.Tag = item.Tag;
                                                                     container.ActiveUID = item.ActiveUID;
                                                                     container.IRRUID = item.IRRUID;
                                                                     container.StatusUID= item.StatusUID;
                                                                     return container;
                                                                     })    
                    
                    c.set('v.payments', []);  
                    c.set('v.selectedPayments', []);
                   c.set('v.selectPayments', []);
                    c.set('v.payments', remainingTagResult);  
                    if( r.message > 0 )
                    {
                        c.set('v.sucessmessage', r.message ); 
                        var succesmessage = c.get('v.sucessmessage')+' Tags created successfully.' + ' ' + ' Pending Tags: ' + c.get('v.payments') .length ;
                        c.set('v.sucessmessage', succesmessage);  
                        c.set('v.succes', succesmessage);
                    } 
                    var Tagsremain = c.get('v.payments');
                    Tagsremain.forEach(function (payment, paymentIndex) {
                        
                        if((!r.successBillSuppliers.includes(payment.Tag) )  )
                        {  
                            remainingTags.push(payment);
                            
                        }
                        
                        
                    });
                    c.set("v.alldatasremainingPayments1", remainingTags);   
                    c.set("v.totalPages", Math.ceil(c.get('v.alldatasremainingPayments1').length/c.get("v.pageSize")));
                    c.set("v.allData", c.get('v.alldatasremainingPayments1'));
                    c.set("v.currentPageNumber",1);
                    h.setPageDataAsPerPagination(c, h);
                     c.set("v.paginationOpen", false);  
                }
            
                if (r.error.length > 0) {
                    var finalerror = r.error.split(',');
                    c.set('v.Errormessage', finalerror);
                    console.log('finalerror',finalerror);
                    window.setTimeout(
                        $A.getCallback(function() {
                            var element_btnSec = document.getElementsByClassName("errorMsg");
                            element_btnSec[0].style.display = 'block';
                            
                        }), 2000
                    );
                    
                } 
                else
                {
                    window.setTimeout(
                        $A.getCallback(function() {
                            var element_btnSec = document.getElementsByClassName("errorMsg");
                            element_btnSec[0].style.display = 'none';
                            
                        }), 50
                    );
                    c.set('v.Errormessage', ' ');    
                }
                
                
            });    
        }else{
            h.warning({ message: 'Please select the altest one tags	.' });
            
        }
        
        
    },
      closeModel: function(component, event, helper) {
         component.set("v.paginationOpen", false);  
             component.set('v.isButtonActive',false);    
    },
    
    onNext : function(component, event, helper) {      
           var selectedPayments = component.get('v.selectedPayments');
        if(selectedPayments.length > 0)
        {
            component.set("v.paginationOpen", true);     
            component.set("v.YesCheckonNext" ,true); 

        }
        else
        {
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.setPageDataAsPerPagination(component, helper);
        }
    },
    
    onPrev : function(component, event, helper) { 
           var selectedPayments = component.get('v.selectedPayments');
        if(selectedPayments.length > 0)
        {
           component.set("v.paginationOpen", true); 
       component.set("v.YesCheckonPrev" ,true); 

        }
        else
        {
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.setPageDataAsPerPagination(component, helper);
        }
    },
    
    selectedPagination : function(component, event, helper) {
        // console.log('currentPageNumber',component.get("v.currentPageNumber"));
        var Selectedpage = component.get("v.YesCheckSelectedpage"); 
        console.log('Selectedpage',Selectedpage);
        if(Selectedpage == true)
        {
            var newpagenum = component.get("v.currentPageNumber");
              component.set("v.YesCheckSelectedpage", false); 
        }
        var selectedPayments = component.get('v.selectedPayments');
        
        if(selectedPayments.length > 0)
        {
            
            component.set("v.paginationOpen", true);  
            console.log('>>>>>>>>>>',component.get("v.currentPageNumber"));
            component.set("v.currentPageNumber", parseInt(event.getSource().get('v.name')));
            var  currentpage = component.get('v.currentPageNumber'); 
            component.set("v.YesCheckSelectedpage" ,true); 
            
            
            
            
        }
        else
        {
            
            if(newpagenum != undefined)
            {
                component.set("v.currentPageNumber", newpagenum); 
                helper.setPageDataAsPerPagination(component, helper);
                component.set('v.isButtonActive',false);    
            }
            else
            {
                component.set("v.currentPageNumber", parseInt(event.getSource().get('v.name'))); 
                helper.setPageDataAsPerPagination(component, helper);
                component.set('v.isButtonActive',false);   
            }
            
        }
        
        
        
    },
      onFirst : function(component, event, helper) {    
         var selectedPayments = component.get('v.selectedPayments');
        if(selectedPayments.length > 0)
        {
           component.set("v.paginationOpen", true); 
            component.set("v.YesCheckonFirst" ,true); 
        }
        else
        {
          component.set("v.currentPageNumber", 1);
        helper.setPageDataAsPerPagination(component, helper);
        }
          
    },
   
    
    onLast : function(component, event, helper) { 
    
       var selectedPayments = component.get('v.selectedPayments');
        if(selectedPayments.length > 0)
        {
            component.set("v.paginationOpen", true);  
            component.set("v.YesCheckonLast", true);  

        }
        else
        {
          
         component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPageDataAsPerPagination(component, helper);  
        }
        
    }, 
    yes : function(component, event, helper) { 
        console.log('yes',component.get("v.YesCheckonLast"));
        var onlast = component.get("v.YesCheckonLast");
        var onFirst = component.get("v.YesCheckonFirst");
        var onPrev = component.get("v.YesCheckonPrev");
        var onnext = component.get("v.YesCheckonNext");
        var Selectedpage = component.get("v.YesCheckSelectedpage");

        if(onlast == true)
        {
            var a = component.get('c.onLast');
            $A.enqueueAction(a);
            component.set("v.paginationOpen", false); 
            component.set('v.selectedPayments', []);
            component.set("v.YesCheckonLast" ,false); 
        }else if(onFirst == true)
        {
           var a = component.get('c.onFirst');
            $A.enqueueAction(a);
            component.set("v.paginationOpen", false); 
            component.set('v.selectedPayments', []);  
            component.set("v.YesCheckonFirst" ,false); 
        }
        else if(onPrev == true)
        {
           var a = component.get('c.onFirst');
            $A.enqueueAction(a);
            component.set("v.paginationOpen", false); 
            component.set('v.selectedPayments', []);  
            component.set("v.YesCheckonPrev" ,false); 
        }
        else if(onnext == true)
        {
           var a = component.get('c.onNext');
            $A.enqueueAction(a);
            component.set("v.paginationOpen", false); 
           component.set('v.selectedPayments', []);  
            component.set("v.YesCheckonNext" ,false); 
        } else if(Selectedpage == true)
        {
           var a = component.get('c.selectedPagination');
            $A.enqueueAction(a);
            component.set("v.paginationOpen", false); 
            component.set('v.selectedPayments', []);  
            component.set("v.YesCheckSelectedpage" ,false); 
            var  currentpage = component.get('v.currentPageNumber'); 
            console.log('currentpage',currentpage);
           component.set("v.currentPageNumber", currentpage);
         component.set("v.YesCheckSelectedpage", true); 
            
         
            
        }
 
        
 
    },
    onNextExist : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumberExist");
        component.set("v.currentPageNumberExist", pageNumber+1);
        helper.setPageDataAsPerPaginationExist(component, helper);
    },
    
    onPrevExist : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumberExist");
        component.set("v.currentPageNumberExist", pageNumber-1);
        helper.setPageDataAsPerPaginationExist(component, helper);
    },
    
    selectedPaginationExist : function(component, event, helper) {
        component.set("v.currentPageNumberExist", parseInt(event.getSource().get('v.name'))); //event.target.name
        helper.setPageDataAsPerPaginationExist(component, helper);
        component.set('v.isButtonActive',false);
        
    },
    
    onFirstExist : function(component, event, helper) {        
        component.set("v.currentPageNumberExist", 1);
        helper.setPageDataAsPerPaginationExist(component, helper);
    },
    
    onLastExist : function(component, event, helper) {        
        component.set("v.currentPageNumberExist", component.get("v.totalPagesExist"));
        helper.setPageDataAsPerPaginationExist(component, helper);
    }, 
    
    
})