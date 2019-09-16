/**
 * @File Name          : ZUC_CoreClass.cls
 * @Description        : 
 * @Author             : mouad
 * @Group              : 
 * @Last Modified By   : mouad
 * @Last Modified On   : 13/09/2019 à 05:06:09
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    13/09/2019   mouad     Initial Version
**/
public abstract class ZUC_CoreClass {
    public ZUC_CoreClass() {

    }

    public Map<String,Object> getX(String memberName){
        String jsonInstance = JSON.serialize(this);
        Map<String,Object> mapInstance = (Map<String,Object>)JSON.deserializeUntyped(jsonInstance);
        // Object currObj = mapInstance.get(memberName);
        //String mapValue = currObj.propMap.get(memberName);
        //System.debug(mapValue);
        // return mapInstance.get(memberName);
        return mapInstance;
    }

}