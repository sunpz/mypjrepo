public class StringArrayTest {
   public  static List<String> generateStringArray(Integer num){
       List<String> testlist =new List<String> ();
       for (Integer n =0; n<num ; n++ ){
           testlist.add('Test ' + n);
       }
        return testlist;
    }
}