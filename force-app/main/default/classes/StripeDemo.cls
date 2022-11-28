public with sharing class StripeDemo {

    public static void toCreateCustomer() {

        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST'); 
        request.setEndpoint('https://api.stripe.com/v1/customers');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');    
        request.setHeader('Authorization','Bearer '+accessToken );
        String body = 'name=Karthika R&email=xyz@gmail.com&description=First Customer';
        HttpResponse response = new HttpResponse();
        request.setBody(body);
        response = httpCall.send(request);
        String responseBody = response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    public static void setPaymentMethod() {

        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.stripe.com/v1/payment_methods');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        String bodyRequest = 'type=card'+'&card[number]=4000000760000002&card[exp_month]=12&card[exp_year]=2024&card[cvc]=123';
        request.setBody(bodyRequest);
        HttpResponse response = httpCall.send(request);
        String responseBody = response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    public static void linkCustomerWithCard () {

        String CustomerId = 'cus_MjSmwK3EqaPFuz';   // Rakesh Id
        String cardId = 'pm_1M004LSF7A1E8pgyWJf1m8pp';
        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');          
        request.setEndpoint('https://api.stripe.com/v1/payment_methods/'+cardId+'/attach');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        request.setBody('customer='+CustomerId);
        HttpResponse response = httpCall.send(request);
        String responseBody = response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    public static void setBankPayment() {

        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.stripe.com/v1/tokens');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        String bodyRequest ='bank_account[country]=US&bank_account[currency]=USD&bank_account[account_holder_name]=Rakesh R&bank_account[account_holder_type]=Individual&bank_account[routing_number]=110000000&bank_account[account_number]=000123456789';
        request.setBody(bodyRequest);
        HttpResponse response = httpCall.send(request);
        String responseBody = response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    public static void linkCustomerWithBankAccount() {

        String customerId = 'cus_MjSsvzslc237wV';           //Karthika Id
        String bankId = 'btok_1M009ZSF7A1E8pgyJEivfH6f';        
        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://api.stripe.com/v1/customers/'+customerId+'/sources');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        request.setBody('source='+bankId);
        HttpResponse response = httpCall.send(request);
        String responseBody = +response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    public static void verifyAccount() {

        String CustomerId = 'cus_MjSsvzslc237wV';           //Karthika Id
        String bankId = 'ba_1M009WSF7A1E8pgyqGRhXWSj';
        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');            
        request.setEndpoint('https://api.stripe.com/v1/customers/'+CustomerId+'/sources/'+bankId+'/verify');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        request.setBody('amounts[]=32&amounts[]=45');
        HttpResponse response = httpCall.send(request);
        String responseBody = +response.getBody();
        system.debug('Response Body ====>'+responseBody);
    }

    @AuraEnabled
    public static String getDetails(Integer accountNumberFromUser) {
    
        String customerId = 'cus_MjSsvzslc237wV';            
        String accessToken = 'sk_test_51LzuboSF7A1E8pgyLVN2HdA4idtPgAd9M1q2IGXnfkQZ6lWVn2t7UexMPF628qUTZ9O8SnuECtBtF6ru0IwPoB2B00yZSpo800';
        String endResult = 'none';
        Http httpCall = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://api.stripe.com/v1/customers/'+customerId+'/sources');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization','Bearer '+accessToken);
        HttpResponse response = httpCall.send(request);
        String responseBody = +response.getBody();        
        system.debug('Response Body ====>'+responseBody);

        If(response.getStatusCode() == 200) {

            Map<String, Object> allJsondata = (Map<String, Object>)Json.deserializeUntyped(response.getBody());
            Object getData = allJsondata.get('data');
            system.debug(' getValues ====>'+getData);        
            String ConvDataToString = String.valueOf(getData);
            Integer startIndex = ConvDataToString.indexOf('last4=');
            Integer endIndex = startIndex+10;
            String accountNumberInString = ConvDataToString.substring(startIndex+6, endIndex );
            Integer accountNumber = Integer.valueOf(accountNumberInString); 

            If(accountNumber == accountNumberFromUser) {
               
                endResult = 'success';             
            } else {
                endResult = 'error';
            }   
        }
        return endResult;
    }

    @AuraEnabled
    public static Opportunity getOpportunityDetails(Id oppIdFromlwc) {

        Opportunity oppValues = [select Id,Amount,Payment_Status_Org__c from Opportunity where Id = :oppIdFromlwc];     
        if(oppValues.Amount != Null) { 

            return oppValues;
        } else { 

            return null;
        }      
    }
}

/* 
    StripeDemo.toCreateCustomer();
    StripeDemo.setPaymentMethod();
    StripeDemo.linkCustomerWithCard();
    StripeDemo.setBankPayment();
    StripeDemo.linkCustomerWithBankAccount();
    StripeDemo.verifyAccount();
    StripeDemo.getDetails(6789);
    StripeDemo.getOpportunityDetails('0065j00000kWZceAAG');
*/
