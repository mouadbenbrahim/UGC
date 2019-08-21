/**
 * Created by Alona Riabchenko on 30.09.2017.
 */

public with sharing class CaseOutboundCall {
		public String error;
		public String errormsg;
		public String callid;


	public static CaseOutboundCall parse(String json) {
		return (CaseOutboundCall) System.JSON.deserialize(json, CaseOutboundCall.class);
	}
}