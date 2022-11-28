// Batch class to Update Lead 
global class LeadUpdateBatch implements Database.Batchable<sObject> {

    /*
        * Intiating start method in batch class
        * Fetching all records in Lead using query Locator
    */
    global Database.QueryLocator start(Database.BatchableContext batchMethodVariable) {
       
        return Database.getQueryLocator([select AnnualRevenue from Lead]);
    }

    /*
        * Intiating Execute method in batch class
        * Getting all records as a Batch in start method
        * Updating Lead Annual Revenue upto '2000000'
    */
    global void execute(Database.BatchableContext batchMethodVariable, List<Lead> leadList) {

        for(Lead leadInstance : leadList) { 
            leadInstance.AnnualRevenue = 2000000;
        }
        update leadList;
    }
    
    /*
        * Intiating finish method in batch class
        * Assigning Email Id to indicate the batch jobs are ran successfully'
    */
    global void finish(Database.BatchableContext batchMethodVariable) {

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] toAddresses = new string[]{'hplaptop13092018@gmail.com','rakeshramster10@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('Batch job you have started is success');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}
