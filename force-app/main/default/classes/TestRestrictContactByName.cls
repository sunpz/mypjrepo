@isTest
public class TestRestrictContactByName {
    @isTest static void Test() {
        Contact cont = new Contact(FirstName = 'xyzFirst',
        LastName = 'INVALIDNAME',
        Email = 'xyzmail@mail.com'
        );
    Test.startTest();
       Database.SaveResult result = Database.insert (cont,false);
    Test.stopTest();
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('The Last Name ',result.getErrors()[0].getMessage()); 
    }
}