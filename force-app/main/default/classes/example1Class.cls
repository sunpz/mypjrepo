public class example1Class {
    public String name{get;set;}
    public example1Class(){}
    public pageReference init(){
        List<Account> accList=[select Id,Name from Account where Name='test'];
        if(accList.size() >0){
            system.debug('for test');
        }
        return null;
    }
}