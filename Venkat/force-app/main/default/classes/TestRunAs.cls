@isTest
private class TestRunAs {
public static testMethod void TestRunAs()
{
        Agent__c ac= new Agent__c(name='Agent Name');
       insert ac;
        id aid=apexpages.currentpage().getparameters().put('aid',ac.id);
        
          ApexPages.StandardController controller=new ApexPages.StandardController(ac);
          AgentInformation app=new  AgentInformation(controller);
          app.imagefile=blob.valueof('this is test');
         app.save();
        app.saveNew();
        
        
       // Agent__c ac=new Agent__c(name='001');
                     //insert ac;
                    Attachment att=new Attachment();
                    att.name='test attach';
                    att.body=blob.valueof('test attack');
                    att.parentid=ac.id;
                    insert att;
                    //id apid=apexpages.currentpage().getparameters().put('id',ac.id);
                   // ApexPages.StandardController controller=new ApexPages.StandardController(ac);
                   AgentImage ai=new AgentImage(controller);
       
}
}