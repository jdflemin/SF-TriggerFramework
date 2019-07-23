/**
 * Created by Justin Fleming on 5/4/2019
 *	Updated on 7/23/19
 */

public abstract class AbstractTrigger {

	// public variables for trigger lists and maps
	public List<SObject> triggerNew;
	public List<SObject> triggerOld;
	public Map<Id, SObject> newMap;
	public Map<Id, SObject> oldMap;
	// true if trigger is not to run, false if trigger is supposed to run
	public Boolean bypassTrigger {
		get { return bypassTrigger != null ? bypassTrigger : false; }
		set;
	}
	// dynamically get sobject type and convert to string
	private String sObjectType {
		get { return trigger.new.isEmpty() ? 
									String.valueOf(trigger.old[0].getSObjectType()) : 
									String.valueOf(trigger.new[0].getSObjectType()); 
		} 
	}
	// custom setting if true, then custom setting is set to turn off triggers
	private Boolean customSettingsTriggerSwitchOff {
		get { return customSettingsTriggerSwitchOff != null ? customSettingsTriggerSwitchOff : false; }
		set;
	}
	// custom metadata which can override the custom setting, if trigger off is true then bypass trigger
	private TriggerControl__mdt triggerControlMetadata {
		get { return [
						SELECT Id, TriggerOff__c, OverrideCustomSettings__c 
						FROM TriggerControl__mdt 
						WHERE ObjectAPIName__c = :sObjectType 
						LIMIT 1
					];
		}
	}
	// constructor which calls a helper to set the context variables, takes in the trigger operation
	public AbstractTrigger(System.TriggerOperation triggerOperation) {
		this.setContextVariables(triggerOperation);	
	}
	// gets custom settings and custom metadata, sets bypassTrigger variable and returns AbstractTrigger
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
	// sets context variables
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
	// stubs for abstract and virtual methods. 
	// Abstract method has to be overriden.
	public abstract AbstractTrigger castingMethod();
	// virtual methods can be overriden.
	public virtual void beforeInsert() { return; }
	public virtual void beforeUpdate() { return; }
	public virtual void beforeDelete() { return; }
	public virtual void afterInsert() { return; }
	public virtual void afterUpdate() { return; }
	public virtual void afterDelete() {	return; }
	public virtual void afterUndelete() {	return;	}
}