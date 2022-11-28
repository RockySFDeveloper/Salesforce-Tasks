//Class to Automate Case Assignment Rules
public with sharing class CaseAssignmentRule {
   
    /*
        * Declaring Invocable method
        * Using DML option class to automate Assignment Rules
    */
    @InvocableMethod(Label='Case Assignment using Apex'  category = 'Case')
    public static void toGetCaseId(List<Id> CaseIds) {

        try{
    
            Database.DMLOptions dbAction = new Database.DMLOptions();
            dbAction.assignmentRuleHeader.useDefaultRule = true;
            Case CaseRecords = [select Id from Case where Case.Id in :CaseIds];
            CaseRecords.setOptions(dbAction);
            update CaseRecords;
        } catch(Exception blankValue) {
            system.debug('Blank value Exception Occurs'+blankValue.getMessage());
        }
    }    
}
