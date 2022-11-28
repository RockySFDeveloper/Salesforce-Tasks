global with sharing class sampleBatchApex implements Database.Batchable<sObject>{
    private static String query='';
    private static String whereClause='';


    global Database.QueryLocator start(Database.BatchableContext BC){
      query='Select Id,Name from Account';
      return Database.getQueryLocator(query+' '+whereClause);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
        system.debug('do something here');
    }

    global void finish(Database.BatchableContext BC){

    }
}