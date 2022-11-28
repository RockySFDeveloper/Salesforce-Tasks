public with sharing class WeatherAPI {

    @future(callout = true)
    public static void cityWeatherDetails(String city) {

        string apiKey = '4111511e42c591ca2ab56f7eb911f8b8';
        String requestEndpoint = 'http://api.openweathermap.org/data/2.5/weather?'+'appid='+apiKey+'&q='+city;

        Http hyperProtocol = new Http();
        HttpRequest requestingServer = new HttpRequest();
        requestingServer.setEndpoint(requestEndpoint);
        requestingServer.setMethod('GET');
        HttpResponse hyperresponse = hyperProtocol.send(requestingServer);

        If(hyperresponse.getStatusCode() == 200) {

            Map<String, Object> allJsondata = (Map<String, Object>)Json.deserializeUntyped(hyperresponse.getBody());
            Map<String, Object> main = (Map<String, Object>)allJsondata.get('main');   
            system.debug(main.get('temp_max'));
        }
    }
}
//WeatherAPI.cityWeatherDetails('London');
