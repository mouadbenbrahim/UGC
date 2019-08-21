@isTest public class DataExtension_Batch_Test {
    
    @isTest public static void testDataExtensionBatch(){
                       
        DataExtension_Batch objTest = new DataExtension_Batch(false,null);   
        Database.executeBatch(objTest);
        
    }
}