public class FAQsController {
    public static Boolean isBrand{
    get{
      if(Utility.loggedInUser.AccountId != null &&
         (Utility.loggedInUser.Account.Type == 'Distributor' || Utility.loggedInUser.Account.Type == 'Manufacturer' ||
        Utility.loggedInUser.Account.Type == 'Producer' || Utility.loggedInUser.Account.Type == 'Cultivator' ||
        Utility.loggedInUser.Account.Type == 'Supplier')){
          isBrand = true;
        }else{
          isBrand = false;
        }
      return isBrand;
    }set;
  }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getFAQs(String searchTerm){
        AuraResponse r = new AuraResponse('FAQsController.getFAQs');
        String[] FAQTypes = new String[]{};
        if(isBrand){
            FAQTypes = new String[]{'Brand','Both'};
        }else{
            FAQTypes = new String[]{'Retailer','Both'};
        }
        FAQ__c[] FAQList = [SELECT Category_Order__c ,FAQ_Category__c ,Type__c,
                            (SELECT FAQ_Question__c ,FAQ_Answer__c ,FAQ_Order__c FROM FAQ_Items__r ORDER By FAQ_Order__c) 
                            FROM FAQ__c 
                            WHERE Type__c IN :FAQTypes 
                            ORDER By Category_Order__c];
        List<FAQCategory> FAQs = new List<FAQCategory>();
        for(FAQ__c f: FAQList){
            FAQCategory fq = isValid(f,searchTerm);
            if(fq != null){
                FAQs.add(fq);
                //FAQs.add(new FAQCategory(f));
            }
            
        }
        r.data.put('FAQs',FAQs);
        return r;
    }
    private static FAQCategory isValid(FAQ__c f,String searchTerm){
        FAQCategory fac = new FAQCategory();
        Boolean isMatched = true;
        System.debug('##searchTerm:'+searchTerm);
        if(String.isNotBlank(searchTerm)){
            System.debug('###f::'+f);
            isMatched = (f.FAQ_Category__c != null && f.FAQ_Category__c.indexOf(searchTerm)>=0)||
                (f.Type__c != null && f.Type__c.indexOf(searchTerm)>=0);
            if(isMatched){
                fac = new FAQCategory(f,true);
                return fac;
            }else{
                fac = new FAQCategory(f,false);
                if(!f.FAQ_Items__r.isEmpty()){
                    for(FAQ_Detail__c fd: f.FAQ_Items__r){
                        System.debug('###fd::'+fd);
                        isMatched = (fd.FAQ_Question__c != null && fd.FAQ_Question__c.toLowercase().indexOf(searchTerm.toLowercase())>=0)||
                            (fd.FAQ_Answer__c != null && fd.FAQ_Answer__c.toLowercase().indexOf(searchTerm.toLowercase())>=0);
                        if(isMatched){
                            fac.FAQs.add(new FAQ(fd));
                        }
                    } 
                }
            }
        }else{
            fac = new FAQCategory(f,true);
        }
        return (fac.FAQs.size() > 0?fac:null);
    }
    public class FAQCategory{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String category{set;get;}
        @AuraEnabled
        public String type{set;get;}
        @AuraEnabled
        public FAQ[] FAQs{set;get;}
        public FAQCategory(){
            FAQs = new FAQ[]{};
        }
        public FAQCategory(FAQ__c f,Boolean isFull){
            this.id = f.Id;
            this.category = f.FAQ_Category__c;
            this.type = f.Type__c;
            this.FAQs = new FAQ[]{};
            if(isFull){
                if(!f.FAQ_Items__r.isEmpty()){
                    for(FAQ_Detail__c fd: f.FAQ_Items__r){
                        this.FAQs.add(new FAQ(fd));
                    } 
                } 
            }
               
               
        }
    }
    public class FAQ{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String question{set;get;}
        @AuraEnabled
        public String answer{set;get;}
        public FAQ(FAQ_Detail__c fd){
            this.id = fd.Id;
            this.question = fd.FAQ_Question__c;
            this.answer = fd.FAQ_Answer__c;
        }
    }
    @AuraEnabled
  public static List < FAQ_Detail__c > fetchFAQ(String searchKeyWord) {
  String searchKey = '%'+searchKeyWord + '%';
  List < FAQ_Detail__c > returnList = new List < FAQ_Detail__c > ();
     
List < FAQ_Detail__c > lstOfFAQs = [SELECT FAQ__c ,FAQ_Answer__c ,FAQ_Question__c FROM FAQ_Detail__c where FAQ_Question__c  LIKE : searchKey ];
                                 
   system.debug('lstOfFAQs>>>'+lstOfFAQs);                                
    
 
  for (FAQ_Detail__c FAQs: lstOfFAQs) {
      
   returnList.add(FAQs);
  }	
  return returnList;
 }
   
}