// Class for making updation in Opportunity Record
public class opportunitySuperClass {

    // Method to Update Opportunity Amount by 1000
    public static void updatingOppAmountBy1000(string opportunityName) {

        Opportunity holdingOpportunityRecords = new Opportunity();
        holdingOpportunityRecords = [Select Amount 
                                     from Opportunity 
                                     where Name = :opportunityName];      
        holdingOpportunityRecords.Amount = holdingOpportunityRecords.Amount + 1000;
        update holdingOpportunityRecords;
        system.debug(holdingOpportunityRecords);

    }
}
