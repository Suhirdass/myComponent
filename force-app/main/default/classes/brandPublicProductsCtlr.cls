public without sharing class brandPublicProductsCtlr {
    
    private static String ORDERBYFIELD_FILTER{
        get{
            return String.isNotBlank(ORDERBYFIELD_FILTER) ? ORDERBYFIELD_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','OrderBy_Field');
        }set;
    }
    private static String IS_ASC{
        get{
            return String.isNotBlank(IS_ASC) ? IS_ASC : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Is_ASC');
        }set;
    }
    private static String BRAND_ID{
        get{
            return String.isNotBlank(BRAND_ID) ? BRAND_ID : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Brand_ID');
        }set;
    }
    private static String FAMILIES_FILTER{
        get{
            return String.isNotBlank(FAMILIES_FILTER) ? FAMILIES_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Families');
        }set;
    }
    private static String ASC_DIRECTION{
        get{
            return String.isNotBlank(ASC_DIRECTION) ? ASC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','ASC_Direction');
        }set;
    }
    private static String DESC_DIRECTION{
        get{
            return String.isNotBlank(DESC_DIRECTION) ? DESC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','DESC_Direction');
        }set;
    }
    private static String SEARCHTERM_FILTER{
        get{
            return String.isNotBlank(SEARCHTERM_FILTER) ? SEARCHTERM_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','SearchTerm');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
    
	public static Boolean isBrand = true;
    public static Boolean isBrandProducts = true;
    public static Id searchBrandId;
    public static Id brandId ;
    public static Id priceBookId;
    public static List<String> productFamilies = new List<String>();
    static String recordTypeName = PRODUCT_RECORD_TYPE_NAME_PRODUCT;
    static Map<String, String> brandPriceBooks;
    public static List<String> priceBooks;
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getShortURL(String currentURL){
        
        AuraResponse r = new AuraResponse('brandPublicProductsCtlr.getShortURL()');
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api-ssl.bitly.com/v4/shorten');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer 99fbd9fa8385b7277be2893d4aa561f912cc3eab');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(new Map<String, Object>{'group_guid' => 'Bl3j5Nn4VqO','domain' => 'bit.ly','long_url' => currentURL}));	
        HttpResponse res = new Http().send( req );	  
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('response = '+response.get('link'));
        
        r.data.put('link', response.get('link'));
        
        return r;
    }
    
    
    public static Map<String, String> getBrandPriceBooks(String retailerId){
        Map<String, String> brandPriceBooks = new Map<String, String>();
        for(Line_Card__c lineCard:[SELECT Community_Price_Book__c,Retailer_Excluded__c , Brand_Name__c FROM Line_Card__c WHERE Retailer_Name__c = :retailerId]){
            if(lineCard.Community_Price_Book__c != null && !lineCard.Retailer_Excluded__c ){
                brandPriceBooks.put(lineCard.Brand_Name__c, lineCard.Community_Price_Book__c);
            }
        }
        return brandPriceBooks;
    }
    
	@AuraEnabled(cacheable=true)
    public static AuraResponse getIds(Map<String, Object> filters,String brndId){
        
		AuraResponse r = new AuraResponse('brandPublicProductsCtlr.getIds()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        List<String> families = new List<String>();
        
        Blob endcodedIdb =EncodingUtil.base64Decode(brndId);
        brandId = endcodedIdb.toString();
        
        System.debug(brndId);
        
        brandPriceBooks = getBrandPriceBooks(brandId);
        priceBooks = brandPriceBooks.values();
        
        Account acc = [SELECT Id,Name,Community_Price_Book__c FROM Account WHERE Id =: brandId];
        
        if(acc.Community_Price_Book__c != null){
            priceBookId = acc.Community_Price_Book__c;
        }
        
        whereParts.add('(Product2.Out_of_stock_product__c = true)');
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.isNumeric()){
                        Decimal price = Decimal.valueOf(searchTerm);
                        whereParts.add('(unitPrice =: price)');
                    } else {
                        searchTerm = '%' + searchTerm + '%';
                        whereParts.add('(Product2.Name LIKE :searchTerm OR Product2.Family LIKE :searchTerm OR Product2.Description LIKE :searchTerm OR Product2.Product_Short_Description__c LIKE :searchTerm OR Product2.Brand_Name__c LIKE :searchTerm OR Product2.Strain__r.Name LIKE :searchTerm OR Product2.Strain__r.Strain_Type__c LIKE :searchTerm)');// OR Product2.Producer_Name__r.DBA__c LIKE :searchTerm OR Product2.Producer_Name__r.Name LIKE :searchTerm OR Product2.Licensee_Name__r.DBA__c LIKE :searchTerm OR Product2.Licensee_Name__r.Name LIKE :searchTerm
                    }
                }
            }
            if(hasFilter(filters, BRAND_ID)){
                searchBrandId = String.valueOf(filters.get(BRAND_ID));
                if(String.isNotBlank(searchBrandId)){
                    isBrandProducts = true;
                }
            }else{
                isBrandProducts = false;
            }
            if(hasFilter(filters, FAMILIES_FILTER)){
                String family = String.valueOf(filters.get(FAMILIES_FILTER));
                if(String.isNotBlank(family)){
                    families = family.split(';');
                    whereParts.add('(Product2.Family IN :families)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Set<Id> ids = new Set<Id>();
        
        Map<Id,PricebookEntry> pbes = new Map<Id,PricebookEntry>((List<PricebookEntry>)Database.query(getQuery(new List<String>{'Id','Product2Id','Product2.Out_of_stock_product__c','Product2.Status__c','Product2.Producer_Name__c','PriceBook2Id'}, whereParts, orderBy, 49999)));
        
        Set<String> brandPriceBookSet = new Set<String>();
        Set<Id> addedProducts = new Set<Id>();
        Map<Integer,Id> priceBookIdsMap = new Map<Integer,Id>();
        Integer i=0;
        List<PricebookEntry> ignoredPBEs = new List<PricebookEntry>();
        for(PricebookEntry pbe : pbes.values()){
            priceBookIdsMap.put(i++,pbe.Id);
            String brandPriceBook = pbe.Product2.Producer_Name__c+'-'+pbe.PriceBook2Id;
            addedProducts.add(pbe.Product2Id);
        }
        Set<Id> ignoredPBEIds = new Set<Id>();
        ids = pbes.keySet();
        ids.removeAll(ignoredPBEIds);
             
        r.data.put('ids', ids);
        r.data.put('isBrand', isBrand);
        
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getProducts(List<String> ids, Map<String, Object> filters,String brndId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProducts()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        
        Blob endcodedIdb =EncodingUtil.base64Decode(brndId);
        brandId = endcodedIdb.toString();
        //brandId = brndId;
        
        brandPriceBooks = getBrandPriceBooks(brandId);
        priceBooks = brandPriceBooks.values();
        
        Account acc = [SELECT Id,Name,Community_Price_Book__c FROM Account WHERE Id =: brandId];
        
        if(acc.Community_Price_Book__c != null){
            priceBookId = acc.Community_Price_Book__c;
        }
        
        System.debug('Ids = '+ids);
        
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        Map<String, ProductsCtlr.Product> records = new Map<String, ProductsCtlr.Product>();
        Map<String, List<ProductsCtlr.Product>> procuderProducts = new Map<String, List<ProductsCtlr.Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'Product2.Out_of_stock_product__c','Product2.MSRP__c','UnitPrice','Product2.Status__c','Product2.Is_Sample__c','Product2.Parent_Product__c','Product2.Name', 'Product2.Family','Product2.RecordType.Name', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c','Product2.Description', 'Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name','Product2.Producer_Name__c','Product2.Licensee_Name__r.Name','Product2.Licensee_Name__c','Product2.White_Labelled__c','Product2.Brand_Name__c', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c', 'Product2.Terpene_percent__c','Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>{'Id IN :ids'}, orderBy, 49999))){
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
        Map<Id,ProductsCtlr.WarehouseAvailableInventory[]> warehouseAvailableInventoryMap = ProductsCtlr.getWarehouseAvailableInventory(records.keySet());
        Set<Id> pbeIds = new Set<Id>();
        
        Set<Id> childIds = new Set<Id>();
        
        for(Product2 tmpProduct:[SELECT Id,Image_URL__c,Available_Qty__c,Status__c,(select id,Is_Sample__c,Parent_Product__c from Products__r), (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            ProductsCtlr.Product p = records.get(tmpProduct.Id);
            p.hasSampleChild = false;
            if(tmpProduct.Products__r.size() > 0){
                //p.hasSampleChild = true;
                p.childProductId = tmpProduct.Products__r[0].Id;
                childIds.add(p.childProductId);
            } 
            
            p.setImages(tmpProduct);
            p.availableInventories = warehouseAvailableInventoryMap.get(tmpProduct.Id);
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
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                }
            }
        }
        
        
        for(PricebookEntry pbe :[SELECT Product2.MSRP__c,Product2.Status__c,UnitPrice,Product2.Is_Sample__c,Product2.Parent_Product__c,Product2.Name,Product2.Brand_Name__c,Product2.Family,Product2.RecordType.Name,Product2.Unit_Height__c,Product2.Retail_Unit_Form_Factor__c,
                                 Product2.Unit_Width__c,Product2.Unit_Radius__c,Product2.Unit_Length__c,Product2.Unit_Cubic_Volume__c,Product2.Product_Rating__c,Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c,Product2.Available_Qty__c
                                 ,Product2.Total_Order_Qty__c,Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c,Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name,Product2.Cultivation_Type__c,
                                 Product2.Image_URL__c,Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,Product2.CDB_Amount__c,Product2.CBD_MG_G__c,
                                 Product2.Fulfilled_by_Filigreen__c, Product2.Licensee_Name__r.Name,Product2.Licensee_Name__c,Product2.White_Labelled__c
                                 FROM PriceBookEntry 
                                 WHERE Product2Id IN : childIds
                                 AND PriceBook2Id IN: priceBooks]){
                                     
                                     ProductsCtlr.Product p = records.get(pbe.Product2.Parent_Product__c);
                                     
                                     if(pbe.Product2.Available_Qty__c > 0){
                                         p.hasSampleChild = true;    
                                         p.sampleProduct = new ProductsCtlr.Product(pbe);
                                     } else {
                                         p.hasSampleChild = false;     
                                     }
                                     
                                 }
        
        DateTime nowTime = System.now();
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime ]){
            List<ProductsCtlr.Product> products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(ProductsCtlr.Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime]){
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
        r.data.put('warehouseTotalOrderedMap',ProductsCtlr.getWarehouseOrderedMap(records.keySet()));
        r.data.put('warehouseAvailableInventory',ProductsCtlr.getWarehouseAvailableInventory(records.keySet()));
        
        List<String> families = new List<String>();
        List<Schema.PicklistEntry> ple = Product2.Family.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry f : ple){
            families.add(f.getValue());
        }
        r.data.put('families', families);
        
        List<String> ExceptionalFamilies = String.isNotBlank(System.Label.ExceptionalFamilies)?System.Label.ExceptionalFamilies.split(','):new List<String>();
        r.data.put('exceptionalFamilies', ExceptionalFamilies);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getProductAndReviews(String id, String brndId, Integer reviewsLimit){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProductAndReviews()');
        
        Blob endcodedIdPB =EncodingUtil.base64Decode(id);
        id = endcodedIdPB.toString();
        
        Blob endcodedIdb =EncodingUtil.base64Decode(brndId);
        brandId = endcodedIdb.toString();
        
        brandPriceBooks = getBrandPriceBooks(brandId);
        priceBooks = brandPriceBooks.values();
        
        Account acc = [SELECT Id,Name,Community_Price_Book__c FROM Account WHERE Id =: brandId];
        
        if(acc.Community_Price_Book__c != null){
            priceBookId = acc.Community_Price_Book__c;
        }
        
        String productId = '';
        ProductsCtlr.Product p;
        System.debug('id = '+id);
        //for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'UnitPrice','Product2.Status__c','Product2.Is_Sample__c','Product2.Parent_Product__c', 'Product2.Name','Product2.Brand_Name__c','Product2.Family', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c' ,'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c','Product2.Terpene_percent__c', 'Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>{'Id = :id'}, '', 49999))){
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query('select Product2.MSRP__c,UnitPrice,Product2.Status__c,Product2.Is_Sample__c,Product2.Parent_Product__c, Product2.Name,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Family, Product2.Product_Rating__c, Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c ,Product2.Available_Qty__c, Product2.Total_Order_Qty__c, Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c, Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name, Product2.Cultivation_Type__c,Product2.Image_URL__c, Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c, Product2.THC_Amount__c, Product2.THC_MG_G__c, Product2.CDB_Amount__c, Product2.CBD_MG_G__c,Product2.Fulfilled_by_Filigreen__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.White_Labelled__c from PricebookEntry where Id = :id Limit 49999 ')){
            productId = pbe.Product2Id;
            p = new ProductsCtlr.Product(pbe);
        }
        if(p != null){
            p.hasSampleChild = false;
            Map<Id,ProductsCtlr.WarehouseAvailableInventory[]> warehouseAvailableInventoryMap = ProductsCtlr.getWarehouseAvailableInventory(new Set<String>{p.Id});
            for(Product2 tmpProduct:[SELECT Id,Image_URL__c,(select id,Is_Sample__c,Parent_Product__c from Products__r), (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id =:p.Id]){
                p.setImages(tmpProduct);
                p.availableInventories = warehouseAvailableInventoryMap.get(tmpProduct.Id);
                if(tmpProduct.Products__r.size() > 0){
                    p.hasSampleChild = true;
                    p.childProductId = tmpProduct.Products__r[0].Id;
                } 
                
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
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                }
            }
            
            if(p.hasSampleChild == true){
                p.hasSampleChild = false;
                Id sampleProductId = p.childProductId;
                //priceBooks.add(priceBookId);
                for(PricebookEntry pbe :[SELECT Product2.MSRP__c,Product2.Status__c,UnitPrice,Product2.Is_Sample__c,Product2.Parent_Product__c,Product2.Name,Product2.RecordType.Name,Product2.Brand_Name__c,Product2.Family,Product2.Unit_Height__c,Product2.Retail_Unit_Form_Factor__c,
                                         Product2.Unit_Width__c,Product2.Unit_Radius__c,Product2.Unit_Length__c,Product2.Unit_Cubic_Volume__c,Product2.Product_Rating__c,Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c,Product2.Available_Qty__c
                                         ,Product2.Total_Order_Qty__c,Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c,Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name,Product2.Cultivation_Type__c,
                                         Product2.Image_URL__c,Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,Product2.CDB_Amount__c,Product2.CBD_MG_G__c,
                                         Product2.Fulfilled_by_Filigreen__c  ,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__c,Product2.White_Labelled__c
                                         FROM PriceBookEntry 
                                         WHERE Product2Id = :sampleProductId
                                         AND PriceBook2Id IN: priceBooks]){
                                             
                                             if(pbe.Product2.Available_Qty__c > 0){
                                                 p.hasSampleChild = true;    
                                                 p.sampleProduct = new ProductsCtlr.Product(pbe);
                                             } else {
                                                 p.hasSampleChild = false;     
                                             }
                    System.debug('##p.sampleProduct::'+p.sampleProduct);
                }
            }
        }
        
        System.debug('##productId::'+productId);
        if(String.isNotBlank(productId) && p != null){
            for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now() AND (Brand__c =: p.producerId OR Product_Name__c =: p.id)]){
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
            r.data.put('warehouseTotalOrderedMap',ProductsCtlr.getWarehouseOrderedMap(new Set<String>{p.Id}));
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
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getCategories(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCategories()');
        Product_Categories__c[] categories = [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c  FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c];//Product_Categories__c.getAll().values();
        r.data.put('categories', categories);
        List<String> termsAndConditions = new List<String>();
        for(Terms_and_condition__c tnc:[SELECT Term_and_condition__c FROM Terms_and_condition__c WHERE Is_Active__c = true ORDER BY Display_Order__c]){
            termsAndConditions.add(tnc.Term_and_condition__c);
        }
        r.data.put('termsAndConditions', termsAndConditions);
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        r.data.put('companyCustomSetting', ccs);
        if(ccs.Default_License__c != NULL){
            State_Licenses__c[] STs = [SELECT Id,Name,License_Number__c FROM State_Licenses__c WHERE Id = :ccs.Default_License__c];
            if(STs.size() > 0){
                r.data.put('STName', STs[0].License_Number__c);
            }
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId = :ccs.Default_License__c ];
            System.debug('##'+files);
            if(!files.isEmpty()){
                if(ccs.Default_License__c != null){
                    String docIds = '';
                    String comma = '';
                    String[] pdfIds = new String[]{};
                    String[] otherIds = new String[]{};
                    for(ContentDocumentLink l:files){
                        if(l.LinkedEntityId == ccs.Default_License__c){
                            System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                            if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                        }
                    }
                    docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                    r.data.put('STFiles', docIds);
                }
            }
        }
        return r;
    }
    
    private static String getQuery(List<String> fields, List<String> filters, String orderBy, Integer maxRecords){
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM PricebookEntry ';
        List<String> ORfilters = new List<String>();
        filters.addAll(new List<String>{
            'Product2Id != null',
                'Product2.RecordType.Name = :recordTypeName',
                'Product2.IsActive = true',
                'Product2.Hide_From_Marketplace__c = false',
                'Product2.Producer_Name__r.Hide_from_Marketplace__c = false',
                'Product2.Is_Sample__c = false'
                });
        
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
            }
        }
        filters.add('(Product2.Family IN : productFamilies)');
        
        filters.add('PriceBook2Id = :priceBookId');
        
        if(!filters.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(filters, ' AND '));
        }
        if(isBrand){
            query += ' AND( (Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true))';
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) +',Product2.Available_Qty__c DESC';
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##query::'+query);
        return query;
    }
   
    public static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
}