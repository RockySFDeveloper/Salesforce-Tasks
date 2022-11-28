public with sharing class OpportunityController {
   
    @AuraEnabled
    public static List<Opportunity> getAllStages(){

        return [Select Name, StageName from Opportunity];
    }
 }