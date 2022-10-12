trigger opportunityTrigger on Opportunity (before update) {
    
    if(Trigger.isBefore){
        opportunityHelper.checkBrandquoteExists(Trigger.New);
    }

}