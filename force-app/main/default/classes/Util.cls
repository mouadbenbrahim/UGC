/**
 * Created by mouad on 31/08/2018.
 */

public with sharing class Util {

    //Constants
    public final static Integer PREAVIS_FR = 2;
    public final static Integer PREAVIS_BE = 2;
    public final static Set<String> FRANCE = new Set<String>{'France','FR','FRANCE','français','033'};
    public final static Set<String> BELGIQUE = new Set<String>{'Belgique','BE','BELGIQUE','BELGIUM','Belgium','belge','032'};


    //Convert SF Date Object to Z date = 'YYYY-MM-DD'
    public static String zDate(Date mDate) {
        system.debug('##MNE Util zDate mDate >> '+mDate);
        if(mDate == null){
            return null;
        }
        /*String zDate;
        zDate = String.valueOf(mDate.year()) + '-' + String.valueOf(mDate.month()) + '-' + String.valueOf(mDate.day());
        return zDate;*/
        String zDate = DateTime.newInstance(mDate.year(), mDate.month(), mDate.day()).format('yyyy-MM-dd');
        return zDate;
    }

    //Retrieve LastDay of the month
    public static Date finMois(Date mDate) {
        return mDate.toStartOfMonth() + date.daysInMonth(mDate.year(), mDate.month()) - 1;
    }


    public static Integer PREAVIS(String pays){
        Integer preavis;
        if (BELGIQUE.contains(pays)) {
            preavis = 1;
        } else if (FRANCE.contains(pays)){
            preavis = 2;
        } else {
            throw new MyException('Attribut Code Pays obligatoire sur le Compte');
        }
        return preavis;
    }

    private class MyException extends Exception {
    }


    public static Date maxDate(Date aDate, Date bDate) {
        if (aDate > bDate) { return aDate;} else { return bDate;}
    }

    public static Date minDate(Date aDate, Date bDate) {
        if (aDate < bDate) { return aDate;} else { return bDate;}
    }

    public static String oppositeAction(String action) {
        String oppAction = '';
        if (action == 'Prioritaire') {oppAction = 'Non-Prioritaire';}
        if (action == 'Non-Prioritaire') {oppAction =  'Prioritaire';}
        if (action == 'Cumulable') {oppAction = 'Cumulable';}
        if (action == 'Non-Cumulable') {oppAction = 'Non-Cumulable';}
        if (action == 'Ignorer') {oppAction ='Ignorer';}
        if (action == 'A Qualifier') {oppAction = 'A Qualifier';}
        return oppAction;
    }

    public static String generateRandomString(Integer len, Boolean includeNumbers) {

        String chars = '';
        if (includeNumbers == true) {
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        } else  {
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        }

        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr;
    }


    /*public static String parseXML(DOM.XMLNode node, String currentNode, List<String> lignes){
        //currentNode = currentNode + node.getName();
        //if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
            //System.debug('MBEN0: ' + currentNode);
        String result;
        //List<String> lignes = new List<String>();
            if (node.getText().trim() != '') {
            System.debug('MBEN2: ' + currentNode + ':' + node.getText().trim());
                //result += node.getText().trim();
                lignes.add(currentNode + ' | ' + node.getText().trim());
            }
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child, currentNode + '.' + child.getName(), lignes);
        }
        //result = lignes.toString();
        for (Integer i = 0; i < lignes.size(); i++) {
            result += lignes.get(i) + '\r\n';
        }
        return result;
    }*/
    
    public static void parseXML(DOM.XMLNode node, list<RejetExtItem__c> listNtry, Id rejetExterneId){
        if (node.getName() == 'Ntry') {
        	RejetExtItem__c r = new RejetExtItem__c();
        	parseXMLNtry(node, r);
        	if(r != new RejetExtItem__c()){
        		r.RejetExterne__c = rejetExterneId;
        		listNtry.add(r);
        	}
        }

        for (Dom.XMLNode child: node.getChildElements()) {
    		parseXML(child, listNtry, rejetExterneId);
        }
    }
    
	public static void parseXMLNtry(DOM.XMLNode node, RejetExtItem__c r){
		
		if(node.getName() == 'Nm' && node.getParent().getName() == 'Dbtr' && String.isNotBlank(node.getText())){
			System.debug('##MNE Name >> ' + node.getName());
			System.debug('##MNE Value >> ' + node.getText().trim());
			r.DebiteurName__c = node.getText().trim();
		}
		
		if(node.getName() == 'Amt' && node.getParent().getName() == 'Ntry' && String.isNotBlank(node.getText())){
			r.MontantRejet__c = Decimal.valueOf(node.getText().trim());
			if(String.isNotBlank(node.getAttributeValue('Ccy',''))){
				r.CurrencyRejet__c = node.getAttributeValue('Ccy','').trim();
			}
		}
		
		if(node.getName() == 'EndToEndId' && node.getParent().getName() == 'Refs' && String.isNotBlank(node.getText())){
	    	r.PaymentReference__c = node.getText().trim();
		}
		
		if(node.getName() == 'AcctSvcrRef' && node.getParent().getName() == 'Refs' && String.isNotBlank(node.getText())){
	    	r.RejetDate__c = Date.valueOf(node.getText().trim());
		}
		
		if(node.getName() == 'MndtId' && node.getParent().getName() == 'Refs' && String.isNotBlank(node.getText())){
	    	r.RUM__c = node.getText().trim();
		}
		
		if(node.getName() == 'Cd' && node.getParent().getName() == 'Rsn' && String.isNotBlank(node.getText())){
			r.CodeRejet__c = node.getText().trim();
		}

        for (Dom.XMLNode child: node.getChildElements()) {
    		parseXMLNtry(child, r);
        }
    }

    // Order Map by keys
    public static void orderMap(Map<Date, WSZ.price> map1){

        Set<Date> pset1 = new Set<Date>();
        List<Date> plist1 = new List<Date>();
        Map<Date, WSZ.price> map2 = new Map<Date, WSZ.price>();

        pset1 = map1.keySet();
        plist1.addAll(pset1);
        plist1.sort();

        for (Date item : plist1){
            map2.put(item,map1.get(item));
        }
        map1.clear();
        map1.putAll(map2);
        // return map2.clone();
    }

    // renvoie la cle inferieur a la cle en entree sur une map trié
    public static Date prevElement(Date mDate, Set<Date> mSet){
        Date prevDate = null;
        for (Date val: mSet ){
            if (mDate >= val ) {prevDate = val;}
        }
        return prevDate;
    }

    /**
     * serializeSobject Seralize un sObject en supprimant les tag attributes.
     * @param  myObject Object de type sObject
     * @return          Json en String
     */
    public static String serializeSobject(Object myObject){
        
        Map<String,Object> map1 = (Map<String,Object>)JSON.deserializeUntyped(JSON.serializePretty(myObject,true));
        map1.remove('attributes');
        return JSON.serialize(map1);        
        
    }

}