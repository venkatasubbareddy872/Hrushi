public class ReceiptInformation
{
  id Id1=apexpages.currentpage().getparameters().get('id'); 
    public Receipt__c rcp{get;set;}
    //public Customer__c ac{get;set;}
    public  ReceiptInformation(ApexPages.StandardController controller)
    {
        
        rcp=new Receipt__c();
       //ac=new Customer__c ();
        if([select count() from Customer__c where id=:Id1]>0)
        {
            //ac=[select id,name from Customer__c where id=:Id1 limit 1];
            rcp=[select id,name,Amount__c,Amount_in_Words__c,Cheque_no__c,Customer__c,Date_of_Paid__c,Type_Amount__c from Receipt__c ];
        }
        
    }
    }