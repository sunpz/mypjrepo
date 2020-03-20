public class MyController2 {
    Account account;

    public PageReference save() {
    try{
        update account;
    }
    catch(DmlException ex){
       System.Debug('ex'+ex);
        ApexPages.addMessages(ex);
    }
    return null;
    }

    public String getName() { 
        return 'MyController';
    }

    public Account getAccount() {
        if(account == null)
        account = [select id, name, numberofemployees, numberoflocations__c from Account
        where id = :ApexPages.currentPage().getParameters().get('id')];
        return account;
    }
}