Trigger SBQQ_AccountTrigger on Account(after Insert) {
    Map<String, Integer> AccountLineGroupMap = new Map<String, Integer> {'MRC' => 10, 'NRC' => 20};   
    List<contact> AccountLineGroupList = new List<Contact>();
    Map<String,Account> AccountMap = new Map<String,Account>();
    for(Account AccountObj: Trigger.New) {
        
        for(String groupName: AccountLineGroupMap.keySet()) {
            Contact qlg = new Contact();
            qlg.LastName = groupName;
            qlg.Email = 'test123'+groupName + '@gmail.com';
            qlg.AccountId = AccountObj.Id;
            AccountLineGroupList.add(qlg);
        }
    }
    
    if(AccountLineGroupList.size() > 0) {
        insert AccountLineGroupList;
    }
    for(contact qlg: AccountLineGroupList) {
        Account q = new Account();
        
        if(AccountMap.containsKey(qlg.AccountId)) {
            q = AccountMap.get(qlg.AccountId);
        }
        q.Id = qlg.AccountId;
        if(qlg.LastName == 'MRC') {
            q.Name = qlg.Id;
        }
        if(qlg.LastName == 'NRC') {
            q.Description = qlg.Id;
        }
        AccountMap.put(q.Id, q);
    }
    
    if(AccountMap.size() > 0)
        update AccountMap.values();
}