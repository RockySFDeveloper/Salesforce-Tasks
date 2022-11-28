public with sharing class AccountCalculator {

    @future
    public static void countContacts(List<Id> accountIds) {

        List<Account> accountList = [SELECT Id, (SELECT Id From Contacts) from Account where Id IN : accountIds];

        for(Account accountDetail : accountList) {

            accountDetail.Number_of_Contacts__c = accountDetail.Contacts.size();
        }

        if(!accountList.isEmpty()) {

            update accountList;
        }
        system.debug(accountList);

    }
}
