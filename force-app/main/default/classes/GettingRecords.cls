public with sharing class GettingRecords {
// Method to insert 200 Records
    public static void getting200Records() {   
        try {             
        List<Account> accountList = [select Name 
                                    from Account 
                                    where Name Like 'Testify%'];        
        for (Account accountDetails : accountList) {
            Account accLoop = [select Name 
                               from Account 
                               where Name = 'Testify1'];
            accLoop.Name = 'Testify01';
            accountList.add(accLoop);
        }
        update accountList;
        system.debug(accountList);
        } catch(Exception unWantedCharacters) {
            system.debug(unWantedCharacters.getMessage);
        }
    }
}
