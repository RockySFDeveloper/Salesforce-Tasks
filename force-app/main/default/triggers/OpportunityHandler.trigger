trigger OpportunityHandler on Opportunity (after Update) {

    double amount;
    //Id recordId;

    if(Trigger.isUpdate) {

        for(Opportunity opportunityDetail : Trigger.new) {

            if(opportunityDetail.Amount != null) {

                amount = opportunityDetail.Amount;
                //recordId = opportunityDetail.Id;
                Platform_Eve_Lwc__e opportunityBatch = new Platform_Eve_Lwc__e();
                opportunityBatch.Amount__c = amount;
                Database.SaveResult results = EventBus.publish(opportunityBatch);
            }

            if(opportunityDetail.Amount == null) {

                amount = opportunityDetail.Amount;
                //recordId = opportunityDetail.Id;
                Platform_Eve_Lwc__e opportunityBatch = new Platform_Eve_Lwc__e();
                opportunityBatch.Amount__c = 0;
                Database.SaveResult results = EventBus.publish(opportunityBatch);
            }
        }
    }     
}