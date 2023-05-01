public without sharing class CallListQueryAction {
	@InvocableMethod
    public static List<Integer> getNextOrderNumbers(List<Id> ids) {
        List<Integer> orderNumbers = new List<Integer>();
        AggregateResult[] groupedResults = [SELECT CallList__c, MAX(Order__c) FROM CallListMember__c WHERE CallList__c in : ids GROUP BY CallList__c];
        for(AggregateResult ar : groupedResults){
            orderNumbers.add(Integer.valueOf(ar.get('expr0')) + 1);
        }
	
	// return the order numbers
        return orderNumbers;
    }
}
