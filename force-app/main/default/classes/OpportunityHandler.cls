// Class to update and delete a values in Opportunity
public class OpportunityHandler {
    
    //Method to Update a values in Opportunity
    public static Opportunity toUpdateOpportunity(string oppName) {

        try {
            
            Opportunity opportunityInstance = [select Id, Name from Opportunity where Name = : oppName ];
            opportunityInstance.TotalOpportunityQuantity = 5;
            update opportunityInstance;
            return opportunityInstance;     
        } catch(Exception invalidInput) {
            
            system.debug(invalidInput.getMessage());
        }
    }  
    
    //Method to Delete a Record in Opportunity
    public static void toDeleteOpportunity(string oppName) {

        try {
            
            Opportunity opportunityInstance = [select Id from Opportunity where Name = :oppName];
            delete opportunityInstance;
        } catch(Exception nullValue){

            system.debug(nullValue.getMessage());
        }
    }  
}