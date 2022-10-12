({
    MAX_FILE_SIZE: 35000000, //Max file size 35 MB MB 
    CHUNK_SIZE: 3500000,      //Chunk Max size 750Kb 
    
    uploadHelper: function(component, event,helper) {
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner", true);
        // get the selected files using aura:id [return array of files]
        var fileInput = component.find("fileId").get("v.files");
        // get the first file using array index[0]  
        var file = fileInput[0];
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner", false);
            component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
 
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess(component, file, fileContents,helper);
        });
 
        objFileReader.readAsDataURL(file);
    },
 
    uploadProcess: function(component, file, fileContents,helper) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        console.log('fileContents.length = ',fileContents.length);
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 		component.set('v.startPosition',startPosition);
        component.set('v.endPosition',endPosition);
        component.set('v.fileContents',fileContents);
        component.set('v.file',file);
        
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '',helper);
    },
 
 
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId,helper) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        var filenameExt = file.name.substr(file.name.lastIndexOf('.') + 1);
        var fName = '';
        let foldName = '';
        let isAccount = component.get('v.isAccount');
        if(component.get('v.isAccount')){
            fName = component.get('v.account.Name')+'.'+filenameExt;
        } else {
            fName = component.get('v.product.Name')+'.'+filenameExt;
            foldName = component.get('v.product.Brand_Name__c')
        }
        var isFileExist = false;
        
        //Check File is available or NOT
        helper.request(component,'checkFile', {fileName: fName, folderName : foldName, isAcc : isAccount}, function(r){
        	isFileExist = r.isFileExist;
            console.log('isFileExist = ',isFileExist);
            component.set('v.fName',fName);
            component.set('v.file',file);
            if(isFileExist){
                component.set('v.showConfirmDialog',true);
            } else {
                if(isAccount){
                    helper.uploadFile(component,fName,file, attachId,'Account Logo uploaded successfully',helper,isAccount); 
                } else {
                    helper.uploadFile(component,fName,file, attachId,'Product Image uploaded successfully',helper,isAccount);    
                } 
            }
        });   
    },
    
    uploadFile: function(component, fName, file, attachId,msg,helper,isAccount) {
        
        var session_id = component.get("v.session_id");
        var endPosition = component.get("v.endPosition");
        var startPosition = component.get("v.startPosition");
        var fileContents = component.get('v.fileContents');
        var file = component.get('v.file');
        var getchunk = fileContents.substring(startPosition, endPosition);
        let CHUNKSIZE =  this.CHUNK_SIZE;
        if(session_id == 'session_id'){
            helper.request(component,'getSessionId', {base64Data: encodeURIComponent(getchunk)}, function(r){
                session_id = r.session_id;
                component.set('v.session_id',session_id);
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + CHUNKSIZE);
                component.set("v.endPosition",endPosition);
                component.set("v.startPosition",startPosition);
                
                if(endPosition == fileContents.length){
                    let totalOffset = 0;
                    component.set('v.totalOffset',totalOffset);
                }
                
                if (startPosition < endPosition) {
                    helper.uploadFile(component, component.get('v.fName'), file, attachId, msg, helper,isAccount);
                } else {
                    helper.uploadFinish(component,component.get('v.fName'),getchunk, msg, helper,isAccount); 
                }
			});
        } else {
            let count = component.get("v.count");
            
            helper.request(component,'appendFile', {base64Data: encodeURIComponent(getchunk),sessionId: session_id,cnt: count}, function(r){
            	let totalOffset = component.get('v.totalOffset');
                console.log('CHUNK SIZE = ',r.chunkSize);
                component.set('v.totalOffset',r.chunkSize + totalOffset);
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + CHUNKSIZE);
                component.set("v.endPosition",endPosition);
                component.set("v.startPosition",startPosition);
                if (startPosition < endPosition) {
                    count = component.get("v.count");
                    count += 1;
                    component.set("v.count",count);
                    helper.uploadFile(component, component.get('v.fName'), file, attachId, msg, helper,isAccount);
                } else {
                    helper.uploadFinish(component,component.get('v.fName'), getchunk, msg, helper,isAccount);
                }
            });
        }    
    },
    
    uploadFinish : function(component, fName,getchunk,msg,helper,isAccount) {
        var session_id = component.get("v.session_id");
        
        helper.request(component,'saveChunk', {recordId: component.get("v.recordId"),fileName: fName,base64Data: encodeURIComponent(getchunk),
                                               folderName : component.get('v.product.Brand_Name__c'),isAcc: isAccount,
                                               sessionId : session_id,offset: component.get('v.totalOffset')
                                              }, function(r){
                                                  if(r.errorMsg != '' && r.errorMsg != null && r.errorMsg != undefined){
                                                      helper.error({ message: r.errorMsg});
                                                      var dismissActionPanel = $A.get("e.force:closeQuickAction");
                                                      dismissActionPanel.fire();
                                                  } else {
                                                      helper.success({ message: msg});
                                                      component.set("v.showLoadingSpinner", false);
                                                      var dismissActionPanel = $A.get("e.force:closeQuickAction");
                                                      dismissActionPanel.fire();
                                                      setTimeout(function(){
                                                          window.location.reload(1);
                                                      }, 2000); 
                                                  }
                                                      
        });    
    }
})