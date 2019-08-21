public with sharing class CalculPrimesSchedulable implements Schedulable {
    
    public void execute(SchedulableContext SC) {
    	CalculPrimes.tallyFrenchCounters();
    	CalculPrimes.tallyBelgianCounters();
    	
    }
}