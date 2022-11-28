public with sharing class StoringJobId {
    @AuraEnabled
    public static Id storeId(Id getId) {
        Id getPassingId ;
        getPassingId = getId;
        System.debug('getPassingId ====>'+getPassingId);
        return getId;
    }
}
