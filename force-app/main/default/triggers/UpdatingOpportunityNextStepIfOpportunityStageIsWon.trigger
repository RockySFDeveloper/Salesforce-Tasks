trigger UpdatingOpportunityNextStepIfOpportunityStageIsWon on Opportunities (before insert) {
    if()
    list<Opportunity> listOfOpportunity = new list<Opportunity>();
    /* 
    listOfOpportunity = [select Name, NextStep, 
                         from Opportunity
                         where CloseDate = date.parse(07/30/2022) ];
    */
    for(Opportunity loopingOpportunityRecords : listOfOpportunity ) {
        Opportunity instanceOfOpportunity = new Opportunity();
        instanceOfOpportunity.NextStep = 'Success';
        listOfOpportunity.add(instanceOfOpportunity);
    }
    update listOfOpportunity;

}