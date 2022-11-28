// Initiating Test Class
@isTest
public with sharing class OpportunityHolderTest {
    
    //Method to create Demo values to check classes
    @isTest static void toCreateOpportunity() {

        string blankOppName, oppName, blankStageName, StageName;
        blankOppName = '';
        blankStageName = '';
        oppName = 'Edge';
        StageName = 'Closed Won';

        OpportunityHolder.getOpportunityDetails(blankOppName,blankStageName);
        OpportunityHolder.getOpportunityDetails(oppName,StageName);
        OpportunityHolder.getOpportunityDetails(oppName,blankStageName);
    }
}
