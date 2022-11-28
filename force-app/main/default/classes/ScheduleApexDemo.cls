public with sharing class ScheduleApexDemo implements Schedulable {

    public void execute(SchedulableContext schContext) {

        Account accountInstance = new Account(Name = 'Schedule Apex');
        insert accountInstance;
    }
}
