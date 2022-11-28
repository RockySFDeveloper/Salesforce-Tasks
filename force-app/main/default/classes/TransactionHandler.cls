// Class to create Transaction Record 
public class TransactionHandler {
     
    /*
        * Parsing the updated Opportunity value in this method.
        * Initiating the loop to create 4 transaction Record which is link with updated Opportunity value.
        * Finally Inserting those values to create transaction.
    */
    public static void toCreateTransaction(List<Id> triggerValues) {

        try{
        List<Transaction__c> listTransaction = new List<Transaction__c>();
        for(Id opportunityId : triggerValues) {
            for(Integer transactionLimit=1; transactionLimit<=4; transactionLimit++) {

                Transaction__c createTransaction = new Transaction__c(Opportunity__c = opportunityId);
                createTransaction.Name = 'Test Transaction'+transactionLimit;
                listTransaction.add(createTransaction);
            }
        }
        insert listTransaction;
        } catch (Exception wrondIds) {
            system.debug(wrondIds);
        }
    }  
}


