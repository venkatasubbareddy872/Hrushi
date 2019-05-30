public class DaterangeCustomers
{
    public Customer__c customer{get;set;}
    public list<Customer__c> CustomerList{get;set;}
    public string mode{get;set;}
    public DaterangeCustomers()
    {
        customer=new Customer__c();
        CustomerList=new list<Customer__c>();
    }
    public void Search()
    {
        CustomerList=[select id,name,Agent_Id__c,IPP_Plans__c,Joining_Date__c,Paid_Total_Amount__c,Type_of_Amount__c,Branch_Code__c from Customer__c where Joining_Date__c>=:customer.Joining_Date__c and Joining_Date__c<=:customer.Date_of_Birth__c];
    }
}