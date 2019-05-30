public Class PostSandboxRefreshActivities { 
    
    public static void abortScheduleReportTypes() {
        //code to kill reports
        List <Crontrigger> abortreportjobs = [SELECT id, cronjobdetail.jobtype FROM Crontrigger WHERE cronjobdetail.jobtype = '8'];

        for (crontrigger thisScheduledReport : abortreportjobs){
        
            System.abortJob(thisScheduledReport.Id);  
        
        }

    }
    
    public static List<Account> createAccounts(Integer noOfRecords) {
        
        
        //Account Data Preparation Code Start Here
        List<Account> insertList = new List<Account>();
        Map<String, ID> accRecordTypes = getAccountRecordTypes();
        for(string rName: accRecordTypes.keySet()) {
            
            for(Integer I = 0; I < noOfRecords; i++) {
                Account acc = new Account();
                acc.Name = 'Test Account' + i + ' - '+rName;
                acc.AccountNumber = '12345';
                acc.BillingStreet = '01730 street';
                acc.BillingCity = 'Boston';
                acc.BillingState = 'MA';
                acc.BillingCountry = 'USA';
                acc.BillingPostalCode = '01730';
                acc.ShippingStreet = '01730 street';
                acc.ShippingCity = 'Boston';
                acc.ShippingState = 'MA';
                acc.ShippingCountry = 'USA';
                acc.ShippingPostalCode = '01730';
                acc.RecordTypeId = accRecordTypes.get(rName);
                insertList.add(acc);
            }
        
            
        }
        
         
        
        if(insertList.size() > 0)
            insert insertList;
            
        return insertList;
    }
    
    public static void createContacts(List<Account> accountsList) {
        List<Contact> contactList = new List<Contact>();
        Set<Id> contactrTypeIds = getContactRecordTypes();
        Integer I = 0;
        for(Account acc: accountsList) {
            if(acc.Id != null)
            for(Id rId: contactrTypeIds) {
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'Test LastName '+I;
                con.Email = 'testemail' + i + '@test.com';
                con.AccountId = acc.Id;
                con.RecordTypeId = rId;
                contactList.add(con);
                I++;
            }
        }
        
        if(contactList.size() > 0)
            insert contactList;
    }
    
    public static void createOpportunities(List<Account> accountsList) {
        List<Opportunity> oppList = new List<Opportunity>();
        Map<String,Id> oppRecordTypeMap = getOpportunityRecordTypes();
        Map<String,String> stageMap = new Map<String,String>();
        stageMap = getStageNames();
        for(Account acc : accountsList) {
        
            for(String rName : oppRecordTypeMap.keySet()) {
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.AccountId = acc.Id;
                opp.RecordTypeId = oppRecordTypeMap.get(rName);
                opp.StageName = stageMap.get(rName);
                opp.CloseDate = System.Today();
                oppList.add(opp);
            }
        }
        
        if(oppList.size() > 0)
            insert oppList;
    }
    
    public static Map<String,String> getStageNames() {
        return new Map<String,String> {'Center' => '0 - FTA',
        'Client Project' => 'Award Negotiation',
        'EdAssist CRD Pipeline' => '0 - FTA',
        'EdAssist CSD Pipeline' => '0 - FTA',
        'EdAssist Network' => 'Agreement Review',
        'Non-Center' => '0 - FTA',
        'Service Intro' => 'Service Intro',
        'UK Pipeline' => '0 - FTA'};
    }
    
    
    public static Map<String,Id> getOpportunityRecordTypes() {
        Schema.DescribeSObjectResult r = Schema.SObjectType.Opportunity; 
        Map<String, ID> recordTypeMap = new Map<String, ID>();
        
        for(Schema.RecordTypeInfo rType : r.getRecordTypeInfos()) {
            if(rType.isActive() && !rType.isMaster()) {
                
                recordTypeMap.put(rType.getName(), rType.getRecordTypeId());
            }
        }
        return recordTypeMap;
    }
    
    public static Set<Id> getContactRecordTypes() {
        Schema.DescribeSObjectResult r = Schema.SObjectType.Contact; 
        Set<ID> recordTypeIds = new Set<ID>();
        for(Schema.RecordTypeInfo rType : r.getRecordTypeInfos()) {
            if(rType.isActive() && !rType.isMaster())
                recordTypeIds.add(rType.getRecordTypeId());
        }
        return recordTypeIDs;
    }
    
    public static Map<String, ID> getAccountRecordTypes() {
        Schema.DescribeSObjectResult r = Schema.SObjectType.Account; 
        Map<String, ID> recordTypeMap = new Map<String, ID>();
        for(Schema.RecordTypeInfo rType : r.getRecordTypeInfos()) {
            if(rType.isActive() && !rType.isMaster())
                recordTypeMap.put(rType.getName(), rType.getRecordTypeId());
        }
        return recordTypeMap;
    }

}