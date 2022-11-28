trigger AccountTrigger on Account (after insert, after update) {

    if(trigger.isUpdate) {

        //Initiating list if multiple records occured
        List<Account> accountsList = new List<Account>();

        /*
            * Passing the inserted values into a loop
            * updating a custom text in description field at account object
            * Adding the newly created records in 'accountList' and updating the values in 'Description'
        */  
        for(Account accountInstance : Trigger.new) {

            If(!preventRecursion.firstCall) {

                preventRecursion.firstCall = True ;   
                AccountHandler.toUpdateAccount(Trigger.new);
            }
        }
    }
        
    
    if(trigger.isInsert) {

        if(!preventRecursion.firstCall) {

            preventRecursion.firstCall = True ;
            Account accountCreation =  new Account(Name = 'Recursive Trigger');
            insert accountCreation;
        } 
    } 
}