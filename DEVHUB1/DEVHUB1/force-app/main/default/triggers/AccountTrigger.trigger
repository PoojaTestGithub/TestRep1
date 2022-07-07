trigger AccountTrigger on Account (before insert, after insert, before update, after update) {
    if(trigger.isInsert){
        if(trigger.isBefore){
            AccountTriggerHandler.ratingUpdate(Trigger.new);
        }  
        else if(trigger.isAfter){
            AccountTriggerHandler.createRelatedOpp(Trigger.new);
        }
    }
    
}