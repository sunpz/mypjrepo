/**
 * @File Name          : TravelRequestListController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 2019-7-13 19:19:01
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author                    Modification
 *==============================================================================
 * 1.0    2019-7-13 19:19:01   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class TravelRequestListController {

    // 抽出対象となるフィールドリスト
    static List<String> TARGET_FIELDS = new List<String>{
         'Id'
        ,'Name'
        ,'TravelRequestName__c'
        ,'Status__c'
        ,'TravelStartDate__c'
        ,'TravelEndDate__c'
        ,'Purpose_of_Travel__c'
        ,'Total__c'
        ,'LastModifiedDate'
    };

    public SearchCondition condition{ get;set; }        // 検索条件
    public List<Travel_Request__c> results { get;set; } // 検索結果リスト
    public String sortingField { get;set; }             // 見出しのソート用リンクを押された際のフィールド名

    /**
     * 初期化処理
     */
    public void init(){
        this.condition = new SearchCondition();
        this.results = new List<Travel_Request__c>();
    }

    /**
     * クリアボタン処理
     */
    public PageReference clear(){
        init();
        return null;
    }

    /**
     * 検索ボタン処理
     */
    public PageReference search() {

        // バリデーションチェック
        if( condition.validate() ){
            return null;
        }

        // 検索条件からSOQLを作成
        String soqlQuery = condition.getSoqlQuery();
        System.debug('[soql] ' + soqlQuery);

        try{
            this.results = database.query(soqlQuery);
        }catch(DmlException e){
            ApexPages.addMessages(e);
        }catch(Exception e){
            ApexPages.addMessages(e);
        }
        return null;
    }

    /**
     * ソートリンク処理
     */
    public PageReference sort(){

        // ソートを行う対象フィールドが不明な場合は何もしない
        if(this.sortingField == null ){
            return null;
        }

        // ソートを行う対象が、現在ソートしているフィールドと同じ場合はソート順を反対にする
        if(this.sortingField == this.condition.sortkey){
            this.condition.setOrderReverse();
        }
        // ソートを行う対象が、現在ソートしているフィールドと違う場合は新しい項目でソートするようにする
        else {
            this.condition.sortkey = this.sortingField;
        }

        // 検索実行
        search();
        return null;
    }

    /**
     * 現在のソートキーを取得するためのメソッド
     * 
     * ・検索結果の見出しにソート順を出すために使う
     * ・本来はgetSortOrderも含めて、ロジックもApex側で持ちたいが、
     * 　VisualForceから引数ありでメソッドが呼べないため、このようにしている。
     * 
     */
    public String getSortKey(){
        return this.condition.sortkey;
    }

    /**
     * 現在のソート順を取得するためのメソッド（▲ or ▼を返す）
     */ 
    public String getSortOrder(){
        return this.condition.sortOrderToString();
    }


    /**
     * 検索条件を管理するクラス
     */ 
    public Class SearchCondition {

    private Time JST_AM0 = Time.newInstance(9, 0, 0, 0);  

        /*
         * 検索条件の入力フィールド用
         * 
         * ・カスタムフィールドとして検索条件の入力項目を作成している。
         * ・こうすることで、プルダウンリストの場合はオブジェクトの設定画面から
         * 　選択リスト値を追加することで一覧画面の選択肢も追加される。
         */
        public Travel_Request__c obj {get;set;}     

        public String sortkey { get;set; }          // ソートキー
        public String order { get;set; }            // ソート順

        public SearchCondition() {
            this.obj = new Travel_Request__c();

            // デフォルトは最終更新日時の降順とする
            sortkey = 'LastModifiedDate';
            order = 'DESC';
        }


        // 検索条件のバリデーションチェック
        public boolean validate(){
            boolean isError = false;
            if( this.obj.SearchConditionLastModifiedFrom__c != null &&
                this.obj.SearchConditionLastModifiedTo__c != null &&
                this.obj.SearchConditionLastModifiedFrom__c > this.obj.SearchConditionLastModifiedTo__c ){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '最終更新日の範囲指定が逆転しています', ''));
                    isError = true;
            }
            return isError;
        }


        // 最終的なSOQLを生成（最大500件というのは固定）
        public String getSoqlQuery(){
            List<String> param = new String[]{ getFieldList(), getWhere(), getOrder() };
            return String.format('SELECT {0} FROM Travel_Request__c {1} {2} LIMIT 500', param);
        }

        // SELECT対象フィールド
        private String getFieldList(){
            return String.join(TARGET_FIELDS, ',');
        }

        // WHERE句作成
        private String getWhere(){
            List<String> param = new String[]{ };

            // ステータス
            if( !String.isBlank(this.obj.SearchConditionStatus__c) ){
                param.add('Status__c = \'' + obj.SearchConditionStatus__c + '\'');
            }
            // 最終更新日From
            if( this.obj.SearchConditionLastModifiedFrom__c != null ){
                Datetime fromDate = getStartOfDay(obj.SearchConditionLastModifiedFrom__c );
                param.add('LastModifiedDate >= ' + fromDate.format('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\''));
            }            
            // 最終更新日To
            if( this.obj.SearchConditionLastModifiedTo__c != null ){
                Datetime toDateAddOneDay = getStartOfDay( obj.SearchConditionLastModifiedTo__c.addDays(1));
                param.add('LastModifiedDate < ' + toDateAddOneDay.format('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\''));
            }

            if(param.isEmpty()){
                return '';
            }
            return 'WHERE ' + String.join(param, ' AND ');
        }

        // ORDERBY句作成
        private String getOrder(){
            List<String> param = new String[]{ sortkey, order };
            return String.format('ORDER BY {0} {1}', param);
        }

        private DateTime getStartOfDay(Date d){
            // GMT+9を考慮して、GMTで日本の0時を作成する（＝GMTでは1日前の15時）
            JST_AM0 = Time.newInstance(15, 0, 0, 0);
            return Datetime.newInstance(d.addDays(-1), JST_AM0);
        }

        // ソート順を見出しに表示する記号に変換する
        public String sortOrderToString(){
            if(this.order == 'DESC'){
                return '▼';
            }
            return '▲';
        }

        // ソート順を逆にする
        public void setOrderReverse(){
            if(this.order == 'DESC'){
                this.order = 'ASC';
            }
            else {
                this.order = 'DESC';
            }
        } 
    }
}