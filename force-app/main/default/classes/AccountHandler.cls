public class AccountHandler {
    public static Account insertNewAccount(String strname){
        try{
            Account acc = new Account(Name = strname);
            insert acc;
            return acc;
            
        }catch(DMLException derr){
            return null;
        }
        
    }

}