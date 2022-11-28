Public class Creating1000Records {
    public creating1000Records() {
        List<Account> list1 = new List<Account>();
     //   integer RECORD_COUNT = 1000;
        for(Integer i = 1; i < 1001; i++){
            Account accountCreation = new Account(Name = 'account'+string.valueOf(i));
      //      accountCreation.name = ‘account’+string.valueOf(i);
             list1.add(accountCreation);
        }
        insert list1;
        system.debug(list1);
    }
}
