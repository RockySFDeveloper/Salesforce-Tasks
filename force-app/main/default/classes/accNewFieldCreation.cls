// Class for created new field in Account
public class accNewFieldCreation {

    // Creating a Method to update Debugging field in Account
    public static void updateAccountField() {  

        try {

// Updating Debugging Field in Account
        Account accDebugField = [Select Debugging__c 
                                 from Account 
                                 where Name = 'Demo1'];          
        accDebugField.Debugging__c = 'Working';
        update accDebugField;

        system.debug(accDebugField);
        
// Retrieving the Updated field in Account
        /*Account getting = [Select Name, 
                           from Account 
                           where Debugging__c = 'Working 4'];     
        system.debug(getting); */

        } catch (Exception requiredFieldMissing) {

            system.debug(requiredFieldMissing.getMessage());
            
          }
    }
}