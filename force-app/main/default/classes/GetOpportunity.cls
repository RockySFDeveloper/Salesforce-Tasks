public with sharing class GetOpportunity {

    @AuraEnabled
    public static List<Opportunity> gettingOppRecords(){

       return [Select Name, StageName from Opportunity];
    }
}
