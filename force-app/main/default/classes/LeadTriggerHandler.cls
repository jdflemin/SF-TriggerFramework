/**
 * Created by Justin Fleming on 5/4/2019
*	Updated on 7/23/19
 */

public class LeadTriggerHandler extends AbstractTrigger{
	// constructor which takes triggerOperation for the AbstractTrigger
	public LeadTriggerHandler(System.TriggerOperation triggerOperation) {
		super(triggerOperation);
	}
	// method must be implemented to cast to appropriate type
	public override AbstractTrigger castingMethod() {
		if(this.triggerNew != null) this.triggerNew = (List<Lead>)this.triggerNew;
		if(this.triggerOld != null) this.triggerOld = (List<Lead>)this.triggerOld;
		if(this.newMap != null) this.newMap = (Map<Id, Lead>)this.newMap;
		if(this.oldMap != null) this.oldMap = (Map<Id, Lead>)this.oldMap;	
		return this;
	}
	/*
		Context Methods
	*/
	public override void beforeInsert() {
		// code to call domain and selector layer
	}

}