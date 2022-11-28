public with sharing class BatchCompletionMail {
    public static void sendEmailWithoutTemplate(Id batchId) {

        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        String [] toAddresses = new String[]{'hplaptop13092018@gmail.com','aravindk6322@gmail.com'};

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Id '+batchId+' done Successfully');
        mail.setToAddresses(toAddresses);
        mailList.add(mail);

        if(!mailList.isEmpty())
            Messaging.sendEmail(mailList);
    }
}
