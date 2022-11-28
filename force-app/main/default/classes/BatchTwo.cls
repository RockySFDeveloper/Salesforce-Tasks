public with sharing class BatchTwo implements Database.Batchable<sObject>,Database.Stateful{
    public double holdBatchProcess;
    /*
        * Intiating start method in batch class
        * Fetching all record in Contact using query Locator
    */
    public Database.QueryLocator start(Database.BatchableContext batchMethodVariable) {
            
        return Database.getQueryLocator([select Id from Contact where Name Like 'Batch Limit6%' AND Name Like 'Batch Limit9%' AND
                                                                        Name Like 'Batch Limit7%' AND Name Like 'Batch Limit8%']);
    }

    /*
        * Intiating Execute method in batch class
        * Getting all records as a Batch in start method
        * Updating 5000 Contacts for one Account
    */
    public void execute(Database.BatchableContext batchMethodVariable, List<contact> contactList) {

        try {

            List<Contact> contactListUpdated = new List<Contact>();
            Account accountInstance = [Select Id, Name from Account where Name = 'Event 2'];
            for(Contact contactUpdate : contactList) { 
                contactUpdate.AccountId = accountInstance.Id;
                contactListUpdated.add(contactUpdate);                 
            }
            update contactListUpdated;
		
            //Getting current Job Id of batch Process
            AsyncApexJob currentApexJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems
                                           FROM AsyncApexJob
                                           WHERE Id = :batchMethodVariable.getJobId()];

            //Initiating Platform Event and assigning values
            Batch_Progress__e batchEvent = new Batch_Progress__e();

            batchEvent.ObjectApiName__c = 'Contact';
            batchEvent.Batch_Id__c = batchMethodVariable.getJobId();
            batchEvent.Batches_Processing__c = Integer.valueOf(currentApexJob.JobItemsProcessed);
            batchEvent.Total_Batches__c = Integer.valueOf(currentApexJob.TotalJobItems);
            batchEvent.Finish_Toast__c = 'Not Completed';
            batchEvent.Record_Id__c = accountInstance.Id;
            holdBatchProcess = batchEvent.Batches_Processing__c + 1;

            if(holdBatchProcess == batchEvent.Total_Batches__c) {
                batchEvent.Finish_Toast__c = 'Completed';
            }

            Database.SaveResult results = EventBus.publish(batchEvent);
        
            if (results.isSuccess()) {
                System.debug('Successfully published event.');
            } else {
                for(Database.Error errorResults : results.getErrors()) {
                    System.debug('Error returned: ' +errorResults.getStatusCode() +' - ' +errorResults.getMessage());
                }
            }
        } catch(Exception error) {

            system.debug('update failed'+error.getMessage());          
        }
    }
    
    /*
        * Intiating finish method in batch class
    */
    public void finish(Database.BatchableContext batchMethodVariable) {
        
        system.debug('Batch '+batchMethodVariable.getJobId()+' Completed Successfully');
        //BatchCompletionMail.sendEmailWithoutTemplate(batchMethodVariable.getJobId());
    }
}
