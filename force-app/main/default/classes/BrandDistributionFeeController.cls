public class BrandDistributionFeeController {
    @AuraEnabled
    public static List<Items> brandDistributionFee(Id recordId){
        String sObjName = recordId.getSObjectType().getDescribe().getName();
        List<Items> feeLines = new List<Items>();
        Map<String,decimal> sumOfLineTotalPrice = new Map<String,decimal>();
        decimal totalLinePrice=0;
        if(sObjName == 'Order__c'){
            Order__c ord = [SELECT Id,Name,Order_Booking_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Product_Price__c,
                            (SELECT Id,Name,Brand_Name__c,Pick_Pack_Fee__c,Pack_Out_Fee__c,Listing_Fee__c,
                             QA_Review_Fee__c,Total__c,Product__r.Name,Product__c,Product__r.White_Labelled__c,Ownership_Code__c,
                             Ownership_Code__r.Membership_Level__c,Ownership_Code__r.Platform_Level__c,
                             Product__r.Licensee_Name__c,Product__r.Producer_Name__c,Weight_to_Mileage_Fee__c,
                             Weight_to_Order_Fee__c
                             FROM Order_Line_Items__r) FROM Order__c WHERE Id =: recordId LIMIT 1];
            Map<String,Items[]> mapItems = new Map<String,Items[]>();
            for(Order_Line_Item__c oli : ord.Order_Line_Items__r){
                Items itm = new Items();
                itm.id = '/'+oli.Id;
                itm.name = oli.Name;
                if(oli.Ownership_Code__c != null){
                    itm.membership = oli.Ownership_Code__r.Membership_Level__c;
                    itm.platform   = oli.Ownership_Code__r.Platform_Level__c;
                }
                itm.productId = '/'+oli.Product__c;
                itm.productName = oli.Product__r.Name;
                itm.pickPackFee = oli.Pick_Pack_Fee__c != null ? oli.Pick_Pack_Fee__c : 0;
                itm.packOutFee = oli.Pack_Out_Fee__c != null ? oli.Pack_Out_Fee__c : 0;
                itm.listingFee = oli.Listing_Fee__c != null ? oli.Listing_Fee__c : 0;
                itm.qaReviewFee = oli.QA_Review_Fee__c != null ? oli.QA_Review_Fee__c : 0;
                itm.mileageFee = oli.Weight_to_Mileage_Fee__c != null ? oli.Weight_to_Mileage_Fee__c : 0;
                itm.weightFee = oli.Weight_to_Order_Fee__c != null ? oli.Weight_to_Order_Fee__c : 0;
                
                if(!sumOfLineTotalPrice.containsKey(oli.Brand_Name__c)){
                    totalLinePrice =0;
                }
                
                itm.totalFee 	= itm.weightFee +itm.pickPackFee + itm.packOutFee +itm.listingFee +itm.qaReviewFee + itm.mileageFee;
                //itm.totalDistro = itm.totalFee / oli.Total__c;
                totalLinePrice += oli.Total__c != null ? oli.Total__c : 0;
				sumOfLineTotalPrice.put(oli.Brand_Name__c,totalLinePrice);
                
                if(oli.Product__r.White_Labelled__c && oli.Product__r.Licensee_Name__c != null){
                    itm.brandId = oli.Product__r.Licensee_Name__c;    
                } else if(oli.Product__r.Producer_Name__c != null){
                    itm.brandId = oli.Product__r.Producer_Name__c;  
                }
                
                if(mapItems.containsKey(oli.Brand_Name__c)){
                    mapItems.get(oli.Brand_Name__c).add(itm);
                    
                } else {
                    mapItems.put(oli.Brand_Name__c, new Items[]{itm});
                }
            }
            feeLines = getFeeLines(mapItems,sObjName,recordId,ord.Order_Booking_Fee__c != null ? ord.Order_Booking_Fee__c : 0 ,ord.Schedule_Dispatch_Fee__c != null ? ord.Schedule_Dispatch_Fee__c : 0,ord.Stage_Manifest_Fee__c != null ? ord.Schedule_Dispatch_Fee__c : 0, sumOfLineTotalPrice);
        }
        else if(sObjName == 'Brand_Quote__c'){
            Brand_Quote__c bQuote = [SELECT Id,Name,Order_Booking_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Product_Price__c,
                                     (SELECT Id,Name,Brand_Name__c,Pick_Pack_Fee__c,Pack_Out_Fee__c,Listing_Fee__c,
                                      QA_Review_Fee__c,Line_Total_Quote_Price__c,Product_Name__r.Name,Product_Name__c,Product_Name__r.White_Labelled__c,
                                      Ownership_Code__c,Ownership_Code__r.Membership_Level__c,Ownership_Code__r.Platform_Level__c,
                                      Product_Name__r.Licensee_Name__c,Product_Name__r.Producer_Name__c,Weight_to_Mileage_Fee__c,
                                      Weight_to_Order_Fee__c
                                      FROM Brand_Quote_Lines__r) FROM Brand_Quote__c WHERE Id =: recordId LIMIT 1];
            Map<String,Items[]> mapItems = new Map<String,Items[]>();
            for(Brand_Quote_Line__c bqli : bQuote.Brand_Quote_Lines__r){
                Items itm = new Items();
                itm.id = '/'+bqli.Id;
                itm.name = bqli.Name;
                if(bqli.Ownership_Code__c != null){
                    itm.membership = bqli.Ownership_Code__r.Membership_Level__c;
                    itm.platform   = bqli.Ownership_Code__r.Platform_Level__c;
                }
                itm.productId = '/'+bqli.Product_Name__c;
                itm.productName = bqli.Product_Name__r.Name;
                itm.pickPackFee = bqli.Pick_Pack_Fee__c != null ? bqli.Pick_Pack_Fee__c : 0;
                itm.packOutFee = bqli.Pack_Out_Fee__c != null ? bqli.Pack_Out_Fee__c : 0;
                itm.listingFee = bqli.Listing_Fee__c != null ? bqli.Listing_Fee__c : 0;
                itm.qaReviewFee = bqli.QA_Review_Fee__c != null ? bqli.QA_Review_Fee__c : 0;
                itm.mileageFee = bqli.Weight_to_Mileage_Fee__c != null ? bqli.Weight_to_Mileage_Fee__c : 0;
                itm.weightFee = bqli.Weight_to_Order_Fee__c != null ? bqli.Weight_to_Order_Fee__c : 0;
                
                if(!sumOfLineTotalPrice.containsKey(bqli.Brand_Name__c)){
                    totalLinePrice =0;
                }
                
                itm.totalFee 	= itm.weightFee +itm.pickPackFee + itm.packOutFee +itm.listingFee +itm.qaReviewFee + itm.mileageFee;
                //itm.totalDistro = itm.totalFee / bqli.Line_Total_Quote_Price__c;
               	
                totalLinePrice += bqli.Line_Total_Quote_Price__c != null ? bqli.Line_Total_Quote_Price__c : 0;
                sumOfLineTotalPrice.put(bqli.Brand_Name__c,totalLinePrice);
                
                if(bqli.Product_Name__r.White_Labelled__c && bqli.Product_Name__r.Licensee_Name__c != null){
                    itm.brandId = bqli.Product_Name__r.Licensee_Name__c;    
                } else if(bqli.Product_Name__r.Producer_Name__c != null){
                    itm.brandId = bqli.Product_Name__r.Producer_Name__c;  
                }
                
                if(mapItems.containsKey(bqli.Brand_Name__c)){
                    mapItems.get(bqli.Brand_Name__c).add(itm);
                } else {
                    mapItems.put(bqli.Brand_Name__c, new Items[]{itm});
                }
            }
            feeLines = getFeeLines(mapItems,sObjName,recordId,bQuote.Order_Booking_Fee__c != null ? bQuote.Order_Booking_Fee__c : 0 ,bQuote.Schedule_Dispatch_Fee__c != null ? bQuote.Schedule_Dispatch_Fee__c : 0,bQuote.Stage_Manifest_Fee__c != null ? bQuote.Stage_Manifest_Fee__c : 0, sumOfLineTotalPrice);
        } 
        else if(sObjName == 'Sales_Order__c'){
            Sales_Order__c so = [SELECT Id,Name,Order_Booking_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Price__c,
                                 (SELECT Id,Name,Producer_Name__c,Pick_Pack_Fee__c,Pack_Out_Fee__c,Listing_Fee__c,
                                  QA_Review_Fee__c,Line_Total_Price__c,Product_Name__r.Name,Product_Name__c,Product_Name__r.White_Labelled__c,
                                  Ownership_Code__c,Ownership_Code__r.Membership_Level__c,Ownership_Code__r.Platform_Level__c,
                                  Product_Name__r.Licensee_Name__c,Product_Name__r.Producer_Name__c,Weight_to_Mileage_Fee__c,
                                  Weight_to_Order_Fee__c
                                  FROM Sales_Order_Lines__r) FROM Sales_Order__c WHERE Id =: recordId LIMIT 1];
            Map<String,Items[]> mapItems = new Map<String,Items[]>();
            for(Sales_Order_Line__c soli : so.Sales_Order_Lines__r){
                Items itm = new Items();
                itm.id = '/'+soli.Id;
                itm.name = soli.Name;
                if(soli.Ownership_Code__c != null){
                    itm.membership = soli.Ownership_Code__r.Membership_Level__c;
                    itm.platform   = soli.Ownership_Code__r.Platform_Level__c;
                }
                itm.productId = '/'+soli.Product_Name__c;
                itm.productName = soli.Product_Name__r.Name;
                itm.pickPackFee = soli.Pick_Pack_Fee__c != null ? soli.Pick_Pack_Fee__c : 0;
                itm.packOutFee = soli.Pack_Out_Fee__c != null ? soli.Pack_Out_Fee__c : 0;
                itm.listingFee = soli.Listing_Fee__c != null ? soli.Listing_Fee__c : 0;
                itm.qaReviewFee = soli.QA_Review_Fee__c != null ? soli.QA_Review_Fee__c : 0;
                itm.mileageFee = soli.Weight_to_Mileage_Fee__c != null ? soli.Weight_to_Mileage_Fee__c : 0;
                itm.weightFee = soli.Weight_to_Order_Fee__c != null ? soli.Weight_to_Order_Fee__c : 0;
                
                if(!sumOfLineTotalPrice.containsKey(soli.Producer_Name__c)){
                    totalLinePrice =0;
                }
                
                itm.totalFee 	= itm.weightFee +itm.pickPackFee + itm.packOutFee +itm.listingFee +itm.qaReviewFee + itm.mileageFee;
                //itm.totalDistro = itm.totalFee / soli.Line_Total_Price__c;
				totalLinePrice += soli.Line_Total_Price__c != null ? soli.Line_Total_Price__c : 0;
                sumOfLineTotalPrice.put(soli.Producer_Name__c,totalLinePrice);
                
                if(soli.Product_Name__r.White_Labelled__c && soli.Product_Name__r.Licensee_Name__c != null){
                    itm.brandId = soli.Product_Name__r.Licensee_Name__c;    
                } else if(soli.Product_Name__r.Producer_Name__c != null){
                    itm.brandId = soli.Product_Name__r.Producer_Name__c;  
                }
                
                if(mapItems.containsKey(soli.Producer_Name__c)){
                    mapItems.get(soli.Producer_Name__c).add(itm);
                } else {
                    mapItems.put(soli.Producer_Name__c, new Items[]{itm});
                }
            }
            feeLines = getFeeLines(mapItems,sObjName,recordId,so.Order_Booking_Fee__c != null ? so.Order_Booking_Fee__c : 0 ,so.Schedule_Dispatch_Fee__c != null ? so.Schedule_Dispatch_Fee__c : 0,so.Stage_Manifest_Fee__c != null ? so.Stage_Manifest_Fee__c : 0,sumOfLineTotalPrice);
        }
        return feeLines;
    }
    
    public static List<Items> getFeeLines(Map<String,Items[]> mapItems,String sObjName,Id recordId ,decimal orderBookingFee,decimal scheduleAndDispatchFee,decimal stageAndManifestFee ,Map<String,decimal> sumOfLineTotalPrice){
        List<Items> feeLines = new List<Items>();
        Items itmTotal = new Items();
        itmTotal.id = '/'+recordId;
        itmTotal.name = 'Total Fee';
		itmTotal.totalDistro =0;        
        for(String str : mapItems.keySet()){
            Items itm = new Items();
            //itm.id = '/'+str;
            itm.name = str;
            for(Items item : mapItems.get(str)){
                itm.id = '/'+item.brandId;
                if(item.pickPackFee != null) itm.pickPackFee = itm.pickPackFee += item.pickPackFee.setScale(2);
                else itm.pickPackFee = itm.pickPackFee += 0;
                
                if(item.packOutFee != null) itm.packOutFee = itm.packOutFee += item.packOutFee.setScale(2);
                else itm.packOutFee = itm.packOutFee += 0;
                
                if(item.listingFee != null) itm.listingFee = itm.listingFee += item.listingFee.setScale(2);
                else itm.listingFee = itm.listingFee += 0;
                
                if(item.qaReviewFee != null) itm.qaReviewFee = itm.qaReviewFee += item.qaReviewFee.setScale(2);
                else itm.qaReviewFee = itm.qaReviewFee += 0;
                
                if(item.mileageFee != null) itm.mileageFee = itm.mileageFee += item.mileageFee.setScale(2);
                else itm.mileageFee = itm.mileageFee += 0;
                
                if(item.weightFee != null) itm.weightFee = itm.weightFee += item.weightFee.setScale(2);
                else itm.weightFee = itm.weightFee += 0;
                
                itm.orderBookingFee = orderBookingFee;
                itm.scheduleAndDispatchFee =  scheduleAndDispatchFee;
                itm.stageAndManifestFee = stageAndManifestFee;
                
                itm.totalFee 	= itm.stageAndManifestFee+itm.scheduleAndDispatchFee+itm.orderBookingFee+itm.weightFee +itm.pickPackFee + itm.packOutFee +itm.listingFee +itm.qaReviewFee + itm.mileageFee;
                if(sumOfLineTotalPrice.get(str) != 0) itm.totalDistro =itm.totalFee/sumOfLineTotalPrice.get(str);
                else itm.totalDistro = 0;
                
            }
            itmTotal.pickPackFee 	= itmTotal.pickPackFee += itm.pickPackFee;
            itmTotal.packOutFee 	= itmTotal.packOutFee += itm.packOutFee;
            itmTotal.listingFee 	= itmTotal.listingFee += itm.listingFee;
            itmTotal.qaReviewFee 	= itmTotal.qaReviewFee += itm.qaReviewFee;
            itmTotal.mileageFee 	= itmTotal.mileageFee += itm.mileageFee;
            itmTotal.weightFee 	= itmTotal.weightFee += itm.weightFee;
            
            
            
            itmTotal.orderBookingFee =0;
            itmTotal.scheduleAndDispatchFee=0;
            itmTotal.stageAndManifestFee=0;
            
            itmTotal.orderBookingFee 	= itmTotal.orderBookingFee += itm.orderBookingFee;
            itmTotal.scheduleAndDispatchFee 	= itmTotal.scheduleAndDispatchFee += itm.scheduleAndDispatchFee;
            itmTotal.stageAndManifestFee 	= itmTotal.stageAndManifestFee += itm.stageAndManifestFee;
            
            itmTotal.totalFee 	= itmTotal.totalFee += itm.totalFee ;
            itmTotal.totalDistro 	= itmTotal.totalDistro += itm.totalDistro ;
            itm.items = mapItems.get(str);
            feeLines.add(itm);
        }
        feeLines.add(itmTotal);
        return feeLines;
    }
    
    public Class Items{
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String brandId {get;set;}
        @AuraEnabled
        public String membership {get;set;}
        @AuraEnabled
        public String platform {get;set;}
        @AuraEnabled
        public String productId {get;set;}
        @AuraEnabled
        public String productName {get;set;}
        @AuraEnabled
        public Decimal pickPackFee {get;set;}
        @AuraEnabled
        public Decimal packOutFee {get;set;}
        @AuraEnabled
        public Decimal listingFee {get;set;}
        @AuraEnabled
        public Decimal qaReviewFee {get;set;}
        @AuraEnabled
        public Decimal mileageFee {get;set;}
        @AuraEnabled
        public Decimal weightFee {get;set;}
        @AuraEnabled
        public Decimal orderBookingFee {get;set;}
        @AuraEnabled
        public Decimal scheduleAndDispatchFee {get;set;}
        @AuraEnabled
        public Decimal stageAndManifestFee {get;set;}
        @AuraEnabled
        public Decimal totalFee {get;set;}
        @AuraEnabled
        public Decimal totalDistro {get;set;}
        @AuraEnabled
        public List<Items> items {get;set;}
        
        public Items(){
            this.pickPackFee 	= 0;
            this.packOutFee 	= 0;
            this.listingFee 	= 0;
            this.qaReviewFee 	= 0;
            this.mileageFee 	= 0;
            this.weightFee		= 0;
            this.orderBookingFee = 0;
            this.scheduleAndDispatchFee = 0;
            this.stageAndManifestFee = 0;
            this.totalDistro = 0;
            this.totalFee 	= 0;
        }
    }
}