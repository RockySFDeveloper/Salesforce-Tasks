public with sharing class EmployeeCreation {

    @AuraEnabled
    public static string employeeInsert(Employee_Information_System__c employeeRecords, string file, string fileName) {

        string empId;
        insert employeeRecords;        
        empId = employeeRecords.Id;  
        String base64File = EncodingUtil.urlDecode(file, 'UTF-8');     
        ContentVersion contentVersionRecord = new ContentVersion();  
        contentVersionRecord.Title = fileName;  
        contentVersionRecord.PathOnClient = '/' + fileName;  
        contentVersionRecord.FirstPublishLocationId = employeeRecords.Id;  
        contentVersionRecord.VersionData = EncodingUtil.base64Decode(base64File);  
        contentVersionRecord.IsMajorVersion = true;  
        Insert contentVersionRecord;
        return empId;
    }
}
