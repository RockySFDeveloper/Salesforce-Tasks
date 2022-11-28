public with sharing class LWCAccountCreation {

    @AuraEnabled
    public static Account accountInsert(Account accountRecords) {

        insert accountRecords;     
        return accountRecords;
    }
}
