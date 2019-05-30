public class CustomerReceipt
{
  id Id1=apexpages.currentpage().getparameters().get('id'); 
    public list<Receipt__c> rp{get;set;}
    public Customer__c ac{get;set;}
    
    public  CustomerReceipt(ApexPages.StandardController controller)
    {
        
        rp=new list<Receipt__c>();
        ac=new Customer__c();
       
        if([select count() from Customer__c where id=:Id1]>0)
        {
            ac=[select id,name,Amount__c,Customer_Name__c,Paid_Total_Amount__c  from Customer__c where id=:Id1 limit 1];
           
            rp=[select id,name,Customer__c,Customer_Name__c,Amount__c,Payments_in_Terms1__c,Date_of_Paid__c,Customer_Plan__c from Receipt__c where Customer__c=:ac.id];
        }
        
    }
    }