public with sharing class AccountUpdate {

    @AuraEnabled
    public static void toUpdateAccount(Integer recordsProcessed, string accountName){

        try {
            
            Account accountInstance = [Select id,Name,Records_Processing__c from Account where Name = :accountName];
            accountInstance.Records_Processing__c = recordsProcessed;
            update accountInstance;        
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
