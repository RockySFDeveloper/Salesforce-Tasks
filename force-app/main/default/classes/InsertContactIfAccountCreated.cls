trigger InsertContactsIfAccountTypeIsProspect on Account (after insert) {

    list<Contact> listOfContact = new list<Contact>();
        for(Account loopAccountRecords : trigger.new) {

            Contact instanceOfContact = new Contact();
            instanceForContact.LastName = 'Working';
            // instanceForContact.AccountId = loopingAccountRecords.Id;
            listOfContact.add(instanceOfContact);
        }

        insert listOfContact;
        system.debug(listOfContact);
    }