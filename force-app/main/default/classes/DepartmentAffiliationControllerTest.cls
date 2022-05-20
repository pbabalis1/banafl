/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-01-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest(SeeAllData=false)
private class DepartmentAffiliationControllerTest {
    
    static testMethod void testLoad_Contact() {
        test.startTest();
        Id conId = createContact();
        Id acctId = createAccount();
        
        hed__Affiliation__c affl = new hed__Affiliation__c(
            hed__Contact__c = conId,
            hed__Account__c = acctId
           // ,Latest_Department_Affiliation_Date__c = system.today()
        );
        insert affl;
        
        DepartmentAffiliationController.allAffiliatedDepartments(conId);
        
        test.stopTest();
    }
    
    static testMethod void testLoad_Account() {
        test.startTest();
        Id conId = createContact();
        Id acctId = createAccount();
        
        hed__Affiliation__c companyAffl = new hed__Affiliation__c(
            hed__Contact__c = conId,
            hed__Account__c = acctId
        );
        insert companyAffl;
        
        hed__Affiliation__c affl = new hed__Affiliation__c(
            hed__Contact__c = conId,
            hed__Account__c = acctId
         //   ,Latest_Department_Affiliation_Date__c = system.today()
        );
        insert affl;
        
        DepartmentAffiliationController.allAccountAffiliatedDepartments(acctId);
        
        test.stopTest();
    }
    
    static Id createAccount() {
        Account acct = new Account(
            Name = 'Testing Department',
            Short_Name__c = 'test',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Departmental Affiliation').getRecordTypeId()
        );
        insert acct;
        return acct.Id;
    }
    
    static Id createContact() {
        Contact con = new Contact(
            FirstName = 'TestFirst',
            LastName = 'TestLast',
            Email = 'testuniqueemail123@test.com',
            hed__WorkEmail__c = 'test@test.com'
        );
        insert con;
        return con.Id;
    }
}