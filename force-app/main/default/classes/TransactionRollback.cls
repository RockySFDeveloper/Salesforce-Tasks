public class TransactionRollback {

    public static void insertingRecordinAccountAndContact() {

//Using Rollback strategy if any Exception Occurs
        Savepoint rollbackforContact = Database.setSavepoint();

        try {
        Account accountInstance = new Account(Name = 'TR Account');
        insert accountInstance;
        system.debug(accountInstance);
        accountInstance = [select Id from Account where Name = 'TR Account'];
        system.debug(accountInstance);

        Contact contactInstance = new Contact(LastName = 'TR Contact', AccountId = accountInstance.Id);
        insert contactInstance;
        system.debug(contactInstance);

        } catch (Exception requiredFieldMissingOnContact) {
            system.debug(requiredFieldMissingOnContact.getMessage());
            Database.rollback(rollbackforContact);
          }       
    }
}
