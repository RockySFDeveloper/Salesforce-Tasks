// Trigger to Update Account if contact is inserted
trigger ContactTrigger on Contact (after update) {

    // Initiating List fuction to get new values
    list<Contact> listContact = [select Id, Account.Debugging__c from contact where Id IN : Trigger.new];
    list<Account> listAccount = new list<Account>();

    /*
        * Iterating the newly updated values
        * Updating the 'Debugging' field in Account which was related to that updated values in contact
    */
    for(Contact contactInstance : listContact) {

        Account accountUpdate = new Account(Id = contactInstance.AccountId);
        accountUpdate.Debugging__c = 'Modified';
        listAccount.add(accountUpdate);
    }   
    update listAccount;   
}