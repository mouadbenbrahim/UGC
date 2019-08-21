/**
 * Created by mouad on 05/09/2018.
 */

public with sharing class SM_DebitMemo {

    //TODO Notes: quand on fait un cancel: dans cancel dans une date non encore invoice(ex. futur), avec un runbill date target qui donne droit un credit memo: seule l'invoice est genere, le credit memo est genere si on execute un bill run manuellement
    //TODO: quand on fait un cancel: dans cancel dans une date non encore invoice(ex. futur), avec un runbill date target qui donne droit un credit memo: seule l'invoice est genere, le credit memo est genere si on execute un bill run manuellement

    /*public static String zEntityId = '8adce421-63ec-c07b-0163-f45782667179'; // France

    public static WSZ.DebitMemoOut cree(String accountId, String chargeId, Double itemAmount, String effDate) {
        String endpoint = '/v1/debitmemos';
        String method = 'POST';
        String wsIn = '';
        String wsOut = '';

        WSZ.DebitMemoCreateInp inp = new WSZ.DebitMemoCreateInp();
        inp.accountId = accountId;
        inp.effectiveDate = effDate;
        inp.effectiveDate = effDate;
        inp.reasonCode = 'Correcting invoice error';
        //WSZ.memoItemCharge charge = new WSZ.memoItemCharge(chargeId,itemAmount);
        inp.charges.add(new WSZ.memoItemCharge(chargeId,itemAmount));
        //inp.charges[0].chargeId = chargeId;
        //inp.charges[0].memoItemAmount = itemAmount;

        // Retrieve Zuora token
        String accessToken = WS001_CallZuora.access_token;

        wsIn = (String) JSON.serialize(inp);
        wsOut = WS001_CallZuora.sendRequest(accessToken, endpoint, zEntityId, method, wsIn, 'type1', null);
        wsOut = wsOut.replace('number','numberx');
        //wsOut = wsOut.replace('currency', 'currencyx');
        return (WSZ.DebitMemoOut) JSON.deserializeStrict(wsOut, WSZ.DebitMemoOut.class);
    }*/

//    public static WSZ.DebitMemoOut post(String memoId) {
//    }

}