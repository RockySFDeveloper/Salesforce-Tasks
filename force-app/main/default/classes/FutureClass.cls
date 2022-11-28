public class FutureClass {

    @future(callout = true)
    public static void futureCalloutMethod(Decimal eur) {
        Decimal inr= 0.0;

        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();

        req.setEndpoint('https://api.exchange ratesapi.io/latest'); 
        req.setMethod('GET');

        HTTPResponse res = h.send(req);
        Map<String, Object> jsonBody = (Map<String, Object>)Json.deserializeUntyped(res.getBody());
        System.debug(jsonBody);

        Map<String, Object> mMap = (Map<String, Object>) jsonBody.get('rates');
        Decimal conversionRate = (Decimal) mMap.get('INR');
        inr = eur * conversionRate;
        System.debug(inr);
    }

    @future(callout=true)    
    public static void myFutureMethod(Set<Id> ids) {

        // Get the list of contacts in the future method since
        // you cannot pass objects as arguments to future methods
        List<Contact> contacts = [SELECT Id, LastName, FirstName, Email
                                  FROM Contact 
                                  WHERE Id IN :ids];

        // Loop through the results and call a method
        // which contains the code to do the actual callout
        for (Contact con: contacts) {

            String response = anotherClass.calloutMethod(con.Id, con.FirstName, con.LastName, con.Email);
            // May want to add some code here to log
            // the response to a custom object
        }
    }
    
}
