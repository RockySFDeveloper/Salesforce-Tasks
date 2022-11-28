// Class to update a field in Account
public class AccountHandler {

    /*
        * Method to get list of values which was triggered
        * Iterating the newly updated values
        * Updating the 'Debugging' field in Account which was related to that updated values in contact
    */
    public static void toUpdateAccount(list<Account> triggeredValue) {

        list<Account> ListAccount = new list<Account>();
        for(Account holdTriggeredValue : triggeredValue) {

            Account createAccount = new Account(Id = holdTriggeredValue.Id);
            createAccount.Description = 'Account updated successfully by Trigger' ;
            ListAccount.add(createAccount);
        }
        update ListAccount;
    }
}
