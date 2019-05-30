public class AgentInformation
{
    public transient  blob imagefile{get;set;}
    public id accid;
    public Agent__c account{get;set;}
    public AgentInformation(ApexPages.StandardController controller)
    {
        account =(Agent__c)Controller.getrecord();
        if([select count() from user where id=:userinfo.getuserid()]>0)
        {
            user u=[select id,name,Branch_Code__c from user where id=:userinfo.getuserid() limit 1];
            if(u.Branch_Code__c!=null)
            {
                 integer AgentCount=[select count() from Agent__c where ownerid=:u.id];
                   integer NewAgent=AgentCount+1;
               account  .Name=u.Branch_Code__c+'00'+NewAgent;
            }
        }
        /*string addzeros='0';
        string Agendid='';
        integer AgentCount=[select count() from Agent__c];
        integer NewAgent=AgentCount+1;
        string TA=string.valueof([select count() from Agent__c]);
        if(TA!='')
        {
            integer Len=TA.length();
            for(integer i=1;i<=8-Len;i++)
            {
                Agendid=Agendid+addzeros;
            }
        }
        account.Agent_Id__c='A-'+Agendid+NewAgent;*/
    }
    public pagereference save()
    {
        try
        {
           
                insert account;
                if(imagefile!=null)
                {
                    Attachment atmt=new Attachment();
                    atmt.body=imagefile;
                    atmt.name='Agent Name';
                    atmt.ParentId=account.id;
                    insert atmt;
                }
            pagereference pr=new pagereference('/'+account.id);
            pr.setredirect(true);
            return pr;
        }
        catch(Exception e)
        {
            return null;
        }
        
    }
    public pagereference saveNew()
    {
        try
        {
           
                insert account;
                if(imagefile!=null)
                {
                    Attachment atmt=new Attachment();
                    atmt.body=imagefile;
                    atmt.name='Agent Name';
                    atmt.ParentId=account.id;
                    insert atmt;
                }
            account.clear();
            return null;
        }
        catch(Exception e)
        {
            return null;
        }
        
    }

}