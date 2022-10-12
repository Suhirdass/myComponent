public without sharing class RatesController {
    private static String FULFILLMENT_SERVICE_QA_REVIEW{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_QA_REVIEW) ? FULFILLMENT_SERVICE_QA_REVIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_QA_Review');
        }set;
    }
    private static String FULFILLMENT_SERVICE_PICK_PACK{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PICK_PACK) ? FULFILLMENT_SERVICE_PICK_PACK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Pick_Pack');
        }set;
    }
    private static String FULFILLMENT_SERVICE_RECEIVING{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_RECEIVING) ? FULFILLMENT_SERVICE_RECEIVING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Receiving_Fee');
        }set;
    }
    public Map<String,List<FRTRateDetail>> FRTRateDetailPrint{set;get;}
    public Set<Decimal> MOQSet {get;set;}
    public String UserId {get;set;}
    public String ratesType {get;set;}
    public Integer MOQLength {get;set;}
    public boolean isOtherFRT {get;set;}
    public boolean isSRT {get;set;}
    public String headingName {get;set;}
    public List<Fulfillment_Rates_Table__c> printOthersFRTList {get;set;}
    public Map<String,List<Shipping_Rates_Table__c>> printSRTDetails {get;set;}
    public RatesController(){
        UserId = ApexPages.currentPAge().getParameters().get('recordId');
        ratesType = ApexPages.currentPAge().getParameters().get('Type');
        if(ratesType == 'SRTRates'){
            headingName='Shipping Rates Table Detail';
            isSRT = true;
            AuraResponse r = RatesController.getSRTRates(UserId);
            printSRTDetails =( Map<String,List<Shipping_Rates_Table__c>>)r.data.get('SRT');
        }else{
            headingName='Fulfillment Rates Table Detail';
            isSRT = false;
            AuraResponse r = RatesController.getFRTRates(UserId,ratesType);
            if(ratesType == 'Others'){
                isOtherFRT=true;
                printOthersFRTList =( List<Fulfillment_Rates_Table__c>)r.data.get('FRT');
                System.debug('###printOthersFRTList :'+printOthersFRTList);
            }else{
                isOtherFRT=false;
                FRTRateDetailPrint = ( Map<String,List<FRTRateDetail>>)r.data.get('FRT');
                MOQSet =(Set<Decimal>)r.data.get('MOQsHeader');
                MOQLength= MOQSet.size();
            }
        }
    }
    @AuraEnabled
    public static AuraResponse getSRTRates(String loginId){
        AuraResponse r = new AuraResponse('RatesController.getSRTRates()');
        User u =[SELECT Id, IsActive,AccountId, Contact.Account.Name,Contact.Primary_Contact__c ,Account.Membership_Level__c,  Phone, MobilePhone FROM User WHERE Id = :loginId];

        List<Shipping_Rates_Table__c> SRTList =[SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                              Weight_Bracket__c, Weight_Bracket_Price__c,Site__r.Active__c,Site__c,Site__r.Name,Site__r.Warehouse_Name__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                              FROM Shipping_Rates_Table__c 
                                              WHERE Active__c = true 
                                              AND Rate_Effective_From__c <= :System.today() 
                                              AND Rate_Effective_To__c >= :System.today()
                                              AND Membership_Level__c =:u.Account.Membership_Level__c
                                               AND Site__r.Active__c = true
                                               Order By Site__r.Warehouse_Name__c,Mileage_Bracket__c];
        
        Map<String,List<Shipping_Rates_Table__c>> SRTMap = new Map<String,List<Shipping_Rates_Table__c>>();
        for(Shipping_Rates_Table__c srt : SRTList){
            if(SRTMap.containsKey(srt.Site__r.Warehouse_Name__c)){
                List<Shipping_Rates_Table__c> SRTs = SRTMap.get(srt.Site__r.Warehouse_Name__c);
                SRTs.add(srt);
                SRTMap.put(srt.Site__r.Warehouse_Name__c, SRTs);
            } else {
                SRTMap.put(srt.Site__r.Warehouse_Name__c, new List<Shipping_Rates_Table__c> { srt });
            }
        }
        r.data.put('SRT', SRTMap); 
        return r;
    }
    public static List<sObject> getFRTRecord(String FRTServiceType,User u){
        List<Fulfillment_Rates_Table__c> FRTList = new List<Fulfillment_Rates_Table__c>();
        String FRTService ='';
        if(FRTServiceType == 'Receiving'){
            FRTService =FULFILLMENT_SERVICE_RECEIVING;
        }else if(FRTServiceType == 'QAReview'){
             FRTService =FULFILLMENT_SERVICE_QA_REVIEW;
        }else if(FRTServiceType == 'PickPack'){
             FRTService =FULFILLMENT_SERVICE_PICK_PACK;
        }else{
             FRTService ='';
        }
        if(FRTService != ''){
            FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Size_Classification__c,Bracket_Price__c ,Site__r.Active__c,Site__r.Warehouse_Name__c,Site__r.Name,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                           FROM Fulfillment_Rates_Table__c 
                           WHERE /*Site__c IN :warehouseIds AND Membership_Level__c =:u.Account.Membership_Level__c*/
                           Active__c = true
                           AND Rate_Effective_From__c <= :System.today()
                           AND Rate_Effective_To__c >= :System.today()
                           AND Fulfillment_Services__c=:FRTService
                       	   AND Membership_Level__c =:u.Account.Membership_Level__c
                       	   AND Site__r.Active__c = true
                       	ORDER BY Membership_Level__c, Weight_lbs__c, MOQ__c
                      ];
        }else{
            FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Size_Classification__c,Bracket_Price__c,Site__r.Active__c ,Site__r.Warehouse_Name__c,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,Site__r.Name,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                 FROM Fulfillment_Rates_Table__c 
                                                 WHERE /*Site__c IN :warehouseIds AND Membership_Level__c =:u.Account.Membership_Level__c*/
                                                 Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                       							 AND Membership_Level__c =:u.Account.Membership_Level__c
                                                 AND Fulfillment_Services__c NOT IN (:FULFILLMENT_SERVICE_RECEIVING,:FULFILLMENT_SERVICE_QA_REVIEW,:FULFILLMENT_SERVICE_PICK_PACK)
                       							AND Site__r.Active__c = true
                      ORDER BY Site__c,Fulfillment_Services__c, Weight_lbs__c, MOQ__c];
        }
        	
        return FRTList;
    }
    @AuraEnabled
    public static AuraResponse getFRTRates(String loginId,String FRTServiceType){
         AuraResponse r = new AuraResponse('RatesController.getFRTRates()');
        System.debug('###FRTServiceType :'+FRTServiceType);
        User u =[SELECT Id, IsActive,AccountId, Contact.Account.Name,Contact.Primary_Contact__c ,Account.Membership_Level__c,  Phone, MobilePhone FROM User WHERE Id = :loginId];
        List<Fulfillment_Rates_Table__c> FRTList = new List<Fulfillment_Rates_Table__c>();
        
        FRTList =getFRTRecord(FRTServiceType,u);
        Map<String,Map<String,Map<Decimal,Map<Decimal,Decimal>>>> siteMembershipWeightMOQPriceMap = new Map<String,Map<String,Map<Decimal,Map<Decimal,Decimal>>>>();
       List<FRTRateDetail> FRTRateDetails = new List<FRTRateDetail>();
        
        if(FRTServiceType == 'Others'){
                r.data.put('FRT', FRTList);
        }else{
            Set<Decimal> MOQs = new Set<Decimal>();
            for(Fulfillment_Rates_Table__c frt : FRTList){
                Map<String,Map<Decimal,Map<Decimal,Decimal>>> membershipWeightMOQPriceMap = new Map<String,Map<Decimal,Map<Decimal,Decimal>>>();
                if(siteMembershipWeightMOQPriceMap.containsKey(frt.Site__r.Warehouse_Name__c)){
                    membershipWeightMOQPriceMap = siteMembershipWeightMOQPriceMap.get(frt.Site__r.Warehouse_Name__c);
                }
                Map<Decimal,Map<Decimal,Decimal>> WeightMOQPriceMap = new Map<Decimal,Map<Decimal,Decimal>>();
                if(membershipWeightMOQPriceMap.containsKey(frt.Size_Classification__c)){
                    WeightMOQPriceMap = membershipWeightMOQPriceMap.get(frt.Size_Classification__c);
                }
                Map<Decimal,Decimal> MOQPriceMap = new Map<Decimal,Decimal>();
                if(WeightMOQPriceMap.containsKey(frt.Weight_lbs__c)){
                    MOQPriceMap = WeightMOQPriceMap.get(frt.Weight_lbs__c);
                }
                MOQs.add(frt.MOQ__c);
                MOQPriceMap.put(frt.MOQ__c,frt.Bracket_Price__c);
                WeightMOQPriceMap.put(frt.Weight_lbs__c,MOQPriceMap);
                membershipWeightMOQPriceMap.put(frt.Size_Classification__c,WeightMOQPriceMap);
                siteMembershipWeightMOQPriceMap.put(frt.Site__r.Warehouse_Name__c,membershipWeightMOQPriceMap);
            }
            
            Map<String,List<FRTRateDetail>> FRTRateDetailsBySite = new Map<String,List<FRTRateDetail>>();
            for(String site: siteMembershipWeightMOQPriceMap.keySet()){
                FRTRateDetails = new List<FRTRateDetail>();
                Map<String,Map<Decimal,Map<Decimal,Decimal>>> membershipWeightMOQPriceMap = siteMembershipWeightMOQPriceMap.get(site);
                for(String MSLevel: membershipWeightMOQPriceMap.keySet()){
                    Map<Decimal,Map<Decimal,Decimal>> WeightMOQPriceMap = membershipWeightMOQPriceMap.get(MSLevel);
                    if(WeightMOQPriceMap != NULL && WeightMOQPriceMap.size() > 0){
                        for(Decimal weight: WeightMOQPriceMap.keySet()){
                            Map<Decimal,Decimal> MOQPriceMap = WeightMOQPriceMap.get(weight);
                            FRTRateDetails.add(new FRTRateDetail(MSLevel,weight,MOQs,MOQPriceMap));
                        }
                    }
                    
                }
                FRTRateDetailsBySite.put(site,FRTRateDetails);
            }
            System.debug('###FRTRateDetailsBySite :'+FRTRateDetailsBySite);
            r.data.put('MOQsHeader', MOQs);
            r.data.put('FRT',FRTRateDetailsBySite);
        }
        
        
        return r;
    }
    public class FRTRateDetail{
        @AuraEnabled
        public String MembershipLevel{set;get;}
        @AuraEnabled
        public Decimal weight{set;get;}
        @AuraEnabled
        public Decimal[] bracketPriceList{set;get;}
        public FRTRateDetail(String MembershipLevel, Decimal weight,Set<Decimal> MOQs,Map<Decimal,Decimal> MOQPriceMap){
            this.MembershipLevel = MembershipLevel;
            this.weight = weight;
            this.bracketPriceList = new Decimal[] {};
            for(Decimal MOQ: MOQs){
                if(MOQPriceMap.containsKey(MOQ)){
                    this.bracketPriceList.add(MOQPriceMap.get(MOQ));
                }else{
                    this.bracketPriceList.add(-1);
                }
            }
            //this.bracketPriceList = bracketPriceList;
        }
    }   
}