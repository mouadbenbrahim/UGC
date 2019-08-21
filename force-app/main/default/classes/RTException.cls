/**
 * Created by mouad on 11/11/2018.
 */

public with sharing class RTException extends Exception {

    public Integer Code;

    public RTException(RTExceptionCode e){
        this.setMessage(e.libelle + ' - ErrorCode: ' + e.code) ;
        //this.setMessage(e.libelle);
        this.Code = e.code;
    }

}