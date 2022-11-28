// Initiate Trigger when Opportunity updated
trigger OpportunityTrigger on Opportunity(after update) {

    if(trigger.isUpdate) {

        List<Id> listOfIdsForCreate = new List<Id>();        
        for(Opportunity opportunityInstance : Trigger.new ) {

            // Checking the old value and new value in a same record
            if(Trigger.oldMap.get(opportunityInstance.Id).StageName == 'Negotiation/Review' 
                && opportunityInstance.StageName == 'Closed Won') {

                listOfIdsForCreate.add(opportunityInstance.Id);                                       
            }          
        }
        // Calling Transaction Handler Class and Method
        TransactionHandler.toCreateTransaction(listOfIdsForCreate);
    }
}