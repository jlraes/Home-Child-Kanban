public class TestDataFactoryService {
    /* SINGLE RECORD CREATE METHODS */
    public static Account createAccount(String name){
        Account thisAccount = new Account(name=name);
        thisAccount.AnnualRevenue = RandomUtility.generateRandomNumber(1000000);
        
        return thisAccount;
    }
    
    public static Opportunity createOpportunity(String name){
        Opportunity thisOpportunity = new Opportunity(name=name);
        thisOpportunity.Amount = RandomUtility.generateRandomNumber(100000);
        thisOpportunity.StageName = RandomUtility.getRandomPickListSingle('Opportunity','StageName');
        
        Date myDate = System.today();
        Date newDate = mydate.addDays(RandomUtility.generateRandomNumber(90));
        thisOpportunity.CloseDate = newDate;
        
        return thisOpportunity;
    }
    
    public static OpportunityLineItem createOpportunityLineItem(Opportunity oppy, Map<Id,List<PriceBookEntry>> mapPriceBookEntries){
        OpportunityLineItem newItem = new OpportunityLineItem();
        //List
        PriceBookEntry thisPricebookEntry = (PriceBookEntry)RandomUtility.getRandomSObjectFromList(mapPriceBookEntries.get(oppy.Pricebook2Id)); 
        newItem.PricebookEntryId = thisPricebookEntry.Id;
        newItem.Quantity = RandomUtility.generateRandomFromRange(1, 100);
        newItem.OpportunityId = oppy.Id;
        newItem.TotalPrice = newItem.Quantity * thisPricebookEntry.UnitPrice; 
        return newItem;
        
    }
    
    public static Product2 createProduct(String name){
        Product2 thisProduct = new Product2(name=name);
        thisProduct.IsActive = true;
        return thisProduct;
        //https://salesforce.stackexchange.com/questions/116359/standard-price-not-defined-for-more-than-1-currency
    }
    
    public static PriceBook2 createPriceBook2(String name, Boolean isDefaultPriceBook){
        PriceBook2 thisPriceBook2 = new PriceBook2(name=name);
        thisPriceBook2.IsActive = true;
        //thisPriceBook2.IsStandard = isDefaultPriceBook;
        return thisPriceBook2;
    }
    
    public static PriceBookEntry createPriceBookEntry(Id pricebook2Id, Id product2Id){
        PriceBookEntry thisPriceBookEntry = new PriceBookEntry();
        thisPriceBookEntry.Product2Id = product2Id;
        thisPriceBookEntry.Pricebook2Id = pricebook2Id;
        thisPriceBookEntry.IsActive = true;
        thisPriceBookEntry.UnitPrice = RandomUtility.generateRandomNumber(1000);
        return thisPriceBookEntry;
    }
    
    
    /* RELATION METHODS */
    public static Opportunity createOpportunity(String name, Account thisAccount){
        Opportunity thisOppy =  createOpportunity(name);
        thisOppy.AccountId = thisAccount.id;
        return thisOppy;
    }
    
    
    
    /* QUERY METHODS*/
    public static string getListAccounts() {
        Integer selectLimit = Limits.getLimitQueryRows();
        String soql = 'select Id, Name from Account LIMIT :selectLimit';
        return soql;
    }
    
    public static PriceBook2 getStandardPriceBook(){
        PriceBook2 stdPriceBook;
        stdPriceBook = [SELECT Id, Name, IsActive, IsArchived, Description, IsStandard FROM Pricebook2 where IsStandard = true LIMIT 1];
        return stdPriceBook;
    }
    
}