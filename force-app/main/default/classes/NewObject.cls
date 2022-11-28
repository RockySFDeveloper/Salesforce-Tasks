public with sharing class NewObject {
    public void apexObject() {
        Apex__c testObject = new Apex__c();
        testObject.Description__c = 'Working';
        update testObject;
    }
}
