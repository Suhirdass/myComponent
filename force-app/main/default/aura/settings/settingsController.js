({
    onInit: function(c, e, h) {
        h.request(c, 'getProfile', {}, function(r){
            c.set('v.profile', r.profile);
            c.set('v.isPrimaryContact', r.profile.isPrimaryContact);
            c.set('v.totalLicenseUsed', r.totalLicenseUsed);
            c.set('v.totalLicenseLimit', r.totalLicenseLimit);
            c.set('v.existingUsers', r.existingUsers);
            c.set('v.isBrand',r.isBrand);
            console.log('##pLevel : ',r.platformLevel);
            console.log('##membershipLevel : ',r.membershipLevel);
            c.set('v.platformLevel',r.platformLevel);
            c.set('v.membershipLevel',r.membershipLevel);
        });        
    },
    updateUser: function(c, e, h){
        var userId = e.currentTarget.dataset.itemId;
        var action = e.currentTarget.dataset.itemAction;
        h.request(c, 'updateUserDetails', {userDetails: JSON.stringify({Id:userId, IsActive: (action === 'activate')})}, function(r){
            h.success({message: 'User updated successfully.'});
            c.set('v.existingUsers', r.existingUsers);
        });
    },
    onPhoneChange: function(c, e, h) {
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        var profile = c.get('v.profile');
        profile.phone = formattedPhone;
        c.set('v.profile',profile);
        e.getSource().showHelpMessageIfInvalid();
    },
    onMobileChange: function(c, e, h) {
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        var profile = c.get('v.profile');
        profile.mobilePhone = formattedPhone;
        c.set('v.profile',profile);
        e.getSource().showHelpMessageIfInvalid();
    },
    onNewPhoneChange: function(c, e, h) {
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        var profile = c.get('v.newProfile');
        profile.phone = formattedPhone;
        c.set('v.newProfile',profile);
        e.getSource().showHelpMessageIfInvalid();
    },
    onNewMobileChange: function(c, e, h) {
        var phone = e.getSource().get('v.value');
        console.log('Phone::',e.getSource().get('v.value'));
        var formattedPhone = h.formatPhoneNumber(c,phone);
        console.log('Phone:',formattedPhone)
        var profile = c.get('v.newProfile');
        profile.mobilePhone = formattedPhone;
        c.set('v.newProfile',profile);
        e.getSource().showHelpMessageIfInvalid();
    },
    onProfileUpdate: function(c, e, h){
        if(!h.isValid(c, 'profile')){
            //h.error({message: 'Correct the error(s).'});
            return;
        }
        
        h.request(c, 'updateProfile', {profileData: JSON.stringify(c.get('v.profile'))}, function(r){
            $A.get('e.c:refreshUsernameEvt').setParams({username: r.user.name}).fire();
            h.success({message: 'Profile updated successfully.'});
        });
    },
    onProfileCreate: function(c, e, h){
        if(!h.isValid(c, 'newprofile')){
            //h.error({message: 'Correct the error(s).'});
            return;
        }
        
        h.request(c, 'createProfile', {profileData: JSON.stringify(c.get('v.newProfile'))}, function(r){
            c.set('v.totalLicenseUsed',r.totalLicenseUsed);
            h.success({message: 'New User created successfully.'});
            c.set('v.newProfile',{'profileType':'Community Plus User'});                
        });
    },
    onPasswordUpdate: function(c, e, h){
        if(!h.isValid(c, 'password')){
            //h.error({message: 'Correct the error(s).'});
            return;
        }
        var passwords = c.get('v.passwords');
        if(passwords.newPassword !== passwords.verifyNewPassword){
            h.error({message: 'Password and Confirm password must be same.'});
            return;
        }
        h.request(c, 'updatePassword', {passwordData: JSON.stringify(passwords)}, function(r){
            h.success({message: 'Password updated successfully.'});
            c.set('v.passwords', {});
        });
    },
    handleUploadFinished:function(c, e, h){
        var uploadedFiles = e.getParam("files");
        if(uploadedFiles.length > 0){
            h.success({message: 'Attachment uploaded successfully.'});
        }
    }
})