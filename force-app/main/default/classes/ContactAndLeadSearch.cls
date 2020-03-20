public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String pstr){
       List<List<sObject>> searchList =
            [FIND :pstr IN NAME FIELDS RETURNING Lead,Contact];    
        return searchList;
    }
}