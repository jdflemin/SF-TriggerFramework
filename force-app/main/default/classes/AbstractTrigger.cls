/**
 * Created by Justin Fleming on 5/4/2019.
 */

public abstract class AbstractTrigger {

	public List<SObject> triggerNew;
	public List<SObject> triggerOld;
	public Map<Id, SObject> newMap;
	public Map<Id, SObject> oldMap;
	
	public Boolean bypassTrigger {
		get { return bypassTrigger != null ? bypassTrigger : false; }
		set;
	}

	private String sObjectType {
		get { return trigger.new.isEmpty() ? 
									String.valueOf(trigger.old[0].getSObjectType()) : 
									String.valueOf(trigger.new[0].getSObjectType()); 
		} 
	}

	private Boolean customSettingsTriggerSwitchOff {
		get { return customSettingsTriggerSwitchOff != null ? customSettingsTriggerSwitchOff : false; }
		set;
	}
	
	private TriggerControl__mdt triggerControlMetadata {
		get { return [
						SELECT Id, TriggerOff__c, OverrideCustomSettings__c 
						FROM TriggerControl__mdt 
						WHERE ObjectAPIName__c = :sObjectType 
						LIMIT 1
					];
		}
	}
	
	public AbstractTrigger(System.TriggerOperation triggerOperation) {
		this.setContextVariables(triggerOperation);	
	}

	public AbstractTrigger isTriggerOnOrOff() {
		Map<String, TriggerSwitch__c> customSettingsMap = new Map<String, TriggerSwitch__c> {
			UserInfo.getUserId() => TriggerSwitch__c.getValues(UserInfo.getUserId()),
			UserInfo.getProfileId() => TriggerSwitch__c.getValues(UserInfo.getProfileId()),
			'Org' => TriggerSwitch__c.getOrgDefaults()
		};

		for (String s : customSettingsMap.keySet()) {
			if (customSettingsMap.get(s) != null) {
				customSettingsTriggerSwitchOff = customSettingsMap.get(s).TriggerOff__c;
				break;
			}
		}

		if (triggerControlMetadata.OverrideCustomSettings__c) bypassTrigger = triggerControlMetadata.TriggerOff__c;
		else bypassTrigger = customSettingsTriggerSwitchOff;

		return this;
	}

		private void setContextVariables(System.TriggerOperation triggerOperation) {
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

	public abstract AbstractTrigger castingMethod();
	public virtual void beforeInsert() { return; }
	public virtual void beforeUpdate() { return; }
	public virtual void beforeDelete() { return; }
	public virtual void afterInsert() { return; }
	public virtual void afterUpdate() { return; }
	public virtual void afterDelete() {	return; }
	public virtual void afterUndelete() {	return;	}
}