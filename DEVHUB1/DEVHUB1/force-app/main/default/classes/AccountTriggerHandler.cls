public class AccountTriggerHandler {
    public static void ratingUpdate(List<Account> newList){
        for(Account acc: newList){
            if(acc.Industry!=Null && acc.Industry == 'Media'){
                acc.Rating ='Hot';
            }
        }
    }
    public static void createRelatedOpp(List<Account> newList){
        List<Opportunity> oppToBeInserted = new List<Opportunity>();
        for(Account acc : newList){
            Opportunity opp = new Opportunity();
            opp.Name=acc.Name;
            opp.AccountId=acc.Id;
            opp.StageName='Prospecting';
            opp.CloseDate=system.today();
            oppToBeInserted.add(opp);
        }
        if(!oppToBeInserted.isEmpty()){
            insert oppToBeInserted;
        }
    }
    
}