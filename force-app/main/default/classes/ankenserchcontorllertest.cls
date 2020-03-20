@istest
public class ankenserchcontorllertest {

    static testMethod void unitTest01(){
        Applicant__c app =new Applicant__c();
        app.FirstName__c='太郎';
        insert app;
        
        Employee__c em = new Employee__c();
        em.FirstName__c=app.FirstName__c;
        em.LastName__c=app.LastName__c;
        insert em;
        
        Anken__c anken = new anken__c();
        anken.Account__c = app.id;
        anken.Level__c = '至急';
        insert anken;
       
        Test.startTest();
        PageReference pageRef = Page.AnkenSearch;
        system.debug('test em.id = ' + em.Id);
        
        pageRef.getParameters().put('id',em.Id);
        Test.setCurrentPage(pageRef);
        AnkenSearchController2 ctrl = new AnkenSearchController2();
        ctrl.init();
        Test.stopTest();        
        
    }
    
    
    
}