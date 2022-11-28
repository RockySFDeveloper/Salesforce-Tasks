trigger ContactBeforeInsert on Contact (before insert) {
    // Trigger.New hold new version of Contacts
    for(Contact contact: Trigger.new){
    contact.Description = 'Contact created successfully by using ContactBeforeInsert trigger';
    }
    // No Need to write DML statement, trigger. New will be take care.
    }
