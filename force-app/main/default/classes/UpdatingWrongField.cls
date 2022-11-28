public with sharing class UpdatingWrongField {

// Method to Update a field in Account
    public static void WrongField() {    

        try {    

// Updating a Name field in Account
            Account Acc1 =[Select Name 
                           from Account 
                           where Name = 'Demo2'];                 
            Acc1.Phone = '12345';
            update Acc1; 
        
// Getting the updated field in Account
            Acc1 = [Select Phone 
                    from Account 
                    where Name = 'AA'];                        
                    system.debug(Acc1);

        } catch(Exception reqFieldMissingOnAccount) {
            system.debug(reqFieldMissingOnAccount.getMessage());
        }           
    }
}
