global class Batch_ZDocDataPurge implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {

    public Integer NbDays;
    
    public Batch_ZDocDataPurge(Integer NbDays) {  
        this.NbDays = NbDays;                        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        System.debug('##ECH Start of ZDocDataPurge batch' );
        
        Date purgeDate = Date.today().addDays(-NbDays);
        
        DateTime purgeDatetime = Datetime.newInstance(purgeDate, Time.newInstance(23,59,59,59));
        
        return Database.getQueryLocator(
            'SELECT ID ' +
            'FROM ZDocData__c ' + 
            'Where CreatedDate <=:purgeDatetime');
    }
    
    global void execute(Database.BatchableContext BC, List<ZDocData__c> scope) {       
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('##ECH End of ZDocDataPurge batch' );
    }
    

}