/**
 * @File Name          : samples.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 12/09/2019 à 08:46:05
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/09/2019   mouad     Initial Version
**/
// List<String> stdObjectNames = new List<String>();
// for ( Schema.SObjectType typ : Schema.getGlobalDescribe().values() ) {
// 	String sobjName = String.valueOf(typ);
// 	if ( !sobjName.contains('__c') ) {
// 		stdObjectNames.add(sobjName);
//         System.debug('stdObjectNames ' + sobjName);
// 	}
// }
// System.debug('stdObjectNames: ' + stdObjectNames);


// public class ClassFactory 
// { 
// 	static Object newInstance(String className) {
// 		if(className == 'foo') { 
// 			return new foo();
// 			} 
// 		if(className == 'bar') { 
// 			return new bar();
// 			}
// 			// code here
// 		} 
// }
/*
public class Class3 {
		public String var1;
		// public Class2 cc2;
		
		// public Class3(String var1) {
		//  	this.var1 = var1;		 	
		// }

		public class Class4 {	
			public String var2;
			public String var3;

			public Class4(String var2, String var3) {
			 	this.var2 = var2;
				this.var3 = var3;		 	
			}

		}
}
*/
		// Map<String,String> propMap = new Map<String,String>{ 
		// // 'var1' => 'Civilite',
		// // 'cc2' => 'NomEtPrenom'
		// 		'T1' => 'Y1'
		// };

		// public static Map<String,String> getPropMap(){
		// 	return propMap;
		// }



public class Class1 {
		public String var1;
		public Class2 cc2;
		public Class2 cc3;
		
		public Class1(String var1) {
		 	this.var1 = var1;		 	
		}

		public Class1(String var1,String var2,String var3) {
		 	this.var1 = var1;
		 	this.cc2 = new Class2(var2,var3);
			this.cc3 = new Class2(var2,var3);
		}
	
		// Map<String,String> propMap = new Map<String,String>{ 
		// // 'var1' => 'Civilite',
		// // 'cc2' => 'NomEtPrenom'
		// 		'T1' => 'Y1'
		// };

		// public static Map<String,String> getPropMap(){
		// 	return propMap;
		// }

}


public class Class2 {
	public String var2;
	public String var3;

	public Class2(String var2, String var3){
		this.var2=var2;
		this.var3=var3;
	}

	 
	// private Map<String,String> propMap = new Map<String,String>{ 
	// 	// 'var2' => 'Nom',
	// 	// 'var3' => 'Prenom'
	// 	'T2' => 'Y2'
	// };

	// public Map<String,String> getPropMap(){
	// 	return propMap;
	// }

	public void runtest(){
		// Class1 c1 = new Class1();
		// c1.var1 ='aaa';
		// System.debug(c1.var1);

		//Type t1 = Type.forName('WSZ.taxationItemsdata');
		// Type t = Class1.class;
	}
}


// Class2 c2 = new Class2('a2','a3');
// Class1 c1 = new Class1('a1');
// c1.cc2 = c2;

Class1 c1 = new Class1('a1','a2','a3');
// Class3 c1 = new Class3('a1');
// c3.Class4 c1 = c3.Class4('a2','a3');

// c2.var3 = 'v333';
// c2.cc1.var1 = 'v111';

System.debug(JSON.serialize(c1));
System.debug(c1);
System.debug(String.valueOf(c1));
System.debug(String.valueOf(c1.cc2)); //donne le nom de la class
Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(c1));

for (String key : m.keySet()){
	System.debug('key: '+key);
	System.debug('val: '+m.get(key));
}


String bodyStr = JSON.serialize(c1);

JSONParser parser = JSON.createParser(bodyStr);
// Double grandTotal = 0.0;
Integer i = 0;
while ((parser.nextToken() != null) && (i < 50) ) {
	System.debug(parser.getCurrentToken()+'-'+parser.getCurrentName()+'-'+parser.getText());
//if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
//	(parser.getText() == 'totalPrice')) {
	// Get the value.
	// if (parser.getCurrentToken() == JSONToken.START_OBJECT){
	// 	String obj1 = parser.getCurrentName();
	// 	if (obj1 == 'cc2') {
	// 		Class2 cd2 = new Class2('z1','z2');
	// 		System.debug(cd2.getPropMap());
	// 	}
	// 	// System.debug(parser.getText());
	// }
	i++;
	// parser.nextToken();

	// Compute the grand total price for all invoices.
	// grandTotal += parser.getDoubleValue();
// }
}


// System.debug();




// String className = 'WSZ.SubscribeToRatePlan';
// Type t1 = Type.forName(className);
// String typeName = t1.getName();
// System.debug(typeName);
// System.debug(t1.toString());
// // Object c2 = t1.newInstance();
// WSZ.SubscribeToRatePlan c2 = (WSZ.SubscribeToRatePlan)t1.newInstance();
// String c2s = JSON.serialize(c2);
// System.debug(c2s);
// String c2Name = String.valueOf(c2);// .split(':')[0];
// System.debug(c2Name); //SubscribeToRatePlan
// String c3Name =  String.valueOf(c2.lieu_c);
// c2.lieu_c='jkhkjh';
// System.debug(c3Name); //xx
