public class Apiget {
    //表示用リストクラス
    public List<apiname> apinameList{get;set;}
     
    //データ格納用クラス
    class apiname{
        public String objectLabel{get;set;}
        public String objectName{get;set;}
        public String objectkeyPrefix{get;set;}
    }
     
    //コンストラクタ
    public Apiget(){
         
        //全オブジェクト情報取得
        MAP<string,Schema.SObjectType> sobMap =schema.getGlobalDescribe();
        apinameList = new List<apiname>();
        for(String sobStr : sobMap.keySet()){
            apiname apnameclass = new apiname();
            Schema.SObjectType sobType = sobMap.get(sobStr);
            Schema.DescribeSObjectResult sobRes = sobType.getDescribe();
            apnameclass.objectLabel = sobRes.label;
            apnameclass.objectName = sobRes.name;
            apnameclass.objectkeyPrefix = sobRes.keyPrefix;
             
            //カスタムオブジェクトは除く
            if(!sobRes.custom)apinameList.add(apnameclass);
        }
    }
}