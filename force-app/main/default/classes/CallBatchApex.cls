public with sharing class CallBatchApex {

    @AuraEnabled
    public static Id getAccount() {
    Id jobId = Database.executeBatch(new BatchAccountUpdate()); 
    return jobId;
}
}
