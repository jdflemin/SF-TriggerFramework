/**
 * Created by Justin Fleming on 5/4/2019.
 */

public class LeadTriggerHandler extends AbstractTrigger{
	
	public LeadTriggerHandler(System.TriggerOperation triggerOperation) {
		super(triggerOperation);
	}
	
	public override AbstractTrigger castingMethod() {
		if(this.triggerNew != null) this.triggerNew = (List<Lead>)this.triggerNew;
		if(this.triggerOld != null) this.triggerOld = (List<Lead>)this.triggerOld;
		if(this.newMap != null) this.newMap = (Map<Id, Lead>)this.newMap;
		if(this.oldMap != null) this.oldMap = (Map<Id, Lead>)this.oldMap;	
		return this;
	}

	public override void beforeInsert() {
		if(triggerOff) return;
		// code to call domain and selector layer
	}

}