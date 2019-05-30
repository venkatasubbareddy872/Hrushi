Public class searchinformatiom
{
      public boolean newclient1{get;set;}
      public Customer__c cu{get;set;}
      public list<Customer__c> culist{get;set;}
      public boolean ADDPR{get; set;}
      public Agent__c acc{get;set;}
      
      public string AgentName{get;set;}
      public string CustomerName{get;set;}
      public list< Agent__c > Agentlist{get;set;}
      public list<Customer__c> Customerlist{get;set;}
      Public  searchinformatiom()
      {
           
           
           cu=new Customer__c();
           acc=new Agent__c();
           newclient1=true;
          // cu=[select id,name,Agent_Id__c,Agent_Name__c,Customer_Name__c,IPP_Plans__c,Joining_Date__c,Paid_Total_Amount__c from Customer__c];
      }
        
    public void search()
    {
         string soql='';
        Agentlist=new list< Agent__c >();
        Customerlist=new list<Customer__c>();
        if(AgentName!='' && CustomerName=='')
        {
            
            soql = 'select id,name,Introducer_Code__c,Agent_Name__c,Phone__c from  Agent__c  where name!=null';
            soql += ' and name LIKE \''+String.escapeSingleQuotes(AgentName)+'%\'';
                Agentlist=Database.query(soql);
        }
        else if(AgentName=='' && CustomerName!='')
        {
            soql = 'select id,name,Agent_Id__c,Total_Amount__c,Customer_Name__c,Customer_Phone_No__c from Customer__c where name!=null';
            soql += ' and name LIKE \''+String.escapeSingleQuotes(CustomerName)+'%\'';
                Customerlist=Database.query(soql);
        }
        else if(AgentName!=null && CustomerName!=null)
        {
            soql = 'select id,name,Agent_Id__c,Total_Amount__c,Customer_Name__c,Customer_Phone_No__c from Customer__c where name!=null';
            soql += ' and name LIKE \''+String.escapeSingleQuotes(CustomerName)+'%\'';
            soql += ' and Agent_Id__r.name LIKE \''+String.escapeSingleQuotes(AgentName)+'%\'';
                Customerlist=Database.query(soql);
            
        }
        /*ADDPR=TRUE;
         cu=new Customer__c();
        if(acc.name!=null && cu.name!=null)
        {
            culist=new list<Customer__c >();
            string soql='';
             soql = 'select id,name from Customer__c,Agent__c where name!=null';
             if (cu.name!=NULL)
                 soql += ' and Street_Number__c LIKE \''+String.escapeSingleQuotes(cu.name)+'%\'';
             if (cu.Street__c!=null)
                 soql += ' and Street__c LIKE \''+String.escapeSingleQuotes(cu.Street__c)+'%\'';
             if (cu.Agent__c!=null)
                 soql +=  ' and Agent__c = \''+String.escapeSingleQuotes(cu.Agent__c)+'\'';
             if (cu.name!=null)
                 soql += ' and name LIKE \''+String.escapeSingleQuotes(cu.Name)+'%\'';
             if (cu.Name!=null)
                 soql += ' and name LIKE \''+String.escapeSingleQuotes(cu.name)+'%\'';
             if (cu.name!=null)
                 soql += ' and name LIKE \''+String.escapeSingleQuotes(cu.name)+'%\'';
             if (cu.name!=null)
                 soql += ' and name LIKE \''+String.escapeSingleQuotes(cu.name)+'%\'';
             if (cu.State__c!=null)
                 soql += ' and State__c LIKE \''+String.escapeSingleQuotes(cu.State__c)+'%\'';   
            if(cu.name!=null || cu.name!=null || cu.name!=null || cu.name!=null || cu.name!=null || cu.name!=null || cu.name!=null || cu.Agent__c!=null)
            {
                soql=soql+'order by Agent__c asc';
                culist=Database.query(soql);
            }
        }
        else
        {
            apexpages.addmessage(new apexpages.message(apexpages.severity.info,'Enter value for Account Name and Last Name'));
        }*/
    
    }
    }