trigger ContactDuplicateName on Contact (before insert,before update) {



   if(Trigger.isInsert){
            system.debug('isInsert');
            ContactDuplicateNameValidationHadler.beforeInsert(Trigger.new, trigger.oldMap); 
      }
     if(Trigger.isUpdate ){
         system.debug('isUpdate');
                ContactDuplicateNameValidationHadler.beforeupdate(Trigger.new,trigger.oldMap);   
    }

          

}