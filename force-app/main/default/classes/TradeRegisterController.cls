public class TradeRegisterController {
 	 public List<AnkenResult> AnkenResultList {get; set;}

    // 取引明細情報
    public List<torihikiMeisai__c> torihikiMeisaiList {get; set;}
    // 決済明細情報
    public List<kesaiMeisai__c> kesaiMeisaiList {get; set;}
    
    // 収支区分	
    public String  shusiKubun {get; set;}
    // 管理番号	
    public String  kanriNmu {get; set;}
    // 取引日	
    public Date torihikiDate {get; set;}
    // 支払期日	
    public Date shiharaiDate {get; set;}
    // 取引先	
    public String torihikisakiCd {get; set;}
    // 社員	 
    public String shainCd {get; set;}
    // 概要	
    public String comment {get; set;}
    // 伝票番号	
    public String denpyoNum {get; set;}
    
    //画面モード
    private String mode = '';
    
    // システムエラーフラグ
    public Boolean isSystemErrorFlg {get; set;}
    // 件数制限
    private Integer limitInt = 1000;
    // 1ページにあたり件数
    private Integer pageSize = 50;
    // offset
    private Integer offsetInt = 0;

    // 案件情報
    public Anken__c ank {get; set;}   

    // コンストラクタ
    public TradeRegisterController() {
    	//this.mode= pmode;
    }


    /*
    * 機能 ：初期化
    * @param ：なし
    * @return：なし
    */
    public pageReference init() {
     //   employeeId = System.currentPageReference().getParameters().get('id');
        try{
            this.isSystemErrorFlg = false;
           
            //親画面のIDをパラメータから取得
            //this.mod =System.currentPageReference().getParameters().get('mod');
            if (this.mode  == null){
                this.isSystemErrorFlg = true;
                Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, 'パラメータエラー'));
                return null;
            }
            
            //新規の場合
            if(this.mode == '1') {
            	//初期化
            	formInit();
            } else {
       
            	formInit();
            }
            
            
          /* 
            employeeId = system.ApexPages.currentPage().getParameters().get('id');

            this.AnkenResultList = new List<AnkenResult>();
            this.showDetail = false;
            torihikiMeisaiList = new List<Employee__c>();

            // 社員情報の取得
            torihikiMeisaiList = EmployeeDao.getEmployeeRecById(employeeId);
            if (torihikiMeisaiList.size() == 0) {
                this.isSystemErrorFlg = true;
                Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, '社員情報は存在しません'));
                return null;
            }

            // 検索情報の作成
            String strSoqlWhere = setSoqlCondition(this.torihikiMeisaiList);


            // レコード件数の取得
            Integer AnkenListSize = AnkenDao.getAnkenCount(strSoqlWhere, this.limitInt+1);
            // 一覧のヒット件数が最大件数を超える場合
            if (AnkenListSize > this.limitInt) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, this.limitInt + '件を超えています'));
            }

            // データの検索
            List<Anken__c> AnkenList = AnkenDao.getAnkenListByCondition(strSoqlWhere, this.pageSize, this.offsetInt);
system.debug('★★★★★★★★★★★★★★'+AnkenList.size());
            if (AnkenList.size() == 0) {
                this.showDetail = true;
                Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.INFO, '検索結果は0件です'));
                return null;
            }
 */
        }catch(Exception e) {
            this.isSystemErrorFlg = true;
            ApexPages.Message msg;
            msg = new ApexPages.Message(
                           ApexPages.Severity.ERROR, 'システムエラーが発生しました' + e.getMessage() + e.getLineNumber() +']'
            );
            ApexPages.addmessage(msg);
        }
        return null;
    }
    
    /*
     * 機能名：案件レコード件数の取得
     * @param employList 社員レコードリスト
     * @return 案件検索条件
     */
    private void formInit() {
    	
    	// 収支区分	
	    this.shusiKubun='支出';
	    // 管理番号	
	    this.kanriNmu = '';
	    // 取引日	
	    this.torihikiDate = null;
	    // 支払期日	
	    this.shiharaiDate = null;
	    // 取引先	
	    this.torihikisakiCd = '';
	    // 社員	 
	    this.shainCd='';
	    // 概要	
	    this.comment ='';
	    // 伝票番号	
	    this.denpyoNum ='';
    
    } 
    
    

    /*
     * 機能名：案件レコード件数の取得
     * @param employList 社員レコードリスト
     * @return 案件検索条件
     */
    private String setSoqlCondition(List<Employee__c> employList) {
        String soqlCondition = ' where AnkenRecruitmentFlg__c = true ';
        Boolean javaFlg = false;
        Boolean dotNetFlg = false;
        Boolean cLanguageFlg = false;
        Boolean cobolFlg = false;
        Boolean SAPFlg = false;
        Boolean SFDCFlg = false;
        Decimal javaYears = 0;
        Decimal dotNetYears = 0;
        Decimal cLanguageYears = 0;
        Decimal cobolYears = 0;
        Decimal SAPYears = 0;
        Decimal SFDCYears = 0;

        javaFlg = employList[0].JavaCheck__c;
        dotNetFlg = employList[0].DotNetCheck__c;
        cLanguageFlg = employList[0].CLanguageCheck__c;
        cobolFlg = employList[0].CobolCheck__c;
        SAPFlg = employList[0].SAPCheck__c;
        SFDCFlg = employList[0].SFDCCheck__c;
        
        if (javaFlg) {
            javaYears = employList[0].JavaYears__c;
            soqlCondition += ' and JavaYears__c <= ' + javaYears;
        }

        if (dotNetFlg) {
            dotNetYears = employList[0].DotNetYears__c;
            soqlCondition += ' and DotNetYears__c <= ' + dotNetYears;
        }

        if (cLanguageFlg) {
            cLanguageYears = employList[0].CLanguageYears__c;
            soqlCondition += ' and CLanguageYears__c <= ' + cLanguageYears;
        }

        if (cobolFlg) {
            cobolYears = employList[0].CobolYears__c;
            soqlCondition += ' and CobolYears__c <= ' + cobolYears;
        }

        if (SAPFlg) {
            SAPYears = employList[0].SAPYears__c;
            soqlCondition += ' and SAPYears__c <= ' + SAPYears;
        }

        if (SFDCFlg) {
            SFDCYears = employList[0].SFDCYears__c;
            soqlCondition += ' and SFDCYears__c <= ' + SFDCYears;
        }

        return soqlCondition;
    }

    /*
    * 機能 ：案件リストの作成
    * @param ：akList   検索された案件レコードリスト
    *
    * @return：なし
    */
    private void setAnkenList(List<Anken__c> akList) {
        this.AnkenResultList = new List<AnkenResult>();
        for (Anken__c ak : akList) {
            this.AnkenResultList.add(new AnkenResult(this.torihikiMeisaiList[0].Id, ak));
        }
    }

    public class AnkenResult {
        public String employeeId {get; set;}
        public Anken__c anken {get; set;}
        public AnkenResult (String empId, Anken__c an) {
            employeeId = empId;
            anken = an;
        }
    }

}