public with sharing class CardDemo {

    public static void getCardDetails() {

        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('Post');
        request.setEndpoint('https://api.stripe.com/v1/payment_methods');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        String bodyRequest = 'type=card'+'&card[number]=4242424242424242&card[exp_month]=12&card[exp_year]=2024&card[cvc]=123';
        request.setBody(bodyRequest);
        HttpResponse response = http.send(request);
        String responseBody = response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }
}
