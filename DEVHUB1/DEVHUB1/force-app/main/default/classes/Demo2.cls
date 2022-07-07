public class Demo2 {
    public static void updatePhoneNumber(){
        List<Account> accList = [SELECT Id, Name from Account where createdDate = LAST_WEEK ];
        if(!accList.isEmpty()){
        for ( Account acc: accList){
            acc.Phone ='1234567890';
        }
        }
        if(!accList.isEmpty()){
            system.debug('accList'+accList);
        update accList;
        }
    }
   
}