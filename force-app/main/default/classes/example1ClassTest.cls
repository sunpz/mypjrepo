@isTest
private class example1ClassTest {
    static testMethod void unitTest1(){
        Account acc = new Account(Name='test');
        insert acc;
        
        test.startTest(); 
        example1Class ex1 = new example1Class(); 
        ex1.name = 'test1';
        ex1.init();
        test.stopTest();
    }
}