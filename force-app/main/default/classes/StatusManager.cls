/**
 * Created by Alona Riabchenko on 01.10.2017.
 */

public abstract with sharing class StatusManager {
	protected TelephonyBoardController telephonyBoardContr;

	public interface Status {
		void setTelephonyBoardContr(TelephonyBoardController telephonyBoardContr);
		void run(String jsResponce);
	}

	public class Status1 extends StatusManager implements StatusManager.Status {
		public String banerColor {get; set;}
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
			telephonyBoardContr.showComponentsForAvailable();
		}
	}

	public class Status2 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
			if (telephonyBoardContr.callEvent == null || telephonyBoardContr.callEvent.Id == null || telephonyBoardContr.infoCallForPage.agent.statusColor == DataMaps.OUTGOING_CALL) {
				onCall(jsResponce);
				telephonyBoardContr.rerenderComponentsForInOutCall(jsResponce);
			}
		}
	}

	public class Status7 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
		}
	}

	public class Status8 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
			onCall(jsResponce);
			telephonyBoardContr.rerenderComponentsForInOutCall(jsResponce);
		}
	}

	public class Status14 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
		}
	}


	public class Status13 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {
		}
	}

	public class Status16 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {

		}
	}

	public class Status25 extends StatusManager implements StatusManager.Status {
		public void setTelephonyBoardContr(TelephonyBoardController telephonyBoardC) {
			telephonyBoardContr = telephonyBoardC;
		}
		public void run(String jsResponce) {

		}
	}

	protected void onCall(String jsResponce) {
		telephonyBoardContr.contacts = new List<SObject>();
		telephonyBoardContr.callEvent = EventManager.createEventIfCallComing(telephonyBoardContr.infoCallForPage);
		setMatchedContacts(telephonyBoardContr.infoCallForPage);
		setRelatedContact();
	}

	private void setMatchedContacts(CaseIncomingCall pollingCallInfo) {
		List<String> contactIds = pollingCallInfo.Sf.getContactIds();
		telephonyBoardContr.contacts.clear();
		List<SObject> contactRecords = getRecords(new String[]{'Name','LastName','FirstName'},'Contact',contactIds);
		telephonyBoardContr.contacts.addAll(contactRecords);

		List<SObject> leads = getRecords(new String[]{'Name','LastName','FirstName'},'Lead',contactIds);
		telephonyBoardContr.contacts.addAll(leads);

		if(Schema.sObjectType.Account.fields.getMap().containsKey( 'isPersonAccount' )){
			List<SObject> personAccountRecords = getRecords(new String[]{'Name',' PersonContactId', 'isPersonAccount'},'Account',contactIds);
			telephonyBoardContr.contacts.addAll(personAccountRecords);
		}else{
			List<SObject> accountRecords = getRecords(new String[]{'Name'},'Account',contactIds);
			telephonyBoardContr.contacts.addAll(accountRecords);
		}
	}

	private static List<SObject> getRecords(List<String> fieldList, String obj, List<String> contactIds) {
		String queryAllRecords = 'SELECT ' + String.join(fieldList,',') +' FROM ' + obj + ' WHERE Id IN : contactIds';
		return Database.query(queryAllRecords);
	}

	private void setRelatedContact() {
		Map<ID, SObject> contactsMap = new Map<Id, SObject>();

		if (telephonyBoardContr.callEvent.Id == null) {
			return;
		}

		List<Event> events = [
				SELECT whoId
						, WhatId
				FROM Event
				WHERE Id = :telephonyBoardContr.callEvent.Id
		];

		if (events.isEmpty()) {
			return;
		}

		List<Contact> contactRecords = [
				SELECT Name, LastName, FirstName
				FROM Contact
				WHERE Id = :events[0].whoId
		];
		contactsMap.putAll(new Map<ID, SObject>((List<SObject>) contactRecords));

		List<Account> accountRecords = [
				SELECT Name
				FROM Account
				WHERE Id = :events[0].WhatId
		];

		contactsMap.putAll(new Map<ID, SObject>((List<SObject>) accountRecords));

		List<Lead> leads = [
				SELECT Name, LastName, FirstName
				FROM Lead
				WHERE Id = :events[0].whoId
		];
		contactsMap.putAll(new Map<ID, SObject>((List<SObject>) leads));

		Map<Id, SObject> mergedMap = new Map<Id, SObject>(telephonyBoardContr.contacts);
		mergedMap.putAll(contactsMap);
		telephonyBoardContr.contacts = mergedMap.values();
	}
}