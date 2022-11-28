public with sharing class CreatingBulkRecords {

//Method to create 50000 records in Account
    public static void creating50000Records() {     

        try {

        List<Account> accList = new List<Account>();  

// Inserting 50000 Records through Loop
        for(Integer loopToInsert50000Records = 1; loopToInsert50000Records < 50000; loopToInsert50000Records++) {
           Account acc = new Account(Name = 'Testing'+string.valueOf(loopToInsert50000Records));       
           accList.add(acc);
        }
        insert accList;
        system.debug(accList);
        
        } catch(Exception limitReached) {
            system.debug(limitReached.getMessage());
        }
    }
}
//CreatingBulkRecords.creating50000Records();