public class RandomContactFactory {
    public static List<Contact> generateRandomContacts( integer ctnum,string slastname){
        List<Contact> ctList = new List<Contact>();
        for (Integer j=0;j<ctnum;j++) {
            ctList.add(new Contact(FirstName = 'Test'+j, LastName = slastname));       
        }
        return ctList;
    }
}