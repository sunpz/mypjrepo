public with sharing class AddressTriggerHandler extends TriggerHandler {
 
     // トリガーの有効化判定フラグ
    public static Boolean TriggerDisabled = false;

    /**
     * @description トリガーの有効化判定処理。
     */
    public override Boolean IsDisabled(){
        return TriggerDisabled;
    }
 
     /**
     * @description before update トリガーのハンドラ処理。
     * @param oldMap 更新前対象データ。
     * @param newMap 更新後対象データ。
     */
    public override void AfterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
        // 対象データを取得する
        List<AddressMaster__c> AddressMasterList = (List<AddressMaster__c>)newMap.values();
        
        // アドレス設定
        empAddSetting(AddressMasterList);
    }
        
     /**
     * @description before update 住所からからアドレスを自動補足処理。
     * @param List<AnkenInfo__c> 対象データ
     */
    private  void empAddSetting(List<AddressMaster__c> AddressMasterList) {
    	
    	// 更新データの住所コードを取得する
        Set<String> addressCDSet = new Set<String>();
        // 住所コードマップ作成(マップ＜住所コード,住所詳細＞)
        Map<String, String> mapAddress = new Map<String, String>();
        
        for (AddressMaster__c item : AddressMasterList){
            If (!String.IsBlank(item.NAME)) {
                addressCDSet.add(item.NAME);
                 mapAddress.put(item.NAME, item.Address__c);
            }
        }
        
    	// 社員マスタから住所情報を取得する
    	List<Employee1__c> employeeList = [select id, AddressCD__c,Address1__c from Employee1__c where AddressCD__c IN :addressCDSet]; 
        //社員マスタ更新リスト
        List<Employee1__c> updateList = new List<Employee1__c>();
        
    	// 社員マスタの住所１を設定する
        for (Employee1__c item : employeeList){
            if (!String.IsBlank(item.AddressCD__c) && mapAddress.containsKey(item.AddressCD__c)) {
                item.Address1__c = mapAddress.get(item.AddressCD__c);
                updateList.add(item);
            }
        }
        
        // 社員マスタの更新を行う。
        if(updateList != null && !updateList.isEmpty()) {
            Database.update(updateList);
        }
    }
}