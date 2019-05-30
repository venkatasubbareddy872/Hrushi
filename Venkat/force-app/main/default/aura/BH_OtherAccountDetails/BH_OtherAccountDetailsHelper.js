({
 helperFun : function(component,event,secId) {
   var acc = component.find(secId);
         for(var cmp in acc) {
         $A.util.toggleClass(acc[cmp], 'slds-show');  
         $A.util.toggleClass(acc[cmp], 'slds-hide');  
       }
 },
    retrieveRecords:function(component, event,recordId){
        var action = component.get("c.getAccount");
        action.setParams({
            "accountId": recordId
        });
        console.log('Account id'+recordId);
        //console.log('sections'+sections); 
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Account id'+response.getReturnValue()); 
            if (state === "SUCCESS") {                   
                component.set("v.Acc",response.getReturnValue());
                component.set("v.isSearchCoPay","False");
                component.set("v.isSearchCcoach","01237000000TR6YAAW");
                 var accnt = component.get("v.Acc"); 
        		 var copay = [];
                 var Ccoach = [];
                 if(accnt !=  undefined)
                 for (var i = 0; i < accnt.length; i++) { 
                     var ac = accnt[i];
                     if(ac.College_Coach_Topic_Elections__r != undefined)
                     for(var j = 0; j < ac.College_Coach_Topic_Elections__r.length; j++){
                         if(j < 10){
                             var cch = ac.College_Coach_Topic_Elections__r[j];
                                 Ccoach.push(cch);
                         }
                     }  
                     if(ac.User_Copay_Infant_Trans_Addtl_Uses__r != undefined) 
                     for(var k = 0; k < ac.User_Copay_Infant_Trans_Addtl_Uses__r.length; k++){
                         if(k < 10){
                             var ccp = ac.User_Copay_Infant_Trans_Addtl_Uses__r[k];
                                 copay.push(ccp);
                         }
                     }  
                 }
                component.set("v.ccoach",Ccoach);
                component.set("v.copay",copay);
                
            } else{
                //console.log('error Account id'+response.getReturnValue());
            }  
             
        });
        
        $A.enqueueAction(action);
    },
    handleSelect:function(component,event){
        console.log("button value: ", event.getParam("value"));
        console.log("button value: ", event.getParam("label"));
		console.log("button name: ", event.getSource().get("v.value")); 
        var eventtype = event.getParam("value");
        if(eventtype == "Edit")
        {var editRecordEvent = $A.get("e.force:editRecord");	
                 editRecordEvent.setParams({
                     "recordId": event.getSource().get("v.value")
               });
                editRecordEvent.fire();
        }else if(eventtype == "Delete"){
               var action = component.get("c.DeleteCon");
                action.setParams({
                    "copayId": event.getSource().get("v.value")
                });
            console.log('error Account id');  
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {  
                         $A.get('e.force:refreshView').fire();
                    } else{
                        console.log('error Account id error');
                    }   
             
        })
                $A.enqueueAction(action);
        }
    },
    handleCCoachSelect : function(component, event) {
        console.log("button value: ", event.getParam("value"));
        console.log("button value: ", event.getParam("label"));
		console.log("button name: ", event.getSource().get("v.value"));
        var eventtype = event.getParam("value");
        if(eventtype == "Edit")
        {var editRecordEvent = $A.get("e.force:editRecord");	
                 editRecordEvent.setParams({
                     "recordId": event.getSource().get("v.value")
               });
                editRecordEvent.fire();
        }else if(eventtype == "Delete"){
               var action = component.get("c.DeleteCcoach");
                action.setParams({
                    "ccoachId": event.getSource().get("v.value")
                });
            console.log('error Account id');  
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {  
                         $A.get('e.force:refreshView').fire();
                    } else{
                        console.log('error Account id error');
                    }   
             
        })
                $A.enqueueAction(action);
        }
    },
    createRecord:function(component, event, recordId){
        var createRecordEvent = $A.get("e.force:createRecord");
        var eventtype = event.getParam("value");
        if(eventtype == "BUCA_ITP_Program"){
            createRecordEvent.setParams({
            "entityApiName": "User_Copay__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR5QAAW"
            },  
         });
        }else if(eventtype == "BUCA_Program_1"){
           createRecordEvent.setParams({
            "entityApiName": "User_Copay__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR5RAAW"
            },  
         }); 
            
        }/*else if(eventtype == "BUCA_Program_2"){
           createRecordEvent.setParams({
            "entityApiName": "User_Copay__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR5SAAW"
            },  
         }); 
            
        }else if(eventtype == "BUCA_Program_3"){
           createRecordEvent.setParams({
            "entityApiName": "User_Copay__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR5TAAW"
            },  
         });            
        }*/
        createRecordEvent.fire();
    },
    createCCoachRecord : function (component, event, recordId) {
        var createRecordEvent = $A.get("e.force:createRecord");
        var eventtype = event.getParam("value");
        if(eventtype == "CC_Core_Topics"){
            createRecordEvent.setParams({
            "entityApiName": "College_Coach_Topic_Elections__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR6YAAW"
            },  
         });
        }else if(eventtype == "CC_Spotlight_Topics"){
           createRecordEvent.setParams({
            "entityApiName": "College_Coach_Topic_Elections__c",      
            "defaultFieldValues": {
                "Account__c": recordId,
                "RecordTypeId":"01237000000TR6ZAAW"
            },  
         }); 
            
        }
		createRecordEvent.fire();
    }
})