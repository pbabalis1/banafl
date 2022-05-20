({
	doInit : function(cmp) {
        var objType = cmp.get("v.objectType");
        var recId = cmp.get("v.recordId");
        
        // get timeline items
        var action;
        
        if (objType == "Contact") {
            action = cmp.get("c.allAffiliatedDepartments");
            action.setParams({
                contactId : recId
            });
        } else if (objType == "Account") {
            action = cmp.get("c.allAccountAffiliatedDepartments");
            action.setParams({
                accountId : recId
            });
        }
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                cmp.set("v.departments", response.getReturnValue());
            } else if (state === "ERROR") {
            	var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                	console.log("Unknown error");
                }
            }
        }); 
        
        //adds the server-side action to the queue        
        $A.enqueueAction(action);
        
	}, 
})