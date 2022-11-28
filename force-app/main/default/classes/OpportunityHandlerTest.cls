@isTest
public class OpportunityHandlerTest {
    
    // Initiating Test setup method to create a virtual Opportunity value
    @TestSetup static void toUpdateOpportunity() {

        List<Opportunity> listOfOpportunity = new List<Opportunity>();       
        for(integer opportunityLimit=1; opportunityLimit<=2; opportunityLimit++){
            
            Opportunity opportunityInstance = new Opportunity();
            opportunityInstance.Name = 'Dummy Opportunity '+opportunityLimit;
            opportunityInstance.StageName = 'Negotiation/Review';
            opportunityInstance.CloseDate = Date.parse('08/08/2022');
            opportunityInstance.TotalOpportunityQuantity = 2;
            listOfOpportunity.add(opportunityInstance);
        }
        insert listOfOpportunity;
	}
    
    /*
        * Calling a Class to update a value by parsing virtual value as a parameter
        * Checking Expected value and Actual value are same
    */
    @isTest static void checkingOpportunityUpdate() {

        Opportunity opportunityInstance = OpportunityHandler.toUpdateOpportunity('Dummy Opportunity 1');           
        system.assertEquals(5,opportunityInstance.TotalOpportunityQuantity);
    }
    
    /*
        * Calling a Class to delete a value by parsing virtual value as a parameter
        * Checking Expected value and Actual value are same
    */
    @isTest static void checkingOpportunityDelete() {
        
        OpportunityHandler.toDeleteOpportunity('Dummy Opportunity 2');
        Opportunity opportunityInstance = new Opportunity();
        system.assertEquals(null,opportunityInstance.TotalOpportunityQuantity);
    }
}