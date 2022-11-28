//Class for creating Records in Account
public class accountCreation {
    public static void creating200Records() {

        List<Account> accountListFor200Records = new List<Account>();
        
//Inserting 200 Account Object Records through Loop
        for(Integer loopToInsert200Records = 1; loopToInsert200Records <= 200; loopToInsert200Records++) {    

            Account accountCreation = new Account(Name = 'testify' + string.valueOf(loopToInsert200Records));
            accountListFor200Records.add(accountCreation);
        }

        insert accountListFor200Records;
        system.debug(accountListFor200Records);
    }
}


