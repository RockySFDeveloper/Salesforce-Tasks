public class CreatingContacts {   
        
    Account InsertAccountOfVF;
    public CreatingContacts(ApexPages.StandardController getAccountOfVF) {
            
        this.InsertAccountOfVF = (Account)getAccountOfVF.getRecord();
    }
    
    public pagereference save() {   
        
        Insert InsertAccountOfVF; 
        list<Contact> listOfContact = new  list<Contact>();
        for(Integer loopForNewContact = 1; loopForNewContact <= 10; loopForNewContact++) {

            Contact createNewContact = New Contact(LastName = InsertAccountOfVF.Name, AccountId = InsertAccountOfVF.id );
            listOfContact.add(createNewContact);
        }        
            
        Insert listOfContact;
        String holdURL;
        holdURL = 'https://csk37-dev-ed--c.visualforce.com/apex/CreatingAccount?core.apexpages.request.devconsole=1&id=' ;
        
        Pagereference referOnContactRecords = New PageReference(holdURL+InsertAccountOfVF.Id);
        return referOnContactRecords;
    } 
}