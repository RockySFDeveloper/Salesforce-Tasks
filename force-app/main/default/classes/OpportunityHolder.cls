// Class to fetch all Opportunity Records
public with sharing class OpportunityHolder {

    /* 
        * Declaring the Method as Aura
        * Searching Opportunity Records which are related to Opportunity Name which comes as Parameter
        * Throwing Exception if error is found
    */
    @AuraEnabled
    public static list<Opportunity> getOpportunityDetails(String opportunityName, string stageName) {

        try{
            opportunityName = '%' + opportunityName + '%';
            stageName = '%' + stageName + '%';
            
            If(String.isBlank(opportunityName) && String.isBlank(stageName)){
                throw new AuraHandledException('Record not Found');
            }

            if(String.isBlank(stageName)){
                list<Opportunity> opportunityList1 = [SELECT  Id, Name, AccountId, CloseDate, StageName From Opportunity WHERE Name LIKE :opportunityName];
                return opportunityList1;
            }else{
                list<Opportunity> opportunityList2 = [SELECT  Id, Name, AccountId, CloseDate, StageName From Opportunity WHERE Name LIKE :opportunityName AND StageName LIKE :stageName];    
                return opportunityList2;
            }
        }catch(Exception blankValue) {
            system.debug('Blank value Exception Occurs'+blankValue.getMessage());
        }
    }
}