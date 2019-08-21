/**
 * Created by Valera on 03.10.2017.
 */

public with sharing class PhoneUserContact {

    public Id id {get;set;}
    public String type {get;set;}
    public String agent_id {get;set;}
    public String service_id {get;set;}
    public String group_id_inbound {get;set;}

    public PhoneUserContact(Id id, String type,String agent_id,String service_id, String group_id_inbound){
        this.id = id;
        this.type = type;
        this.agent_id = agent_id;
        this.service_id = service_id;
        this.group_id_inbound = group_id_inbound;
    }
}