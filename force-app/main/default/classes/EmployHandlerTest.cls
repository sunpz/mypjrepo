@isTest
public class EmployHandlerTest {
    // Utility method that can be called by Apex tests to create price book entries.
    
     @testSetup 
     static void setup() {
        // Create common test accounts
        Employee1__c employeeIns = new Employee1__c();
        employeeIns.AddressCD__c ='2250045';
        employeeIns.Mail__c  ='test@gmail.com';
        employeeIns.ShimeiKatakana__c ='フジワラ'; 
        employeeIns.ShimeiKanji__c ='藤原';
        insert employeeIns; 
        AddressMaster__c addressMaster= new AddressMaster__c();
        addressMaster.name='2250030';
        addressMaster.Address__c='テスト住所';
               
    }
    @isTest 
    static void AfterUpdateTest() {
        // First, set up test price book entries.
        // Insert a test product.
        
        Employee1__c employee = [select id, AddressCD__c,Address1__c from Employee1__c where ShimeiKanji__c ='藤原']; 
        System.debug(employee);
        employee.AddressCD__c = '2250023';
        System.debug(employee.AddressCD__c);
        Test.startTest();
        update  employee;
        Employee1__c  employee2 = [select id, AddressCD__c,Address1__c from Employee1__c where ShimeiKanji__c ='藤原'];
		System.debug(employee2.Address1__c);
		System.assertEquals(employee2.Address1__c,'テスト住所');  
		Test.stopTest();
        // Next, perform some tests with your test price book entries.
    }
}