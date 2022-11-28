public with sharing class JobAPI {

    /*
        * Declaring Future method to call out External services to find the citites maximum temperature.
        * Then Holding the URL in custom settings and Initiating the HTTP request and response.
        * After that converting Json format into Primitve datatypes.
        * Then Updating city maimum temperature into the created Account details.
    */
    @future(callout = true)
    public static void jobDetails() {       

        string requestEndpoint = 'https://www.themuse.com/api/public/jobs?company=Frontpoint&company=Spryker&company=Persado&company=Klaviyo&company=Sedera&company=Accenture&category=Accounting&category=Accounting%20and%20Finance&category=Account%20Management&category=Advertising%20and%20Marketing&category=Animal%20Care&category=Business%20Operations&category=Computer%20and%20IT&category=Construction&category=Corporate&category=HR&category=IT&level=Entry%20Level&level=Mid%20Level&level=Senior%20Level&level=management&level=Internship&page=10&descending=true&33deca95f09e6d2bef46e2451724085c6263ef43483f46352334b9053100aeca';
        system.debug('requestEndpoint =====>'+requestEndpoint);

        Http hyperProtocol = new Http();
        HttpRequest requestingServer = new HttpRequest();
        requestingServer.setEndpoint(requestEndpoint);
        requestingServer.setMethod('GET');
        HttpResponse gettingResponse = hyperProtocol.send(requestingServer);
        system.debug('gettingResponse =====>'+gettingResponse);
        
        // Using Try catch exception if any 'Page not found' or Null Exception Occurs
        try {

            If(gettingResponse.getStatusCode() == 200) {
               
                Map<String, Object> allJsonData = (Map<String, Object>)Json.deserializeUntyped(gettingResponse.getBody());
                system.debug('Jobs =====>'+allJsonData);
                Integer externalWebsiteData = allJsonData.get('total');
                system.debug('Total Jobs =====>'+externalWebsiteData);
            }
        } catch(Exception pageNotFound) {
            system.debug('The Request you search in this website is not Available : '+pageNotFound.getMessage());
        }                 
    }
}
