({
    initSearch: function (c, e) {
        var h = this;
        sessionStorage.setItem('initSearch', 1);
        sessionStorage.setItem('searchTerm', e.getParam('searchTerm'));
        h.redirect('/products', true);
    },
    showToast: function (toastType, params) {
        params['type'] = toastType;
        params['mode'] = 'dismissible';
        $A.get('e.force:showToast').setParams(params).fire();
    },
    info: function (params) {
        this.showToast('info', params);
    },
    success: function (params) {
        this.showToast('success', params);
    },
    warning: function (params) {
        this.showToast('warning', params);
    },
    error: function (params) {
        this.showToast('error', params);
    },
    handleErrors: function (component, errors) {
        var h = this;
        $A.warning('Callback failed', '' + errors);
        if (errors && Array.isArray(errors)) {
            var errorMessages = [];
            errors.forEach(function (error) {
                if (error.pageErrors && Array.isArray(error.pageErrors)) {
                    error.pageErrors.forEach(function (pageError) {
                        errorMessages.push(pageError.message);
                    });
                    
                    if (errorMessages.length > 0) {
                        h.error({ mode: 'sticky', message: errorMessages.join(', '), title: 'Fix the following error(s).' });
                        errorMessages = [];
                    }
                }
                
                if (error.fieldErrors && Array.isArray(error.fieldErrors)) {
                    error.fieldErrors.forEach(function (field) {
                        error.fieldErrors[field].forEach(function (errorList) {
                            errorMessages.push(errorList.message);
                        });
                    });
                    
                    if (errorMessages.length > 0) {
                        h.error({ mode: 'sticky', message: errorMessages.join(', '), title: 'Fix the following error(s).' });
                        errorMessages = [];
                    }
                }
                
                if (error.fieldErrors && Object.keys(error.fieldErrors)) {
                    Object.keys(error.fieldErrors).forEach(function (field) {
                        error.fieldErrors[field].forEach(function (errorList) {
                            errorMessages.push(errorList.message);
                        });
                    });
                    
                    if (errorMessages.length > 0) {
                        h.error({ mode: 'sticky', message: errorMessages.join(', '), title: 'Fix the following error(s).' });
                        errorMessages = [];
                    }
                }
                
                try {
                    var err = JSON.parse(error.message);
                    if (err && err.cause) {
                        var errorCause = err.cause;
                        var errMsg = err.message;
                        h.error({ mode: 'sticky', message: '[' + component.getName() + ']: ' + '[' + errorCause + ']: ' + errMsg });
                    } else if (err) {
                        h.error({ mode: 'sticky', message: err });
                    }
                } catch (e) {
                    var message = error.message || '';
                    if (message.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION') > 0) {
                        message = message.split('FIELD_CUSTOM_VALIDATION_EXCEPTION, ')[1];
                        message = message.split(': ')[0];
                    }
                    
                    if (message.indexOf('DUPLICATE_VALUE') > 0) {
                        message = message.split('DUPLICATE_VALUE, ')[1];
                        message = message.split(': ')[0];
                    }
                    errorMessages.push(message);
                }
            });
            
            if (errorMessages.length > 0) {
                h.error({ mode: 'sticky', message: errorMessages.join(', ') });
            }
        } else {
            h.error({ mode: 'sticky', title: 'Something went wrong!', message: 'Contact Administrator!' });
        }
    },
    openModal: function (c, modalId) {
        c.find(modalId || 'modal').open();
    },
    closeModal: function (c, modalId) {
        c.find(modalId || 'modal').close();
    },
    tab: function (tabAPIName, isRedirect) {
        var h = this;
        h.redirect(('/one/one.app#/n/' + tabAPIName), isRedirect);
    },
    redirect: function (url, isRedirect) {
        $A.get('e.force:navigateToURL').setParams({
            url: url,
            isredirect: (isRedirect === true)
        }).fire();
    },
    navigateToRecord : function(c,recordId,type){
        console.log('recordId::',recordId);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "slideDevName":type
        });
        navEvt.fire();
    },
    navigateToComponent: function (componentNameWithNamespace, componentAttributes, isRedirect) {
        var attributes = {};
        if (Object.keys(componentAttributes || {}).length > 0) {
            attributes = componentAttributes;
        }
        $A.get('e.force:navigateToComponent').setParams({
            componentDef: componentNameWithNamespace,
            componentAttributes: attributes,
            isredirect: (isRedirect === true)
        }).fire();
    },
    isValid: function (c, id) {
        console.log('Id:',id);
        var validateFields = c.find(id || 'validate');
        var isValid = true;
        if (validateFields) {
            console.log('Lenght:',validateFields.length);
            isValid = [].concat(validateFields).reduce(function (validSoFar, input) {
                var allValid = true;
                if(input && input.showHelpMessageIfInvalid){
                    console.log('input:',input);
                    input.showHelpMessageIfInvalid();
                    var validity = input.get('v.validity');
                    if(validity)
                        allValid = validity.valid;
                }
                return validSoFar && allValid;
            }, true);
        }
        return isValid;
    },
    request: function (c, method, params, success, tmpOptions) {
        var action = c.get('c.' + method);
        var options = Object.assign({ spinnerAttr: 'isProcessing', forceRefresh: false, showSpinner: true, hideSpinner: true, handleErrors: true }, tmpOptions);
        
        if (Object.keys(params)) {
            action.setParams(params);
        }
        
        if (options.background) {
            action.setBackground();
        }
        
        if (options.storable) {
            if (options.forceRefresh) {
                action.setStorable({ ignoreExisting: true });
            } else {
                action.setStorable();
            }
        }
        
        if (options.abortable) {
            action.setAbortable();
        }
        
        var hideSpinner = false;
        if (options.showSpinner && options.spinnerAttr) {
            hideSpinner = true;
            c.set(('v.' + options.spinnerAttr), true);
        }
        
        action.setCallback(this, function (response) {
            if (options.showSpinner) {
                hideSpinner = true;
                c.set(('v.' + options.spinnerAttr), true);
            }
            
            switch (response.getState()) {
                case 'SUCCESS':
                    success(response.getReturnValue().data || {});
                    break;
                    
                case 'ERROR':
                    var errors = response.getError();
                    if (options.handleErrors) {
                        this.handleErrors(c, errors);
                    }
                    
                    if (options.error) {
                        options.error(errors);
                    }
                    break;
                    
                default:
            }
            
            if (options.done) {
                options.done();
            }
            
            if (hideSpinner && options.hideSpinner) {
                c.set(('v.' + options.spinnerAttr), false);
            }
        });
        $A.enqueueAction(action);
    },
    initPagination: function (c, ids, filters, paginatorId) {
        c.find(paginatorId || 'paginator').setIds(ids, filters);
    },
    scroll: function (c, to, el) {
        var h = this;
        var scroller = c.find(el || 'scroller').getElement();
        h.scrollLeft(scroller, scroller.scrollLeft, to, 500);
    },
    scrollLeft: function (el, start, change, duration) {
        var currentTime = 0;
        var increment = 20;
        //t = current time
        //b = start value
        //c = change in value
        //d = duration
        var easeInOutQuad = function (t, b, c, d) {
            t /= d / 2;
            if (t < 1) return c / 2 * t * t + b;
            t--;
            return -c / 2 * (t * (t - 2) - 1) + b;
        };
        
        var animateScroll = function () {
            currentTime += increment;
            var val = easeInOutQuad(currentTime, start, change, duration);
            el.scrollLeft = val;
            if (currentTime < duration) {
                window.setTimeout(animateScroll, increment);
            }
        };
        animateScroll();
    },
    sortBy: function (c, field, records) {
        try {
            var sortAsc = c.get("v.sortAsc"),
                sortField = c.get("v.sortField"),
                sortAsc = sortField != field || !sortAsc;
            records.sort(function (a, b) {
                var t1 = a[field] == b[field],
                    t2 = (!a[field] && b[field]) || (a[field] < b[field]);
                return t1 ? 0 : (sortAsc ? -1 : 1) * (t2 ? 1 : -1);
            });
            c.set("v.sortAsc", sortAsc);
            c.set("v.sortField", field);
            return records;
        } catch (e) {
            console.log("Error:", e);
        }
    },
    keyCode: {
        ENTER: 13
    },
    fetchPageForFile: function (c) {
        //debugger;
        var h = this;
        var ids = c.get('v.allIds');
        console.log('fetchPageForFile - > ids::',ids);
        if (ids.length > 0) {
            h.getRecordsForFile(c, ids);
        }
    } ,
    prepareBreadCrumb:function(c,screenName,removeIdsFromCache){
        var AllBreadCrumb = sessionStorage.getItem('AllBreadCrumb');
        if(AllBreadCrumb){
            AllBreadCrumb = JSON.parse(AllBreadCrumb);
        }
        
        var matchedMenu = AllBreadCrumb.find((menu) => {
            return menu.text == screenName;
        })
        console.log('screenName::',matchedMenu);
        if(matchedMenu){
            sessionStorage.setItem('breadCrumb', JSON.stringify({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}));
            $A.get('e.c:changeBreadcrumbEvent').setParams({breadCrumbString: matchedMenu.label, breadCrumbIds : matchedMenu.value}).fire();
        }
        console.log('removeIdsFromCache:',removeIdsFromCache);
        if(removeIdsFromCache){
            var Ids = removeIdsFromCache.split(',');
            if(Ids.length){
                Ids.forEach((id) => {
                    sessionStorage.removeItem(id);
                })
                }
                }
                }
                })