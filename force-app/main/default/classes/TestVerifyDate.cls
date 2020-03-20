@isTest
private class TestVerifyDate {
    @isTest static void testCheckDates() {
        Date date1 =  Date.newInstance(2018, 10, 1);
        Date date2 =  Date.newInstance(2018, 5, 1);
        Date reDate = VerifyDate.CheckDates(date1,date2);
        System.assertEquals(Date.newInstance(2018, 10, 31),reDate);
    }
    
    @isTest static void testCheckDates2() {
        Date date21 =  Date.newInstance(2018, 5, 1);
        Date date22 =  Date.newInstance(2018, 5, 15);
        Date reDate2 = VerifyDate.CheckDates(date21,date22);
        System.assertEquals(Date.newInstance(2018, 5, 31),reDate2);
    }
        @isTest static void testCheckDates3() {
        Date date31 = Date.newInstance(2018, 5, 1);
        Date date32 =  Date.newInstance(2018, 6, 15);
        Date reDate3 = VerifyDate.CheckDates(date31,date32);
        System.assertEquals(date32,reDate3);
    }
   
    
}