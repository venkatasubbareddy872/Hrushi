trigger AgentAmountTotal on Receipt__c (after insert,after update) 
{
    set<id> Customerids=new set<id>();
    set<id> Agentids=new set<id>();
    id parentid;
    for(Receipt__c rec:trigger.new)
    {
        if(rec.Customer__c!=null)
            Customerids.add(rec.Customer__c);
    }
    map<id,Customer__c> Custmap=new map<id,Customer__c>();
    for(Customer__c Cus:[select id ,name,Agent_Id__c from Customer__c where id=:Customerids])
    {
        if(Cus.Agent_Id__c!=null)
        {
            Agentids.add(Cus.Agent_Id__c);
        }
        Custmap.put(Cus.id,Cus);
    }
    map<id,id> resmap=new map<id,id>();
    list<Customer__c> updateCustmorlist=new list<Customer__c>();
    for(Receipt__c res:[select id,name,Customer__c,Amount__c from Receipt__c where Customer__c=:Customerids])
    {
        if(Custmap.get(res.Customer__c)!=null)
        {
            if(resmap.get(res.Customer__c)==null)
            {
                updateCustmorlist.add(Custmap.get(res.Customer__c));
                Custmap.get(res.Customer__c).Total_Amount__c=res.Amount__c;
                resmap.put(res.Customer__c,res.Customer__c);
            }
            else 
            {
                Custmap.get(res.Customer__c).Total_Amount__c=Custmap.get(res.Customer__c).Total_Amount__c+res.Amount__c;
            }
        }
    }
    if(updateCustmorlist.size()>0)
        update updateCustmorlist;
    map<id,Agent__c> accmap=new map<id,Agent__c>();
    for(Agent__c acc:[select id,name,Introducer_Code__c,Total_Agents_Collection_Amount__c from Agent__c])
    {
        accmap.put(acc.id,acc);
    }
    map<id,id> Customermap=new map<id,id>();
    list<Agent__c> AccCustomlist=new list<Agent__c>();
    for(Customer__c cust:[select id, name,Agent_Id__c,Total_Amount__c,Paid_Total_Amount__c from Customer__c where Agent_Id__c=:Agentids])
    {
        if(accmap.get(cust.Agent_Id__c)!=null)
        {
            if(Customermap.get(cust.Agent_Id__c)==null)
            {
                accmap.get(cust.Agent_Id__c).Customer_Collected_Amount__c=cust.Total_Amount__c;
                Customermap.put(cust.Agent_Id__c,cust.Agent_Id__c);
                AccCustomlist.add(accmap.get(cust.Agent_Id__c));
            }
            else if(Customermap.get(cust.Agent_Id__c)!=null)
            {
                accmap.get(cust.Agent_Id__c).Customer_Collected_Amount__c=accmap.get(cust.Agent_Id__c).Customer_Collected_Amount__c+cust.Total_Amount__c;
            }
        }
    }
    if(AccCustomlist.size()>0)
        update AccCustomlist;
    list<Agent__c> updateAgentlist=new list<Agent__c>();
    boolean ParentCheck=false;
    map<id,id> tempmap=new map<id,id>();
    decimal TAgent=0;
    set<id> Inheritids=new set<id>();
    /*list<Agent__c> inheritagentlist=new list<Agent__c>();
    set<id> Inheritids=new set<id>();
    for(Agent__c acc:[select id,name,Customer_Collected_Amount__c from Agent__c where id=:Agentids])
    {
        inheritagentlist.add(acc);
        Inheritids.add(acc.id);
    }
    for(Agent__c acc1:[select id ,name,Customer_Collected_Amount__c,Total_Collected_Amount__c from Agent__c where Introducer_Code__c=:parentid])
    {
        
    }*/
    for(Agent__c acc:[select id,name,Customer_Collected_Amount__c from Agent__c where id=:Agentids])
    {
        decimal Total=0.0;
        do
        {
            if(parentid==null)
            {
                
                //Total=acc.Customer_Collected_Amount__c;
                parentid=acc.id;
                ParentCheck=true;
            }
            else if(parentid!=null)
            {
                if(accmap.get(parentid)!=null)
                {
                    if(accmap.get(parentid).Introducer_Code__c!=null)
                    {
                        parentid=accmap.get(parentid).Introducer_Code__c;
                        Inheritids.add(parentid);
                        SYSTEM.DEBUG(parentid+'pppppppppppppppppppppppppppp');
                    }
                    else
                    {
                        Inheritids.add(parentid);
                             ParentCheck=false;
                    } 
                }
            }
            
        }while(ParentCheck);
    }
    map<id,list<Agent__c>> inheritmap=new map<id,list<Agent__c>>();
    for(Agent__c acc1:[select id ,name,Customer_Collected_Amount__c,Total_Collected_Amount__c,Introducer_Code__c,Total_Agents_Collection_Amount__c from Agent__c where Introducer_Code__c=:Inheritids])
    {
         if(inheritmap.get(acc1.Introducer_Code__c)==null)
         {
             list<Agent__c> agentlist=new list<Agent__c>();
             agentlist.add(acc1);
             inheritmap.put(acc1.Introducer_Code__c,agentlist);
         }
         else if(inheritmap.get(acc1.Introducer_Code__c)!=null)
         {
             list<Agent__c> agentlist=inheritmap.get(acc1.Introducer_Code__c);
             agentlist.add(acc1);
             inheritmap.put(acc1.Introducer_Code__c,agentlist);
         }
    }
    ParentCheck=FALSE;
    parentid=NULL;
    for(Agent__c acc:[select id,name,Customer_Collected_Amount__c from Agent__c where id=:Agentids])
    {
        decimal Total=0.0;
        do
        {
            if(parentid==null)
            {
                
                //Total=acc.Customer_Collected_Amount__c;
                parentid=acc.id;
                ParentCheck=true;
            }
            else if(parentid!=null)
            {
                if(accmap.get(parentid)!=null)
                {
                    if(accmap.get(parentid).Introducer_Code__c!=null)
                    {
                        parentid=accmap.get(parentid).Introducer_Code__c;
                        if(inheritmap.get(parentid)!=null)
                        for(Agent__c acc1:inheritmap.get(parentid))
                        {
                            if(acc1.Customer_Collected_Amount__c!=null)
                            Total=Total+acc1.Customer_Collected_Amount__c;
                            system.debug(acc1.name);   
                        }
                        accmap.get(parentid).Total_Agents_Collection_Amount__c=Total;
                        if(accmap.get(parentid).Customer_Collected_Amount__c!=null)
                        Total=accmap.get(parentid).Customer_Collected_Amount__c+Total;
                        updateAgentlist.add(accmap.get(parentid));
                       // update updateAgentlist;
                        tempmap.put(accmap.get(parentid).id,accmap.get(parentid).id);
                        system.debug(accmap.get(parentid).name+''+accmap.get(parentid).Total_Collected_Amount__c);
                    }
                    else
                    {
                        system.debug('Total'+Total);
                       /* Total=0;
                       if(inheritmap.get(parentid)!=null)
                        for(Agent__c acc1:inheritmap.get(parentid))
                        {
                            system.debug(acc1.name);
                            if(acc1.Customer_Collected_Amount__c!=null)
                                Total=Total+acc1.Customer_Collected_Amount__c;      
                            if(acc1.Total_Agents_Collection_Amount__c!=null)
                                Total=Total+acc1.Total_Agents_Collection_Amount__c;
                            system.debug(acc1.id+'********'+acc1.Customer_Collected_Amount__c+'*****'+acc1.Total_Agents_Collection_Amount__c+'*****'+acc1.Total_Collected_Amount__c);
                        }*/
                        accmap.get(parentid).Total_Agents_Collection_Amount__c=Total;
                       
                        system.debug(accmap.get(parentid).name);
                        if(tempmap.get(accmap.get(parentid).id)==null)
                            updateAgentlist.add(accmap.get(parentid));
                             ParentCheck=false;
                    } 
                }
            }
            
        }while(ParentCheck);
    }
    if(updateAgentlist.size()>0)
        update updateAgentlist;
}