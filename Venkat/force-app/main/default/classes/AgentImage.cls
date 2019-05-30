public class AgentImage
{
    public id attachmentid{get;set;} 
    public boolean checkimage{get;set;}
    public AgentImage(ApexPages.StandardController controller)
    {
        if(controller.getid()!=null)
        {
            if([select count() from Agent__c Where id=:controller.getid()]>0 && [select count() from Attachment where parentid=:controller.getid()]>0)
            {
                attachment att=[select id,name from attachment where parentid=:controller.getid() limit 1];
                attachmentid=att.id;
                checkimage=true;
            }
        }
    }
    /* PUBLIC static testmethod void agentimagemeth()      
     {
                     Agent__c ac=new Agent__c(name='001');
                     insert ac;
                    Attachment att=new Attachment();
                    att.name='test attach';
                    att.body=blob.valueof('test attack');
                    att.parentid=ac.id;
                    insert att;
                    id apid=apexpages.currentpage().getparameters().put('id',ac.id);
                    ApexPages.StandardController controller=new ApexPages.StandardController(ac);
                   AgentImage ai=new AgentImage(controller);
     }*/
}