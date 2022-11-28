public with sharing class AsyncJobProcess {
    @AuraEnabled
    public static List<AsyncApexJob> toGetJobProcess(Id getJobId){
        try {
            List<AsyncApexJob> getJobProcess = [SELECT Id, Status, JobItemsProcessed, TotalJobItems
                                          FROM  AsyncApexJob
                                          WHERE Id =:getJobId] ;

            system.debug('AsyncJobs' +getJobProcess);
            return getJobProcess;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
