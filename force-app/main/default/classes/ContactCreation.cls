public with sharing class ContactCreation {

    @AuraEnabled
    public static Contact contactInsert(Contact contactRecords) {

        insert contactRecords;     
        return contactRecords;
    }
}
