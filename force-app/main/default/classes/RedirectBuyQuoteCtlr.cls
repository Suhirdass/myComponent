public class RedirectBuyQuoteCtlr {
    private Opportunity opp;
    public RedirectBuyQuoteCtlr(ApexPages.StandardController controller) {
        opp = ((Opportunity)controller.getRecord());
    }
    
    public PageReference redirectToSplitQuote(){
        PageReference retPage =new PageReference('/apex/SplitBQByProducerName?id='+opp.Id+'&type=Buy_Quote');
        retPage.setRedirect(true);
        return retPage;
    }
}