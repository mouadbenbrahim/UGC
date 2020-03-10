/**
 * Created by mouad on 04/11/2018.
 */
@RestResource(urlMapping='/Offre/*')
global with sharing class WS003_Offre {

    @HttpPost
    global static void offreHttpPost() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WSZ.GenericOut wsOut = new WSZ.GenericOut();

        switch on req.params.get('action') {
            when 'subOffre'{
                subOffre(req,res);
            }
            when 'consommeCoupon'{
                consommeCoupon(req,res);
            }
            when 'subOffreTest'{
                subOffreTest(req,res);
            }            
            when else{
                wsOut.Success = false;
                wsOut.Message = 'Requette inconnue, verifiez les parametres';
                res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            }
        }
    }

    public static void subOffre(RestRequest req, RestResponse res) {

        WSZ.SubOffreOut wsOut = new WSZ.SubOffreOut();
        Blob body = req.requestBody;
        String respBodyStr = null;
        WSZ.SubOffreIn wsIn = new WSZ.SubOffreIn();
        try {
            wsIn = (WSZ.SubOffreIn) JSON.deserializeStrict(body.toString(), WSZ.SubOffreIn.class);
            List<WSZ.SubProduct> subProducts = SM_Offre.getSubOffres(wsIn);
            wsOut.Success = true;
            wsOut.Message = null;
            wsOut.subProducts = subProducts.clone();
        } catch (RTException e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage();
            wsOut.ErrorCode = e.Code;
        } catch (Exception e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage() + e.getStackTraceString();
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            respBodyStr = res.responseBody.toString();
            respBodyStr = respBodyStr.replace('"lieu_c"', '"Lieu__c"');
            respBodyStr = respBodyStr.replace('"intitule_c"', '"Intitule__c"');
            respBodyStr = respBodyStr.replace('"agent_c"', '"Agent__c"');
            res.responseBody = Blob.valueOf(respBodyStr);
        }
    }

    public static void consommeCoupon(RestRequest req, RestResponse res) {

        WSZ.GenericOut wsOut = new WSZ.GenericOut();
        Blob body = req.requestBody;
        WSZ.CouponIn wsIn = new WSZ.CouponIn();
        try {
            wsIn = (WSZ.CouponIn) JSON.deserializeStrict(body.toString(), WSZ.CouponIn.class);
            SM_Coupon.consommer(wsIn.coupon,Date.valueOf(wsIn.dateSub));
            wsOut.Success = true;
            wsOut.Message = null;
            wsOut.Name = wsIn.coupon;
            // wsOut.SubOut = subProducts.clone();
            //res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
        } catch (RTException e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage();
            wsOut.ErrorCode = e.Code;
        } catch (Exception e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage();
        } finally {
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
        }
    }

    public static void subOffreTest(RestRequest req, RestResponse res) {

        WSZ.SubOffreOut wsOut = new WSZ.SubOffreOut();
        Blob body = req.requestBody;
        String respBodyStr = null;
        WSZ.SubOffreIn2 wsIn = new WSZ.SubOffreIn2();
        Datetime dt1;
        try {
            wsIn = (WSZ.SubOffreIn2) JSON.deserializeStrict(body.toString(), WSZ.SubOffreIn2.class);
            dt1 = wsIn.dt1;
            System.debug('MBEN Datetime: ' + dt1);
            List<WSZ.SubProduct> subProducts = new List<WSZ.SubProduct>();
            wsOut.Success = true;
            wsOut.Message = null;
            wsOut.subProducts = subProducts.clone();
        } catch (RTException e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage();
            wsOut.ErrorCode = e.Code;
        } catch (Exception e) {
            wsOut.Success = false;
            wsOut.Message = e.getMessage() + e.getStackTraceString();
        } finally {
            //return wsOut;
            res.responseBody = Blob.valueOf(JSON.serializePretty(wsOut, true));
            respBodyStr = res.responseBody.toString();
            // respBodyStr = respBodyStr.replace('"lieu_c"', '"Lieu__c"');
            // respBodyStr = respBodyStr.replace('"intitule_c"', '"Intitule__c"');
            // respBodyStr = respBodyStr.replace('"agent_c"', '"Agent__c"');
            res.responseBody = Blob.valueOf(respBodyStr);
        }
    }    

}