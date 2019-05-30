({
    doInit : function(component, event, helper) {
        var mode = component.get('v.mode');
        if(mode=='Input')component.set('v.inputModeBool', true);
        var action = component.get("c.getFields");
        var objectApiName = component.get("v.objectApiName");
        var fsName = component.get("v.fieldSetName");
        action.setParams({typeName: objectApiName, fsName: fsName});
        action.setCallback(this, function(a) {
            var fields = a.getReturnValue();
            component.set("v.fields", fields);
        });
        $A.enqueueAction(action);  
        
    },
    fireRefreshView : function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    },
    handleToggle : function(component, event, helper) {        
        var inputModeBool = component.get("v.inputModeBool");
        component.set("v.inputModeBool", !inputModeBool);
    },
    handleClick : function (component, event, helper) {
        var mode = component.get('v.mode');
        console.log('Mode: '+component.get('v.mode'));
        if(mode == 'Input') {
            component.set('v.mode','Output');
            component.set('v.inputModeBool', false);
        }
        else {
            component.set('v.mode','Input');
            component.set('v.inputModeBool', true);
        }
        console.log('Mode: '+component.get('v.mode'));
        console.log('Mode: '+component.get('v.inputModeBool'));
        
    },
    onSaveClick : function (component, event, helper) {
        var mode = component.get('v.mode');
        console.log('Mode: '+component.get('v.mode'));
        var inputMode = component.get('v.inputModeBool');
        component.set('v.inputModeBool', !inputMode);
        if(mode == 'Input') {
            component.set('v.mode','Output');
            
        }
        else {
            component.set('v.mode','Input');
            
        }
        console.log('Mode: '+component.get('v.mode'));
        console.log('Mode: '+component.get('v.inputModeBool'));
        
    },
    UpdateColor: function(component) {
        var img = component.find('imgOver');
        
        $A.util.addClass(img,'slds-button_icon_hover');
        
    }
})