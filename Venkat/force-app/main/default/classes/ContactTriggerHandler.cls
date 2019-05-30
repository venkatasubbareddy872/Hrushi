public class ContactTriggerHandler {

    public static void onAfterInsert( List<Contact> newRecords) {
        Set<Id> accountIds = new Set<Id>();
        for( Contact con : newRecords) {
            if(con.Client_Engagement__c == true && con.AccountId != null)
                accountIds.add( con.AccountId );
        }
        
        System.Debug('$$$$ AccountIds '+accountIds);
        if( accountIds.size() > 0 )
            AccountContactRoolupSummary( accountIds );
    }
    
    public static void onAfterUpdate( List<Contact> newRecords, Map<Id,Contact> oldMap ) {
        Set<Id> accountIds = new Set<Id>();
        for( Contact con : newRecords) {
            if( con.Client_Engagement__c != oldMap.get(con.Id).Client_Engagement__c && con.AccountId != null)
                accountIds.add( con.AccountId );
            if( (con.AccountId != oldMap.get(con.Id).AccountId) && 
            (con.Client_Engagement__c != oldMap.get(con.Id).Client_Engagement__c || con.Client_Engagement__c)) {
                if(con.AccountId != null)
                accountIds.add( con.AccountId );
                if(oldMap.get(con.ID).AccountId != null)
                accountIds.add( oldMap.get(con.ID).AccountId );
            }
                
        }
        
        System.Debug('$$$$ AccountIds '+accountIds);
        if( accountIds.size() > 0 )
            AccountContactRoolupSummary( accountIds );
    }
    
    public static void OnAfterDelete( List<Contact> oldRecords) {
        Set<Id> accountIds = new Set<Id>();
        for( Contact con : oldRecords  ) {
            if(con.Client_Engagement__c == true && con.AccountId != null)
                accountIds.add( con.AccountId );
        }
        
        System.Debug('$$$$ AccountIds '+accountIds);
        if( accountIds.size() > 0 )
            AccountContactRoolupSummary( accountIds );  
    }
    
    //Contact Roll up for each Account
    public static void AccountContactRoolupSummary( Set<ID> accountIds ) {
        
        Map<String,Integer> AccountRollupMap = new Map<String,Integer>();
        List<Account> accountList = new List<Account>();
        String AccountId = '';
        Decimal Count = 0;
        
        List<AggregateResult> aggResult = [Select count(Id) cnt, AccountID from Contact where AccountID IN :accountIds AND Client_Engagement__c = true Group By AccountID];
        
        for(AggregateResult agg : aggResult) {
            AccountId = (string) agg.get('AccountID');
            Count = 0;
            if( (Decimal) agg.get('cnt') != null ) 
                Count = (Decimal) agg.get('cnt');
            AccountRollupMap.put( AccountId, Count.intValue() );
        } 
        
        for( Id accId : accountIds ) {
            Account acc = new Account();
            acc.Id = accId;
            if(AccountRollUpMap.containsKey(accId))
                acc.Client_Engagement_Contacts__c = AccountRollUpMap.get( accId );
            else
                acc.Client_Engagement_Contacts__c = 0;
            accountList.add( acc );
        }
        
        if( accountList.size() > 0)
            update accountList;
    }
}