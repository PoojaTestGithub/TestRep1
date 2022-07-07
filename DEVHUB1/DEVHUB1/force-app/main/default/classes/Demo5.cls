public class Demo5 {
    public static void updatetheAccountPhone(){
        List<Contact> conList =[SELECT id, FirstName,Phone, Account.Phone from Contact where AccountID!=NUll];
        if(!ConList.isEmpty()){
            for(Contact con: conList){
                If(Con.phone==NULL){
                    Con.phone=con.Account.phone;
                }
            }
        }
        if(!ConList.isEmpty()){
            update conList;
        }
    }

}