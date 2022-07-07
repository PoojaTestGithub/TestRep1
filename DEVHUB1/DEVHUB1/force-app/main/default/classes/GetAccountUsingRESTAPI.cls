// It will callout Apex class of Target Org and return you 10 Accounts for SF to SF Integration.
// It is Source Org Code.
public class GetAccountUsingRESTAPI {
    private final String clientId = '3MVG9n_HvETGhr3CNtkMRQRYy5OQTCwt_K51B_RM6M1nu2j.I_txfCrINzbOpgrVWmTzpjSOCn5V17_MAKwG4';
    private final String clientSecret = 'A66FAB42E5F2A02F9CCBA51D3A64A6F4C5F73BFE0F5EBF313F9DB6E353081C42';
    private final String username = 'poojaktp955@gmail.com';
    private final String password = 'Algo@1234';
    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    public String ReturnAccessToken (GetAccountUsingRESTAPI acount)
    {
        system.debug('@@@@ acount'+ acount);
        String reqbody = 'grant_type=password' + '&client_id='+clientId +
            '&client_secret='+clientSecret + '&username='+username + '&password='+password;
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://poojarajput19-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse res = h.send(req);
        system.debug('@@@@ res' +res);
        deserializeResponse response = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
        system.debug('@@@@access_token@@'+response );
        system.debug('@@@@ response.access_token'+response.access_token);
        system.debug('@@@@ response.id'+response.id);
        return response.access_token;
    }
    public static list<account> callGetAccount()
    {
        GetAccountUsingRESTAPI acount1 = new GetAccountUsingRESTAPI();
        system.debug('@@@@ acount1'+acount1);
        String accessToken;
        accessToken = acount1.ReturnAccessToken (acount1);
        
        list<account> ListAccount=new List<account>();
        if(accessToken != null) {
            String endPoint = 'https://poojarajput19-dev-ed.my.salesforce.com/services/apexrest/v1/getAccounts/';
            Http h2 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + accessToken);
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse res1 = h2.send(req1);
            
            String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
            system.debug('@@@RESPONSE@@'+trimmedResponse);
            JSONParser parser = JSON.createParser(res1.getBody());
            system.debug('@@@@ parser'+ parser);
            set<account> accList=new set<account>();
            
            while (parser.nextToken() != null) {
                if((parser.getCurrentToken() == JSONToken.FIELD_NAME) ) {
                    //system.debug('@@@@ parser.getCurrentToken()'+parser.getCurrentToken());
                    //system.debug('@@@@ JSONToken.FIELD_NAME'+JSONToken.FIELD_NAME);
                    Account acc;
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                        //system.debug('@@@@ parser.getCurrentToken()'+parser.getCurrentToken());
                        //system.debug('@@@@ JSONToken.FIELD_NAME'+JSONToken.FIELD_NAME);
                        parser.nextToken();
                        //system.debug('@@@@ parser.nextToken()'+parser.nextToken());
                        String sId= parser.getText();
                       // system.debug('@@@@ parser.getText()'+parser.getText());
                        acc=new Account();
                        acc.Id=sId;
                        //system.debug('Id@@@' + sId);
                        parser.nextToken();
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Name')) {
                            parser.nextToken();
                            string sName= parser.getText();
                            acc.Name=sName;
                            system.debug('Name@@@' + sName );
                        }
                    }
                    accList.add(acc); 
                }
                accList.remove(null);
            }
            ListAccount.AddAll(accList);
            system.debug('AccountList@@@@'+Json.serialize(ListAccount));
        }
        return ListAccount;
    }
}