//Class to get all Contact Record
public with sharing class LWCApexClass {

    /* 
        * Enabling Aura Enabled
        * Fetching all contact Records
    */
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts(){
        
        try {
            List<Contact> fetchContactRecords = [select Id, LastName, Phone from contact];       
            return fetchContactRecords;          
        } catch(Exception systemError) {
            system.debug(systemError.getMessage());
        }
    }
}
