Public class AccountController {
    
    public List<AccountWrapper> wrapperList { get; set; }
    
    Public class AccountWrapper {
        public Boolean checked { get; set; }
        public Account acc { get; set; }
        public AccountWrapper() {
            checked = false;
            acc = new Account();
        }
    }
    
    public AccountController() {
        wrapperList = new List<AccountWrapper>();
        init();
    }
    
    public void init() {
        wrapperList = new List<AccountWrapper>();
        for(Account accObj : [Select Id, Name from Account Limit 10]) {
            AccountWrapper wObj = new AccountWrapper();
            wObj.acc = accObj;
            wrapperList.add(wObj);
        }
        
    }
    
    public PageReference disabledSelectedContacts() {
        Set<Id> accountIds = new Set<Id>();
        List<Contact> contactsList = new List<Contact>();
        
        for(AccountWrapper w : wrapperList) {
            if(w.Checked == true)
                accountIds.add(w.acc.Id);
        }
        
        if(accountIds.size() > 0) {
            for(Contact c : [Select Id, Is_Disabled__c from Contact where AccountID IN : accountIds]) {
            
                c.Is_Disabled__c = true;
                contactsList.add(c);
            }
        }
        
        try {
            
            if(contactsList.size() > 0)
                update contactsList;
                
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Related Child Contacts are Disabled Successfully.'));
                
        }
        catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
        }
        return null;
    }
}