//Class for Getting details form Accounts
public class accountGetting {

//Method to Retrieve Account Details based on Paramete we Passed
    public static void gettingAccountOfUser(string getName) {
        
        Account getAccount = [Select Type, Industry, Phone 
                              from Account 
                              where Name = :getName];
        system.debug(getAccount);
    }
}
