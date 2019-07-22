/**
 * Created by Justin Fleming on 5/4/2019.
 */

public class LeadTriggerHandler extends VirtualTrigger{
	
	public LeadTriggerHandler(System.TriggerOperation triggerOperation) {
		super(triggerOperation);
		setSObjectType();
	}
	
	public override void setSObjectType() {
		System.debug(this.triggerNew);
	}

	public override void beforeInsert() {
		// code to call domain and selector layer
	}

}