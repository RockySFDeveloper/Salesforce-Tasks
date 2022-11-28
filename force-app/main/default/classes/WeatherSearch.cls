//Program to find city weather details
public with sharing class WeatherSearch {
    
    /*
        * Declaring Future method to call out External services to find the citites maximum temperature.
        * Then Holding the URL in custom settings and Initiating the HTTP request and response.
        * After that converting Json format into Primitve datatypes.
        * Then Updating city maimum temperature into the created Account details.
    */
    @future(callout = true)
    public static void weatherDetails(String city, Id accountId) {       

        string requestEndpoint = City_Atmosphere__c.getInstance().Atmosphere_URL__c+city;

        Http hyperProtocol = new Http();
        HttpRequest requestingServer = new HttpRequest();
        requestingServer.setEndpoint(requestEndpoint);
        requestingServer.setMethod('GET');
        HttpResponse gettingResponse = hyperProtocol.send(requestingServer);
        
        // Using Try catch exception if any 'Page not found' or Null Exception Occurs
        try {

            If(gettingResponse.getStatusCode() == 200) {
               
                Map<String, Object> allJsonData = (Map<String, Object>)Json.deserializeUntyped(gettingResponse.getBody());
                Map<String, Object> externalWebsiteData = (Map<String, Object>)allJsonData.get('main'); 
            
                Account accountCreate = new Account(Id = accountId);
                accountCreate.Debugging__c = string.valueOf(externalWebsiteData.get('temp_max'));
                update accountCreate;

                system.debug(externalWebsiteData.get('temp_max'));
            }
        } catch(Exception pageNotFound) {
            system.debug('The Request you search in this website is not Available : '+pageNotFound.getMessage());
            EmailUtility.sendEmailWithoutTemplate(pageNotFound.getMessage());
          }                 
    }
}
