public with sharing class OpportunityUpdation {

    @AuraEnabled
    public static void updateOppPaymentStatus(Id opportunityId) {

        Opportunity opportunityRecords = [select Id,Payment_Status_Org__c from Opportunity where Id= :opportunityId];
        opportunityRecords.Payment_Status_Org__c = 'Paid';
        update opportunityRecords;
    }
}
