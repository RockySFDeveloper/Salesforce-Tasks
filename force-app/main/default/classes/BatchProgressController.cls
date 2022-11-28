public with sharing class BatchProgressController {

    @AuraEnabled
    public static string startBatch(){
        Id batchId;
        try {
            BatchAccountUpdate accountBatch = new BatchAccountUpdate();
            batchId = Database.executeBatch(accountBatch, 1);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return String.valueOf(batchId);
    }
}