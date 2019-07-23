/**
 * Created by Justin Fleming on 5/4/2019
 *	Updated on 7/23/19
 */

public with sharing class TriggerDispatcher {
	// main method that dispatches to the appropriate trigger context
	public static void run(AbstractTrigger handler, System.TriggerOperation triggerOperation) {
		// hander first determines if trigger is on or off
		handler = handler.isTriggerOnOrOff();
		// if trigger is off end execution
		if (handler.bypassTrigger) return;
		// else cast methods
		else handler = handler.castingMethod();
		// run appropriate trigger context
		switch on triggerOperation {
			when BEFORE_INSERT {
				handler.beforeInsert();
			}
			when BEFORE_UPDATE {
				handler.beforeUpdate();
			}
			when BEFORE_DELETE {
				handler.beforeDelete();
			}
			when AFTER_INSERT {
				handler.afterInsert();
			}
			when AFTER_UPDATE {
				handler.afterUpdate();
			}
			when AFTER_DELETE {
				handler.afterDelete();
			}
			when AFTER_UNDELETE {
				handler.afterUndelete();
			}
		}
	}
}