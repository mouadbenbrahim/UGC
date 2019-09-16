/**
 * @File Name          : ZUC_Temp.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 13/09/2019 à 09:14:09
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/09/2019   mouad     Initial Version
**/
public with sharing class ZUC_Temp {
    public ZUC_Temp() {

    }

public class Class1 extends ZUC_CoreClass {
		public String var1;
		public Class2 cc2;
        public List<String> lrs;        
        public List<Class4> lc4;
		//public Class2 cc3;
		
		public Class1(String var1, Class2 cc2, List<String> lrs, List<Class4> lc4) {
		 	this.var1 = var1;
		 	this.cc2 = cc2;
            this.lrs = lrs;
            this.lc4 = lc4;
			//this.cc3 = cc3;
		}
	
		Map<String,String> propMap = new Map<String,String>{ 
		'var1' => 'Civilite',
		'cc2' => 'Nomination',
        'cc3' => 'Adresse',
        'lrs' => 'Les courses'				
		};

		// public static Map<String,String> getPropMap(){
		// 	return propMap;
		// }

}


public class Class2 {
	public String var2;
	public String var3;
    public Class4 cc4;

	public Class2(String var2, String var3, Class4 cc4){
		this.var2=var2;
		this.var3=var3;
        this.cc4 =cc4;
	}

	public Map<String,String> propMap = new Map<String,String>{
        'var2' => 'Nom',
        'var3' => 'Prenom',
        'cc4' => 'Description Physique'
        };   
}

public class Class4 {
	public String var41;
	public String var42;    

	public Class4(String var41, String var42){
		this.var41=var41;
		this.var42=var42;
	}

	public Map<String,String> propMap = new Map<String,String>{
        'var41' => 'Couleur',
        'var42' => 'Taille'
        };

    
}

}