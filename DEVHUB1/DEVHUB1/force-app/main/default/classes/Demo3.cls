public class Demo3 {
    public static void updateOpportunityDescription(){
        List<Opportunity> oppList = [SELECT Id , Name, StageName, CloseDate FROM Opportunity where createddate= LAST_Week ];
            if(!oppList.isEmpty()){
                for( Opportunity opp :oppList){
                    if(opp.StageName=='Closed Won'){
                        opp.Description='Opportunity is Closed Won';
                    }
                    else if(opp.StageName == 'Closed lost'){
                        opp.Description='Opportunity is Closed Lost';
                    }
                }
            }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
 
}