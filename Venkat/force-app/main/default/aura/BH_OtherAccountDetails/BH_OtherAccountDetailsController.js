({
    doInit : function(component, event, helper) {
        //var sections = component.get("v.sectionid"); 
        var recordId = component.get("v.recordId");
  		helper.retrieveRecords(component,event,recordId);
    },
    
    /*Edit and Delete for User Co-Pay*/
    handleSelect : function(component, event, helper) {
         helper.handleSelect(component,event);
       
    },
    
   /*Edit and Delete for College Coach*/
   handleCCoachSelect : function(component, event, helper) {
         helper.handleCCoachSelect(component, event);
       
    },
    
    /*Create New Record for User Co-Pay*/
	createRecord : function (component, event, helper) {
		var recordId = component.get("v.recordId");
		helper.createRecord(component, event, recordId);
	
	},
    
    /*Create New Record for college coach*/
	createCCoachRecord : function (component, event, helper) {
		var recordId = component.get("v.recordId");
		helper.createCCoachRecord(component, event, recordId);
	
	},
    
    
    /*search and clear for copay*/
    SearchCopay : function(component, event, helper) {        
        var accnt = component.get("v.Acc"); 
        var cnt = [];
                 for (var i = 0; i < accnt.length; i++) { 
                     var ac = accnt[i];
                     if(ac.User_Copay_Infant_Trans_Addtl_Uses__r != undefined)
                     for(var j = 0; j < ac.User_Copay_Infant_Trans_Addtl_Uses__r.length; j++){
                         var copaySearch = ac.User_Copay_Infant_Trans_Addtl_Uses__r[j];
                          console.log('Co-Pay search name' + component.get("v.copayName"));
                         console.log('Co-Pay name' + copaySearch.Name);                         
                         if(copaySearch.Name == component.get("v.copayName")){
                             console.log('CoPay id'+ copaySearch.Name);
                             cnt.push(copaySearch);
                         }
                     }                     
                 }
        component.set("v.copay",cnt);
        console.log('CoPay '+ component.get("v.copay"));
         component.set("v.isSearchCoPay","True");
    },
    ClearCopay : function(component, event, helper) {
        var accnt = component.get("v.Acc"); 
        		 var copay = [];
                 if(accnt !=  undefined)
                 for (var i = 0; i < accnt.length; i++) { 
                     var ac = accnt[i]; 
                     if(ac.User_Copay_Infant_Trans_Addtl_Uses__r != undefined)
                      for(var k = 0; k < ac.User_Copay_Infant_Trans_Addtl_Uses__r.length; k++){
                         if(k < 10){
                             var ccp = ac.User_Copay_Infant_Trans_Addtl_Uses__r[k];
                                 copay.push(ccp);
                         }
                     }  
                 }
         		component.set("v.copayName","");
                component.set("v.copay",copay);         
        	 	component.set("v.isSearchCoPay","False");
    },
	
	/*search and clear for college coach*/
	SearchCcoach : function(component, event, helper) {        
        var accnt = component.get("v.Acc");
        var ischange = "False";
        var cnt = [];
        		 if(accnt !=  undefined)
                 for (var i = 0; i < accnt.length; i++) { 
                     var ac = accnt[i];
                     if(ac.College_Coach_Topic_Elections__r != undefined)
                     for(var j = 0; j < ac.College_Coach_Topic_Elections__r.length; j++){
                         var cccoachSearch = ac.College_Coach_Topic_Elections__r[j];
                          //console.log('cccoachSearch'+component.get("v.ccoachName"));
                         
                         if(cccoachSearch.Name == component.get("v.ccoachName") && cccoachSearch.RecordTypeId == "01237000000TR6ZAAW"){
                                    cnt.push(cccoachSearch);
         							component.set("v.isSearchCcoach","01237000000TR6ZAAW"); 
                         }else if(cccoachSearch.Name == component.get("v.ccoachName")){
                                     //component.set("v.ccoach",cccoachSearch);
                                      cnt.push(cccoachSearch);
       								  component.set("v.isSearchCcoach","01237000000TR6YAAW");
                         }
                     }                     
                 }
        		   component.set("v.ccoach",cnt);
    },
    ClearCcoach : function(component, event, helper) {
        var accnt = component.get("v.Acc"); 
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
                 }
         		component.set("v.ccoach",Ccoach);
                component.set("v.ccoachName","");
         		component.set("v.isSearchCcoach","01237000000TR6YAAW");
    },
    
    editRecord : function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
             "recordId": component.get("v.recordId")
       });
        editRecordEvent.fire();
 }, 
 
  refreshcmp : function(component, event, helper) {
       
  var action = component.get("c.getAccount");
        action.setParams({
            "accountId": component.get("v.recordId")
        });
        console.log('Account id'+component.get("v.recordId"));
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Account id'+response.getReturnValue()); 
            if (state === "SUCCESS") {                   
                component.set("v.Acc",response.getReturnValue());
                $A.get('e.force:refreshView').fire();
            } else{
                //console.log('error Account id'+response.getReturnValue());
            }  
             
        });
    },
    print : function(component, event, helper) {
        window.open("/apex/CustomAccountDetails?exp=light&id="+component.get("v.recordId")+"&searchcopaytext="+component.get("v.copayName")+"&searchccoachtext="+component.get("v.ccoachName"));
    },
    
    sectionOne : function(component, event, helper) {
       helper.helperFun(component,event,'articleOne');
    },
    
   sectionTwo : function(component, event, helper) {
      helper.helperFun(component,event,'articleTwo');
    },
   
   sectionThree : function(component, event, helper) {
      helper.helperFun(component,event,'articleThree');
   },
   
   sectionFour : function(component, event, helper) {
      helper.helperFun(component,event,'articleFour');
   },
   
   sectionFive : function(component, event, helper) {
      helper.helperFun(component,event,'articleFive');
   },
   sectionSix : function(component, event, helper) {
      helper.helperFun(component,event,'articleSix');
   },
   sectionSeven : function(component, event, helper) {
      helper.helperFun(component,event,'articleSeven');
   },
   sectionEight : function(component, event, helper) {
      helper.helperFun(component,event,'articleEight');
   },
   sectionNine : function(component, event, helper) {
      helper.helperFun(component,event,'articleNine');
   },
   sectionTen : function(component, event, helper) {
      helper.helperFun(component,event,'articleTen');
   },
   sectionEleven : function(component, event, helper) {
      helper.helperFun(component,event,'articleEleven');
   },
   sectionTweleve : function(component, event, helper) {
      helper.helperFun(component,event,'articleTweleve');
   }
    
})