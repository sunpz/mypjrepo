public with sharing class EmploySearchController {

    public String employResultList { get; set; }

    // 社員情報
    public List<Anken__c> ankenList {get; set;}
    public List<Employee__c> EmployeeList {get; set;}
    
    public String employeename {get; set;}

    public Boolean showDetail {get; set;}
    // システムエラーフラグ
    public Boolean isSystemErrorFlg {get; set;}
    // 件数制限
    private Integer limitInt = 1000;
    // 1ページにあたり件数
    private Integer pageSize = 50;
    // offset
    private Integer offsetInt = 0;
    // コンストラクタ
    public EmploySearchController() {
        this.employeename = '林田';
        this.isSystemErrorFlg = false;
    }
    /*
    * 機能 ：初期化
    * @param ：なし
    * @return：なし
     */
    
    public PageReference Init() {
        employeeList = [SELECT ID, FirstName__c, Sex__c,Age__c,EmployeeDivision__c,
        SmallMonthPrice__c,BigMonthPrice__c,JapaneseLevel__c,StartJobDay__c 
        FROM Employee__c ];
        
        ankenList = [SELECT ID, Name FROM Anken__c ];
        
        System.debug(employeeList[0].FirstName__c);
        return null;
    }
    
        /*
    * 機能 ：初期化
    * @param ：なし
    * @return：なし
     */
    
    public List<Employee__c> searchEmployeeList() {
       
        
       String parameter = System.currentPageReference().getParameters().get('FirstName__c');
        System.debug('1111111' + parameter);   
        String query = '';
        query += ' SELECT ';
        query += '  Id ';
        query += ' ,Name ';
        query += ' ,FirstName__c';
        query += ' ,Sex__c';
        query += ' ,Age__c';
        query += ' ,EmployeeDivision__c';
        query += ' ,SmallMonthPrice__c';
        query += ' ,BigMonthPrice__c';
        query += ' ,JapaneseLevel__c';
        query += ' ,StartJobDay__c ';
        query += ' FROM ';
        query += ' Employee__c';
        query += ' ORDER BY Name ASC ';
        query += ' LIMIT 200 ';
       return  database.query(query);

    }

}