//class to update Contact using Batch
public with sharing class BatchAccountUpdate implements Database.Batchable<sObject>,Database.Stateful {

    public integer count = 0;
    public static Id batchId;
    /*
        * Intiating start method in batch class
        * Fetching all record in Contact using query Locator
    */
    public Database.QueryLocator start(Database.BatchableContext batchMethodVariable) {
            
        return Database.getQueryLocator([select Id from Contact where Name Like 'Batch%' Limit 1000]);
    }

    /*
        * Intiating Execute method in batch class
        * Getting all records as a Batch in start method
        * Updating 5000 Contacts for one Account
    */
    public void execute(Database.BatchableContext batchMethodVariable, List<contact> contactList) {

        List<Contact> contactListUpdated = new List<Contact>();
        Account accountInstance = [Select Id, Name from Account where Name = 'Event 2'];
        for(Contact contactUpdate : contactList) { 
            contactUpdate.AccountId = accountInstance.Id;
            contactListUpdated.add(contactUpdate);                 
        }
        update contactListUpdated;
		
		try {
            Batch_Progress__e bpEvent = new Batch_Progress__e();

            AsyncApexJob job = [
                SELECT Id, Status, NumberOfErrors,
                JobItemsProcessed,
                TotalJobItems
                FROM AsyncApexJob
                WHERE Id = :batchMethodVariable.getJobId()
            ];

            bpEvent.Batch_Id__c = batchMethodVariable.getJobId();
            bpEvent.Class_name__c = 'ProcessAccountsBatch';
            bpEvent.Count__c = Integer.valueOf(job.JobItemsProcessed);
            bpEvent.DML_type__c = 'Update';
            bpEvent.isSuccess__c = true;
            bpEvent.ObjectApiName__c = 'Account';
            bpEvent.Total_Batches__c = Integer.valueOf(job.TotalJobItems);

            Database.SaveResult results = EventBus.publish(bpEvent);
            // database.saveresult[] databseSavedResult =  Database.update(contactList,false);
            // for(database.SaveResult storeDbResult : databseSavedResult){
            //     if(storeDbResult.issuccess()) {
            //         count++;
            //     }        
            // }

            // AsyncApexJob getJob = [SELECT Id FROM  AsyncApexJob WHERE Id =:batchMethodVariable.getJobId()];
            // system.debug('getJob '+getJob);
            // batchId = getJob.Id;
            // system.debug('Batch Job Id ===>'+batchId);
            
            // Batch__c custombatch =  Batch__c.getOrgDefaults();
            // custombatch.Job_Id__c = batchId;
            // update custombatch;
            // system.debug('Custom Batch ===>'+custombatch.Job_Id__c);
            // system.debug('Custom Batch ===>'+custombatch);
        
            if (results.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error err : results.getErrors()) {
                    System.debug('Error returned: ' +
                                err.getStatusCode() +
                                ' - ' +
                                err.getMessage());
                }
            }
        } catch(Exception e) {

            system.debug('update failed');
            
        }
    }
    
    /*
        * Intiating finish method in batch class
        * Assigning Email Id to indicate the batch jobs are ran successfully'
    */
    public void finish(Database.BatchableContext batchMethodVariable) {

        system.debug('Count of Batch ====>'+count);      
    }

    @AuraEnabled(cacheable=true) 
    public static Batch__c getCustomSettings(){
        return Batch__c.getOrgDefaults();
    }
}
