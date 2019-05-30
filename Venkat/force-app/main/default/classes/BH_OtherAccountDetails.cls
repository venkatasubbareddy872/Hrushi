public with sharing class BH_OtherAccountDetails {
      
    @AuraEnabled
    public static List<account> getAccount(Id accountId) {
    
            //List<account> account = new List<account>();
            List<account> account = [SELECT id,name,Outreach_Client_Name__c,Company_ID__c,X2017_CEM_TKA__c,
                                     Employees_Referred_to_as__c,Community_Launch_Status__c,Legacy_CAD_ID__c,B2E_Marketing_Do_Not_Email__c,
                                     B2E_Marketing_Do_Not_Raffle__c,B2E_Marketing_Do_Not_Survey__c,B2B_Do_Not_Survey__c,Do_Not_Gift__c,
                                     Whitelisting__c,
                                     (select id,Name,Copay_Group_Name__c,Child_Center_Copay__c,Family_Center_Copay__c,In_Home_Copay__c,Number_of_Uses__c,
                                        Use_Per__c,Use_Count__c from User_Copay_Infant_Trans_Addtl_Uses__r),
                                     (select id,Name,RecordTypeId,RecordType.Name,LastModifiedById,LastModifiedBy.Name,
                                      LastModifiedDate from College_Coach_Topic_Elections__r)
                                     FROM Account WHERE Id=:accountId];
            system.debug('account details' +account);
            return account;           
        
    }
    
   /*Delete a record for User Co-Pay*/
   
    @AuraEnabled
    public static String DeleteCon(Id copayId) {
            //List<account> account = new List<account>();
            
            User_Copay__c copay = new User_Copay__c(id = copayId);
            System.debug('delete record'+copay);
            delete copay;
            String success = 'deleted';
            return success;           
        
    }
    
    /*Delete a record for College Coach*/
    @AuraEnabled
    public static String DeleteCcoach(Id ccoachId) {
            //List<account> account = new List<account>();
            
            College_Coach_Topic_Elections__c ccoach = new College_Coach_Topic_Elections__c(id = ccoachId);
            System.debug('delete record'+ccoach);
            delete ccoach;
            String success = 'deleted';
            return success;           
        
    }


}