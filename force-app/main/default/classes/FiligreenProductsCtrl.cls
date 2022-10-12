/*Test Class : ProductsCtlrTest*/
public without sharing class FiligreenProductsCtrl {
    static String recordTypeName = 'Product';
    public static List<String> productFamilies = new List<String>();
    public static Id priceBookId{
        get{
            if(priceBookId == null){
                PriceBook2[] pbes = [SELECT Id,Name FROM PriceBook2 WHERE Name = 'Standard Price Book'];
                if(!pbes.isEmpty()){
                    priceBookId = pbes[0].Id;
                }else if(Test.isRunningTest()){
                    priceBookId = Test.getStandardPricebookId();
                }
                
            }
            return priceBookId;
        }set;
    }
    public static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
    private static String getQuery(List<String> fields, List<String> filters, String orderBy, Integer maxRecords){
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM PricebookEntry ';
        List<String> ORfilters = new List<String>();
        //filters.addAll(new List<String>{'PriceBook2Id = :priceBookId','Product2Id != null','Product2.RecordType.Name = :recordTypeName','Product2.IsActive = true','Product2.Hide_From_Marketplace__c  = false'/*, 'Product2.Image_URL__c != null'*/});
        filters.addAll(new List<String>{
            'Product2Id != null',
                'Product2.RecordType.Name = :recordTypeName',
                'Product2.IsActive = true',
                'Product2.Hide_From_Marketplace__c = false',
                'Product2.Producer_Name__r.Hide_from_Marketplace__c = false',
                'PriceBook2Id = :priceBookId'
                });
        if(!filters.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(filters, ' AND '));
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) +',Product2.Available_Qty__c DESC';
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##priceBookId::'+priceBookId);
        System.debug('query: ' + query);
        return query;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getCategories(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCategories()');
        Product_Categories__c[] categories = [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c  FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c];//Product_Categories__c.getAll().values();
        System.debug('###categories:'+categories);
        r.data.put('categories', categories);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getIds()');
        List<String> whereParts = new List<String>();
        Boolean includeOutStock = false;
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        List<String> families = new List<String>();
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
            if(hasFilter(filters, 'includeOutStock')){
                System.debug('###includeOutStock:'+filters.get('includeOutStock'));
                includeOutStock = Boolean.valueOf(filters.get('includeOutStock'));
                System.debug('###includeOutStock:'+includeOutStock);
            }
            if(hasFilter(filters, 'searchTerm')){
                searchTerm = String.valueOf(filters.get('searchTerm'));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Product2.Name LIKE :searchTerm OR Product2.Family LIKE :searchTerm OR Product2.Description LIKE :searchTerm OR Product2.Product_Short_Description__c LIKE :searchTerm OR Product2.Brand_Name__c LIKE :searchTerm OR Product2.Strain__r.Name LIKE :searchTerm OR Product2.Strain__r.Strain_Type__c LIKE :searchTerm OR Product2.Producer_Name__r.DBA__c LIKE :searchTerm OR Product2.Producer_Name__r.Name LIKE :searchTerm OR Product2.Licensee_Name__r.DBA__c LIKE :searchTerm OR Product2.Licensee_Name__r.Name LIKE :searchTerm)');
                }
            }
            System.debug('###filters:'+filters);
            if(hasFilter(filters, 'families')){
                String family = String.valueOf(filters.get('families'));
                
                if(String.isNotBlank(family)){
                    families = family.split(',');
                    whereParts.add('(Product2.Family IN :families)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Set<Id> ids = new Set<Id>();
        Map<Id,PricebookEntry> pbes = new Map<Id,PricebookEntry>((List<PricebookEntry>)Database.query(getQuery(new List<String>{'Id','Product2Id','Product2.Out_of_stock_product__c','Product2.Status__c','Product2.Producer_Name__c','PriceBook2Id','Product2.MOQ__c','Product2.Available_Qty__c'}, whereParts, orderBy, 49999)));
        
        Set<Id> addedProducts = new Set<Id>();
        Map<Integer,Id> priceBookIdsMap = new Map<Integer,Id>();
        Integer i=0;
        List<PricebookEntry> ignoredPBEs = new List<PricebookEntry>();
        for(PricebookEntry pbe : pbes.values()){
            if(includeOutStock ||(!includeOutStock && pbe.Product2.Available_Qty__c > pbe.Product2.MOQ__c)){
                ids.add(pbe.Id);
            }
        }
       
        //ids = pbes.keySet();
        
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getProducts(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProducts()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        
        if(filters != null){
            if(hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? 'ASC': 'DESC');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        Map<String, ProductsCtlr.Product> records = new Map<String, ProductsCtlr.Product>();
        Map<String, List<ProductsCtlr.Product>> procuderProducts = new Map<String, List<ProductsCtlr.Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'UnitPrice','Product2.RecordType.Name','Product2.Out_of_stock_product__c','Product2.MSRP__c','Product2.Status__c','Product2.Is_Sample__c','Product2.Parent_Product__c', 'Product2.Name', 'Product2.Family','Product2.Inventory_On_Hold_Qty__c', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c','Product2.Description', 'Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name','Product2.Producer_Name__c','Product2.Licensee_Name__r.Name','Product2.Licensee_Name__c','Product2.White_Labelled__c','Product2.Brand_Name__c', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c', 'Product2.Terpene_percent__c','Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>{'Id IN :ids'}, orderBy, 49999))){
            System.debug(pbe.Product2Id);
            ProductsCtlr.Product p = new ProductsCtlr.Product(pbe);
            string paramvalue = EncodingUtil.base64Encode(Blob.valueOf(p.price.id));
            p.encryptPriceBookId = paramvalue;
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c, new List<ProductsCtlr.Product>{p});
            }
        }
        Map<Id,Id> productComplianceImageMap = new Map<Id,Id>();
        Set<Id> complianceIds = new Set<Id>();
        for(Product2 tmpProduct:[SELECT Id,Available_Qty__c,Status__c,Image_URL__c, (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            ProductsCtlr.Product p = records.get(tmpProduct.Id);
            p.setImages(tmpProduct);
            if(!complianceIds.isEmpty()){
                System.debug('###complianceIds::'+complianceIds);
                ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                System.debug('##'+files);
                //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                if(!files.isEmpty()){
                    if(productComplianceImageMap.containsKey(p.Id)){
                        Id complianceId = productComplianceImageMap.get(p.Id);
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    docIds += comma + l.ContentDocumentId;
                                    comma = ',';
                                }
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                    System.debug('###p.complianceFileId:::'+p.complianceFileId);
                }
            }
            
            
        }
        
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet()]){
            List<ProductsCtlr.Product> products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(ProductsCtlr.Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet()]){
            ProductsCtlr.Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        for(Product_Stock_Notification__c psn :[SELECT Product__c FROM Product_Stock_Notification__c WHERE Product__c IN :records.keySet() AND Sent_Notification__c = false]){
            records.get(psn.Product__c).notifyRequested(true);
        }
        
        r.data.put('records', records.values());
        
        List<String> families = new List<String>();
        List<Schema.PicklistEntry> ple = Product2.Family.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry f : ple){
            families.add(f.getValue());
        }
        r.data.put('families', families);
        
        List<String> ExceptionalFamilies = String.isNotBlank(System.Label.ExceptionalFamilies)?System.Label.ExceptionalFamilies.split(','):new List<String>();
        r.data.put('exceptionalFamilies', ExceptionalFamilies);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getProductAndReviews(String id, Integer reviewsLimit){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProductAndReviews()');
        Blob endcodedIdPB =EncodingUtil.base64Decode(id);
        id = endcodedIdPB.toString();
        String productId = '';
        ProductsCtlr.Product p;
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'UnitPrice','Product2.RecordType.Name','Product2.Out_of_stock_product__c', 'Product2.Name','Product2.Inventory_On_Hold_Qty__c','Product2.Is_Sample__c','Product2.Parent_Product__c', 'Product2.MSRP__c','Product2.Status__c', 'Product2.Brand_Name__c','Product2.Family', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c','Product2.Terpene_percent__c','Product2.Fulfilled_by_Filigreen__c','Product2.Licensee_Name__r.Name','Product2.Licensee_Name__c','Product2.White_Labelled__c', 'Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c'}, new List<String>{'Id = :id'}, '', 49999))){
            productId = pbe.Product2Id;
            p = new ProductsCtlr.Product(pbe);
        }
        if(p != null){
            for(Product2 tmpProduct:[SELECT Id,Image_URL__c, (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id =:p.Id]){
                p.setImages(tmpProduct);
                Set<Id> complianceIds = new Set<Id>();
                if(tmpProduct.Compliance_Images__r.size() > 0){
                    complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
                }
                if(!complianceIds.isEmpty()){
                    System.debug('###complianceIds::'+complianceIds);
                    ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                    System.debug('##'+files);
                    //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                    if(!files.isEmpty()){
                        Id complianceId = tmpProduct.Compliance_Images__r[0].Id;
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    docIds += comma + l.ContentDocumentId;
                                    comma = ',';
                                }
                            }
                            p.complianceFileId = docIds;
                        }
                        System.debug('###p.complianceFileId:::'+p.complianceFileId);
                    }
                }
            }
        }
        
        System.debug('##productId::'+productId);
        if(String.isNotBlank(productId) && p != null){
            for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND (Brand__c =: p.producerId OR Product_Name__c =: p.id)]){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                //p.setDiscountPercent(bd.Discount_Percentage__c);
            }
            for(Product_Stock_Notification__c psn :[SELECT Id FROM Product_Stock_Notification__c WHERE Product__c = :productId AND Sent_Notification__c = false]){
                p.notifyRequested(true);
            }
            r.data.put('product', p);
            
            Integer totalReviews = Database.countQuery('SELECT COUNT() FROM Product_Review__c WHERE Product__c = :productId');
            r.data.put('totalReviews', totalReviews);
            
            r.data.put('reviews', null);
            if(0 < totalReviews){
                List<ProductsCtlr.Review> reviews = new List<ProductsCtlr.Review>();
                reviewsLimit = Integer.valueOf(reviewsLimit);
                if(1 > reviewsLimit){
                    reviewsLimit = 5;
                }
                
                List<ProductsCtlr.ReviewChart> tmpRatingsSummary = new List<ProductsCtlr.ReviewChart>{new ProductsCtlr.ReviewChart(0,0),new ProductsCtlr.ReviewChart(0,0),new ProductsCtlr.ReviewChart(0,0),new ProductsCtlr.ReviewChart(0,0),new ProductsCtlr.ReviewChart(0,0)};
                    for(AggregateResult ar :[SELECT Rating_Text__c rating, COUNT(Id) ratingCount FROM Product_Review__c WHERE Product__c = :productId GROUP BY Rating_Text__c ORDER BY Rating_Text__c DESC]){
                        Integer rating = Integer.valueOf(ar.get('rating'));
                        Integer ratingCount = Integer.valueOf(ar.get('ratingCount'));
                        Decimal percent = (decimal.valueOf(ratingCount)/totalReviews)*100;
                        tmpRatingsSummary.set((rating - 1), new ProductsCtlr.ReviewChart(ratingCount,Integer.valueOf(Math.round(percent))));
                        //tmpRatingsSummary.set((rating - 1), '('+ratingCount+')'+Integer.valueOf(Math.round(percent))+'%');
                    }
                
                List<ProductsCtlr.ReviewChart> ratingsSummary = new List<ProductsCtlr.ReviewChart>();
                for(Integer i = tmpRatingsSummary.size() - 1; i >= 0; i--){
                    ratingsSummary.add(tmpRatingsSummary[i]);
                }
                r.data.put('ratingsSummary', ratingsSummary);
                
                for(Product_Review__c pr :[SELECT Rating__c, Review__c, CreatedDate, Owner.Name FROM Product_Review__c WHERE Product__c = :productId ORDER BY CreatedDate DESC LIMIT :reviewsLimit]){
                    reviews.add(new ProductsCtlr.Review(pr));
                }
                r.data.put('reviews', reviews);
            }
            for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
                if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                    productFamilies.addAll(pc.Product_Families__c.split(';'));
                }
            }
            r.data.put('productFamilies', productFamilies);
        }
        r.data.put('isBrand', false);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getRecentProducts(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRecentProducts()');
        
        Map<String, ProductsCtlr.Product> records = new Map<String, ProductsCtlr.Product>();
        Map<String, List<ProductsCtlr.Product>> procuderProducts = new Map<String, List<ProductsCtlr.Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'UnitPrice','Product2.RecordType.Name','Product2.Out_of_stock_product__c', 'Product2.Name','Product2.Inventory_On_Hold_Qty__c','Product2.Is_Sample__c','Product2.Parent_Product__c', 'Product2.MSRP__c','Product2.Status__c', 'Product2.Brand_Name__c','Product2.Family', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c','Product2.Terpene_percent__c','Product2.Fulfilled_by_Filigreen__c','Product2.Licensee_Name__r.Name','Product2.Licensee_Name__c','Product2.White_Labelled__c', 'Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c'}, new List<String>(), 'Product2.Emerging_Product_Order__c', 10))){
            ProductsCtlr.Product p = new ProductsCtlr.Product(pbe);
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new List<ProductsCtlr.Product>{p});
            }
        }
        Map<Id,Id> productComplianceImageMap = new Map<Id,Id>();
        Set<Id> complianceIds = new Set<Id>();
        for(Product2 tmpProduct:[SELECT Id,Image_URL__c, (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            ProductsCtlr.Product p = records.get(tmpProduct.Id);
            p.setImages(tmpProduct);
            if(!complianceIds.isEmpty()){
                System.debug('###complianceIds::'+complianceIds);
                ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                System.debug('##'+files);
                //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                if(!files.isEmpty()){
                    if(productComplianceImageMap.containsKey(p.Id)){
                        Id complianceId = productComplianceImageMap.get(p.Id);
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    docIds += comma + l.ContentDocumentId;
                                    comma = ',';
                                }
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                    System.debug('###p.complianceFileId:::'+p.complianceFileId);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet()]){
            List<ProductsCtlr.Product> products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(ProductsCtlr.Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet()]){
            ProductsCtlr.Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        for(Product_Stock_Notification__c psn :[SELECT Product__c FROM Product_Stock_Notification__c WHERE Product__c IN :records.keySet() AND Sent_Notification__c = false]){
            records.get(psn.Product__c).notifyRequested(true);
        }
        
        r.data.put('products', records.values());
        return r;
    }
}