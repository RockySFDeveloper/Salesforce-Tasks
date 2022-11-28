// Delete Account at Scheduled time using schedule method
public class ScheduleQueueableApex implements Schedulable{
    
    // Calling Queueable method to delete account Records
    public void execute(SchedulableContext schdlContext) {

        system.enqueueJob(new TestQueueable());
    }
}
