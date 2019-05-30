public class customer
{
   public Customer__c cu{get;set;}
   id id1=apexpages.currentpage().getparameters().get('id');
   
    public customer(ApexPages.StandardController controller) 
    {

        cu=new Customer__c();
        cu=[select id,name,Age__c,Agent_Id__c,Agent_Name__c,City__c ,Sex__c,Country__c ,Receipt_No__c,Receipt_Date__c  ,Amount__c,Branch_Code__c,Cheque_No__c,Customer_Father_Name__c,Customer_Name__c,Customer_Plan__c,Date_of_Birth__c,Joining_Date__c,Nominee_Age__c,Nominee_Name__c,Nominee_Relationship__c,Pass_Book_No__c,Postal_Code__c,Street__c,State__c,Type_of_Amount__c,Nominee_City__c,Nominee_State__c,Nominee_Street__c,Nominee_Postal_Code__c,Nominee_Country__c,IPP_Plans__c,Payment_In_Terms__c from Customer__c];
   
    }

 /*PUBLIC static testmethod void Property()
    
    {
       Agent__c ac=new Agent__c(name='001');
        insert ac;
       
        Customer__c acc=new Customer__c (Agent_Id__c=ac.id);
        insert acc;
        
    
        
         id apid=apexpages.currentpage().getparameters().put('apid',acc.id);
          ApexPages.StandardController controller=new ApexPages.StandardController(acc);
          customer app=new  customer(controller);
    }*/
    
}