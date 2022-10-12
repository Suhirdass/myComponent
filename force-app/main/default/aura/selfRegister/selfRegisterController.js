({
	/*handleFilesChange : function (c, e,h) {
        var files = e.getSource().get("v.files");
        console.log('File:',files[0]);
        console.log(files.length + ' files !!');
    },*/
    onSendCopyChange: function(c, e, h) {
        var sendMeCopy = e.getSource().get('v.checked');
        c.set('v.sendMeCopy',sendMeCopy);
    },
    onPhoneChange: function(c, e, h) {
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        c.set('v.phone',formattedPhone);
        e.getSource().showHelpMessageIfInvalid();
    },
    handleFilesChange: function(c, e, h) {
        var fileName = '';
        if (e.getSource().get("v.files").length > 0) {
            fileName = e.getSource().get("v.files")[0]['name'];
        }
        c.set("v.fileName", fileName);
    },
    onSignUp : function(c,e,h){
        try{
        var isValid = h.isValid(c);
        console.log('isValid:',isValid);
            if(isValid){
                if (c.get('v.fileName') != '') {
                    h.uploadHelper(c, e,h);
                }  else {
                    h.onSignupHelper(c);
                   //h.error({message: 'Please select a valid file'});
                } 
                
            }    
        }catch(err){
            console.log('Error:',err);
        }
    }
})