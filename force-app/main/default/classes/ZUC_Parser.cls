/**
 * @File Name          : ZUC_Parser.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 23/09/2019 à 02:02:21
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    19/09/2019   mouad     Initial Version
**/
public with sharing class ZUC_Parser {

public final static Boolean MAP_SWAP = true;
public final static Boolean MAP_NO_SWAP = false;

public Boolean mapSwap {get; set;}


public ZUC_Parser(Boolean mapSwap) {
    this.mapSwap = mapSwap;
}


/**
* @description serialize un objet en json string avec renommage des variables.
* Ca utilise propertymapping des classes pour le renommage, utilise pour les requete send de Zuora.
* @author mouad | 23/09/2019 
* @param Object lc1 : l object a convertir
* @return String : json de la nouvelle structure renommer.
**/
public String serializeWithMapping(Object lc1){

    Map<String,Object> currMap = untypeObj(lc1,true);
    String bodyStr = JSON.serialize(lc1,true);

    JSONParser parser = JSON.createParser(bodyStr);
    JSONGenerator gen = JSON.createGenerator(true);
    System.debug('MBEN ORI JSON:' + bodyStr);

    parser.nextToken();
    gen.writeStartObject();
    runParse(parser, gen, currMap);
    
    return gen.getAsString();

}

/**
* @description renvoie la translation de nom de variable en swappant la map
* @author mouad | 19/09/2019 
* @param Map<String Object> propMap 
* @param String srcVal 
* @return String 
**/
public String getMapVal(Map<String,Object> propMap, String srcVal){
	
	String tgtVal;
	Map<String,String> revMap = new Map<String,String>();

	if (propMap == null){
		return srcVal; 
	}

	if (propMap.size() == 0){
		return srcVal; 
	}


	for (String key : propMap.keySet()){
		if (mapSwap) {
            revMap.put(String.valueOf(propMap.get(key)),key);
        }else {
            revMap.put(key,String.valueOf(propMap.get(key)));
        }
	}

	if (revMap.containsKey(srcVal)){
		tgtVal=revMap.get(srcVal);
	} else {
		tgtVal=srcVal;
	}

	return tgtVal;

}

/**
* @description (Reccursive): transforme une Map(obj) d une class et cree un json avec renommage des variables
* @author mouad | 19/09/2019 
* @param JSONParser myParser : parser du json en input
* @param JSONGenerator gen : un generator json
* @param Map<String Object> currMap : une map(Obj) de la class à convertir
* @return void 
**/
public void runParse(JSONParser myParser, JSONGenerator gen, Map<String,Object> currMap) {
	String gToken = String.valueOf(myParser.getCurrentToken());
	String gName = myParser.getCurrentName();
	String gText = myParser.getText();	
	Object propObj = currMap.get('propertyMappings');	
	//Map<String,String> propMap = (Map<String,String>)propObj;
	Map<String,Object> propMap = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(propObj));
	System.debug('STARTMETH: '+gToken+'-'+gName+'-'+gText);	
	System.debug('CURRMAP_OBJ' +String.valueOf(JSON.serialize(currMap,true)));
	// System.debug('Run myMethod');
	Integer i = 0;
	while ((myParser.nextToken() != null) && (gToken != 'END_OBJECT') && (i < 50) ) {	
		gToken = String.valueOf(myParser.getCurrentToken());
		gName = myParser.getCurrentName();
		gText = myParser.getText();
		System.debug('PARSER: ' +gToken+'-'+gName+'-'+gText);
		
		if (gToken == 'VALUE_STRING') {			
			if (gName != null){ //cas des Array list
				//if (currMap.containsKey(gName)){newName=String.valueOf(propMap.get(gName));} else {newName=gName;}
				//newName = getMapVal(propMap,gName);
				gen.writeStringField(getMapVal(propMap,gName), gText);
			}else{
				gen.writeString(gText);
			}

		}else if (gToken == 'VALUE_TRUE') {
			if (gName != null){gen.writeBooleanField(getMapVal(propMap,gName), myParser.getBooleanValue());} else{gen.writeBoolean(myParser.getBooleanValue());}		

		}else if (gToken == 'VALUE_FALSE') {
			if (gName != null){gen.writeBooleanField(getMapVal(propMap,gName), myParser.getBooleanValue());} else{gen.writeBoolean(myParser.getBooleanValue());}		

		}else if (gToken == 'VALUE_NUMBER_FLOAT') {
			if (gName != null){gen.writeNumberField(getMapVal(propMap,gName), myParser.getDoubleValue());} else{gen.writeNumber(myParser.getDoubleValue());}		

		}else if (gToken == 'VALUE_NUMBER_INT') {
			if (gName != null){gen.writeNumberField(getMapVal(propMap,gName), myParser.getIntegerValue());} else{gen.writeNumber(myParser.getIntegerValue());}		

		}else if (gToken == 'VALUE_NULL') {	System.debug('valeur null');			

		}else if (gToken == 'START_OBJECT' && gName != 'propertyMappings') {			
			if (gName != null) {
				//if (currMap.containsKey(gName)){newName=String.valueOf(propMap.get(gName));} else {newName=gName;}
				gen.writeFieldName(getMapVal(propMap,gName));
				gen.writeStartObject();
				runParse(myParser, gen,untypeObj(currMap.get(gName),true)); //recursive
			}		
		}else if (gToken == 'START_OBJECT' && gName == 'propertyMappings') {
				myParser.skipChildren();
		
		
		}else if (gToken == 'START_ARRAY') {
            System.debug('MBENTGT: '+String.valueOf(currMap.get(gName)));
			if (currMap.get(gName) == null) {
                System.debug('MBEN: Cas non traite dans ARRAY');
            }else if (!String.valueOf(currMap.get(gName)).contains('{')) { // List simple:  pas d objet
			// 	//Type t1 = Type.forName('c1.'+gName);		
			 	//System.debug('START_ARRAY: ' +gToken+'-'+gName+'-'+gText);
			 	// if (currMap.containsKey(gName)) {newName=String.valueOf(propMap.get(gName));} else {newName=gName;}
			 	gen.writeFieldName(gName);
			 	gen.writeStartArray();		
				List<Object> listObj = (List<Object>)currMap.get(gName);			 				
			 	for (Object obj1 : listObj){					
					myParser.nextToken();
					gen.writeString(String.valueOf(obj1));
					//gen.writeEndObject();
			 	}
				 gen.writeEndArray();
				 myParser.nextToken();				 
			 }else {			 // Une liste d objets
			 	gen.writeFieldName(getMapVal(propMap,gName));
			 	gen.writeStartArray();
				// myParser.nextToken();		
				List<Object> listObj = (List<Object>)currMap.get(gName);			 				
			 	for (Object obj1 : listObj){										
			 		gen.writeStartObject();
			 		runParse(myParser, gen, untypeObj(obj1,true)); //recursive
			 	}
				 gen.writeEndArray();			 	
			}
		
		}else if (gToken == 'END_OBJECT') {
			gen.writeEndObject();
		
		
		}else if (gToken == 'END_ARRAY') {
			gen.writeEndArray();
		}
				
		i++;
	}

}

/**
* @description Transform un Objet en Map(Obj) avec suppression des null variables
* @author mouad | 19/09/2019 
* @param Object currObj 
* @return Map<String, Object> 
**/
public Map<String,Object> untypeObj(Object currObj, Boolean ignoreEmpty) {
	Map<String,Object> map1 = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(currObj,ignoreEmpty));
	return map1;
}

/**
* @description log les lignes du parser d un json
* @author mouad | 19/09/2019 
* @param String jString : json string
* @return void 
**/
public void jsonParseLog(String jString) {

	JSONParser myParser = JSON.createParser(jString);

	while (myParser.nextToken() != null){
		String gToken = String.valueOf(myParser.getCurrentToken());
		String gName = myParser.getCurrentName();
		String gText = myParser.getText();
		System.debug('jsonLog: '+gToken+'-'+gName+'-'+gText);
	}

}


public void runParse2(Map<String,Object> emptyMap, Map<String,Object> currMap,Map<String,Object> newMap){
		String keytrans='DEFAULT';
		String currItemJson;
		Object currItemObj;
		Object empObj;
		String emptyJson;
		System.debug('emptyMap: ' + emptyMap);
		System.debug('currMap: ' + currMap);
		System.debug('newMap: ' + newMap);		
		Map<String,Object> propMap = untypeObj(emptyMap.get('propertyMappings'),false);

		for (String itemKey : currMap.keySet()){					
			currItemObj = currMap.get(itemKey);
			currItemJson = JSON.serialize(currItemObj,false);
			keyTrans = getMapVal(propMap,itemKey); 

			System.debug('MBEN: itemKey: '+itemKey + '  keyTrans: ' + keyTrans + '   Json: ' + currItemJson);
			
			if (currItemJson == null) {
				System.debug('MBEN: Cas non traite dans ARRAY');

			}else if (currItemJson.startsWith('{')) {
			 	System.debug('MBEN {{{: un objet');
				Map<String,Object> currItemMap = (Map<String,Object>)JSON.deserializeUntyped(currItemJson);
				Map<String,Object> emptyItemMap = untypeObj(emptyMap.get(keyTrans),false);
				System.debug('MBEN emptyMap: '+emptyMap);
				System.debug('MBEN emptyMapObject: '+emptyMap.get(keyTrans));
				System.debug('MBEN emptyItemMap: '+emptyItemMap);
				Map<String,Object> newMap1 = new Map<String,Object>();
				runParse2(emptyItemMap,currItemMap,newMap1);
				newMap.put(keyTrans,newMap1);				

			 }else if (currItemJson.startsWith('[{')){ // liste d objets
			 	System.debug('MBEN [{: liste d objets');
				List<Object> listObj = (List<Object>)currItemObj;
				List<Object> newListObj = new List<Object>();
				System.debug('propMap: '+propMap);
				System.debug('itemKey: '+itemKey);				
				System.debug('keyTrans: '+keyTrans);
				Object emptyObj = emptyMap.get(keyTrans);
				List<Object> listEmpyObj = (List<Object>)emptyObj;
				System.debug('listObj: '+listObj);
				System.debug('listEmpyObj: '+listEmpyObj);

			 	for (Object obj1 : listObj){										
					Map<String,Object> inMap1 = untypeObj(obj1,true);
					Map<String,Object> emptyMap1 = untypeObj(listEmpyObj.get(0),true); //tous les element ont la meme propertyMappings, on prend le premier
					Map<String,Object> propMap1 = untypeObj(emptyMap1.get('propertyMappings'),false);
					Map<String,Object> newMap2 = new Map<String,Object>(); 					

			 	 	runParse2(emptyMap1,inMap1,newMap2);

					newListObj.add(newMap2); //voir si map rentre dans Objet
			 	}
				 //keyTrans = getMapVal(propMap,itemKey);
				 newMap.put(keyTrans,newListObj);
                
            }else if (currItemJson.startsWith('[')) { // List simple:  pas d objet		 	
				System.debug('MBEN [: liste simple');
				List<Object> listObj = (List<Object>)currItemObj;
				List<Object> newListObj = new List<Object>();
			 	for (Object obj1 : listObj){
					newListObj.add(obj1);					
			 	}				
				newMap.put(keyTrans,newListObj);

			 }else { // Une valeur
			 	System.debug('-----: une valeur');				
				newMap.put(keyTrans,currMap.get(itemKey));
			 }
		}
}

/**
* @description convertir un json en utilisant une class equivalente dont les noms sont gere par propmapping
* Utilise pour les json Resultat de zuora
* @author mouad | 23/09/2019 
* @param String jsonStr 
* @param String className 
* @return String : json de la nouvelle structure traduite
**/
public String serializeWithMapping2(String jsonStr, String className){
/* Sample call:
String bodyOutS = '{"SingleError":{"Code":"Err000","Message":"pb000"},"Errors":[{"Code":"Err111","Message":"pb111"},{"Code":"Err222","Message":"pb222"}],"SubscriptionId":"8adcd9eb6d485afb016d4a7d090015c8","TotalDeltaTcv":20,"Success":true,"AmendmentIds":["8adcd9eb6d485afb016d4a7d087b15be","XXX8adcd9eb6d485afb016d4a7d087b15be"],"TotalDeltaMrr":0,"InvoiceId":"8adcd9eb6d485afb016d4a7d0b7915f1"}';
ZUC_Parser p = new ZUC_Parser(ZUC_Parser.MAP_NO_SWAP);
String jsonStr = p.serializeWithMapping2(bodyOutS,'ZUC.AmendResult');
System.debug('jsonStr' + jsonStr);
*/


	Type t = Type.forName(className);
	Object emptyResult = (Object)t.newInstance();
	//ZUC.AmendResult emptyResult = new ZUC.AmendResult();	
	Map<String,Object> newMap = new Map<String,Object>();
	// System.debug('emptyResultJSON' + JSON.serialize(emptyResult,false));
	Map<String,Object> emptyMap = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(emptyResult,false));
	Map<String,Object> inMap = (Map<String,Object>)JSON.deserializeUntyped(jsonStr);
	runParse2(emptyMap,inMap,newMap);
	System.debug('MBEN: map result: ' + newMap); // MAP
	System.debug('MBEN: json result: ' + JSON.serialize(newMap,false)); // JSON
	System.debug('MBEN: object result: ' + JSON.deserializeStrict(JSON.serialize(newMap,false),t)); //Object mais contient les null
	return JSON.serialize(newMap,false);
}


}