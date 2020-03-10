/**
 * Created by mouad on 11/11/2018.
 */

public without sharing class RTException extends Exception {

    public Integer Code;
    // public WSZ.ProcessLog pLog;

    public RTException(RTExceptionCode e){
        this.setMessage(e.libelle + ' - ErrorCode: ' + e.code) ;
        //this.setMessage(e.libelle);
        this.Code = e.code;
    }

    public RTException(RTExceptionCode e, ProcessLog__c pLog){
        String msg = e.libelle + ' - ErrorCode: ' + e.code;
        this.setMessage(msg) ;
        //this.setMessage(e.libelle);
        this.Code = e.code;
        
        // Insert processLog
        if(e.code<5000 && e.code>=6000)
        {
            pLog.Code__c = e.code;
            pLog.Message__c = msg + pLog.Message__c;
            insert pLog;
        }
    }


}