/**
 * Created by Alona Riabchenko on 29.09.2017.
 */

public with sharing class ClickToDail {
	public static void consumeObject(JSONParser parser) {
		Integer depth = 0;
		do {
			JSONToken curr = parser.getCurrentToken();
			if (curr == JSONToken.START_OBJECT ||
					curr == JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == JSONToken.END_OBJECT ||
					curr == JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}


	public String number_Z { get; set; } // in json: number
	public String objectId { get; set; }
	public String objectName { get; set; }
	public String object_Z { get; set; } // in json: object
	public String displayName { get; set; }
	public String callid { get; set; }
	public String error { get; set; }

	public ClickToDail(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'number') {
						number_Z = parser.getText();
					} else if (text == 'recordId') {
						objectId = parser.getText();
					} else if (text == 'recordName') {
						objectName = parser.getText();
					} else if (text == 'objectType') {
						object_Z = parser.getText();
					} else if (text == 'displayName') {
						displayName = parser.getText();
					} else if (text == 'error') {
						error = parser.getText();
					}else if (text == 'callid') {
						callid = parser.getText();
					} else {
						consumeObject(parser);
					}
				}
			}
		}
	}

	public static ClickToDail parse(String json) {
		return new ClickToDail(System.JSON.createParser(json));
	}
}