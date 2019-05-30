@isTest
private class TestRunAs1 {
public static testMethod void TestRunAs1()
{
 Agent__c ac=new Agent__c(name='001');
        insert ac;
        
  Customer__c acc=new Customer__c (Agent_Id__c=ac.id,Joining_Date__c=system.today(),Date_of_Birth__c=system.today()+1);
        insert acc;
          
    Receipt__c rp=new Receipt__c(name='001',amount__c=23,Customer__c=acc.id);         
     insert rp;       
    
        id apid=apexpages.currentpage().getparameters().put('apid',acc.id);
          ApexPages.StandardController controller=new ApexPages.StandardController(acc);
          customer app=new  customer(controller);
           CustomerInformation app1=new  CustomerInformation(controller);
           CustomerReceipt app2=new  CustomerReceipt(controller);
            DaterangeCustomers app3=new  DaterangeCustomers();
            //NewCustomerApplication app4=new  NewCustomerApplication(controller);
            // app4.save();
             //app4.Cust=acc;
             
            //app4.saveNew();
           
           
                    
             ReceiptInformation app5=new  ReceiptInformation(controller);
             searchinformatiom si=new searchinformatiom();
           si.AgentName='0';
           si.cu=acc;
           si.acc=ac;
           si.search();
           si.CustomerName='0';
si.search();

    }
    }