/**
 * Created by Justin Fleming on 5/4/2019.
 */

/**
 * Created by Justin Fleming on 5/4/2019.
 */

public abstract class AbstractTrigger {

	public List<SObject> triggerNew;
	public List<SObject> triggerOld;
	public Map<Id, SObject> newMap;
	public Map<Id, SObject> oldMap;
    	public System.TriggerOperation triggerOperation;
	public Schema.SObjectType sObjectType {
		get { return trigger.new.isEmpty() ? trigger.old[0].getSObjectType() : trigger.new[0].getSObjectType(); } 
	}
	
	public AbstractTrigger(System.TriggerOperation triggerOperation) {
        this.triggerOperation = triggerOperation;
		this.setContextVariables(triggerOperation);	
		castingMethod();
	}

	public abstract void castingMethod();

	public virtual void beforeInsert() {
		return;
	}
	public virtual void beforeUpdate() {
		return;
	}
	public virtual void beforeDelete() {
		return;
	}
	
	public virtual void afterInsert() {
		return;
	}
	public virtual void afterUpdate() {
		return;
	}
	public virtual void afterDelete() {
		return;
	}
	public virtual void afterUndelete() {
		return;
	}
	
	private void setContextVariables(System.TriggerOperation triggerOperation){
		switch on triggerOperation {
			when BEFORE_INSERT {
				this.triggerNew = Trigger.new;
			}
			when AFTER_INSERT, AFTER_UNDELETE {
				this.triggerNew = Trigger.new;
				this.newMap = Trigger.newMap;
			}
			when BEFORE_DELETE, AFTER_DELETE {
				this.triggerOld = Trigger.old;
				this.oldMap = Trigger.oldMap;
			}
			when BEFORE_UPDATE, AFTER_UPDATE {
				this.triggerNew = Trigger.new;
				this.triggerOld = Trigger.old;
				this.newMap = Trigger.newMap;
				this.oldMap = Trigger.oldMap;
			}
			when else {
				System.debug('Error');
			}
		}
	}
}
