public with sharing class AccessLevel {

// Method to access four layer Records
    public static void accessOf4Level() {    

        try {           

            Diary__c dia2 = [select Name, Contact__r.Account.Owner.CompanyName 
                             from Diary__c 
                             where Name = 'Dcheck'];
        system.debug(dia2);
    }

// Method to access five layer Records
    public static void accessOf5level() {   
                    
        Note__c not1 = [select Name, DiaryNote__r.Contact__r.Account.Owner.CompanyName 
                        from Note__c 
                        where Name = 'Ncheck'];
        system.debug(not1);
    }
    } catch (Exception al) {
        system.debug (al.getMessage());
    }
}