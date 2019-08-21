public with sharing class EventPageController {
	@TestVisible
	private Event lastEvt = new Event();
	public Boolean logSet = false;
	public Boolean disableTextArea = false;
	public TelephonyBoardController telephonyBoardCntr { get; set; }
	@TestVisible
	private String description;

	public Boolean getDisableTextArea() {
		return disableTextArea;
	}

	public void setDisableTextArea(Boolean var) {
		this.disableTextArea = var;
	}
	public Boolean getLogSet() {
		return logSet; 
	}
	public void setLogSet(Boolean logSet) {
		this.logSet = logSet;
	}
	public void setDescription(String descr){
		description = descr;
	}
	public String getDescription(){
		if(telephonyBoardCntr != null
				&& telephonyBoardCntr.callEvent != null
				&& telephonyBoardCntr.callEvent.Id != null
				&& lastEvt.Id != telephonyBoardCntr.callEvent.Id ) {
			description = telephonyBoardCntr.callEvent.Description;
			disableTextArea = false;
			logSet = false;
			lastEvt = telephonyBoardCntr.callEvent;
		}
		return description;
	}

	public void addText() {
		disableTextArea = false;
		logSet = false;
	}
	public void saveEvent() {
		if(telephonyBoardCntr != null && telephonyBoardCntr.callEvent != null
				&& telephonyBoardCntr.callEvent.Id != null && lastEvt.Id != telephonyBoardCntr.callEvent.Id ) {
			lastEvt = telephonyBoardCntr.callEvent;
		}
		logSet = true;
		disableTextArea = true;
		telephonyBoardCntr.callEvent.Description = description;
		lastEvt.Description = description;
		upsert lastEvt;
	}
}