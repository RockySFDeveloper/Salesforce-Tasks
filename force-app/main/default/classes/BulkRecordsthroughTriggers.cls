/* trigger BulkRecordsThroughTriggers on Account(before insert) {  

    List<Account> accountWithOppportunites = [SELECT Id,(
                                   SELECT Id,Name,CloseDate FROM Opportunities) 
                                   FROM Account 
                                   WHERE Id IN :Trigger.New];
  
    for(Account loopingOpportunitiesofAccounts : accountWithOppportunites) { 
        Opportunity[] relatedOpps = loopingOpportunitiesofAccounts.Opportunities;  
    }
} */
trigger BulkRecordsThroughTriggers on Account(before insert) {
    Account a = Trigger.New[0];
    a.Phone = '1122';
}
