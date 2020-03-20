public class NewAndExistingController {

    public Account account { get; private set; }

    public NewAndExistingController() {
        Id id = ApexPages.currentPage().getParameters().get('id');
         System.debug(id );
        account = (id == null) ? new Account() : 
            [SELECT Name, Phone, Industry FROM Account WHERE Id = :id];
    }

    public PageReference save() {
        try {
                 System.debug('start' );
            upsert(account);
                     System.debug('end' );
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        //  After successful Save, navigate to the default view page
        PageReference redirectSuccess = new ApexPages.StandardController(Account).view();
        return (redirectSuccess);
    }
}