// Update Lead at Scheduled Time using Schedule method
public with sharing class ScheduleBatchApex implements Schedulable{

    // Calling batch method to update lead 'Annual Revenue'
    public void execute(SchedulableContext schdContext) {

        Database.executeBatch(new LeadUpdateBatch());
    }
}
