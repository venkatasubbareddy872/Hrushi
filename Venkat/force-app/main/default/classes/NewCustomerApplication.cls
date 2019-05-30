public class NewCustomerApplication
{
    public Customer__c Cust{get;set;}
    public NewCustomerApplication(ApexPages.StandardController controller)
    {
        Cust=new Customer__c();
    }
    public pagereference save()
    {
        if(Cust.Agent_Id__c!=null)
        {
            insert Cust;
            pagereference pr=new pagereference('/'+Cust.id);
            pr.setredirect(true);
            return pr;
            Cust.clear();
        }
        return null;
    }
    public pagereference SaveNew()
    {
        if(Cust.Agent_Id__c!=null)
        {
            insert Cust;
            Cust.clear();
        }
        return null;
    }
 }