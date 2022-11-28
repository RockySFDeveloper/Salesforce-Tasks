trigger InsertContIfAccIsCreated on Account (after insert) {

    list<lead> listOfLead = new list<lead>();
    for (Integer i=1; i<=200; i++) {
            
        lead instanceOfLead = new lead();
        instanceOfLead.LastName = 'Trigger Lead'+i;
        instanceOfLead.Company = 'some Company'+i;
        listOfLead.add(instanceOfLead);           
    }      
    insert listOfLead;
    system.debug(listOfLead);
    /*
    list<Contact> listOfContact = new list<Contact>();
    	for (Integer i=1; i<=50; i++) {
            
		Contact instanceOfContact = new Contact();
        instanceOfContact.LastName = 'Trigger Contact';
        listOfContact.add(instanceOfContact);
            
        }
        
        insert listOfContact;
        system.debug(listOfContact);
    */
}