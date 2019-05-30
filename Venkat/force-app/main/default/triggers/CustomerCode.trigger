trigger CustomerCode on Customer__c (before insert)
{
          for(Customer__c cust:trigger.new)
         {
                     if([select count() from user where id=:userinfo.getuserid()]>0)
                    {
                               user u=[select id,name,Branch_Code__c from user where id=:userinfo.getuserid() limit 1];
                               if(u.Branch_Code__c!=null)
                               {
                                           integer AgentCount=[select count() from Customer__c where CreatedById=:u.id];
                                           integer NewAgent=AgentCount+1;
                                           cust.Name=u.Branch_Code__c+'0000'+NewAgent;
                              }
                     }
          }
}