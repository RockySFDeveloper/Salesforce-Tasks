//Class to Automate Lead Assignment Rules 
public with sharing class LeadAssignmentRule {

    /*
        * Declaring Invocable method
        * Using DML option class to automate Assignment Rules
    */
    @InvocableMethod(Label='Lead Assignment using Apex'  category = 'Lead')
    public static void toGetLeadId(List<Id> leadIds) {

        try {
            Database.DMLOptions dbAction = new Database.DMLOptions();
            dbAction.assignmentRuleHeader.useDefaultRule = true;
            Lead leadRecords = [select Id from Lead where Lead.Id in :leadIds];
            leadRecords.setOptions(dbAction);
            update leadRecords;
        } catch(Exception blankValue) {
            system.debug('Blank value Exception Occurs'+blankValue.getMessage());
        }
    }
}
