public with sharing class AsyncApexPushTopic {

    @AuraEnabled
    public static void Publish(){

        try {
            
            PushTopic pushTopicforApexAsync = new PushTopic();
            pushTopicforApexAsync.Name = 'AsyncUpdates';
            pushTopicforApexAsync.Query = 'SELECT Id, Status, JobItemsProcessed, TotalJobItems FROM  AsyncApexJob';
            pushTopicforApexAsync.ApiVersion = 50.0;
            pushTopicforApexAsync.NotifyForOperationCreate = true;
            pushTopicforApexAsync.NotifyForOperationUpdate = true;
            pushTopicforApexAsync.NotifyForOperationUndelete = true;
            pushTopicforApexAsync.NotifyForOperationDelete = true;
            pushTopicforApexAsync.NotifyForFields = 'Referenced';
            insert pushTopicforApexAsync;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
