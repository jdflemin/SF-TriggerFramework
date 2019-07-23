/**
 * Created by Justin Fleming on 5/4/2019.
 */

public with sharing class TriggerDispatcher {
	public static void run(AbstractTrigger handler, System.TriggerOperation triggerOperation) {
		switch on triggerOperation {
			when BEFORE_INSERT {
				handler.isTriggerOnOrOff().castingMethod().beforeInsert();
			}
			when BEFORE_UPDATE {
				handler.isTriggerOnOrOff().castingMethod().beforeUpdate();
			}
			when BEFORE_DELETE {
				handler.isTriggerOnOrOff().castingMethod().beforeDelete();
			}
			when AFTER_INSERT {
				handler.isTriggerOnOrOff().castingMethod().afterInsert();
			}
			when AFTER_UPDATE {
				handler.isTriggerOnOrOff().castingMethod().afterUpdate();
			}
			when AFTER_DELETE {
				handler.isTriggerOnOrOff().castingMethod().afterDelete();
			}
			when AFTER_UNDELETE {
				handler.isTriggerOnOrOff().castingMethod().afterUndelete();
			}
		}
	}
}