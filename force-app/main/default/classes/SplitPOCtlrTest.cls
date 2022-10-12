@isTest
public class SplitPOCtlrTest {
    
    @isTest
    public static void runInvalidDataTest(){
		TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
        Brand_Quote__c bq = [SELECT Id FROM Brand_Quote__c LIMIT 1];
        ApexPages.StandardController stdController = new ApexPages.StandardController(bq);
        SplitPOCtlr controllerObj = new SplitPOCtlr(stdController);
    }
    
    @isTest
    public static void runValidDataMultiLineCreateTest(){
		TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
        Boolean isAllNegative = true;
        Map<String,Boolean> PPOLineMap = new Map<String,Boolean>();
        Brand_Quote__c bq = [SELECT Id,RecordTypeId FROM Brand_Quote__c LIMIT 1];
        ApexPages.StandardController stdController = new ApexPages.StandardController(bq);
        SplitPOCtlr controllerObj = new SplitPOCtlr(stdController);
        for(SplitPOCtlr.splitPoWrpr spl : SplitPOCtlr.items){
            
        }
        SplitPOCtlr.isMulti = true;
        controllerObj.updateQtyToBillForAllBQLines();
        controllerObj.updateQtyToBillForSelectedProducerBQLines();
        controllerObj.backToQuote();
        Id poRecordTypeID = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(SplitPOCtlr.BRAND_QUOTE_RECORDTYPE_SELL_QUOTE).getRecordTypeId();
        bq.RecordTypeId = poRecordTypeID;
        poRecordTypeID = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(SplitPOCtlr.BRAND_QUOTE_RECORDTYPE_RMA).getRecordTypeId();
        bq.RecordTypeId = poRecordTypeID;
    }
    
    @isTest
    public static void lightningImplementationTest(){
        
        TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
        Test.startTest();
        Account acc = [SELECT ID from Account LIMIT 1];
        Contact con = [SELECT Id FROM Contact LIMIT 1];
        
        Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(SplitPOCtlr.PRODUCT_RECORDTYPE_DISCOUNT).getRecordTypeId();
        Product2  objProd = new Product2 ();
        objProd.RecordTypeId = devRecordTypeId;
        objProd.Name = 'Discount';
        objProd.Family = 'Discount';
        objProd.Description = 'test Labeling';
        objProd.Producer_Name__c = acc.id;
        objProd.Prepaid__c=true;
        objProd.IsActive = true;
        objProd.Quantity_Type__c = 'Quantity';
        objProd.Track_Trace_Category__c='Capsule';
        objProd.Net_Weight_UOM__c='EA';
        objProd.Unit_Gross_Weight__c = 10;
        objProd.Stocking_UOM__c = 'EA';
        insert objProd;
        
        Brand_Quote__c bq = [SELECT Id,Order_Type__c,Notes__c,Ownership__r.Membership_Level__c,Total_Weight_Fee__c,Total_Mileage_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,RecordTypeId,Planned_Transfer_Date__c,Site__r.Name,Factoring_Assignee__c,Factoring_Rate__c,Factoring_Discount__c,Factoring_Contact__c,Ownership__c,Opportunity_Name__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Supplier_Name__c,Supplier_License__c,Supplier_Contact__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Shipping_Terms__c,Shipping_Method__c,Payment_Terms__c, Sample_Order__c,Site__c FROM Brand_Quote__c LIMIT 1];
        bq.Factoring_Assignee__c = acc.Id;
        bq.Factoring_Rate__c = 102;
        bq.Factoring_Contact__c = con.Id;
        update bq;
        
        Brand_Quote__c bq2 = [SELECT Id,Order_Type__c,RecordTypeId,Planned_Transfer_Date__c,Site__r.Name,Factoring_Assignee__c,Factoring_Rate__c,Factoring_Discount__c,Factoring_Contact__c,Ownership__c,Opportunity_Name__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Supplier_Name__c,Supplier_License__c,Supplier_Contact__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Shipping_Terms__c,Shipping_Method__c,Payment_Terms__c, Sample_Order__c,Site__c FROM Brand_Quote__c LIMIT 1];
        bq2.Factoring_Assignee__c = acc.Id;
        bq2.Factoring_Rate__c = 5;
        bq2.Factoring_Contact__c = con.Id;
        update bq2;
        
       
        
        List<Brand_Quote_Line__c> bqLine = [SELECT id,name,Brand_Quote_Number__c,Disty_Margin__c 
                                            ,MOQ__c,Product_Title__c,Price_Book__c
                                            ,Line_Total_Qty__c,Product_Name__c
                                            ,Product_Name__r.Name
                                            ,Product_Description__c, Invoiced_Quantity__c, Billed_Quantity__c 
                                            ,Product_Name__r.Producer_Name__c
                                            ,Product_Name__r.Prepaid__c
                                            ,Product_Name__r.Producer_Name__r.Name
                                            ,Disty_Cost__c,Is_Sample__c,Total_Weight_lbs__c
                                            ,Ownership_Code__c,Quantity_Cases__c FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c =: bq.Id];
        for(Brand_Quote_Line__c bql : bqLine){
            bql.Total_Weight_lbs__c =1;
        }
        update bqLine;
        Brand_Quote_Line__c bqLineobj = [SELECT id,name,Brand_Quote_Number__c,Disty_Margin__c,MOQ__c,Product_Name__r.Unit_Shipping_Weight_lbs__c,Product_Name__r.Case_Shipping_Weight_lbs__c,Product_Title__c,
					 Price_Book__c,Line_Total_Qty__c,Product_Name__c,Product_Name__r.Name, Product_Description__c,Quantity_Cases__c,
					 Invoiced_Quantity__c,Billed_Quantity__c,Product_Name__r.Producer_Name__c,Product_Name__r.Prepaid__c,
                     Harvest_Batch_Code__c,Order_Type__c,                           
					 Product_Name__r.Producer_Name__r.Name,Disty_Cost__c,Is_Sample__c,Ownership_Code__c,Total_Weight_lbs__c,
					 Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c =: bq.Id limit 1];
        bqLineobj.Total_Weight_lbs__c =1;
        update bqLineobj;
        SplitPOCtlr.getRecordName(bq.Id);
        SplitPOCtlr.initCreatePO(bq.Id);
        String recordtypenames = 'RMA';
        Id poRecordTypeIDs   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(SplitPOCtlr.PURCHASE_ORDER_RECORDTYPE_FACTORING).getRecordTypeId();
        Id poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(SplitPOCtlr.PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING).getRecordTypeId();
        Purchase_Order__c objPO = new Purchase_Order__c();
        Purchase_Order__c[] POList = new Purchase_Order__c[]{};       
            objPO.Site__c = bq.Site__c;
        objpO.PO_Status__c = 'Draft';
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = bq.Supplier_License__c;
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = bq.Receiver_License__c;
        objPO.Ownership__c = bq.Ownership__c;
        insert objPO;
        POList.add(objPO);
        upsert  POList;  
        
        Product2[] discountProducts = [SELECT Id, Name, Product_Short_Description__c,Unit_Shipping_Weight_lbs__c FROM Product2 WHERE Family = 'Discount' AND RecordType.Name =: SplitPOCtlr.PRODUCT_RECORDTYPE_DISCOUNT AND Producer_Name__c = :bq.Factoring_Assignee__c];
        if(discountProducts.size() > 0){
            Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
            newPOLI.Product_Title__c = SplitPOCtlr.PURCHASE_ORDER_LINE_PRODUCT_TITLE;
            newPOLI.Qty_Ordered__c = 1;
            newPOLI.Purchase_Order__c = objPO.Id;
            newPOLI.Unit_Cost__c = bq.Factoring_Discount__c;
            newPOLI.Is_Sample__c = false;
            newPOLI.RecordTypeId = poliRecordTypeID;
            insert newPOLI;
        }
        
        Purchase_Order__c[] POList2 = new Purchase_Order__c[]{
            
        };
            
        SplitPOCtlr.getPO(bq.Id, SplitPOCtlr.PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING, poRecordTypeIDs); 
        Purchase_Order__c newPOw =SplitPOCtlr.getPO(bq.Id, recordtypenames, poRecordTypeIDs); 
        POList2.add(newPOw);
        
         Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,
			Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c FROM 
			Fulfillment_Rates_Table__c WHERE Site__c = :newPOw.Site__c AND Active__c = true AND Rate_Effective_From__c <= :System.today() 
			AND Rate_Effective_To__c >= :System.today()  AND Fulfillment_Services__c =: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Receiving_Fee') ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
        
        SplitPOCtlr.createFactoringPO(bq.Id);
        SplitPOCtlr.createInvoicePO(bq.Id);
        SplitPOCtlr.splitPoWrpr wrpSplit = new SplitPOCtlr.splitPoWrpr();
        SplitPOCtlr.AllProductDetails allProd = new SplitPOCtlr.AllProductDetails();
        SplitPOCtlr.BrandQuoteLineWrapper  br = new  SplitPOCtlr.BrandQuoteLineWrapper();
        br.isSelected=true;
        br.qtyToBill=1.0;
        br.quoteLine=bqLine[0];
        br.name=bqLine[0].Product_Name__c;
        wrpSplit.Name = bqLine[0].Product_Name__r.Producer_Name__c;
        wrpSplit.producerId = bqLine[0].Product_Name__c;
        
        List<SplitPOCtlr.BrandQuoteLineWrapper> lineWrpr = new List<SplitPOCtlr.BrandQuoteLineWrapper>();
        List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
        String JSONStr1 = JSON.serialize(new List<Object>{br});
        System.debug('##JSONStr1'+JSONStr1);
        SplitPOCtlr.isMulti = False;
        SplitPOCtlr.createOrderOne(bq,JSONStr1,false,bq.Id);
        SplitPOCtlr.isMulti = true;
        //SplitPOCtlr.createOrderOne(bq,JSONStr1,true,bq.Id);
        SplitPOCtlr.updateQtyToBillForProducerBQLines(JSONStr1);
        
        string selectedProducerId = 'test';
        SplitPOCtlr.updateQtyToBillForSelectedProducerBQLines(JSONStr1, selectedProducerId);
        Id poRecordTypeID = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(SplitPOCtlr.BRAND_QUOTE_RECORDTYPE_SELL_QUOTE).getRecordTypeId();
        bq.RecordTypeId = poRecordTypeID;
        string recordtypename = SplitPOCtlr.BRAND_QUOTE_RECORDTYPE_RMA;
        SplitPOCtlr.getPO(bq.Id, recordtypename, poRecordTypeID);
        /*Purchase_Order__c newPO2 = new Purchase_Order__c();
        newPO2.Brand_Quote__c =bq.Id;
        insert newPO2;*/
        Id poliRecordTypeIDs = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(SplitPOCtlr.PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
        
        
	        
        //SplitPOCtlr.getPOLI(bqLineobj, newPO2, poliRecordTypeIDs, 10);
        SplitPOCtlr.validateLineItems(SplitPOCtlr.ERR_MSG_QTYBILL_GREATER_VALUES);
        SplitPOCtlr.validateLineItems(SplitPOCtlr.ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED);
        
        SplitPOCtlr.validateLineItems(SplitPOCtlr.ERR_MSG_POSITIVE_VALUES);
        SplitPOCtlr.validateLineItems(SplitPOCtlr.ERR_MSG_PRODUCT_NO_DISCOUNT);
        
        
        Map<String,List<Brand_Quote_Line__c>> poToCreate = new Map<String,List<Brand_Quote_Line__c>>();
        Boolean   isAllNegative = false;
        
        //SplitPOCtlr.createOrderOne(bq,JSONStr1,false,bq.Id);
        poRecordTypeID = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(SplitPOCtlr.BRAND_QUOTE_RECORDTYPE_RMA).getRecordTypeId();
        bq.RecordTypeId = poRecordTypeID;
        for(SplitPOCtlr.BrandQuoteLineWrapper line :lineWrpr){
            line.qtyToBill = 100;
            if(line.qtyToBill > 0){
                if(poToCreate.containsKey(line.Name)){
                    bqLines = poToCreate.get(line.Name);
                }
                bqLines.add(line.quoteLine);
                poToCreate.put(line.name,bqLines);
            } 
            
            
            
        }
        set<id> bqlIds = new set<id>();
        for(SplitPOCtlr.BrandQuoteLineWrapper bqlWrapper: lineWrpr){    
            if(bqlWrapper.isSelected){
                bqlIds.add(bqlWrapper.quoteLine.Id); 
            }
        }
        List<Service_Ticket_Line__c>  STL = new List<Service_Ticket_Line__c>();
        
        SplitPOCtlr.getPOLI(bqLineobj,objPO,poliRecordTypeID,1.0,STL,'',FRTList);
        /*List<AggregateResult> aggResult = [select Brand_Quote_Line__c ,  sum(Qty_Ordered__c) from Purchase_Order_Line__c 
                                           where Brand_Quote_Line__c  =:bqlIds GROUP BY Brand_Quote_Line__c ];*/
        string allproductName ='ACK';
        string  message = String.format(SplitPOCtlr.ERR_MSG_PRODUCT_PREPAID_VALIDATION,new List<String>{String.valueOf(allproductName)});
        message = String.format(SplitPOCtlr.ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED,new List<String>{String.valueOf(allproductName)});
        message = SplitPOCtlr.ERR_MSG_NO_PURCHASE_ORDER_LINES;
        message= String.format(SplitPOCtlr.ERR_MSG_QTY_BILL_NOT_GREAT_THAN_AVAILABLE_QTY,new List<String>{String.valueOf(allproductName)});
          message = SplitPOCtlr.ERR_MSG_FACTORING_PO_NOT_BLANK;
        message = SplitPOCtlr.PURCHASE_ORDER_RECORDTYPE_RMA;
        message = SplitPOCtlr.PURCHASE_ORDER_LINE_RECORDTYPE_RMA;
        Test.stopTest();
    } 
    
    @isTest
    public static void lightningImplementationTest2(){
        TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
        SplitPOCtlr.BrandQuoteLineWrapper  br2 = new  SplitPOCtlr.BrandQuoteLineWrapper(); 
        
        SplitPOCtlr.BrandQuoteLineWrapper  br = new  SplitPOCtlr.BrandQuoteLineWrapper(); 
        String JSONStr1 = JSON.serialize(new List<Object>{br});
        
        List<SplitPOCtlr.BrandQuoteLineWrapper> lines  = (List<SplitPOCtlr.BrandQuoteLineWrapper>) System.JSON.deserialize(JSONStr1, List<SplitPOCtlr.BrandQuoteLineWrapper>.class);
        for(SplitPOCtlr.BrandQuoteLineWrapper line : lines){
            
            line.qtyToBill = -10;
            if(line.qtyToBill > line.quoteLine.Billed_Quantity__c)
            {
                Boolean isError = false;
                SplitPOCtlr.validateLineItems(SplitPOCtlr.ERR_MSG_POSITIVE_VALUES);  
            }
        }
        
        
        
        Boolean hasPOLines = false;
        SplitPOCtlr.isMulti = true;
        List<Purchase_Order_Line__c> poLineItems = new List<Purchase_Order_Line__c>();
        Map<String, Decimal> qtyMap = new Map<String, Decimal>();
        for(SplitPOCtlr.BrandQuoteLineWrapper line : lines){
            Decimal qtyToBill = line.qtyToBill;
            if(qtyToBill != null && qtyToBill > 0 && line.quoteLine.Product_Name__r.Prepaid__c == false)
            { 
                hasPOLines = true;
                
                set<id> bqlIds = new set<id>();
                for(SplitPOCtlr.BrandQuoteLineWrapper bqlWrapper : lines){    
                    if(bqlWrapper.isSelected){
                        bqlIds.add(bqlWrapper.quoteLine.Id); 
                    }
                }
                List<AggregateResult> aggResult = [select Brand_Quote_Line__c , sum(Qty_Ordered__c) from Purchase_Order_Line__c 
                                                   where Brand_Quote_Line__c  =:bqlIds GROUP BY Brand_Quote_Line__c ];

            }
        }
        
    } 
    
    
    
}