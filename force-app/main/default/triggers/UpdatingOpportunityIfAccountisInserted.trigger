trigger UpdatingOpportunityIfAccountisInserted on Account (after insert) {

    list<Opportunity> filteredOpportunites = [Select Id, Name, StageName
                                              From Opportunity
                                              Where NextStep = 'checking'];

    list<Opportunity> opportunityList = new list<Opportunity>();
    for(Opportunity loopingOpportunityRecords : filteredOpportunites) {    

            loopingOpportunityRecords.StageName = 'Closed Won';
            opportunityList.add(loopingOpportunityRecords); 

    }  
    update opportunityList;
}