@isTest 
public class TransactionHandlerTest {

    //Initiating Test setup method to create and update a virtual value for calling function in test method
    @TestSetup static void toCreateOpportunity() {

        List<Opportunity> listOfOpportunity = new List<Opportunity>();
        List<Id> listOfIds = new List<Id>();
        for(integer opportunityLimit=1; opportunityLimit<=5; opportunityLimit++) {
            Opportunity opportunityInstance = new Opportunity();
            opportunityInstance.Name = 'Test Opportunity Practice '+opportunityLimit;
            opportunityInstance.StageName = 'Negotiation/Review';
            opportunityInstance.CloseDate = Date.parse('08/08/2022');
            listOfOpportunity.add(opportunityInstance);
        }
        insert listOfOpportunity;

        List<Opportunity> listOfOpportunity2 = new List<Opportunity>();
        for(Opportunity opportunityInstance : listOfOpportunity) {
            opportunityInstance.StageName = 'Closed Won';
            listOfOpportunity2.add(opportunityInstance);
        }  
        update listOfOpportunity2;
    }    

    /* 
        * Initiating Test method to check class 
        * Getting a created virtual value for test method and passing into the method
        * creating a list to hold a wrong Ids for covering catch statement in 'Transaction Handler class'
    */
    @isTest static void testTransactionOfOpportunity() {

        List<Opportunity> getOpportunityUpdatedValue = [select Id from Opportunity where Name like 'Test Opportunity Practice%' ]; 
        List<Id> opportunityFailedIds = new List<Id>{'0065j00000naQezLAE','0065j00000naQf0LAE','0065j00000naQf1LAE','0065j00000naQf2ALE','0065j00000naQf3APE'};
        List<Id> opportunityIds = new List<id>();   
        for(Opportunity opp : getOpportunityUpdatedValue){
            opportunityIds.add(opp.Id);
        }

        TransactionHandler.toCreateTransaction(opportunityIds);
        TransactionHandler.toCreateTransaction(opportunityFailedIds);
    }
}
