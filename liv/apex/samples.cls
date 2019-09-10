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


public class Class1 {
		String var1;
		String var2;

	public void runtest(){
		// Class1 c1 = new Class1();
		// c1.var1 ='aaa';
		// System.debug(c1.var1);

		//Type t1 = Type.forName('WSZ.taxationItemsdata');
		// Type t = Class1.class;
	}
}

public class Class2 {
		String var3;
		Class1 cc1;
		
		public Class2() {
		 	this.var3 = 'aaa';
		 	this.cc1 = new Class1();
		}

}


Class2 c2 = new Class2();
c2.var3 = 'v333';
c2.cc1.var1 = 'v111';

System.debug(JSON.serialize(c2));
System.debug(c2);
System.debug(String.valueOf(c2));
System.debug(String.valueOf(c2.cc1)); //donne le nom de la class
Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(c2));

for (String key : m.keySet()){
	System.debug(key);
	System.debug(m.get(key));
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
