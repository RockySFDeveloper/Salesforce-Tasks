//class to update Contact using Batch
public with sharing class ContactUpdateUsingBatch implements Database.Batchable<sObject>,Database.Stateful {

    public double holdBatchProcess;
    public string recordName;
    /*
        * Intiating start method in batch class
        * Fetching all record in Contact using query Locator
    */
    public ContactUpdateUsingBatch(string recordName) {
        this.recordName = recordName;
    }

    public Database.QueryLocator start(Database.BatchableContext batchMethodVariable) {
            
        return Database.getQueryLocator([select Id from Contact where Name Like 'Batch%' Limit 2000]);
    }

    /*
        * Intiating Execute method in batch class
        * Getting all records as a Batch in start method
        * Updating 2000 Contacts for one Account
    */
    public void execute(Database.BatchableContext batchMethodVariable, List<contact> contactList) {

    

        try {

            List<Contact> contactListUpdated = new List<Contact>();
            Account accountInstance = [Select Id, Name from Account where Name =:recordName];
            for(Contact contactUpdate : contactList) { 
                contactUpdate.AccountId = accountInstance.Id;
                contactListUpdated.add(contactUpdate);                 
            }
            // accountInstance.Name = null;
            // update accountInstance;
            update contactListUpdated;
		
            //Getting current Job Id of batch Process
            AsyncApexJob currentApexJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems
                                           FROM AsyncApexJob
                                           WHERE Id = :batchMethodVariable.getJobId()];

            //Initiating Platform Event and assigning values
            Batch_Progress__e batchEvent = new Batch_Progress__e();

            //batchEvent.ObjectApiName__c = 'Contact';
            batchEvent.Batch_Id__c = batchMethodVariable.getJobId();
            batchEvent.Batches_Processing__c = Integer.valueOf(currentApexJob.JobItemsProcessed);
            batchEvent.Total_Batches__c = Integer.valueOf(currentApexJob.TotalJobItems);
            batchEvent.Finish_Toast__c = 'Not Completed';
            batchEvent.Record_Id__c = accountInstance.Id;
            batchEvent.Batch_Status__c = 'Success';
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

            Account accountInstance = [Select Id, Name from Account where Name =:recordName];
            Batch_Progress__e batchEvent = new Batch_Progress__e();
            batchEvent.Record_Id__c = accountInstance.Id;
            batchEvent.Batch_Status__c = 'Failed';
            batchEvent.Error_Message__c = String.valueOf(error.getMessage());
            system.debug('update failed'+error.getMessage());   
            Database.SaveResult results = EventBus.publish(batchEvent);       
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

// Database.executeBatch(new ContactUpdateUsingBatch('Event 1'),1);

// List<Contact> delContact = [SELECT Id FROM Contact WHERE LastName LIKE 'Batch%' Limit 1000];
// delete delContact;

// List<contact> contactList = new List<contact>();
//     for(integer contactLimit = 1; contactLimit <= 200; contactLimit++){
//       Contact contactInstance = new Contact();
//       contactInstance.LastName = 'Batch Contact'+contactLimit;
//       contactList.add(contactInstance);               
//     }    
// insert contactList;

// List<Contact> contactListUpdated = new List<Contact>();
// List<Contact> getContact = [select Id from Contact where Name Like 'Batch%'];
//     for(Contact contactUpdate : getContact) { 
//         contactUpdate.AccountId = null;
//         contactListUpdated.add(contactUpdate);                 
//     }
// update contactListUpdated;


List<Opportunity> delOpportunity = [SELECT Id FROM Opportunity WHERE Name LIKE 'Opportunity%'];
delete delOpportunity;


