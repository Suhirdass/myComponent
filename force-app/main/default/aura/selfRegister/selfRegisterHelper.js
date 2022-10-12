({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
    formatPhoneNumber: function(c, phone) {
        var s2 = (""+phone).replace(/\D/g, '');
        var m = s2.match(/^(\d{3})(\d{3})(\d{4})$/);
        return (!m) ? phone :m[1] + "-" + m[2] + "-" + m[3];
    },
    uploadHelper: function(component, event,h) {
        var fileInput = component.find("fileId").get("v.files");
        var file = fileInput[0];
        var self = this;
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        if (file.size > self.MAX_FILE_SIZE) {
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
            self.uploadProcess(component, file, fileContents,h);
        });
 
        objFileReader.readAsDataURL(file);
    },
 
    uploadProcess: function(component, file, fileContents,h) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '',h);
    },
 
    onSignupHelper: function(c){
        var h = this;
        h.request(c, 'registerNewUser', {firstName: c.get("v.firstName"),
                                             lastName: c.get("v.lastName"),
                                             dbaName: c.get("v.dbaName"),
                                             phone: c.get("v.phone"),
                                             email: c.get("v.email"),
                                             title: c.get("v.title"),
                                             stateLicense: c.get("v.stateLicense"),
                                             sendMeCopy: c.get("v.sendMeCopy")
                                            }, function(r){
                                                 if(r.id){
                                                     h.success({message: 'Success! Self Registration form submitted successfully'});  
                                                     window.location.reload();
                                                 } else {
                                                     h.error({message: r.error});
                                                 }    
                                             });
    },
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId,h) {
        // call the apex method 'saveChunk'
        var getchunk = fileContents.substring(startPosition, endPosition);
        
        
        h.request(component, 'saveTheFile', {firstName: component.get("v.firstName"),
                                     lastName: component.get("v.lastName"),
                                     dbaName: component.get("v.dbaName"),
                                     phone: component.get("v.phone"),
                                     email: component.get("v.email"),
                                     title: component.get("v.title"),
                                     stateLicense: component.get("v.stateLicense"),
                                     sendMeCopy: component.get("v.sendMeCopy"),
                                     fileName: file.name,
                                     base64Data: encodeURIComponent(getchunk),
                                     contentType: file.type}, function(r){
                                         if(r.flag){
                                             h.success({message: 'Success! Self Registration form submitted successfully'});  
                                             window.location.reload();
                                         } else {
                                             h.error({message: r.error});
                                         }    
                                     });
        
    }
})