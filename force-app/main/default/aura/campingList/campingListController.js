({
   doInit : function (component, event, helper) {
        var action = component.get("c.getItems");
        action.setCallback(this,function (response) { 
        	var campingItems = response.getReturnValue();
            component.set("v.items",campingItems);
        });
        $A.enqueueAction(action);
    },    
    handleAddItem: function(component, event, helper) {
        var item = event.getParam("item");       
        var action = component.get("c.saveItem");
        action.setParams({
            "item": item
        });  
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {        
                var theItems = component.get("v.items");
                theItems.push(item);
                component.set("v.items",theItems);
            }
        });
        $A.enqueueAction(action);
    }
})