/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Yinka Ayeni @ Cloud Code Academy
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {

    //  The body of the method
      List <Lead> allLeads = [SELECT Id, LastName, Company, Phone, Email FROM Lead ];

      return allLeads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactByFirstName () {
    //  The body of the method

    List<Contact> matchingContacts = [SELECT FirstName, LastName, Name  FROM Contact WHERE FirstName = 'John' ];

    return matchingContacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName () {
    //  The body of the method
    List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones'];

    List<Id> contactId= new List<Id>();

    for (Contact contact : contacts){

       contactId.add(contact.Id);


    }



    return contactId;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (String accountId) {
    //  The body of the method
      List<Opportunity> closedWonOppsOnAcc =  [SELECT Name, StageName, Amount, CloseDate, AccountId
      
      FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won'];

      return closedWonOppsOnAcc;

    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount () {
    //  The body of the method
    
    Integer numOfAccounts = [SELECT count() FROM Account];

    return numOfAccounts;

        }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTaskDueNextWeek () {
    //  The body of the method

    Map<Id, Task> taskIdToTask = new Map<Id, Task>();

    Date todaysDate = Date.today();

    List<Task> taskDueWithin7Days = [SELECT Id, Subject, ActivityDate FROM Task
     WHERE ActivityDate >= :todaysDate  AND ActivityDate <= :todaysDate.addDays(7)];
    

    for(Task t : taskDueWithin7Days){

        taskIdToTask.put(t.Id, t);

    }

    return taskIdToTask;

        }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {
    //  The body of the method

    List<Contact> contactsbyEmail =  [SELECT FirstName , LastName,Name, Email 
    
    FROM Contact WHERE Email LIKE '%example.com%'];

    return contactsbyEmail;

    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
   public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {

    if (keyword == null){
        return new List<Opportunity>();
    }

    String searchWord = '%' + keyword + '%';

    List<Opportunity> oppWithKeyword = [SELECT Id, Name, Amount FROM Opportunity WHERE Name LIKE :searchWord];
   
    return oppWithKeyword;
   }

  /** 
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
    */ 
    public static List<Case> getFilterCaseOrigins() {

     List<Case> casesFiltered =   [SELECT Id,  Status, Subject, Origin FROM  Case WHERE Origin NOT IN ('Web', 'Email', NULL)];
        
     return casesFiltered; // Replace null with the variable you used to store the result
    }
   
    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle (String source, String keyword) {
    // The body of the method

        String sourceToSearch = source;

        String keywordToSearch = '%' + keyword + '%';

       List<Lead> leadBySourceOrTitle =  [SELECT LastName, Company, Phone, Email FROM Lead
        
        WHERE LeadSource = :source OR Title LIKE :keywordToSearch
        ];

        return leadBySourceOrTitle;

    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
   public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames

        List<String> contactsOnAcc = new List<String>();

        String contactLastName = '';

        // Query the Contacts

        List<Contact> contactsByAcc = [SELECT LastName, AccountId FROM Contact WHERE AccountId = :accountId ];
        // Loop through each Contact and add the LastName to the list
        for (Contact con : contactsByAcc) {
        //    
              
       contactsOnAcc.add(con.LastName);
        }

        // Return the list of Contact LastNames
     return contactsOnAcc; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue

        AggregateResult result = [SELECT  SUM(Amount) totalAmount
        
        FROM Opportunity
        
        WHERE StageName = :stage OR Amount > 10000
        ];

        Decimal totalRevenue = (Decimal) result.get('totalAmount');


        // Return the total revenue
        return totalRevenue; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {

    List<Account> firstTenAccs= [SELECT Name
     FROM Account   
     ORDER BY Name ASC 
     LIMIT 10];
 
    return firstTenAccs; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {

      List<Opportunity> highValueOpps =  [SELECT Amount, CloseDate FROM Opportunity
        
        WHERE Amount > 100000

        ORDER BY CloseDate

        LIMIT 5

        ];

        return highValueOpps; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        
       List<Contact> birthdateContacts = [SELECT LastName, FirstName, Birthdate FROM Contact 
        
        ORDER BY Birthdate DESC

        LIMIT 3
        ];
     
        return birthdateContacts; // Replace null with the variable you used to store the result
    }
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {

      List<Case> caseWithStatus =  [SELECT Status, Description, createdDate
      
       FROM Case

       WHERE Status = 'Open'
        
       ORDER BY createdDate

       LIMIT 10

       OFFSET 5
        ];
     return caseWithStatus; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
   public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids

        Set<Id> caseIds = new Set<Id>();

        // Query the Cases

       List<Case> returnedCases =  [SELECT Id, Status, Description FROM Case
        
        WHERE Case.AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        for (Case c : returnedCases) {
        //    
        caseIds.add(c.Id);
        }

      return caseIds; // Replace null with the variable you used to store the result
   }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        
         Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts

      List<Account> accoundNotInUS =  [SELECT Name, Industry FROM Account
        WHERE BillingCountry !=:country ];
        // Loop through each Account and add the Id and Name to the map

        for(Account acc : accoundNotInUS){

             accountIdsToNames.put(acc.Id, acc.Name);
        }
       return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
   public static String getAccountNameForContact(String contactId) {

   Contact con = [SELECT LastName, Name, Account.Name FROM Contact
    
    WHERE Id = :contactId];

    String accName = con.Account.Name;
    return accName; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
    

       Account accountWithOpps = [SELECT Id, Name, (SELECT Id, Name, StageName, CloseDate FROM Opportunities)
        
        FROM Account
        
        WHERE Id = :accountId];

    return accountWithOpps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account

      List<Account> matchingAcc =  [SELECT Name, Industry, BillingState FROM Account
        WHERE Id = :accountId ];

        // Store the Account's BillingState

        String accBillingState = matchingAcc[0].BillingState;

        // Query the Contacts

        List<Contact> con = [SELECT LastName, Account.Name, MailingState FROM Contact
        WHERE MailingState = :accBillingState];
    //    
         return con; // Replace null with the variable you used to store the result
   }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
   public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads

            List<Lead> returnedLeads = [SELECT Id, Email, LastName FROM  Lead 
            
            WHERE Id IN :leadIds];
        
     // Create a set of email domains from the Leads

        Set<String> emailDomains = new Set<String>();


     // Loop through each Lead
        for(Lead l : returnedLeads){
          // Get the email from the Lead

            if (l.Email != null && l.Email.contains('@')) {
                
                String[] emailParts = l.Email.split('@');

                if(emailParts.size() > 1) {  // Check if the email is not null
                   String domain = emailParts[1].trim();
                    emailDomains.add(domain);  // Add the email domain to the set

                }
            }
          }
            if(emailDomains.isEmpty()){

                return new List<Account>();

            }
        
           // Query the Accounts
           // Adjust the domains for potential matches (e.g., adding 'www.' prefix)
           Set<String> websiteDomains = new Set<String>();
            for (String domain : emailDomains) {
               websiteDomains.add('www.' + domain);  // Add "www." prefix
                 websiteDomains.add(domain);          // Include the raw domain

            }
            List<Account> matchingAccounts = [SELECT Id, Name, Website
            FROM Account
            WHERE Website IN :websiteDomains];

                
           
        return matchingAccounts;
   
        
   
   }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items

      List<OpportunityLineItem> originalOpportunityLineItems=  [SELECT Id, Product2Id, Quantity, UnitPrice, PricebookEntryId,
      
        Name, OpportunityId FROM OpportunityLineItem
        
        WHERE OpportunityId = :origOppId];

        // Create a list to hold the new line items
      if(originalOpportunityLineItems.isEmpty()){

        return;
      }

      List<OpportunityLineItem> clonedLineItems = new List<OpportunityLineItem>();
        // Generate a random number between 1 and 3

        Integer randomNumber = (Integer)(Math.floor(Math.random() * 3) + 1);


        for(Id cloneOppId : cloneOppIds) {// Loop through each cloned Opportunity Id

            for(OpportunityLineItem origItem : originalOpportunityLineItems) {// Loop through each original line item

                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newItem = new OpportunityLineItem();
                newItem.OpportunityId = cloneOppId;
                newItem.Product2Id = origItem.Product2Id;
                newItem.Quantity = origItem.Quantity + (Integer)(Math.floor(Math.random() * 3) + 1); // Add random 1-3 to quantity
                newItem.UnitPrice = origItem.UnitPrice;
                newItem.PricebookEntryId = origItem.PricebookEntryId;

                clonedLineItems.add(newItem);

        }
      }
        // Insert the new line items

        if(!clonedLineItems.isEmpty()){

          insert clonedLineItems;

          System.debug('Cloned Opportunity Line Items inserted successfully: ' + clonedLineItems.size());
        }
         else {
           
          System.debug('No Opportunity Line Items to insert.');
        }
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
   
         List<Opportunity> oppsForClosedWon =[SELECT Name, Account.Name, 
         
         StageName, Owner.Name
         
         FROM Opportunity
            
         WHERE StageName ='Closed Won' ];
   
      return oppsForClosedWon; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities

        List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();

        // Create a set of Account Ids from the Opportunities

       
        Set<Id> acctIdsFromOpps = new Set<Id>();
        
        for(Opportunity opp : closedWonOpps){

          if(opp.AccountId !=null) {
            acctIdsFromOpps.add(opp.AccountId);
          }
        }

        Map<Id, Contact> accountIdToContact = new Map<Id,Contact>();


        // Query the Contacts

        List<Contact> allConsWithAccId = [SELECT  Id, Name, AccountId
        FROM Contact 
        WHERE AccountId IN :acctIdsFromOpps 
        ORDER BY createdDate];

       // Loop through each Contact and add the Account Id and Contact to the map

        for (Contact con : allConsWithAccId) {

          // Ensure only the contact is stored per account

          if (!accountIdToContact.containsKey(con.AccountId)){
            accountIdToContact.put(con.AccountId, con);
          }
        }
 
        
        
        // Loop through each Opportunity
          for(Opportunity opp : closedWonOpps){

         // Update the Opportunity primary contact from accountToContactMap

          if (accountIdToContact.containsKey(opp.AccountId)) {
          opp.Primary_Contact__c = accountIdToContact.get(opp.AccountId).Id;
      }
          }

         // Update the Opportunities

        if (!closedWonOpps.isEmpty()) {
          update closedWonOpps;
      }
        }
     


      
}
