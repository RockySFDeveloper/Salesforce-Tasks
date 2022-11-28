//Class to create a Records in Account and Contact
public with sharing class AccountAndContactCreation {

// Method to create a new Account Record
    public static void accountCreationNew() {   

        Account holdingAccCreation = new Account();
        holdingAccCreation.Name = 'Father';
        insert holdingAccCreation;
        system.debug(holdingAccCreation);
    }

// Method to create a new Contact Record by linking Account Record
    public static void contactCreationNew() {   

        Account accId = [Select Id 
                         from Account 
                         where Name = 'Father'];
        system.debug(accId);
        Contact holdingContCreation = new Contact(LastName = 'Son', AccountId=accId.Id);
        insert holdingContCreation;
        system.debug(holdingContCreation);
    }
}
