public class BatchApexProgressIndicatorController {
	@AuraEnabled
    public static Id executeBatchJob(){
        Id batchJobId = Database.executeBatch(new sampleBatchApex(), 1);
        return batchJobId;
    }

    @AuraEnabled
    public static AsyncApexJob getBatchJobStatus(Id jobID){
        AsyncApexJob jobInfo = [SELECT Status, NumberOfErrors,JobItemsProcessed,TotalJobItems FROM AsyncApexJob WHERE Id = :jobID];
        return jobInfo;
    }
}