/*
    * Trigger to create Account with city temperature by calling Future method
*/
trigger AccountMapTrigger on Account (after insert) {

    string accountCity;
    Id recordId;

    // Using Try catch to identify a blank value

    If(Trigger.isInsert) {

        for(Account accountDetail : Trigger.new) {

            if(accountDetail.billingCity != null) {

                accountCity = accountDetail.billingCity;
                recordId = accountDetail.Id;
            }
        }
    }       
    WeatherSearch.weatherDetails(accountCity, recordId);
}
