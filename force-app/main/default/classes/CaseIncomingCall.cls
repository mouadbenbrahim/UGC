/**
 * Created by Valera on 19.09.2017.
 */

public with sharing class CaseIncomingCall {

    public Sf sf { get; set; }
    public Agent agent { get; set; }
    public Call call { get; set; }

    public static String jsonExapmle0 = '{' +
            '  \"sf\": {' +
            '    \"contacts\": [' +
            '        {' +
            '            \"type\": \"Contact\",' +
            '            \"service_id\": null,' +
            '            \"id\": \"001f400000A1T5T\",' +
            '            \"group_id\": null,' +
            '            \"agent_id\": null' +
            '        },' +
            '        {' +
            '            \"type\": \"Account\",' +
            '            \"service_id\": null,' +
            '            \"id\": \"003f4000007TrxQ\",' +
            '            \"group_id\": null,' +
            '            \"agent_id\": null' +
            '        }' +
            '    ],' +
            '  },' +
            '  \"agent\": {' +
            '    \"id\": \"1017293\",' +
            '    \"sda\": \"0123456789\",' +
            '    \"status\": \"2\",' +
            '    \"name\": \"John Doe\",' +
            '    \"change_time\": \"2017-09-08 17:51:38\"' +
            '  },' +
            '  \"call\": {' +
            '  }' +
            '}';

    public static String json = '{'+
            '  \"sf\": {'+
            '    \"phone\": 7852416200,'+
            '    \"contacts\": ['+
            '        {'+
            '            \"type\": \"Contact\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0030Y00000VCN2wQAH\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        },'+
            '        {'+
            '            \"type\": \"Account\",'+
            '            \"service_id\": null,'+
            '            \"id\": \"0010Y00000anFKOQA2\",'+
            '            \"group_id\": null,'+
            '            \"agent_id\": null'+
            '        }'+
            '    ],'+
            '    \"organization_id\": \"00D0Y000002iyaOUAQ\",'+
            '    \"user_id\": \"0050Y000002wveiQAA\"'+
            '  },'+
            '  \"agent\": {'+
            '    \"id\": \"1003203\",'+
            '    \"sda\": \"0123456789\",'+
            '    \"status\": \"2\",'+
            '    \"name\": \"John Doe\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\"'+
            '  },'+
            '  \"call\": {'+
            '    \"callid\": \"V44200717090800ffcba\",'+
            '    \"start_time\": \"2017-09-08 17:51:38\",'+
            '    \"agent_uid\": \"1003203\",'+
            '    \"status\": \"3\",'+
            '    \"change_time\": \"2017-09-08 17:51:38\",'+
            '    \"service_uid\": \"11089\",'+
            '    \"group_uid\": \"55522\",'+
            '    \"product_uid\": \"1\",'+
            '    \"sda\": \"7852416200\",'+
            '    \"ref\": \"Call test\"'+
            '  }'+
            '}';


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

    public class Agent {
        public String id { get; set; }
        public String sda { get; set; }
        public String status { get; set; }
        public String name { get; set; }
        public String change_time { get; set; }
        public String company_uid { get; set; }
        public String statusValue { get; set; }
        public String statusValueAgent { get; set; }
        public String statusColor { get; set; }

        public Agent(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'sda') {
                            sda = parser.getText();
                        } else if (text == 'status') {
                            status = parser.getText();
                            if (DataMaps.allStatuses.contains(status)) {
                                statusValue = 'Status' + status;
                                statusValueAgent = 'StatusAgent' + status;
                            } else {
                                statusValue = 'Status' + '003';
                            }
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'change_time') {
                            change_time = parser.getText();
                        } else if (text == 'company_uid') {
                            company_uid = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Agent consuming unrecognized property: ' + text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public class Call {
        public String callid { get; set; }
        public String start_time { get; set; }
        public String agent_uid { get; set; }
        public String status { get; set; }
        public String change_time { get; set; }
        public String service_uid { get; set; }
        public String group_uid { get; set; }
        public String product_uid { get; set; }
        public String service_label { get; set; }
        public String sda { get; set; }
        public String ref { get; set; }
        public String company_uid { get; set; }

        public Call(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'callid') {
                            callid = parser.getText();
                        } else if (text == 'start_time') {
                            start_time = parser.getText();
                        } else if (text == 'agent_uid') {
                            agent_uid = parser.getText();
                        } else if (text == 'status') {
                            status = parser.getText();
                        } else if (text == 'change_time') {
                            change_time = parser.getText();
                        } else if (text == 'service_uid') {
                            service_uid = parser.getText();
                        } else if (text == 'group_uid') {
                            group_uid = parser.getText();
                        } else if (text == 'product_uid') {
                            product_uid = parser.getText();
                        } else if (text == 'service_label') {
                            service_label = parser.getText();
                        } else if (text == 'sda') {
                            sda = parser.getText();
                        } else if (text == 'ref') {
                            ref = parser.getText();
                        } else if (text == 'company_uid') {
                            company_uid = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Call consuming unrecognized property: ' + text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    @TestVisible
    public class Sf {
        public String phone { get; set; }
        public String organization_id { get; set; }
        public String user_id { get; set; }
        public List<Contacts> contacts { get; set; }

        public Sf() {
        }

        public Sf(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'phone') {
                            phone = parser.getText();
                        } else if (text == 'contacts') {
                            contacts = new List<Contacts>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                contacts.add(new Contacts(parser));
                            }
                        } else if (text == 'organization_id') {
                            organization_id = parser.getText();
                        } else if (text == 'user_id') {
                            user_id = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Sf consuming unrecognized property: ' + text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }

        public List<String> getContactIds() {
            List<String> result = new List<String>();
            if (contacts == null) {
                return result;
            }
            for (Contacts contact : contacts) {
                if (contact != null || contact.Id != null) {
                    result.add(contact.Id);
                }
            }
            return result;
        }
    }

    public class Contacts {
        public String type_Z { get; set; } // in json: type
        public String service_id { get; set; }
        public String id { get; set; }
        public String group_id { get; set; }
        public String agent_id { get; set; }

        public Contacts() {
        }

        public Contacts(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type_Z = parser.getText();
                        } else if (text == 'service_id') {
                            service_id = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'group_id') {
                            group_id = parser.getText();
                        } else if (text == 'agent_id') {
                            agent_id = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Contacts consuming unrecognized property: ' + text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }

    public CaseIncomingCall(JSONParser parser) {
        while (parser.nextToken() != JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != JSONToken.VALUE_NULL) {
                    if (text == 'sf') {
                        sf = new Sf(parser);
                    } else if (text == 'agent') {
                        agent = new Agent(parser);
                    } else if (text == 'call') {
                        call = new Call(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'CaseIncomingCall consuming unrecognized property: ' + text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }


    public static CaseIncomingCall parse(String json) {
        return new CaseIncomingCall(System.JSON.createParser(json));
    }
}