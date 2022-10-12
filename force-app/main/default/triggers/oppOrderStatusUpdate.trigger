trigger oppOrderStatusUpdate on Opportunity (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
       //     oppOrderStatusUpdateClass.oppOrderStatusUpdateMethod(Trigger.New);
        }
   
}