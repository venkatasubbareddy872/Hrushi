@isTest
private class TestRunAs12 {
PUBLIC static testmethod void CustomerInformationtest()
          
      {
         Agent__c ac=new Agent__c(name='001');
          insert ac;
             
          Customer__c acc=new Customer__c (name='test',Agent_Id__c=ac.id);
         // insert acc;
          Customer__c acc1=new Customer__c (name='test',Agent_Id__c=ac.id);
              
              // id apid=apexpages.currentpage().getparameters().put('apid',acc.id);
                ApexPages.StandardController controller=new ApexPages.StandardController(acc);
                NewCustomerApplication app=new  NewCustomerApplication(controller);
                    app.Cust=acc;
                    app.save();
                     app.Cust=acc1;
                    app.saveNew();
          }
          }