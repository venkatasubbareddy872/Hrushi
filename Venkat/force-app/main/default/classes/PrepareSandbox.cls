global class PrepareSandbox implements SandboxPostCopy {
    
    global static void testDataSetup() {
        //User Email Address Revert Code
        Id BatchId = Database.executeBatch(new RevertUserEmailsBatchable(), 100);
        
        //abort Scheduled Reports
        PostSandboxRefreshActivities.abortScheduleReportTypes();
        
        // Insert logic here to prepare the sandbox for use.
        Integer RowCount = 2;
        
        //Account Data Setup
        List<Account> accountList = new List<Account>();
        accountList = PostSandboxRefreshActivities.CreateAccounts(2);
        
        //Contact Data Setup
        PostSandboxRefreshActivities.createContacts(accountList);
        
        //Opportunity Data Set up
        PostSandboxRefreshActivities.createOpportunities(accountList);
    }
    global void runApexClass(SandboxContext context) {
        System.debug('Org ID: ' + context.organizationId());
        System.debug('Sandbox ID: ' + context.sandboxId());
        System.debug('Sandbox Name: ' + context.sandboxName());

        //User Email Address Revert Code
        Id BatchId = Database.executeBatch(new RevertUserEmailsBatchable(), 100);
        
        //abort Scheduled Reports
        PostSandboxRefreshActivities.abortScheduleReportTypes();
        
        // Insert logic here to prepare the sandbox for use.
        Integer RowCount = 2;
        
        //Account Data Setup
        List<Account> accountList = new List<Account>();
        accountList = PostSandboxRefreshActivities.CreateAccounts(2);
        
        //Contact Data Setup
        PostSandboxRefreshActivities.createContacts(accountList);
        
        //Opportunity Data Set up
        PostSandboxRefreshActivities.createOpportunities(accountList);
    }
}