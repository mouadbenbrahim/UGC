public class SM_AnnulationMigration {
	//Operation retractation
    public static void AnnulationMigration (Id caseId) {
    
        if(caseId == null){
            throw new MyException('No Id Case found for Annulation Migration');
        }
        
        SM_Desabonnement.desabonner(caseId,false);
    }

    private class MyException extends Exception {
    }
}