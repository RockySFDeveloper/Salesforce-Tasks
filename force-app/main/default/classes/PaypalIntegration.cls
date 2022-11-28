public with sharing class PaypalIntegration {

    @AuraEnabled 
    @future(callout = true)
    public static void getPaypalDetails(string cardNumber, string expiryDate, string cvv) {

        PayPalAPI payer1 = new PayPalAPI();
        
    }
}
