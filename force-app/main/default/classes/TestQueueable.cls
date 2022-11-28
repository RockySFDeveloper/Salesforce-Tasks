// Delete Account using Queueable
public class TestQueueable implements Queueable {

    // Calling another Queueable to delete one more record in Account
    public void execute(QueueableContext queContext) {

        Delete [select Id from Account where Name = 'Acc l5'];
        system.enqueueJob(new TestQueueable2());
    }
}
