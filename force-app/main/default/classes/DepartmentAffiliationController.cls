/**
 * @description       : Miscelaneous
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-20-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * 
 * test 2.1.2
 
**/
global class DepartmentAffiliationController {
    
    @AuraEnabled
    public static list<hed__Affiliation__c> allAffiliatedDepartments(Id contactId) {
        //system.debug('--- contactId: ' + contactId);
        list<hed__Affiliation__c> depts = [
            SELECT Id, hed__Account__c, hed__Account__r.Name, hed__Account__r.Department_Icon__c 
            FROM hed__Affiliation__c 
            WHERE hed__Contact__c = :contactId AND hed__Affiliation_Type__c = 'Departmental Affiliation'
        ];
         
        return depts;
    }
    
    @AuraEnabled
    public static list<hed__Affiliation__c> allAccountAffiliatedDepartments(Id accountId) {
        //system.debug('--- accountId: ' + accountId);
        
        set<Id> contactIds = new set<Id>();
        for (hed__Affiliation__c affl : [SELECT Id, hed__Contact__c FROM hed__Affiliation__c 
                                         WHERE hed__Account__c = :accountId AND hed__Status__c != 'Former' AND hed__Status__c != 'Alumni' AND hed__Status__c != 'Transfer Out']) {
                                             contactIds.add(affl.hed__Contact__c);
        }
        
        map<Id, hed__Affiliation__c> depts = new map<Id, hed__Affiliation__c>();
        for (hed__Affiliation__c affl : [SELECT Id, hed__Account__c, hed__Account__r.Name, hed__Account__r.Department_Icon__c 
                                         FROM hed__Affiliation__c 
                                         WHERE hed__Contact__c IN :contactIds AND hed__Affiliation_Type__c = 'Departmental Affiliation']) {
                                             if (!depts.containsKey(affl.hed__Account__c)) {
                                                 depts.put(affl.hed__Account__c, affl);
                                             }
        }
        
        return depts.values();
    }

}