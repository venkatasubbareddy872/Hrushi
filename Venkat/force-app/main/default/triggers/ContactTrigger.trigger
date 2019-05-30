trigger ContactTrigger on Contact (After Insert, After Update, After Delete) {
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert)
            ContactTriggerHandler.onAfterInsert(Trigger.New);
        if(Trigger.isUpdate)
            ContactTriggerHandler.onAfterUpdate(Trigger.New, Trigger.oldMap);
        if(Trigger.isDelete)
            ContactTriggerHandler.onAfterDelete(Trigger.Old);
    }
    
}