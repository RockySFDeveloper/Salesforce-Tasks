public with sharing class ContactPushTopic {
    
    @AuraEnabled
    public static void Publish(){

        try {
            
            PushTopic pushTopicforContact = new PushTopic();
            pushTopicforContact.Name = 'ContactOperation';
            pushTopicforContact.Query = 'SELECT Id, LastName, AccountId FROM  Contact';
            pushTopicforContact.ApiVersion = 50.0;
            pushTopicforContact.NotifyForOperationCreate = true;
            pushTopicforContact.NotifyForOperationUpdate = true;
            pushTopicforContact.NotifyForOperationUndelete = true;
            pushTopicforContact.NotifyForOperationDelete = true;
            pushTopicforContact.NotifyForFields = 'Referenced';
            insert pushTopicforContact;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
