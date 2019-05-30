public class CustomerInformation
{
    public id Id1=apexpages.currentpage().getparameters().get('id');
   public list<Customer__c> cu{get;set;}
    public Agent__c ac{get;set;}
    public CustomerInformation(ApexPages.StandardController controller)
    {
        cu=new list<Customer__c>();
        ac=new Agent__c();
       
        if([select count() from Agent__c where id=:Id1]>0)
        {
            ac=[select id,name,customer_Collected_Amount__c from Agent__c where id=:Id1 limit 1];
           
            cu=[select id,name,Amount__c,Agent_id__c,Agent_Name__c,Paid_Total_Amount__c ,Customer_Name__c,Customer_Plan__c,Joining_Date__c  from Customer__c where Agent_id__c=:ac.id];
        }
        }
          
    }