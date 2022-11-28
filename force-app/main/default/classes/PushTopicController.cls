public with sharing class PushTopicController {

    @AuraEnabled
    public static void Publish(){

        try {
            
            PushTopic pushTopic = new PushTopic();
            pushTopic.Name = 'AccountUpdates';
            pushTopic.Query = 'SELECT Id, Name, Records_Processed__c, Records_Processing__c,NumberOfEmployees, Phone FROM Account';
            pushTopic.ApiVersion = 50.0;
            pushTopic.NotifyForOperationCreate = true;
            pushTopic.NotifyForOperationUpdate = true;
            pushTopic.NotifyForOperationUndelete = true;
            pushTopic.NotifyForOperationDelete = true;
            pushTopic.NotifyForFields = 'Referenced';
            insert pushTopic;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
