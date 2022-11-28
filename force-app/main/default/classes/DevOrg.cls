public class DevOrg {

    Account insertAccountOfVF;
    public DevOrg(ApexPages.StandardController getAccountOfVF) {
            
        this.insertAccountOfVF = (Account)getAccountOfVF.getRecord();
        Insert insertAccountOfVF;
    }

    @future(callout = true)
    public static void weatherDetails() {

        public pagereference save() {   
        string requestEndpoint = 'https://curious-bear-j6yxgi-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=Recent' ;

        Http hyperProtocol = new Http();
        HttpRequest requestingServer = new HttpRequest();
        requestingServer.setEndpoint(requestEndpoint);
        requestingServer.setMethod('GET');
        HttpResponse gettingResponse = hyperProtocol.send(requestingServer);

        If(gettingResponse.getStatusCode() == 200) {
           
            Account accountCreate = new Account();
            accountCreate.Name = insertAccountOfVF.Name;
            update accountCreate;
            system.debug(accountCreate);
        }
    }
}
