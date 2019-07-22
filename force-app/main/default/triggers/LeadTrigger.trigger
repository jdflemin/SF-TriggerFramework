/**
 * Created by Justin Fleming on 5/4/2019.
 */

trigger LeadTrigger on Lead (before insert, before update, before delete, after insert, after update,
	after delete, after undelete) {
		TriggerDispatcher.run(
            new LeadTriggerHandler(Trigger.operationType), 
            Trigger.operationType
        );

}