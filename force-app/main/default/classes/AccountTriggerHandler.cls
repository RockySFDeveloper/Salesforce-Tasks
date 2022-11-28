public with sharing class AccountTriggerHandler {

    public static void updateAccount (List<Account> accountList, Map<Id,Account> accountOldMap) {
        
        List<Account> accountToBeUpdated = new List<Account>();
        
        for (Account accountInstance : accountList) {
            Account accountUpd = new Account (Id = accountInstance.Id);
            accountInstance.Description= 'Test';
            accountToBeUpdated.add(accountInstance);
        }
        
        if(!accountToBeUpdated.isEmpty()) { 
            update accountToBeUpdated;
        }
    }           
}
