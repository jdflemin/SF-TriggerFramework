/**
 * Created by Justin Fleming on 5/4/2019.
 */

public with sharing class TriggerDispatcher {
	public static void run(AbstractTrigger handler) {
        System.TriggerOperation triggerOperation = handler.triggerOperation;
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
