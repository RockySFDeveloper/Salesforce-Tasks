public with sharing class EmailUtility {

    public static void sendEmailWithoutTemplate(string errorMessage) {

        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        String [] toAddresses = new String[]{City_Atmosphere__c.getInstance().Email__c};

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject(City_Atmosphere__c.getInstance().Email_Subject__c);
        mail.setPlainTextBody(City_Atmosphere__c.getInstance().Email_Body__c+errorMessage);
        mail.setToAddresses(toAddresses);
        mailList.add(mail);

        if(!mailList.isEmpty())
            Messaging.sendEmail(mailList);
    }
}
