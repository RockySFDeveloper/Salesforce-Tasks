// Trigger to create Contact through Account using Queueable Method
trigger AccountTriggerForContact on Account (after insert) {

    if(Trigger.isAfter && Trigger.isInsert) {

        system.enqueueJob(new CreateContactQueueable(Trigger.new));
    }
}