public class TestDataFactory {
    //TestDataFactory.createListUsers(3);
    //TestDataFactory.createListIdeas(100);
    //TestDataFactory.createListIdeaComments(1000); // 10 per idea
    
    public final static string USER_COE_PROFILE = 'System Administrator';
    public final static string USER_MARKET_PROFILE = 'Company Communities User';
    public final static string USER_MARKET_PROFILE_BACKUP = 'Force.com - App Subscription User';    
    public final static string USER_COE_PERMISSIONSET = 'Idea_Tracker';
    public final static string USER_MARKET_PERMISSIONSET = 'Idea_Tracker_User';
    
    
    public static void createTestData(){
        //createTestUsers();
        // createListAccounts(50);
        List<Account> listAccounts = createListAccounts(50);
        
        List<PriceBook2> listPriceBooks = createListPriceBooks(3);
        List<Product2> listProducts = createListProducts(300);
        //List<PriceBookEntry> listPriceBookEntries = createListPriceBookEntries(listPriceBooks, listProducts);
        //Map<PriceBook.Id,List<PriceBookEntry>>
       	 
        Map<Id,List<PriceBookEntry>> mapPriceBookEntries = createMapPriceBookEntriesStandard( listProducts);
        mapPriceBookEntries.putAll(createMapPriceBookEntries(listPriceBooks, listProducts));// = createMapPriceBookEntriesStandard( listProducts);
        
        List<Opportunity> listOpportunities = createListOpportunities(300, listAccounts, listPriceBooks);
        List<OpportunityLineItem> listOpportunityLineItems = createListOpportunityLineItems( 900, listOpportunities, mapPriceBookEntries);
        //       List<OpportunityLineItem> listOpportunityLineItems = createListOpportunityLineItems(listOpportunities, listPriceBookEntries);
    }
    
    
    
    /*
private static List<PermissionSetAssignment> assignPermissionSet(List<User> ListUsers, Id permissionSetId){
List<PermissionSetAssignment> listPermissionSetAssignment = new List<PermissionSetAssignment>();        
for (User user : ListUsers) {
PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = PermissionSetId, AssigneeId = user.Id);
listPermissionSetAssignment.add(psa);
}   
return listPermissionSetAssignment;
}

private static void assignPermissionSet(List<User> listUsers, String profileName){
Id PermissionSetId = Test_PSR_TestingUtil.getPermissionSet(profileName);
List<PermissionSetAssignment> listPermissionSetAssignment = assignPermissionSet(listUsers, PermissionSetId);
Database.insert(listPermissionSetAssignment); 
}
*/
    public static List<Account> createListAccounts(Integer numberOfAccounts){
        List<Account> listAccounts = new List<Account>();
        //List<Id> ListCommunityIdeas = Test_PSR_TestingUtil.getCommunityIds();
        
        for(integer i=0;i<numberOfAccounts;i++) {
            listAccounts.add(TestDataFactoryService.createAccount('Account ' + i));
        }
        
        //      }
        Database.insert(listAccounts);
        return listAccounts;
        
        // set random status on requirement
        //setStatusFeatures(listFeatures); 
    }
    
    public static void createListOpportunities(Integer numberOfOpportunities, List<PriceBook2> listPriceBooks){
        //total comments
        List<Account> listAccounts = Database.query(TestDataFactoryService.getListAccounts());
        //        createVotes(ListIdeas);
        createListOpportunities(numberOfOpportunities, listAccounts, listPriceBooks);
    }
    
    private static List<Opportunity> createListOpportunities(Integer numberOfOpportunities, List<Account> listAccounts, List<PriceBook2> listPriceBooks){
        System.Debug('TestDataFactory.createListOpportunities -  numberOfOpportunities: ' + numberOfOpportunities);
        System.Debug('TestDataFactory.createListOpportunities -  listAccounts.size: ' + listAccounts.size());
        Integer numberOfOpportunitiesPerAccount = numberOfOpportunities / listAccounts.Size() ;
        System.Debug('TestDataFactory.createListOpportunities -  numberOfOpportunitiesPerAccount: ' + numberOfOpportunitiesPerAccount);
        List<Opportunity> listOpportunities = new List<Opportunity>();
        Opportunity singleOpportunity;
        for (Account accountRecord : ListAccounts) {
            for (integer i=0;i<numberOfOpportunitiesPerAccount;i++) {
                singleOpportunity = TestDataFactoryService.createOpportunity('Oppy number: ' + i, accountRecord);
                //singleOpportunity.Pricebook2Id = listPriceBooks[0].Id;
                singleOpportunity.Pricebook2Id = RandomUtility.getRandomSObjectFromList(listPriceBooks).Id;
                
                listOpportunities.add(singleOpportunity);
            }
            
        }
        System.debug('TestDataFactory.createListOpportunities - about to insert Opportunities: ' + listOpportunities.size());
        Database.insert(listOpportunities);
        return listOpportunities;
    }
    
    public static List<PriceBook2> createListPriceBooks(Integer numberOfPriceBooks){
        List<PriceBook2> listPriceBooks = new List<PriceBook2>();
        Boolean isDefaultPriceBook = false;
        
        for(integer i=0;i<numberOfPriceBooks;i++) {
            if (i==0) {isDefaultPriceBook = true;} else {isDefaultPriceBook = true;}
            listPriceBooks.add(TestDataFactoryService.createPriceBook2('PriceBook ' + i, isDefaultPriceBook));
        }
        
        Database.insert(listPriceBooks);
        return listPriceBooks;
    }
    
    
    private static List<Product2> createListProducts(Integer numberOfProducts){
        System.Debug('TestDataFactory.createListProducts -  numberOfProducts: ' + numberOfProducts);
        //System.Debug('TestDataFactory.createListProducts -  listAccounts.size: ' + listPriceBooks.size());
        //Integer numberOfProductsPerPriceBook = numberOfProducts / listPriceBooks.Size() ;
        //System.Debug('TestDataFactory.createListProducts -  numberOfProductsPerPriceBook: ' + numberOfProductsPerPriceBook);
        List<Product2> listProducts = new List<Product2>();
        //for (PriceBook2 priceBookRecord : listPriceBooks) {
        for (integer i=0;i<numberOfProducts;i++) {
            listProducts.add(TestDataFactoryService.createProduct('Prod number: ' + i));
        }
        
        //}
        System.debug('TestDataFactory.createListProducts - about to insert Products: ' + listProducts.size());
        Database.insert(listProducts);
        return listProducts;
    }
    
    public static Map<Id,List<PriceBookEntry>> createMapPriceBookEntriesStandard(List<Product2> listProducts) {
        Map<Id,List<PriceBookEntry>> mapPriceBook = new Map<Id,List<PriceBookEntry>>();
        List<PriceBook2> listPriceBooks = new List<PriceBook2>();
        PriceBook2 stdPriceBook = TestDataFactoryService.getStandardPriceBook();
        listPriceBooks.add(stdPriceBook);
        List<PriceBookEntry> listPriceBookEntries = createListPriceBookEntries(listPriceBooks,listProducts);
        mapPriceBook.put(stdPriceBook.Id, listPriceBookEntries);
        return mapPriceBook;
    }
    
    public static List<PriceBookEntry> createListPriceBookEntries(List<PriceBook2> listPriceBooks,List<Product2> listProducts) {
        System.Debug('TestDataFactory.createListPriceBookEntries -  START. ');
        List<PriceBookEntry> listPriceBookEntries = new List<PriceBookEntry>();
        
        
        for (PriceBook2 priceBookRecord : listPriceBooks) {
            // Add all products to each pricebook
            for (integer x=0;x < listProducts.Size();x++) {
                Id product2Id = listProducts.get(x).Id;
                Id pricebook2Id = priceBookRecord.Id;
                
                listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
            }                
        }
        
        
        
        System.debug('TestDataFactory.createListPriceBookEntries - about to insert PriceBookEntries: ' + listPriceBookEntries.size());
        Database.insert(listPriceBookEntries);
        return listPriceBookEntries;
    }
    
    
    public static List<PriceBookEntry> createListPriceBookEntriesDistributed(List<PriceBook2> listPriceBooks,List<Product2> listProducts) {
        Integer numberOfProductsPerPriceBook = listProducts.Size() / listPriceBooks.Size() ;
        System.Debug('TestDataFactory.createListPriceBookEntries -  numberOfProductsPerPriceBook: ' + numberOfProductsPerPriceBook);
        List<PriceBookEntry> listPriceBookEntries = new List<PriceBookEntry>();
        Integer productIndex = 0;
        PriceBook2 priceBookRecord;
        for (Integer i = 0; i < listPriceBooks.Size(); i++) {
            priceBookRecord = listPriceBooks[i];
            
            //        for (PriceBook2 priceBookRecord : listPriceBooks) {
            // standard price book
            if (i == 0) {
                for (Integer j = 0; j < listProducts.Size(); j++) {
                    Id product2Id = listProducts.get(productIndex).Id;
                    Id pricebook2Id = priceBookRecord.Id;
                    
                    listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
                    
                }
            }
            
            // distribute products over pricebooks. Necessary ? or pricebookentry for each product/pricebook combination ?
            for (integer x=0;x<numberOfProductsPerPriceBook && productIndex < listProducts.Size();x++) {
                Id product2Id = listProducts.get(productIndex).Id;
                Id pricebook2Id = priceBookRecord.Id;
                
                listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
            }
            
        }
        System.debug('TestDataFactory.createListPriceBookEntries - about to insert PriceBookEntries: ' + listPriceBookEntries.size());
        Database.insert(listPriceBookEntries);
        return listPriceBookEntries;
    }
    
    
    // Map<PriceBook.Id,List<PriceBookEntry>>
    public static Map<Id,List<PriceBookEntry>> createMapPriceBookEntries(List<PriceBook2> listPriceBooks,List<Product2> listProducts) {
        //Integer numberOfProductsPerPriceBook = listProducts.Size() / listPriceBooks.Size() ;
        System.Debug('TestDataFactory.createMapPriceBookEntries -  START. ' );
        //List<PriceBookEntry> listPriceBookEntries = new List<PriceBookEntry>();
        Map<Id,List<PriceBookEntry>> mapPriceBookEntries = new Map<Id, List<PriceBookEntry>>();
        List<PriceBookEntry> listPriceBookEntries;
        List<PriceBookEntry> listAllPriceBookEntries = new List<PriceBookEntry>();
        //Integer productIndex = 0;
        for (PriceBook2 priceBookRecord : listPriceBooks) {
            listPriceBookEntries = new List<PriceBookEntry>();
            for (integer x=0;x < listProducts.Size();x++) {
                Id product2Id = listProducts.get(x).Id;
                Id pricebook2Id = priceBookRecord.Id;
                
                listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
                
            }
            mapPriceBookEntries.put(priceBookRecord.Id, listPriceBookEntries);
            listAllPriceBookEntries.addAll(listPriceBookEntries);
            
        }
        System.debug('TestDataFactory.createListPriceBookEntries - about to insert PriceBookEntries: ' + mapPriceBookEntries.size());
        Database.insert(listAllPriceBookEntries);
        return mapPriceBookEntries;
    }
    
    
    public static List<OpportunityLineItem> createListOpportunityLineItems(List<Opportunity> listOpportunities,List<PriceBookEntry> listPriceBookEntries) {
        //Integer numberOfItemsPerOppy = listProducts.Size() / listPriceBooks.Size() ;
        //System.Debug('TestDataFactory.createListPriceBookEntries -  numberOfProductsPerPriceBook: ' + numberOfProductsPerPriceBook);
        List<OpportunityLineItem> listOpportunityLineItems = new List<OpportunityLineItem>();
        /*
Integer productIndex = 0;
for (PriceBook2 priceBookRecord : listPriceBooks) {
for (integer x=0;x<numberOfProductsPerPriceBook && productIndex < listProducts.Size();x++) {
Id product2Id = listProducts.get(productIndex).Id;
Id pricebook2Id = priceBookRecord.Id;

listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
}

}
System.debug('TestDataFactory.createListOpportunityLineItems - about to insert OpportunityLineItems: ' + OpportunityLineItem.size());
Database.insert(OpportunityLineItem);
*/
        return listOpportunityLineItems;
    }
    public static List<OpportunityLineItem> createListOpportunityLineItems(Integer numberOfItems, List<Opportunity> listOpportunities,Map<Id, List<PriceBookEntry>> mapPriceBookEntries) {
        //Integer numberOfItemsPerOppy = listProducts.Size() / listPriceBooks.Size() ;
        //System.Debug('TestDataFactory.createListPriceBookEntries -  numberOfProductsPerPriceBook: ' + numberOfProductsPerPriceBook);
        List<OpportunityLineItem> listOpportunityLineItems = new List<OpportunityLineItem>();
        Integer itemIndex = 0;
        OpportunityLineItem newItem;
        for (Opportunity oppy : listOpportunities){
            newItem = TestDataFactoryService.createOpportunityLineItem(oppy, mapPriceBookEntries);
            listOpportunityLineItems.add(newItem);
        }
        /*
Integer productIndex = 0;
for (PriceBook2 priceBookRecord : listPriceBooks) {
for (integer x=0;x<numberOfProductsPerPriceBook && productIndex < listProducts.Size();x++) {
Id product2Id = listProducts.get(productIndex).Id;
Id pricebook2Id = priceBookRecord.Id;

listPriceBookEntries.add(TestDataFactoryService.createPriceBookEntry(pricebook2Id, product2Id));
}

}
System.debug('TestDataFactory.createListOpportunityLineItems - about to insert OpportunityLineItems: ' + OpportunityLineItem.size());
Database.insert(OpportunityLineItem);
*/
        Database.insert(listOpportunityLineItems);
        return listOpportunityLineItems;
    }
    
    /*
public static void setStatusFeatures(List<Feature__c> listFeatures) {
for (Feature__c feat : listFeatures){
feat.Status__c = RandomUtility.selectRandomStringFromList(IdeaService.getStatusDependentPickList('Requirement'));

}
database.update(listFeatures);
}
public static void createListIdeas(Integer numberOfIdeas){
createListIdeas(numberOfIdeas, null);
}

public static void createListIdeas(Integer numberOfIdeas, List<Feature__c> listFeatures){
List<Idea> ListIdeas = new List<Idea>();
List<Id> ListCommunityIdeas = Test_PSR_TestingUtil.getCommunityIds();

for (ID CommunityId : ListCommunityIdeas) {
if (listFeatures == null) {
for(integer i=0;i<NumberOfIdeas/ListCommunityIdeas.Size();i++) {
ListIdeas.add(Test_PSR_TestingUtil.createIdea('Some Title ' + i, CommunityId));
}
}
else {
integer i=0;
for (Feature__c feature : listFeatures) {
ListIdeas.add(Test_PSR_TestingUtil.createIdea(CommunityId, feature));
i++;
}
}

}
Database.insert(ListIdeas);

// add comments
//createListIdeaComments(10, ListIdeas);

}

public static void createListIdeaComments(Integer numberOfIdeaComments){
//total comments
List<Idea> ListIdeas = Database.query(Test_PSR_TestingUtil.getListIdeas());
createVotes(ListIdeas);
createListIdeaComments(NumberOfIdeaComments, ListIdeas);
}

private static void createListIdeaComments(Integer numberOfIdeaComments, List<Idea> ListIdeas){
System.Debug('TestDataFactory.createListIdeaComments -  NumberOfIdeaComments: ' + NumberOfIdeaComments);
System.Debug('TestDataFactory.createListIdeaComments -  ListIdeas.size: ' + ListIdeas.size());
Integer NumberOfIdeaCommentsPerIdea = NumberOfIdeaComments / ListIdeas.Size() ;
System.Debug('TestDataFactory.createListIdeaComments -  NumberOfIdeaCommentsPerIdea: ' + NumberOfIdeaCommentsPerIdea);
List<IdeaComment> ListIdeaComments = new List<IdeaComment>();
for (Idea IdeaObject : ListIdeas) {
for (integer i=0;i<NumberOfIdeaCommentsPerIdea;i++) {
ListIdeaComments.add(Test_PSR_TestingUtil.createIdeaComment('Comment number: ' + i, IdeaObject));
}

}
System.debug('TestDataFactory.createListIdeaComments - about to insert IdeaComments: ' + ListIdeaComments.size());
Database.insert(ListIdeaComments);
//with ids, create votes
createVotes(ListIdeaComments);
}

public static void createVotes(List<Sobject> listObjects){
Integer recordCount = 0;
List<Vote> listVotes = new List<Vote>();
String voteType = 'Up';
for (Sobject record : listObjects){
voteType = math.mod(RecordCount, 2) == 0 ? 'Up' : 'Down'; // if even => UP else DOWN
listVotes.Add(Test_PSR_TestingUtil.createVote(record.Id, voteType));
}   
}
*/
}