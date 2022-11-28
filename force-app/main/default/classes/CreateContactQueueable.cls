// Create contact using Queueable method
public class CreateContactQueueable implements Queueable {

    list<Account> accountLists = new list<Account>();

    // Declare constructor to get value from Account Trigger
    public createContactQueueable(list<Account> accountFromTrigger) {

        this.accountLists = accountFromTrigger;
    }

    /*
        * Passing parameter to Queueable method which is get from trigger
        * Iterating Parameter value and Creating a contact by linking that Account
        * Insert the Contact
    */
    public void execute(QueueableContext queueVariable) {

        list<Contact> contactLists = new list<Contact>();
        for(Account accountInstance : accountLists) {
            Contact createContact = new Contact();
            createContact.LastName = accountInstance.Name;
            createContact.AccountId = accountInstance.Id;
            contactLists.add(createContact);
        }
        insert contactLists;
    }
}
