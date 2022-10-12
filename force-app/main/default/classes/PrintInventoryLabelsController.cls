/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PrintInventoryLabelsController
 */
public class PrintInventoryLabelsController {
    
    private ApexPages.StandardController stdController;
    private String uniqueKeyFormat = '{0}{1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}{12}';
    @TestVisible private static String ONEBYTHREE = '1 X 3';
    @TestVisible private static String TWOBYFOUR = '2 X 4';
    @TestVisible private static String FOURBYSIX = '4 X 6';
    
    public transient  String  imageTextSrc {get; set;}
    public transient  String  imageTextSrc1 {get; set;}
    public  List<InventoryPositionWrapper> invPositionWrappList {get; set;}
    public Product2 productObj {get; set;}
    public static Product2 productObjLight {get; set;}
    public String selectedDymoLabelLayout {get; set;}
    public transient String imageXml {get; set;}
    public Boolean isSelectedInventory {get; set;}
    public transient String inventoryInfo {get; set;}
    public static List<CustomSelectOptions> options;
    public static List<CustomSelectOptions> optionPrinter;
    List<String> AssignedWarehouseIds = new List<String>();
    // Constructor
    public PrintInventoryLabelsController(ApexPages.StandardController controller) {
        this.stdController = controller;
        productObj = ((Product2)stdController.getRecord());
        invPositionWrappList = new List<InventoryPositionWrapper>();
        imageTextSrc = 'data:image/png;base64';
        imageTextSrc1 = 'data:image/png;base64';
        isSelectedInventory = false;
        //Get Assigned warehouse from loggedIn User
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
        }
    }
    @AuraEnabled
    public static AuraResponse inventoryDetails(String recId){
        List<String> AssignedWarehouseIdsUser = new List<String>();
        AuraResponse r = new AuraResponse('PrintInventoryLabelsController.inventoryDetails()');
        List<InventoryPositionWrapper> invPositionWrappList = new List<InventoryPositionWrapper>();
        //Get Assigned warehouse from loggedIn User
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIdsUser = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
        }
        List<Product2> prodList = [Select ID,name,Producer_Name__c,Strain__r.Name,Producer_Name__r.name,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,Strain__c,Strain_Type__c,MOQ__c,
                   ItemToPutAway__c,Allocated_Inventory__c,Available_Inventory__c,Inventory_On_Hold_Qty__c ,Available_Qty__c ,Total_Inventory__c,TotalCannabisWeight__c,
                   (Select id,Name,Site__c,Site__r.Name,Product_Name__c,Product_Name__r.Name,Inventory_Location__c,Inventory_Location__r.Name,Rack__c,Supplier_License_Number__c,
                    Product_Description__c,
                    Sales_Order_Line__c,Sales_Order_Line__r.Status__c,Sales_Order_Line__r.Name,Rack_Level__c,Rack__r.Name,Rack_Level__r.Name,Ownership__r.Name,
                    Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Qty_Allocated__c,Bin_Location__r.Name,Supplier_Name__c,License_Premise__c,
                    Harvest_Batch_or_Lot_Code__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Lab_Test_Status__c,UID__c,UID_New__c,UID_New__r.Name,Hold__c ,
                    Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name 
                    from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true AND Inventory_Location__r.Site_Name__c IN :AssignedWarehouseIdsUser) from Product2 where ID=:recId];
        
        // Map of unique key of inventory position to give aggregate quantity
        Map<String, Decimal> totalQtyByUniqueInvPosition = new Map<String, Decimal>();
        Decimal totalQty;
        String uniqueKey;
        Boolean isDifferentInvPosition;
        
        for(Inventory_Position__c invPosRec : prodList[0].Inventory_Positions__r){
            InventoryPositionWrapper invPositionWrapper = new InventoryPositionWrapper(false, invPosRec);
            invPositionWrappList.add(invPositionWrapper);
        }
        
        options = new List<CustomSelectOptions>();
        options.add(new CustomSelectOptions('', 'Select Layout'));
        options.add(new CustomSelectOptions(ONEBYTHREE, ONEBYTHREE));
        options.add(new CustomSelectOptions(TWOBYFOUR, TWOBYFOUR));
        options.add(new CustomSelectOptions(FOURBYSIX, FOURBYSIX));
        
        optionPrinter = new List<CustomSelectOptions>();
        optionPrinter.add(new CustomSelectOptions('', 'Select Printer'));

        //productObj = prodList[0]; 
        productObjLight = prodList[0];      
        
        AllProductDetails allRec = new AllProductDetails();      
        allRec.prod = prodList[0];
        allRec.invPositionWrappList = invPositionWrappList;
        allRec.dymoLabelLayouts = options;
        allRec.printers = optionPrinter;
        allRec.selectedDymoLabelLayout = '';
        allRec.inventoryInfo = '';
        r.data.put('records', allRec);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse fetchFilterProducts(String str,String JSONStr1,String recId){
        AuraResponse r = new AuraResponse('PrintInventoryLabelsController.fetchFilterProducts()');
        List<InventoryPositionWrapper> invPositionWrappListNew = new List<InventoryPositionWrapper>();
        
        List<InventoryPositionWrapper> invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonStr1, List<InventoryPositionWrapper>.class);
        for( InventoryPositionWrapper var : invPositionWrappList ){
            if(var.invPos.Name.indexOf(str) != -1){
                invPositionWrappListNew.add(var);
            }
        }
        if(invPositionWrappListNew.size() > 0){
            r.data.put('records', invPositionWrappListNew);    
        } else {
            invPositionWrappList.clear();
            PrintInventoryLabelsController.inventoryDetails(recId);
            r.data.put('records', invPositionWrappList);    
        }
        return r;
    }
    /**
     *  Retrieve inventory positions related to selected product
     */
    public void retrieveInventoryPositions(){
        
        if(productObj.Id != null){
            productObj = [Select Name,
                                 Description,
                                 IsActive,
                                 Family,
                                 (Select Name,
                                        Site__c,
                                        Product_Name__c,
                                        Product_Name__r.Name,
                                        Inventory_Location__c,
                                        Inventory_Location__r.Name,
                                        Rack__c,
                                        Rack__r.Name,
                                        Sales_Order_Line__c,
                                        Sales_Order_Line__r.Status__c,
                                        Rack_Level__c,
                                        Rack_Level__r.Name,
                                        Date_Received__c,
                                        Bin_Location__c,
                                        Bin_Location__r.Name,
                                        Ownership__c,
                                        Qty_On_Hand__c,
                                        Qty_Allocated__c,
                                        Harvest_Batch_Code__c,
                                        Harvest_Batch_Code__r.Name,
                                        Lab_Test_Status__c,
                                        UID_New__c,
                                        UID_New__r.Name,
                                        Supplier_Name__c ,
                                        Supplier_License_Number__c,
                                        License_Premise__c,
                                        Product_Description__c,
                                        Purchase_Order__c,
                                        Quantity_Type__c,
                                        Stocking_UOM__c,
                                        Ownership__r.Name,
                                        Producer_Name__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c 
                                     From Inventory_Positions__r 
                                     Where Inventory_Location__r.Include_in_Inventory__c = true AND Inventory_Location__r.Site_Name__c IN :AssignedWarehouseIds) 
                        From Product2 Where ID=:productObj.Id ];
            
            // Map of unique key of inventory position to give aggregate quantity
            Map<String, Decimal> totalQtyByUniqueInvPosition = new Map<String, Decimal>();
            Decimal totalQty;
            String uniqueKey;
            Boolean isDifferentInvPosition;
            
            for(Inventory_Position__c invPosRec : productObj.Inventory_Positions__r){
                
                /*isDifferentInvPosition = false;
                uniqueKey = createUniqueKeyOfInvPosition(invPosRec);
                
                if(!totalQtyByUniqueInvPosition.containsKey(uniqueKey)){
                    isDifferentInvPosition = true;
                }
                
                totalQty = totalQtyByUniqueInvPosition.get(uniqueKey);
                totalQty = totalQty == null ? invPosRec.Qty_Allocated__c : 
                           invPosRec.Qty_Allocated__c == null ? totalQty : invPosRec.Qty_Allocated__c + totalQty;
                totalQtyByUniqueInvPosition.put(uniqueKey, totalQty);
                
                // Assign total qty as allocated qty
                invPosRec.Qty_Allocated__c = totalQty;
                    
                // Add only unique inventory position to the list
                if(isDifferentInvPosition){
                    InventoryPositionWrapper invPositionWrapper = new InventoryPositionWrapper(false, invPosRec);
                    invPositionWrappList.add(invPositionWrapper);
                }*/
                InventoryPositionWrapper invPositionWrapper = new InventoryPositionWrapper(false, invPosRec);
                invPositionWrappList.add(invPositionWrapper);
            }
            
            // Assign total qty to unique inventory positions
            /*for(InventoryPositionWrapper invPositionWrapper : invPositionWrappList){
                uniqueKey = createUniqueKeyOfInvPosition(invPositionWrapper.invPos);
                invPositionWrapper.invPos.Qty_Allocated__c = totalQtyByUniqueInvPosition.get(uniqueKey);
            }*/
        }
    }
    
    /**
     * Create unique key of inventory position
     * @param invPosRec The inventory position record
     * @return The unique key of inventory position
     */
    /*private String createUniqueKeyOfInvPosition(Inventory_Position__c invPosRec){
        String uniqueKey = String.format(uniqueKeyFormat,
                                         new List<String>{invPosRec.Supplier_License_Number__c,
                                                          invPosRec.License_Premise__c,
                                                          invPosRec.Product_Name__c,
                                                          invPosRec.Product_Description__c,
                                                          invPosRec.Purchase_Order__c,
                                                          invPosRec.Date_Received__c != null ?
                                                          invPosRec.Date_Received__c.format() : '',
                                                          invPosRec.Harvest_Batch_Code__c,
                                                          invPosRec.UID_New__c,
                                                          //invPosRec.Quantity_Type__c // Which Type?
                                                          invPosRec.Stocking_UOM__c,
                                                          invPosRec.Ownership__c,
                                                          invPosRec.Rack__c,
                                                          invPosRec.Rack_Level__c,
                                                          invPosRec.Bin_Location__c});
        return uniqueKey;
    }*/
    
    // Redirect to product page
    public PageReference redirectItemDetail(){
        PageReference pageRef = null;
        if(String.isNotBlank(productObj.Id)){
            pageRef = new PageReference('/'+productObj.Id);
            pageRef.setRedirect(true);
            return pageRef;
        }
        return pageRef;
    }
    
    public static String getImage1X3Xml(Inventory_Position__c invPos){
        String template = '<?xml version="1.0" encoding="utf-8"?>' +
            '<DieCutLabel Version="8.0" Units="twips">' +
            '<PaperOrientation>Landscape</PaperOrientation>' +
            '<Id>Address</Id>' +
            '<PaperName>30252 Address</PaperName>' +
            '<DrawCommands>' +
                '<RoundRectangle X="0" Y="0" Width="1581" Height="9040" Rx="270" Ry="270" />' +
            '</DrawCommands>' +
            '<ObjectInfo>' +
            '   <ImageObject>' +
            '       <Name>GRAPHIC</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>False</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <Image>iVBORw0KGgoAAAANSUhEUgAAAgsAAACzCAYAAAAHWV//AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAC82SURBVHhe7d0JvEzl/wfwr2TNGhKR7dpd+1K2NpG/8FNaSMjSqlelRSpLRUW0b7iWSqHNUipaSAhZU3bZLuXaXVxr838+3znPOHfMHHNx3bnu531f5zXzPGfuzJlznvOc77PMTKaePXv6JMgll1wi1apVc1JE0efEiRMyf/58KVOmjBQuXNjJJYpeiQcSZfkfy6VKlSqSJ08eJ5co+qxdu1Z27NjhpPwymeWUYIGIiIjIusi5JSIiIgqJwQIRERF5YrBAREREnhgsEBERkaeQExxz5colHTp0cFJE0efo0aMyatQoadSokVSuXNnJJYpe27dvl4kTJ0qrVq2kaNGiTi5R9Pnxxx9l3bp1TsovZLCAj00uXbrUSRFFn71790r+/Pk1YLjnnnucXKLo9fvvv0vdunVl9uzZ0qBBAyeXKPp0v7e7xI2Ic1J+HIYgIiIiTwwWiIiIyBODBSIiIvLEYIGIiIg8MVggIiIiTwwWiIiIyNMFESysXr1aVq5c6aRozIdj5K233nJSlNF89dVX8s477+gvcxJlJPMXzJfBgwfLli1bnBw6V9JVsNC1WzcpW7asbN682cnxq1GjhlSqVEn279/v5ESPw4cP6xcH4bsr3njjDSdXZNLkSVKuXDmZM2eOk3Pu9O/XXx555BEnRdHmueee058pxlK7dm3p1r2brFixwll79gYNGiQPP/ywHEo65OSk3Pr162Xd+uRfymKlRZmm9A9f9GPLPersm2++WUaPHu2s9bZr1y5Z/udyOXrsqJMT2tRvpkqvXr3kjz/+cHLCQ1BdqlQpbVzBU089Fdg+fA8Gvr/ls88+03WUzoKFdWvX6rdKHTqUvBJE5YuLYzT+Rvzu3bv1S1hQeB977DGz/Ws1P2F7gv5mONZTxvLrr7/KX3/9JUWKFJH//vtPRsaN1Mrz33//dR6R9urUqSOVK4X+ZkyWaToTqLtR7rNnz65B5ffffy9dunSRSZMmOY8I7+WXX5aqsVVl7py5Ts7ZS0hIkI0bN8o/2/7R9Pz583X7ChYsKEeOHJExY8bIHXfcIXfeeaeuz+guiGGIbNmy6VdUW6isBgwYIHfddZc888wzgUp42bJl8sQTT+hXWQ8dOjQQdCDiRVSJoQzcdu3aVX766SddB8hHpYiC069fPzl48KDmh3s+L3379nPuJffSSy/J888/76RE3n//fXn66afl2LFjge1DQX788celU6dOesHBdj3wwAP6bVvofgs2ZcoU3Qf4302bNjm5p98PP8/4Wdq1ayfTp0/XfEodGCpYvHixNG7cWL++Gsc03DFYtWqVBsXt27fXcuHuicD/4jjieL733nuatr777js91qgU4bffftMytHz5ck37fD4ZO3as9tqhHKFX4LXXXpM9e/bo8+A1f/nlF31sOOHKNF6jd+/eet7cf//98s033zhrRF599VWtjL/99lttwWGb8HXIX375pb5H/J876DiTc42iU8eOHWXChAmBXqmFCxfqbbjygnPC1sfDhw/X8wbC1fPw999/S8+ePf11+c8n6/JIjBgxQrdpzZo1UqhQId1Wd9nNyPB1z8mWatWqmTok+phKVbfPXCSdHL8SJUpoPiQlJflKly6t6Rw5cuitiUp95mKq983B99WqVUvvN2vWVP+nT58+mg5e1q9f70tMTPTlyJVDn+u2tm19efPm9S1ZssTz+dy2bt2q69q0aaPPg/vmAuEbNmyY3jcXdH1c/vz5fZkzZ9b7ULduXV2/P3F/2O3D49339+7dq/9r94d7QZ4JPFK0H1555RXNj0bmYqbbOGrUKCcn/bDl2AQAmm7VqpWmJ06aGPIYmIorkC5VqlTgvqlc9f9N6yyQ515QdswFVu+bClMfaypoTX/yySeaNoFJ4PFZs2b1VapUKXD+2GXQoEH6WCvSMl24cGE9bxo2bBh4LjwOQpVRnFvu9O23366PjfRci3YLFizQbZ89e7aTk7GYBpC+f5RJ7AscQ6TNhVjXhysv/fv3D6Sx4PoUrp4PV1ea4EFfw81uj2moadqelyZI0DSYwFTzevXq5eRkDN26dwvsO7tccJ+GmDx5skaVLVu21MgT91vc3EKGDhmq69FKQtR43XXXybRp05NNhEF304EDB7TlDvgud1MxStKBJO2WHWaiWnRdVa1aNaLnc8MQycAXBur9Z599Vm9TCi1NE7yIOcmSpZs0aaKT2Wxr0fr888/FnFRSJTZWexbmzp0b0XajpYvHdzOtTUo9aNFjbgF6gEyFJ/Wvru+sSX4MTMCgeWh1ozyj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icECEREReWKwQERERJ4YLBAREZEnBgtERETkicECEREReWKwQERERJ4YLBAREZEnBgtERETkicECEREReWKwQERERJ4ymcXnv3tS0aJF5ZVXXnFSRNHn0KFDcv/990uXrl3l2muucXKJotfff/8t/fv3l+eee07KlSvn5BJFnxEjRsivv/7qpPxCBgtEREREVshgoXLlyjJz5gwnRRR99u7bJ2Vjysqbb74p7du3c3KJoteSJUuladOm8s0330i9enWdXKLo89hjPWXs2LFOyi9ksFCtWjVZunSpkyKKPnv37pX8+fPLqFGj5J577nFyiaLX77//LnXr1pXZs2dLgwYNnFyi6NP93u4SNyLOSflxgiMRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROTpgg8Wxnw4Rt566y0nlbp27dol8xfMl6NHjzo5RCn31VdfyTvvvCMnTpxwci48q1evlpUrVzqplMF+mTdvnuzcucPJIaLUlibBQtdu3aRs2bKyefNmJyf19O/XXx555BEnddLBgwf129SqVKkisVWryvXXXy+9evWSPXv2OI9IOfxIzFX1rpLPP//cyTm/Dh8+LI0aNdJv4HzjjTecXJFJkyfpD9fMmTPHyaGzgR8CQrnBUrt2benWvZusWLHCWXv2Bg0aJA8//LAcSjrk5KQcAtflfy6Xo8dCB65PPfVU4D3g2wTxLZifffaZszb11ahRQypVqiT79+93csILfi+zfp0lV199tXTp0lXTdOHauWun1l133nmnk+OHc7BMmTJaLnbv3i3ly5eX2267Tde563YsN93UTK8Bf/75p66nM5MmwcK6tWtl3bp1+suBaWXfvn369at/b/pbalSvLhs3bpTBgwdLjx49nEekXOvWrU0F1kULalrASYOvkv3jjz/kscceM/t4reYnbE+QtWafYz2dPfwa219//SVFihSR//77T0bGjdSL37///us8Iu29/PLLUjW2qsydM9fJSW7+/Pn6HgoWLChHjhyRMWPGyB133HFKpZxaUNmjAs+TJ4+TE17we6lQvoL+4mj79u01TReuI4ePaN0V3Au1adMm/RXP/fv2ayNpzZo1gYDd1u2rVq2SkiVLyurVa7R3OTY29rwGxBeaqBuGGD9+vLbUUBmgRWwlJCTICy+8IB07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TPTDhKpjx47qOHEwzAU4fMTf9Zk9W3ZtPbm7j9GiRwRrKjYxF2ft4UAki49toccDXWNoTWEcFMMkaC2ipY5tRosz+LWxDu/PTrRB1y+eI2FHguTNk1e7d/E86FkxlZy24swJEBgLD/WawdCyxxwPfAzOwsfvDiclSZkyMfr+UrK/MJfk+InjEmP+N1Q63HtIbShDGEJCSxQf8TyfMIkOZQO9M+7yAtgfmEiHY+Y+BoCWOcbYcXzQS2aHIABlEb1HmOCLVhRaRbacII1yiNfCvBccI5QB2/uFjyKuWLFSW+CY72CHilDe0P2K+S6YW+DmPgezZc2m5RvnXzC7zXjOipUqBlpl6AbenrBdihYpGthOCLUtoc5Bdx6GwzC5efKUyTonJsvFWbQcufeP+73gfQfvY603TNk39ZyeM/b7G0IdDzwOvRF4z+cTJi6jtwNDjPgiLIoczgEcR5S5ywtfbspNTLLygToIZQ71GLjr9nzmWBcsmPxcJG/46HPciDgn5Xfeg4XgypUuXKi4U0taBgsswxeW1CynbgwWUiY1z7PzdczTq1DBQprOWSAiIqLod96DBUR0XDLGcqEK9V65pN+FolOoY3WuFko59iwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeGCwQERGRJwYLRERE5InBAhEREXlisEBERESeMpnF5797Uo4cOaR169ZOiij6HDt2TL788kupVauWlC1b1sklil47d+6UH3/8Ua6//nq57LLLnFw6FxYtWiQ5c+aUihUrOjl0NubMmSNbtmxxUn4hg4XMmTNLnbp1nBRR9Dlx/IT8/vvvUqJECSlStIiTSxS9Evcnyl9//aUXtLz58jq5dC78vuB3beRWia3i5NDZWLlipezbt89J+YUMFqpVqyZLly51UkTRZ+/evZI/f34ZNWqU3HPPPU4uUfRCcFu3bl2ZPXu2NGjQwMmlc6FOnTpSvnx5GTt2rJNDZ6P7vd0lbkSck/LjnAUiIiLyxGCBiIiIPDFYICIiIk8MFoiIiMgTgwUiIiLyxGCBiIiIPDFYICIiIk8MFoiIiMhTug0WTpw4IfPmzZOdO3c4OWTt2rVL5i+YL0ePHnVyKCPAMR88ePApX9Oannz11Vfyzjvv6PlNRNEj6oOF3bt3S7ly5eS2225zcvxm/TpLrr76aunSpauTE11mzpwpsVWrSpUqVfQbMVu2bClffPGFszZ19e/fX66qd5V8/vnnTg6lpaSkJP3GPpQFLI0aNZIXXnhBDh486Dzi3Jj6zVTp1auX/PHHH07O+fXRRx9J48aNJVu2bPrbByjzKf0m2EGDBsnDDz8sh5IOOTmUWj786MNkx6tVq1bJyg5+f2X5n8tl566dTg65de3aVX+XJn5rvJMj8uuvv0rp0qXltddec3JEEhMT5YknntBzP1OmTPpNk48++qh+C6314osv6vp69eppI9gNjYDatWvr+jfeeMPJPf+iPlg4fPiwrF27VlasWOHk+FUoX0Huv/9+ad++vZMTXVatWiV/Ll8u//33n1xxxRXyzTffaMBzPr6OFD8C1qVLF/1qWUp7e/bskblz52qZQOC7cuVK6devn7Rr1855RPr37LPPSqdOnWT+/PnSvHlz/c0OlPkaNWrIn3/+6TyKosUzzzwjnTt1Tna8vv76a23Y2LoWX09dNbaqPN//eU1TcmvWrJF169ZJ0qEkJ8ec63v3yIYNG2Tr1q2aPnLkiF7ohw4dKgcOHJC2bdvqby68+eabcs011wR60PADY/jdkAULFmjg4DZwwED9oSysxzFJK+l2GAI/dnXJJZdI1qxZnRz/L4/17NlTA4jhw4frhRrGjx8v3bp30+Bi0uRJmgevvvqqjBkzRr7//nvp2q2bRn/2IAN+1RDRY4cOHWTcuHFObvjnCwUV6LfffivvvvuupidPnizbt2/X1/rhhx/koYce0gsHoBC98sorctddd2kLcfXq1ZpvH//bb79pxIr3h65aRKwDBgzQx48cOVIfC5kuyiT58uUzUaw/He59LFu2TJ8X+SjMhw75W3OJBxK1OxsXswcffFBbF3T2KlaqpN3sS5f5W9uonNHr8NJLL8nzz5+skN9//315+umntWUXrqygx80ee1T8//77r+bD33//recBjvlPP//k5IosN8Fr79695Y477tCyi4u5hQDm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7+hhOx/1cfd7u0vciDgn5ZcuggWiYOktWCCKtmAhFHzHyrAPhuknYvBdK6HgE12YuI2gwU4oT2tpGSxciEIFC1E/ZwHju1yiY6EzE2pfckmdhbyF2mfuBT0MTz75pH4UPdR6LAgUAJMbbV5G494fabGkhQvm0xBERESUOqI+WPD5fFyiZKEzE2pfckmdhbyF2mfnYsloQu2D87mkBfYsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkScGC0REROSJwQIRERF5YrBAREREnhgsEBERkadMZvH5754UExMjn376qZMiij6JBxLlhutvkOeee05atWrl5BJFrxUrV0jnTp1lxIgRUq1aNSeXzoW7O94tJUuUkBdfHODk0NkYMGCATJkyxUn5hQwWiIiIiCwOQxAREZEnBgtERETkicECEREReWKwQERERB5E/h9M/8d8koRKsgAAAABJRU5ErkJggg==</Image>' +
            '       <ScaleMode>Fill</ScaleMode>' +
            '       <BorderWidth>0</BorderWidth>' +
            '       <BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Center</VerticalAlignment>' +
            '   </ImageObject>' +
            '   <Bounds X="331" Y="58" Width="4622" Height="1435" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>License Number</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + invPos.Supplier_License_Number__c + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="427.8261" Y="301.3044" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Legal Busines Name</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + String.escapeSingleQuotes(invPos.Supplier_Name__c) + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="414.1304" Y="788.4783" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>License Premise</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + String.escapeSingleQuotes(invPos.License_Premise__c).escapeXml() + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>Suppress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="410.8696" Y="1233.913" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Product Name</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + String.escapeSingleQuotes(invPos.Product_Name__r.Name) + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="1953.261" Y="318.9131" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Product Description</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + String.escapeSingleQuotes(invPos.Product_Description__c).escapeXml() + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="1950" Y="790.4348" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Purchase Order</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + invPos.Purchase_Order__c + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="1951.957" Y="1225.435" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Batch ID</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + (!String.isBlank(invPos.Harvest_Batch_Code__r.Name) ? invPos.Harvest_Batch_Code__r.Name : '') + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="3472.174" Y="330" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>UID</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Top</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + (!String.isBlank(invPos.UID_New__r.Name) ? invPos.UID_New__r.Name : '') + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="3476.478" Y="785.8696" Width="1408.696" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>Qty</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation>' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Middle</VerticalAlignment>' +
            '       <TextFitMode>ShrinkToFit</TextFitMode>' +
            '       <UseFullFontHeight>True</UseFullFontHeight>' +
            '       <Verticalized>False</Verticalized>' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + (checkQtyAllocation(invPos.Qty_Allocated__c)?invPos.Qty_On_Hand__c :invPos.Qty_Allocated__c)  + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>AboveAddress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="3492.13" Y="1252.174" Width="631.3043" Height="161.7391" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '   <AddressObject>' +
            '       <Name>UOM</Name>' +
            '       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '       <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '       <LinkedObjectName />' +
            '       <Rotation>Rotation0</Rotation> ' +
            '       <IsMirrored>False</IsMirrored>' +
            '       <IsVariable>True</IsVariable>' +
            '       <GroupID>-1</GroupID>' +
            '       <IsOutlined>False</IsOutlined>' +
            '       <HorizontalAlignment>Center</HorizontalAlignment>' +
            '       <VerticalAlignment>Middle</VerticalAlignment> ' +
            '       <TextFitMode>ShrinkToFit</TextFitMode> ' +
            '       <UseFullFontHeight>True</UseFullFontHeight> ' +
            '       <Verticalized>False</Verticalized> ' +
            '       <StyledText>' +
                        '<Element>' +
                        '<String>' + invPos.Stocking_UOM__c + '</String>' +
                        '<Attributes>' +
                            '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                        '</Attributes>' +
                        '</Element>' +
                    '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly> ' +
            '       <BarcodePosition>AboveAddress</BarcodePosition> ' +
            '       <LineFonts /> ' +
            '   </AddressObject> ' +
            '   <Bounds X="4245.391" Y="1248.913" Width="631.3043" Height="161.7391" /> ' +
            '</ObjectInfo> ' +
            '</DieCutLabel>';
            
        return template;        
    }
    
    private static Boolean checkQtyAllocation(Decimal val){
        if(val == null || val == 0){
            return true;
        }
        return false;
    }
    
    public static String getImage2X4Xml(Inventory_Position__c invPos){
        String template = '<?xml version="1.0" encoding="utf-8"?>' +
            '<DieCutLabel Version="8.0" Units="twips" MediaType="Default">' +
            '   <PaperOrientation>Portrait</PaperOrientation>' +
            '   <Id>Shipping</Id>' +
            '   <IsOutlined>false</IsOutlined>' +
            '   <PaperName>30323 Shipping</PaperName>' +
            '   <DrawCommands>' +
            '       <RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
            '   </DrawCommands>' +
            '   <ObjectInfo>' +
            '       <ImageObject>' +
            '           <Name>GRAPHIC</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>False</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <Image>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</Image>' +
            '           <ScaleMode>Fill</ScaleMode>' +
            '           <BorderWidth>0</BorderWidth>' +
            '           <BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Center</VerticalAlignment>' +
            '       </ImageObject>' +
            '       <Bounds X="86" Y="307" Width="2918" Height="5323" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Legal Business Name</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Left</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + String.escapeSingleQuotes(invPos.Supplier_Name__c) + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="183.3478" Y="1131.522" Width="2739.13" Height="313.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>License Premise</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Left</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + String.escapeSingleQuotes(invPos.License_Premise__c).escapeXml() + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>Suppress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="185.3044" Y="1655.217" Width="2739.13" Height="213.913" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>License Number</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Supplier_License_Number__c + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="174.8696" Y="611.7391" Width="2739.13" Height="333.9131" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Product Name</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Left</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + String.escapeSingleQuotes(invPos.Product_Name__r.Name) + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="176.8261" Y="2168.478" Width="2739.13" Height="213.913" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Product Description</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Left</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + String.escapeSingleQuotes(invPos.Product_Description__c).escapeXml() + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="173.5652" Y="2707.826" Width="2739.13" Height="213.913" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Purchase Order</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Purchase_Order__c + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="201.6087" Y="3221.087" Width="1257.391" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Received Date</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Date_Received__c + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="1627.913" Y="3223.043" Width="1257.391" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Batch ID</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + (!String.isBlank(invPos.Harvest_Batch_Code__r.Name) ? invPos.Harvest_Batch_Code__r.Name : '') + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="193.1304" Y="3760.435" Width="1257.391" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>UID</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + (!String.isBlank(invPos.UID_New__r.Name) ? invPos.UID_New__r.Name : '') + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="1619.435" Y="3757.174" Width="1257.391" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Ownership</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + String.escapeSingleQuotes(invPos.Ownership__r.Name) + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="180.7391" Y="4807.174" Width="2739.13" Height="213.913" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Qty</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + (checkQtyAllocation(invPos.Qty_Allocated__c)?invPos.Qty_On_Hand__c :invPos.Qty_Allocated__c) + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="184.6522" Y="4289.348" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Type</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Quantity_Type__c + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="1151.826" Y="4296.522" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>UOM</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Stocking_UOM__c + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="2108.565" Y="4293.261" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Rack</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Rack__r.Name + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="181.3913" Y="5334.783" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Level</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Rack_Level__r.Name + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="1138.13" Y="5347.174" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '   <ObjectInfo>' +
            '       <AddressObject>' +
            '           <Name>Bin</Name>' +
            '           <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '           <BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '           <LinkedObjectName />' +
            '           <Rotation>Rotation0</Rotation>' +
            '           <IsMirrored>False</IsMirrored>' +
            '           <IsVariable>True</IsVariable>' +
            '           <GroupID>-1</GroupID>' +
            '           <IsOutlined>False</IsOutlined>' +
            '           <HorizontalAlignment>Center</HorizontalAlignment>' +
            '           <VerticalAlignment>Top</VerticalAlignment>' +
            '           <TextFitMode>ShrinkToFit</TextFitMode>' +
            '           <UseFullFontHeight>True</UseFullFontHeight>' +
            '           <Verticalized>False</Verticalized>' +
            '           <StyledText>' +
            '               <Element>' +
            '                   <String>' + invPos.Bin_Location__r.Name + '</String>' +
            '                   <Attributes>' +
            '                       <Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '                       <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '                   </Attributes>' +
            '               </Element>' +
            '           </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '       </AddressObject>' +
            '       <Bounds X="2100.087" Y="5343.913" Width="808.6957" Height="193.0435" />' +
            '   </ObjectInfo>' +
            '</DieCutLabel>';
        return template;        
    }
    
    public static String getImage4X6Xml(Inventory_Position__c invPos){
        String template = '<DieCutLabel Version="8.0" Units="twips" MediaType="Default">' +
            '        <PaperOrientation>Portrait</PaperOrientation>' +
            '        <Id>Shipping4x6</Id>' +
            '        <PaperName>1744907 4 in x 6 in</PaperName>' +
            '        <DrawCommands>' +
            '          <RoundRectangle X="0" Y="0" Width="5918.4" Height="9038.4" Rx="270" Ry="270"/>' +
            '        </DrawCommands>' +
            '        <ObjectInfo>' +
            '          <ImageObject>' +
            '            <Name>GRAPHIC</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>False</IsVariable>' +
            '            <Image>iVBORw0KGgoAAAANSUhEUgAAAk8AAANtCAYAAACJ1J/nAAABfGlDQ1BJQ0MgUHJvZmlsZQAAKJFjYGAqSSwoyGFhYGDIzSspCnJ3UoiIjFJgv8PAzcDDIMRgxSCemFxc4BgQ4MOAE3y7xsAIoi/rgsxK8/x506a1fP4WNq+ZclYlOrj1gQF3SmpxMgMDIweQnZxSnJwLZOcA2TrJBUUlQPYMIFu3vKQAxD4BZIsUAR0IZN8BsdMh7A8gdhKYzcQCVhMS5AxkSwDZAkkQtgaInQ5hW4DYyRmJKUC2B8guiBvAgNPDRcHcwFLXkYC7SQa5OaUwO0ChxZOaFxoMcgcQyzB4MLgwKDCYMxgwWDLoMjiWpFaUgBQ65xdUFmWmZ5QoOAJDNlXBOT+3oLQktUhHwTMvWU9HwcjA0ACkDhRnEKM/B4FNZxQ7jxDLX8jAYKnMwMDcgxBLmsbAsH0PA4PEKYSYyjwGBn5rBoZt5woSixLhDmf8xkKIX5xmbARh8zgxMLDe+///sxoDA/skBoa/E////73o//+/i4H2A+PsQA4AJHdp4IxrEg8AAEAASURBVHgB7J0FuCTF9bdrYXF3d2dxCO7uSdDgECBocMkCQYIsGjQ4Ca4fENwlyOLuLovr4k5/53f+qU6P3Z2ZnZ7t2/et57m3u8vrrZnuM6dOne539NFHJ9dff32oDjPOOGOYZpppqqO5hgAEIAABCEAAAn2CwJAhQ8Lrr79eM9Z+iy++eDJ48OCaBCIgAAEIQAACEIAABGoJjFQbRQwEIAABCEAAAhCAQCMCCE+NyBAPAQhAAAIQgAAE6hBAeKoDhSgIQAACEIAABCDQiADCUyMyxEMAAhCAAAQgAIE6BPrPMMMMoZ7B+EorrRSWWmqpOkWIggAEIAABCEAAAuUncO+994bbbrutZqD9p5122ppIRSy33HJh4MCBddOIhAAEIAABCEAAAmUnMGjQoLrCE8t2ZZ95xgcBCEAAAhCAQEcJIDx1FCeVQQACEIAABCBQdgIIT2WfYcYHAQhAAAIQgEBHCSA8dRQnlUEAAhCAAAQgUHYCCE9ln2HGBwEIQAACEIBARwkgPHUUJ5VBAAIQgAAEIFB2AghPZZ9hxgcBCEAAAhCAQEcJIDx1FCeVQQACEIAABCBQdgIIT2Wf4RzHN3To0HDNNdeEBx98MMdWqBoCEIAABCBQLAIdFZ4++ugjf9XL+++/3+Mozz777HDQQQeF119/vcd8fSVR3F544YXw6aefNhzyF198EZ544onw+eefN8zT7YSbb745/O53vwubbLJJt5umPQhAAAIQgMAII9BR4WnfffcNSyyxRNhll10aDujbb78N22+/ffjb3/4WJET19fDll18GvSJnzjnnDJNPPnm4/fbb6yI58MADwwILLBD23nvvuulEQgACEIAABCDQHQIdFZ6a6fLoo48eZp55Zs86yyyzNFOk1HmkSfrhhx98jD///HPYcccdw08//VQz5iRJPC4eazIQAQEIQAACEIBAVwh0XXgaaaSRwosvvhi+//77sNVWW3VlkL2pkVdeeSWcfvrpvanL9BUCEIAABCDQpwj0HxGjffvtt92+R0tVo402Wk0XhgwZEp555hnXyMw111yhkYbql19+cVuh559/Pkw11VRhnnnmCeOMM05NfW+++WaQzdDcc88dJLyp/YceeihMN910XkbasHrhtddeC6pbS42zzz57mHfeeetlC832o27hTORqq60WbrrpJl/S3HzzzcN4442XSa1/KrsxjW3AgAFh1FFHrcj07rvvhg8//DDMOuusYeyxx/Y0Ca2R12STTRa+++67cO+99/oYF1xwwTDNNNOkdbz11lvOadJJJw1Kq8c2zWwnWoK85557wo8//hgWXXTRMOWUU2aTK86bZZadu6+//trfbt2vX7+w7LLLhgknnLCiTi4gAAEIQAACXSEwcOBArQfV/B1xxBG2QtRa2HLLLb2e9dZbr8eCJoh4vgsuuKAinwk1yYorrljTlxVWWCH54IMPKvJee+21ycQTT1yR1wSjROOxZa+KvLG9u+66q6Z+EyCS+++/vyK/CQHJ2muvXVG3GJlAUJFPF630o6awRZhwkLZjAl3Sv39/vzb7sYrsf/7znz3+j3/8Y0X8FFNM4fFXX311RbwulllmGU876qij0rRLL73U49Zdd93kX//6VzLGGGP4tcY38sgjJ4cddpjz23333RPxjJ+NscYaK7GddWk9Ornkkks8fcYZZ0xOPfXUxAS0NL/KrbrqqokJPBVldNEKszh3F110URLHqrrNrq6mXiIgAAEIQAACnSQgWSg+B7PHri/bWePBBqZDetS5NCBLLrmkG0zbg9p3ca2//vqufbnjjjvChRdeqGweLr/88mDCTfjk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999/721qyUlBD32Nb5JJJgnTTDNNRZs///xzePbZZ8PYY4/ty3/ZRAlGEsyk0ZpgggnCoosuGsYff/w0i5bqVK/annbaadN42UJJQzb33HOHkUYaKbz99tvhoYce8uVGse3JNuvTTz8NTzzxRPjqq698HmQH1kgwk32YBLdvv/02SAs277zzpn2IJ8MaQ8zX6LjKKquE2267zZfljj/++LDffvs1yloTr7E89thj4ZNPPgmTTTZZmG222cLUU09dk6+al+z1VE72elp+jvZWmqt77rknqF6NdZZZZmnIptXPdE2niIAABCAAgeITGDhwoIxKav6OOOIIWxFpLZgNjtez3nrrDbPgtddem0w88cQV7doDP1F/bHmsovzrr7+eLLPMMhV5q/tsD34vY7ZHiT38avLawzOxh3FFvZdcconnM0GhIr7ehT1o0zpNiKvIYobnaZoJPGnaGWec4fH2wE3j4sldd93laWYzFaP8eMUVVyQmbKX1aZwm9CT//ve/03ym+fJ0ExjTOJ2YIOPxqnvFFVesqMOEiOT++++vyK8Ls+VKNtxww4q8atMEjuTJJ5+syP/ll18ma6+9dk1eE+4q8jUzhooCmYv4Gdp9990TM4b3tkygTj788MM0lwkxaR9MQEzjNUdrrrlmos9R9vNhQmCy9dZb13yuIq877rgjsWXYijJKU30PP/xwYrZtFWmrrbZaIhbVoZXPdHVZriEAAQhAoHgEJAtlnyfxfIRoni6//PJgD2zrQwjLL798WHLJJX2XngkzYdCgQW5bdMwxx3i6fvVvsMEG4dFHH3Uty2abbeYakltvvTUozQQwLy8NgzQ/f/7zn10rIJukBRdc0OO0zCbDYhlYS3slO6VOBbX597//3auToXNWE2QfA4+Px2ybMS4elWYP66Dxqc611lrLx6WdZ5dddpmP+be//W1FfdmySojXMrSWfZb6Io3T7bffHkz4COuuu663ETVw0pIstdRS4ZlnnnEt1sYbb+yasCuvvNI1fHFexFZhn332CSYguCZtu+22c7urG264wbVb0vZJ29XsGLzCHv6pPtmQmSDm2jAZyJ966qk9lAjh9NNPD9dff733b/XVVw+TTjppeOSRR1wreM455ziL7GaGLC+xkMZQGkITpoJ285mQ5No7adFk5yb7Mrm1uOmmm/xzal+qtD+tfKbTQpxAAAIQgEDvJNBtzZMJBoktubkkt9tuu9nz63/h2GOP9XhpWqKmwZZR0jizL0ozH3744R4/+eSTp3H2wE3MRiYxYSCN04kt4aXaiHvvvTdNa1fztM4667gmQxo2E1C8HxNNNFGivmaDPcw9zQSYbLSfmzF0Oq6YeO6553qcLTHGKD9K02JuINK4Rv2Wtsg+hf53yCGHJOKhII1bjL/66qvTeqJmzJYEE2n3YrClu1R7t8cee8TodN5MUEjjdGKCRnrd7BjSAlUnUfO06667eooJbN73/v37p+000jxJgyTmtqxZUev666/vdaywwgoV8VleRx11VJqW/U6oXRNe07SopbNl5jSu2c90WoATCEAAAhDoFQQaaZ66bjB+3333uXZC9jeHHnpohcQpzYiCNC+yv1GQbY+C3AJk7VZsecbjP/jgA9dM6EI2On/729/CXHPN5Wnxn2yAYlnZAQ1vuOqqq4I0Gf/v//0/10yovq+//jooXhqTdkPUCMkIXRqyGGTbJLupZoMteYUDDzwwtcuxJTy3+1F52VHFcMEFF/jpTjvt5L65YrzssCLfwYMHx+jUZsyWBdM4ncimKIZOjSHWJ1snE0xdyyjNV09BWkxpxKp3IEqDpNBo7vfcc0/XqsW6VUcMckEhzWcMtvznp++991748ccf/bzZz3SsgyMEIAABCPRuAl1fttMyVAx77bVXPK05avlHQUsvCjJQfvfdd90ppa5l3KugB2u1kbmJs8Hse1wAkXClJRkZNyvEB55ftPnv7LPP9iUxGW7rgSwhRMs5pg3zB7cEl3aCHv4SlD777LMw33zzBT2od9hhh5YdQc4///w1zWsJT8b2MnqOIc6FjN233377GO1HLVspxHnQuWlwfCnttNNO86U60w758msUmJSnU2NQXQrjjTeeC4JqS0uGMtyuFo7/L+f//mvOJfTJ7YFYallSodHcVxu8S9CWIK7PkeYhG6IQrjQZ1+vzFzkqX0+f6Ww9nEMAAhCAQO8l0HXhKWo+pF2yZaOG5GTLpLD44ov7jinZ7GgHluyWtAsq+lSKdkCxItmj7LjjjhUP/ZjWqaPsqbTjKgYJOKuuumqQHdZxxx0XtL2+0U61WKbeUYLiLbfc4mN87rnnwimnnOJ/ElrESjvv2g1xp50e+goS/MRUQYKm/uqFOA9Kk1CocieeeGJ4/PHHwxZbbOEaG9ki2VKmF89jDOIrFhJSpH268cYb63XVNZYSOGV/JHu4doM+X1F4qq7DlvGqo1Jt3rA+0zUFiYAABCAAgV5JoOvLdvFhLG/dWvqo9/fxxx+7cbOISnugX/gKEij23nvvYHY4rlFYbrnlUmNtpWuJTw9xaUuUpoeotupr27+23ucV9KCVsbWC7cJKhZLYXiONR0zPHhdaaCHXlEhAkECmIKPpbbbZJpttuM+lLYoau5NOOqnuPGhuZHAdgxxzHn300c7XbKrcWF8CmJa14jKr8nZ6DGpXPrQUNJ96H2G9IO3ZxRdf7F7ftXwrw2/bMRji5oN6ZToR1+xnuhNtUQcEIAABCIx4ArU/o3PuU/THpIeu/DSNO+64PbaonXJactMuKe0i0/KdbHK0i0y+eLJBWhv9+pdfJ53roRtD9AkVrzt9lEYmhmhzEzVFUcMT03WUXVOjIGFMdjr6046u/fff33d4yZ5KO9o6FSRQSrDUMlcr7yJUXmmhJKxoF5qWU/WewOxyYafHIKFYu/9kX6Sdd9VBGrUoVMkvVLRNUr5m3ltYXV8r161+plupm7wQgAAEIFA8Ap17Ejc5tkUWWcQ1AxJyqg3GYxV6mMcQbXS0HCctlIQmGYBLGJJDyGyIebW1PBtUNtpIZeM7da6lSLlYUJDTSNktKcjxp4LexaY+xCDnj9U2RkqTliQ7dsVJi6MgYaTTIXpG1xb/esbU0vjJEF5BwmG1obiW6KJrhijU5TkG243pfanXV2n3ooYy9lmZ9Vn45z//6eXy+tfqZzqvflAvBCAAAQh0h0Aumie9k0yGw9VBu7q0o07LbjKu1sNQD1vtBpMHbWkI5KfHts27Bknlt9pqK9/ZJnuXbbfdtrpKX9qSAfP05nFcnrgVbFt/kC2UdoxJs6KdcTIa71TYeeedvb/SdkjYMUeKLlzIVkY2TzGoP+qXlhG1tKWxvPHGG66lqWeTo6Umacw22WSTsPDCCwe9jFj2RQoSdKKAEusf3uMBBxwQzj333NRAXf2TryMJHw888ECQD6eDDjrIPahr95/mVNol+eiS7ycJgconwU7LpAp5jkFCitqW36vqoGVI9U3+wKSt09KvjM3PP/989+Renb+T19LEtfKZ7mTb1AUBCEAAAiOAQNanjTXv/nB0lG+DVoMZ9qbls3XFczPy9ipNi5HYUlQiHzoxLXuUN/EY5LvHHoyJPaATE54S+f/505/+lMirdSxvS0cxu/tfytalc3n4Nvshb+tf//pXmreRv6Q0Q+bEXvWR+oqqrl/X6oM5o8yU+L9T+XOy5buKccpHkAlJHiefVjGY4OXjrK5f/Tf7o5gtadTv6LfIBIY0bzwxp5venglMMcqPZtOUmCavon+xfVseTUyY9XzyRG52ajX5NDfqdwzNjiHmrz5u+V8v9dHPU3W6aZ0S0+yl/cj6v5KfLdOGpWkahwm0idnJeZz6nw098TJB1cuYcJgtksi7fOSjz0QMrXymYxmOEIAABCBQbAKN/Dz1k/AUl5zsoZAG/Xq3tPS6mRNpSqSFMRR1s2tLuDm1TNNk9yNDY22hV5kpp5wySLuQ3cmmbekyFJeBcrULgLPOOiuYIOX1SdMQDXelfVA/ZCslDY40QNL+qC1pT6LPJC3zyahYfdIOumEFvfdM70vLBhldy/g9LtFl0+K5bJ7MOacvHWrru7x622tZfOu9dsFFw3DlVz+ludMSpTQnc845p2t1sst2jfqtNmTkbc4gUxaxD9LwibP4ShuWDfJGLmYyuFd5aQHlLX2xxRar8MaufHJroK3/WnbVuKVx0rxlQzNjyObPnqsPei+hliujLVE2XeeysdJcaL61GzMbtHQnY3tpL7WkKNbyGi57KI0rLlWqTE+8VIc+P2ussYbPVWxDDK677jrXAtqramq0gc18pmNdHCEAAQhAoNgEJB/Ve7dqR4WnTiOQQKWt4TKUli8le9dZRRN6iOkBJgNt7XLT0g0BAhCAAAQgAAEIdIJAI+GpIzZPWa1IJzpbrw69801/9YKMhaMfo3rpxEGgSAQaaWaL1Ef6AgEIQAACjQl0fbdd466QAgEIQAACEIAABIpPAOGp+HNEDyEAAQhAAAIQKBCBjizbsQxRoBmlKxCAAAQgAAEI5EoAzVOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEUB4KtuMMh4IQAACEIAABHIlgPCUK14qhwAEIAABCECgbAQQnso2o4wHAhCAAAQgAIFcCSA85YqXyiEAAQhAAAIQKBsBhKeyzSjjgQAEIAABCEAgVwIIT7nipXIIQAACEIAABMpGAOGpbDPKeCAAAQhAAAIQyJUAwlOueKkcAhCAAAQgAIGyEejfyQF99NFH4dVXXw0zzDBDmGKKKRpWffbZZ4chQ4aELbbYIsw444wN8/WVhA8//DB89tln6XBHHnnkMOmkk4bxxx8/jestJ8xtb5kp+gkBCEAAAu0S6KjwtO+++4Zzzz03rLfeeuGKK66o26dvv/02bL/99uGXX34JP/30UzjiiCPq5usrkV9++WWYdtppw48//lgz5Lnmmivss88+YbPNNqtJK2IEc1vEWaFPEIAABCDQaQJdX7YbffTRw8wzz+zjmGWWWTo9nl5X3+eff54KThKWFl100TD77LOHfv36hWeffTZsvvnm4W9/+1uvGBdz2yumiU5CAAIQgMBwEuio5qmZvow00kjhxRdfDD/88EMYbbTRminSZ/JceumlYcCAAT7et956K6y55pouQB122GG+xDnddNMVmgVzW+jpoXMQgAAEINAhAl0XntTvt99+O3z66adhzjnnrCtAyR7qmWeecQFL2phGGiot/b3wwgvh+eefD1NNNVWYZ555wjjjjFOD5s033wxffPFFmHvuuYMe8Gr/oYceChJGVEYak3rhtdde87q1HCVt0Lzzzlsvmy9BNtOPuoUbRKpv55xzTlhkkUV8efP+++/3/ip7djxff/11uO2221xTteyyy4YJJ5wwrbFdPrJbe+yxx9xubYkllgiywVL4+eefwz333ONzJxaaF2nIsqGnuR2RPLN95BwCEIAABCAwXAQGDhyYWAU1f2aLlLQattxyS6/HbJ56LGqCiOe74IILKvLZgzdZccUVa/qywgorJB988EFF3muvvTaZeOKJK/KaYJRoPGZLVZE3tnfXXXfV1D/ZZJMlJphU5Dc7pGTttdeuqFuMbEmtIp8uWulHTWGLMEEobceW6SqymB1UmnbSSSelaXE8F110UWKG+WmeXXbZJc3TSr9ifXfccUey9NJLp/VpzEpTHx9++OHEllsr0lZbbbVErLIh1pWd227yzPaFcwhAAAIQgMDwEJAsVE9GGiGaJxuI9cWezP896vy7774LSy65pGuFxhprrLDSSiuFUUYZJdx6663BHurhwgsvDHvuuaeyhssvvzxsuOGGfr788st7OWlLLrnkkjBo0CDX1BxzzDGern+xnZVXXtnTZKAtjdPtt98etNNt3XXXdW1OXEaUkbYJH2GSSSYJ2223nffjhhtucG3Vr7/+6tor1dtqP1SmlfDuu++m2bWDMYY4nk022cSjZEMm7Zi0agqt9ivWJz7SVs0666xhmmmmce5aYjUhyeflm2++CQsssEAYddRRw4MPPhhuuukm5501+o91xaP6UxSe6gsBAhCAAAQgMNwERoTmabbZZnNJ7vzzz7dn7P8Fs+vxuLHHHjt5/PHHY3RiW/iTbbbZJrn++us97vvvv0+mn356z7vbbrul+XRy7LHHerwtwyUmFKVpsT2DlRxyyCGJCUCeZstdnl/xV199dZo/1m9CSBqnExMk0ut2+pEWzpw00jxJe7bBBht4/0yITN577720VHY8e+21VzoelWmnX9n6jjrqqLSd7Gejf//+yWWXXZammfDqfbPl0jROJ7Gu7Nx2kmdFY1xAAAIQgAAEciTQSPPU9d12jaS9a665xpO0u2z++edPs00wwQThrLPOCmussYbH3Xfffa4lkp3SoYcemubTiTRICiZAhCeeeMLPs/923333cOCBB6Z2OrZEGOxh71lkoB1D1EDZMl+M8mPMq4vh6UdFpZkLW4YLp5xyimtqpOGRBknhoIMOqus3y5Yzw9FHH52OxwSc4eqXNHvSEsUgrVsMJ598cjBhLl6Grbfe2s9NqEt3C6aJVSed5FlVNZcQgAAEIACBrhMYIct29UapZTeFZZZZpl5yGvfKK6+k56Z1Sc+rT0yjUx1VIZTFRC3hvfTSS24EHePWX3/9oB1up512mi/V7brrrr5MGIUA5RuefsR2qo9acswG08KF/fffP+y9997Z6PRcTkarDbaHp1/VBvFTTz21129CfZhvvvnSdnWiNAWlffXVV2GiiSby63r/OsmzXv3EQQACEIAABLpJoBDCk3bCyd+Rgjxr9xSihkjapTPOOKNhVjMmb5iWTYg77SQExCDtlFwpnHjiicGWEN1NgDQyp556alhnnXU8W6f7oUpteTJMPvnkwYzYfSfbggsuGJodR+x7J/ulXXYSzrJsYjvScjUbOsmz2TbJBwEIQAACEMiLQPNPwLx6YPXKQFwPY22Fz76mpF6TUZjQVv4HHnigXhY38I756mYYRqQM1bUcpmU+LRlqyUqG5Vq2euSRR1yDFevvZD/Mhiv18zSMLjZMzqNfDRtrMqGTPJtskmwQgAAEIACB3AgUQniS4KRlIC21Pfroo6l2p96oZ5ppJo+WMCOha9xxx62XrSNxej+ftCZ6nYxskLT77eabb3bhqZv9aGUwRe2XxtAbebbCnrwQgAAEINA3CBTGYFxuChTOPPNM3xYf8Wv5TO/MkzG1gpxGjjHGGG4UXm0wHsuYT6h42vJR7VUbimspUbZRCtEdQN79aLnj/y1QtH71dp7tzgPlIAABCECgvARy0TzdeeedQf6XqsNOO+2U7oirTjvggAPcT5M8jy+00EJBRsayudEuPHmtlgG3grQXe+yxRzj88MODuSYITz75ZNCuufHHHz/Ig7W5NAivv/66C1fVbTRz/fLLL3vfteNPvqRkfyQP3loilP3Pcsst59Xk3Y9m+lovT9H61dt51mNMHAQgAAEI9G0CHRWepBFSkN1StfZG8dpa3yjIDcCVV14Zttpqq/Dxxx+7cXbMK4eW0Smm4rSUpmA+idzRpZxdZsOwduxl81afS8MkOya5Osi6O9BOOzmDXHjhhdMiefYjbaSNkyL1qww825gCikAAAhCAQIkJ9JMjxOot8hqvBAVLa2noQ4cODfYaj7q7s1SRtsJrN9m9994b5B9IwlQ0cI4NSfMk79X2qhJ/7512nGlJr3pLvvLrHXgScORqQDvCppxySl/Wq34XXk/tSXOl8lruMmeO3g1zNhnuvvtuf7+edvVJmJLGSfXXC832o15ZGcnLe7k8l8uXlbx3Dyv0NJ5s2Wb71VN9N954o3svV9+icKw2xOi6667zZUx7lU26nFmvrm7yzI6fcwhAAAIQgMDwEJB8tN9++9VU0VHhqaZ2IiAAAQhAAAIQgEAvJdBIeOrIsl09rVAv5US3ewmBer6neknX6SYEIAABCPRyAoXZbdfLOdJ9CEAAAhCAAAT6CAGEpz4y0QwTAhCAAAQgAIHOEOjIsh1LKJ2ZDGqBAAQgAAEIQKD4BNA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCSA8FX+O6CEEIAABCEAAAgUigPBUoMmgKxCAAAQgAAEIFJ8AwlPx54geQgACEIAABCBQIAIITwWaDLoCAQhAAAIQgEDxCfT/4Ycf6vbyiy++CEOGDKmbRiQEIAABCEAAAhAoOwHJQvVCv8UXXzwZPHhwvTTiIAABCEAAAhCAAASqCLBsVwWESwhAAAIQgAAEINATAYSnnuiQBgEIQAACEIAABKoIIDxVAeESAhCAAAQgAAEI9EQA4aknOqRBAAIQgAAEIACBKgL9Rx999Kqo/7scf/zxwzjjjFM3jUgIQAACEIAABCBQdgJfffVVGDp0aM0w+y+yyCLhzjvvrEnYZ599wsCBA2viiYAABCAAAQhAAAJ9gcCgQYPCfvvtVzNUlu1qkBABAQhAAAIQgAAEGhNAeGrMhhQIQAACEIAABCBQQwDhqQYJERCAAAQgAAEIQKAxAYSnxmxIgQAEIAABCEAAAjUEEJ5qkBABAQhAAAIQgAAEGhNAeGrMhhQIQAACEIAABCBQQwDhqQYJERCAAAQgAAEIQKAxAYSnxmxIgQAEIAABCEAAAjUE+pTw9PLLL4fbb789fPrppzUgiIAABCAAAQhAAALNEOio8PTLL7+EF198Mbzwwgvp31tvvRUUX4Sw7bbbhpVWWimcffbZRehOwz5Ejq+88kqP7MT6+eefb1gPCRCAAAQgAAEIdJ5AR4Wn/fffP8wxxxxhzjnnTP+mn376MO6444Ytt9wyvP/++50fQcFrTJIk/Pzzzy318q9//atznHXWWcPKK68cVEd1+Pzzzz3PgAEDwjvvvFOdzDUEIAABCEAAAjkR6Kjw9OGHH3o39VLhRRddNCy44IJhwgknDN9++20477zzwm9+85vw3nvv5TSUYlY7++yzh1FGGSXcfPPNTXcwK2TqvYNiVx2yAlX2vDof1xCAAAQgAAEIdJZAR4Wn2LUVV1wxPPDAA+HRRx8NEqhOOOEET3r33XfDIYccErP1iaMER4V4bGfQ0kR999137RSlDAQgAAEIQAACHSaQi/CU7WP//v3DrrvuGlZbbTWPvuuuu9Lk77//Pjz++OMuYCnyscceCxdddFF46KGH0jzx5JtvvgkPPvhguOyyy8IjjzwSdN1T+Oqrr4Lauuaaa8LHH3/cMKuEEvVhyJAhNXm03Pbkk0+GV199tSZNESorAfHyyy/3trICjozSVe6HH37wslpa03Wjuuo1sMoqq4SRRhrJl+WOP/74elkaxqn9W2+9NVx88cXhjjvuaLi09+abb4annnoq/Prrr16X+ifG99xzT4W9lVhIC3bFFVcEGd73pO2Szdazzz7rXO6///6guSBAAAIQgAAESkNg4MCBMqip+TviiCPs+dhaMLsmr2e99darKbjvvvt6mi3jpWmXXnqpx62zzjrJzjvvXNGHzz77zPN9/fXXyR//+MfEhIiK9JFHHjnZb7/9kh9//DGtL56o79X5Vb8tJXodRx55ZMyanHHGGR4377zzpnHxxIQvTxtjjDFiVHpUubHHHruiT+ONN15y1llneR6zVapIyzJOK2lwEjnuvvvuyaabbur1jDPOOIlp8dISJhyl9b/99ttpvAlDyZprrlkz/n79+iVbb7118tNPP6V5dWLLil6PCVjJ0ksvndap/ipN9T388MPJzDPPXJFmwnDy5ZdfVtSli2uvvTaZeOKJK/JqLvQ5q267pjAREIAABCAAgQIRkDyRfX7H8/520pXwwQcfeDszzDBD2p7x8fOrrrrKjyakBNkISWshjYs0GEsuuaRrf0xYCloOnGaaaVzb88wzzwQblGuMzj///LTOY489NphQ5df2wA+zzDJLuPvuu8Mpp5yS5smexD7EYzNpp556athpp50869xzzx3mn39+310ojZgJPGGbbbYJyyyzjBuKS4MjrY2M6CeffPJs9cM8lzbosMMOc22PtDcHH3xwUNs9hdNPPz1cf/31YZJJJgmrr756mHTSSV1TJwbnnHNOmGeeecIuu+ySVhHHLcN08ZaRuhhLW6XdfNIYmnDmmr4FFlggjDrqqK4BvOmmm8KgQYN8DmJl0sBtuOGGfrn88sv73EmTdckll3heE57CMcccE7NzhAAEIAABCPROAt3QPJlQkdhD16U3aYBisIdqKtFNMcUUyUsvveRJUUNx5plnerot/SU33nhjLJaYUJHYUqCnSaPyxBNPeJotmyWTTTaZx6+11lqJCS0eLy3NwgsvnLaV1TyZsOHxJlSk9ccTW6bytNFHHz1GJUOHDk01K5tvvnliAkeaJq3L+uuvn17rZOqpp/Y6rrzyyor4ni6i5kljVNhnn328DnEwgcbjGmmepEHSmGy50PPFf+qXfUKTFVZYIUb5cbbZZvN4pR111FFpWvZzoXZtKS9NMwHJy0w11VRpnC3BJraz0uN32223NF4nJtB6vDhmtWcVmbiAAAQgAAEIFIxAI81TLjZPsomRhsQexsEEjLD44osHW15zzYu0J9XBBCC3zZHWQ0F2UgomPPlxgw02SG2mFKH80npoV59xDia0eL777rsvtZ+SBkraKgXt+LvtttvCjDPO6NfD8082PJ988on3UX2QhiwGE9jczided+ooTdpEE03kGiwTpHqsVhqf7bbbzjVE2YzR5kxapHphzz33DNm6VUcMJ598ctAcxGDLf36qnZOaVwWxl/2UCUjh0EMP9bj4b9111/VT2biZoBujOUIAAhCAAAR6JYFclu2efvrpdFkrUllqqaXCP/7xDxcCYlw8ailv2WWXjZfpUU4iFbT8VB20xKc6r7vuuvDaa695shxyKmjZKQpiHmH/5GvKtEDh9ddfj1FtHaPBt5YDp5xyyrbqaLWQ2VKFAw880A3vJShqKXCuuebqsRotkw4ePNh9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AQ6TEEAAAQQQQACBXAGCp1wRhhFAAAEEEEAAgQoECJ4qwGESAggggAACCCCQK0DwlCvCMAIIIIAAAgggUIFAyfbbb29RDcZPPvlk69u3bwWLMgkBBBCoPQF/l93TTz9deyshZwQQQKACgREjRtjw4cPLzFGy0UYblRmpEa1atbLu3btHTmMkAgggkC8BvofyJc16EEAgV2Dy5Mm5o9ww1XaRLIxEAAEEEEAAAQSiBQieol0YiwACCCCAAAIIRAoQPEWyMBIBBBBAAAEEEIgWIHiKdmEsAggggAACCCAQKUDwFMnCSAQQQAABBBBAIFqA4CnahbEIIIAAAggggECkAMFTJAsjEUAAAQQQQACBaIGiDJ4+//xzGz16tL322mvRKoxFAAEEEEAAAQTKESgpZ3yNRv/444/2wQcfZC27ySabWMOGDa1evXpZ4+tyQD0W9+vXz7baaiubM2fOKm3KlClT7JdffrGddtrJVlvt11h0yZIlpiDNp7XWWsuaN29u9evX96N4RQCBWhQoLS01dXCn7x6dn+V9By1atMgWLFhgbdq0sY033jizRZ988on7PmvZsqU1btw4Mz7qe07TN9xww8w8vEEAgXQL/PprH8N+Xnrppda2bdusv80339waNGhghx56qE2fPn2V16IvxJ9++mmV84kjA33hduzY0XbZZRd79913M1kqaGrRokWWgwK1tdde29q1a+cCt/fffz8zP28QQCB+AV3I6dzceeedbe7cueWu4NRTT7UuXbrY1VdfnTXPxRdfbHvssYedeeaZWeOjvuf0pIZGjRrZ3nvvbX/729/cBVXWQgwggECqBGINnpYtW+ZwVNrUtWtX94XUrFkz+/777+3JJ5+0/fff33Q1typp2223tdVXX90K4XlXCuSi0hdffGG6OlXabrvtrFOnTiaHH374wWbOnGkPP/yw7bDDDjZkyJCoxRmHAAJ5FPDnsX/1q84d9uP999wGG2zgzm09H1QXRh9//LG99NJLdtZZZ9nuu+9u7733nl+EVwQQSJlArMGTt9GzqCZMmGCvvPKKKw4fOXKkKzLXl8uwYcP8bDV6/eabb9xy/rVGmeRxoUcffdTeeOMN56CgauzYsa767rvvvrNLLrnE/vGPf+Rxa1gVAgjEJXDAAQe4c3vq1Kn21VdfuSq+3/3udy57nfNHHHFE5iIqrnWSDwIIFIZArQRPubvWp08f69y5sxsdVXWnNkPvvPOO/etf/3J/aqeg0qpw+vTTT92Xkx+/cOFCN6yieT/Oz//tt9/aW2+9ZY888oi98MILpuGKkpZ/8cUXXSPyjz76qKJZV2na+uuvbwcffLDbV12tKl1wwQX25ZdfrlK+LIwAAnUroPaOW2+9td16662ZC0RV5d944411u2GsHQEEakUgL8FTeMvVcDqcbrnlFmvatKlr0HnkkUea/tRGYZtttrHnnnsuM+sxxxxjrVq1Ml9krqJxDevvgQceyMx311132WabbeaK0/v27Wv77ruva+xZXomXqtA23XRT22effax3796uVOi0005zVWyZTGN+o/YR1157rct16dKlNmLEiJjXQHYIIFBXAmpDteuuu7rV33TTTXW1GawXAQRqUSAvwdPzzz9vr7/+utuNHj16ZHZHVVd/+MMfTAGE2kidc845NmDAAFNwoZKlk046yXz1nBpiKhAqKfnvDYJqmK5h/em90m233Wann366rVy50jp06GAnnHCCC6JUXaa8c9OHH37oGm9rO9Qey+dzzz332O233547e6zDBx10kOkuHiXaRsRKS2YI1LmAr75bvHgxJct1fjTYAATiF4i1qwK/eZMmTTKV3vz88882b948mzhxoqnx5W9/+1s76qij/Gy25ppr2uWXX+7GtW/fPjNeAdSOO+5ouoVYVXh77rmnax+kNkJqeK3AavDgwa5NgV9IAdKVV17pBhU0DR8+PNN1gBqrh0un/DJ6VQCj4E6vauR94IEHuio8La/SrdpMKjXTXUAET7WpTN4I5F+gdevWmZXOmjXLXcRlRvAGAQQSL1ArwZMCJpXe5CYFQmrz5AMl9bsyaNCg3NlcqZGq8tQVgP6qktQ4ffny5a5kSnexhftc6tWrl+kvN+luGTVsV0CmpLv4VHKl9k/z58/PnT32YZWwKYX7g4p9JWSIAAJ5Fwj3F8X5nXd+VohArQvUSvCkKjb1haLSJgU0CpruvPNOe/vtt61bt26mPo7CXy6aT8GPxqsKTyVWvrpOt/dXJfnOOVWas8UWW1RlEVOXCj5w8guoI0ulfHzhyUapSZMm7pV/CCCQDgHfNlN7w/mdjmPKXiAQFqiV4ElfFrqN1yc19lZjbAVVumtOVWLnnXeem/zUU0+Z2geotGpVku8ET72Zr0rKbdC+KnlV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V9mdd955dsMNN7iSJ5UqKdjywZOWy02bbLJJmcbhQXsqN5saj/s8fFWjJviSmty8NOxLyMLT1FmlGoqHk6r9FCh99tlnrjuGoI2VDRgwIFNtGJ5X76u6nbnL5Q4H7bXKNLRXgKouIVTduXDhwtxFGEYAgYQKUPKU0APHZiMQJeCr64IG4VGTs8b5UipfMqSJavPToEED125H1XMq8dGdYyo9CRqWW9Co2t1t9vrrr7s2Raq2U4oKntyEnH8qXfLJtxvypVBa15133lnmz8+v4KQqSVWP2nZV26lXdVX56f1RRx1VpaBS64jazqqsO2oemSnprkASAgikQ4DgKR3Hkb1AwAn4kh1VtamX8fKS2gf5Z7ptvfXWmdnUoeYBBxzghtXuSVVqCmq6dOnibvdXcKWkEicFKCo9atOmjQV3obnxNfnngyIFfosXL478U+NvX4VXlXWosbYavWs7e/To4RYJ7sBzDcersnyc8/igye9nnHmTFwII1I0AwVPduLNWBGpFoHv37i5f3YGmh96Wl2666SZXuqS+inRXWzj5UiTdRecbh/uA6uCDD3azKiipqMounF9l733w9vHHH9s666yT6S/K9xul15oEHqrO012HamvkOwbVewV8tZFUDeoDJZ+/+oz6z3/+4wZ9qaCfxisCCCRXgOApuceOLUegjMBxxx2XeYTISSedlAl+wjOqc0x/F5sacKvjy3BSo3G1Z1KXBNdff72b5EucFIwoTZ482YK+kdx7H2y5gRr869y5s6sqVAlXboNxn11VqiH9vLqrL3d+321Abvsov0wcryodU/Dq25IpTz3/TvtVv379TIleHOsiDwQQqFsBGozXrT9rRyBWAd1t9pe//MX1K6RSEJUUqUpNPWZrWD19q4RHSb2K5/ZArvFqM6S759RoXEmNxn3woUBLvX770pRwf1Fu5hr8U8nSueee60qHFKwp+FGwpt7A58yZY2PGjHF9MSkIqUoaNGiQCxrVB5R6+FbjdJW0KXXr1s0FhlXJpybzyKx169auDZgaiPsuH/Qg5nDbsprkzTIIIFA4AgRPhXMs2BIEYhFQf0t65Io6flS7Hz0qRX8+qVRJ/Slde+21rvsAPz78qtIkHzzp7jUt45MCMh88aV3haX6e6r7qln4ldWipu/v8HX4+Hz3UuKppzz33tKAncde3k/p38mmHHXawYcOG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kiawYMEC23nnnd1mT58+3dq1a5e0XWB7EcirwKWXXmpDhw4ts84111zTDjzwQLvmmmusffv2menffPON+y35+eef3W+NppPqXqCwLxPr3qfCLfjiiy8ygZM+7J07d3Yf+tVXX93ee+89O/vss+33v/99hXkwEQEEEECgeASWLVvmdlalTV27drUuXbpYs2bN7Pvvv7cnn3zS9t9/f/vkk08yIGuttZZts802brhVq1aZ8bypWwGCp5j8H374YVM7imnTppmuwDt16uRyvuOOO2zevHkxrYVsEEAAAQTSINC9e3ebMGGCvfLKK6YS3JEjR7paio8//thUTeeTqsJ1Mf7dd9/ZySef7EfzWscCVNvVwgFo3bq1DRkyxF1B/PLLLzZ16lTbcssts9b06aef2ttvv23Lly+3zTff3Nq0aWNNmzbNmic88O2339qMGTPsww8/dHXju+22mzVo0CA8S+R7nYiLFi1yeee7HVbkBjGy6AX02Vc7qa+++sq2335714bDt/X46aef3AWIrra32267SCtdoKiNlZYNp4ryDc/HewQKUaBPnz6u9kIX4boADycFV/p8t23b1lS9p6RgaubMmdakSRP3G/LDDz/Yq6++6trgduzY0ZVmhfPgfbwClDzF65nJTcWwPvkfBg3Pnz/fevXq5RqU68rj2GOPdUFW8+bN7bTTTjP9eOSmu+66y82v0qy+ffvavvvua40bN866OsldRsO6olHDWLVJueyyy6JmYRwCeRNQNffRRx9tm266qR1wwAF2xBFHuOoIBUm6wFDSq7749SMRdUfcM88844KmHXfc0XRBoVSVfN2M/EMgIQK6eAgn/VbovHj00Uczo0ePHu2+28844wz75z//aaoG7Natm/Xu3dv874kCKlLtCBA81Y5rJrCpX7++uwvJr0bVeGPGjHEfdN05ccEFF7gPvK6k77nnHrvtttv8rO5Vw6effrqtXLnSOnToYCeccIKrEtQPxjnnnJM1b3hApVQK0tTYUHdBXXvtteHJvEcgrwJq7LrXXnvZiBEjbOONN3ZtAS+++GJTGw7dJbrnnnuaSkn1WdWFgdJDDz1UZhu1vNLuu+/uSl6rmm+ZjBiBQIEJPP/88/b666+7rerRo0fW1un3Qcm/ht8//vjj7iJcJVFqL6ULDyX9ntx+++3uPf/iF6DaLibTRx55xBWTqqGfToJ///vfLmcFR+FSKF1xqwpPdddrrLFGZu1HHXWUu6p44okn3B16mqAA6corr3TzKGgaPnx45lZwNSx84IEHMsuH36iIV1cqK1ascD9Gzz33nPvBCs/DewTyKaAvclW3bbjhhvbWW29Zy5Yt3ep155GqudXlx3XXXWc33HCD60rgL3/5izsfbrzxxsxnXne16odCSSW2StXJ1y3APwQKRGDSpEmutkEXAGoXO3HiRBcc/fa3vzX9HlQ1qWmIzif97uhV54nu2nvxxRfdb8ZZZ51V1ayYrxoClDxVA6uiWQcNGmT60OvHQIFTSUmJK31S26dwUpWbSpLCgZOmH3TQQW42BT4+qdpNbaKUl/IJ96GjUiUFbLlJ8+vEUTsnXcUTOOUKMVwXAj7QVxWDD5y0Heuuu6717NnTbZJ+TJR8YKSA6qWXXnLj9O/ZZ591FwS6m1XV10rVydctwD8ECkRAAZOC//vuu88FOgqilCZPnlymzVNFm7zBBhu4huf+vNL5od8YJTUTIdWOACVPMbmqvdLaa6/tvuzfeecd13ZJJ0d5aenSpaYfC/1AqFdwXZUrheuofUdqqtrYYostyssqa/y5557rhlXaReCURcNAHQrMnj3brV1Xw+r/LJx0J5GSP1/UtkPtoN59911Xzad2HEq+yk5VGmrfoVSdfN0C/EOgQAT23ntvd7Gtqjhd9CpouvPOO92NRPrMv//++1WqMdC5EK7d0O6pzZNSuANnN4J/sQkQPMVEqT6d1EGgilAHDBhgauStzsx0B4Uat/qkeulTTz3VlRpFNQ738+l17ty5blA9z1Y1qURLAdjixYtdQKYTlIRAXQqo/xq1Z1JSaar+opIakvt03HHHuR8W3b598803m67K1UBWSdOUapKvW5B/CBSAgO6SUzMOn4455hjX2Fvf2bqzTs00zjvvPD+5Wq+5Dc6rtTAzV0lgtSrNxUxVFlDV2l//+ld3d5wCqdyeZHXVrTsj1M2AqvpUT62Sqtz5tEIVxyqp7VJV00033eSCOP3Y6M4mlXCREKhLAd1avd5667lN+Nvf/uYCewX3uX9vvvlmZjP1Q6K7VHVFrnNk/Pjxrg3g+uuvb4ceeqibryb5ZlbAGwQKUEA3TvhSI1+qWoCbySYFAgRPtfAxUGDkqyZ05ex7lFXxrL96VkPYyy+/3HU7sMMOO0Q+r8jXYav6rqrFr+uss47rbE1tSRQ4qW1IZSVctUBAlghkCajLDCV9JnU3XdRf+GpZN1XssccebhlV1/kqO5Xkhuerbr4uQ/4hUMACvulGbrvYAt7kotw0gqdaOuynnHKKa+CtE+Hee+91a9F7dQyopK4HfPr6668z8/hxetXt2CrJUn82V199dXiS6wPHN7TNmhAM6Ll6qjZUUoPbgQMHuvf8Q6CuBHy7JXXVEb4pwm+PzovwOaHxvuG4Smp1EaLkq+zcQPCvJvn6ZXlFoJAEVFMxePBgVyKr7fIXD4W0jWzLrwK0efrVItZ3emCw+txQp34KZC688ELXM6zugNOt2moPpRIpVc3df//9kXdX6BZuPQH+wQcftOuvv95V7+2yyy6up3H1FaW78FSaFe6E0++Elnv55Zddv1FaVs9POvzww/1kXhGIXUD9lqlaLZxUAqruN9RJq+4q0s0RagOorjr0+VbApF6Rx44d67rlUN9PPul2bd1mrbZNSmoj4oMlP09N8vXL8opAXQro0Sz+rlFdIKtXcd/OVdV3Rx55ZF1uHuuuRIDgqRKgVZmsO/AUPOmRKuo5WT8auptC3RKoPyhfmqSONNUfVFS7p1tuucWVPD322GPu7jndQaek9h6XXHJJZODkt1l95bzxxhsuWFNJ2CGHHFKmiwQ/L68I1ERAwZFKR3XVrMcN5SbdNq0AX43B9dnV51B3luqzGU7KR53AhpM609S54qu61Q4q3F2H5q1JvuF18B6BfAv4x2qpO5nc7mbUNlDniEqg9LtAKlwBgqdVODa6Eh41apT74Yh62rUeP6Hp6rRs6623dmvSbdhqwzRu3DgXVKlxoHpe1q2mKh1SJ4LhpOF//etf7jZWPQ9MbUa0jDrBDD+r7u6773bFvfvtt19mcQVYTz31lL3wwgumHzGVVJEQiFNAt0krQFfD7qikoMiXjKrUVAGWSl7VDYEajOvzrW4JVEWtrj5yk3pIVvWd8gjfmRSerzr5Kg+1n2rUqFE4C94jkDcB1TroESq6qPBJFwU6l9q3bx95gRv1/V7RZ1m9jKuqO9w+0K+L13gE+DVdBUcFI4cddli5OejKIWq6ri58cW14YZ1Q5SUFXforLykAi0q6Mv/Nb34TNYlxCMQioGcnVjUpiFegpL+qJDUsr8rnt6r56geqOr03V2UbmQeB6gjogkEdGVcnRX2/V/RZVtCkmytItSdA8FQDW38lXYNF63yR8NVOnW8MG5BogSSfB2F4zomwBu9rU6Cuzxk+6/EdXe62i8+SnBBAAAEEEECgCAQInorgILOLCCCAAAIIIBCfANV2NbCk6LMGaCySOgHOg9QdUnaolgU4Z2oZOI/ZU/KUR2xWhQACCCCAAALJFyB4Sv4xZA8QQAABBBBAII8CBE95xGZVCCCAAAIIIJB8AYKn5B9D9gABBBBAAAEE8ihA8JRHbFaFAAIIIIAAAskXIHhK/jFkDxBAAAEEEEAgjwIET3nEZlUIIIAAAgggkHwBgqfkH0P2AAEEEEAAAQTyKEDwlEdsVoUAAggggAACyRcgeEr+MWQPEEAAAQQQQCCPAgRPecRmVQgggAACCCCQfAGCp+QfQ/YAAQQQQAABBPIoQPCUR2xWhQACCCCAAALJFyB4Sv4xZA8QQAABBBBAII8CBE95xGZVCCCAAAIIIJB8AYKn5B9D9gABBBBAAAEE8ihA8JRHbFaFAAIIIIAAAskXIHhK/jFkDxBAAAEEEEAgjwIET3nEZlUIIIAAAgggkHwBgqfkH0P2AAEEEEAAAQTyKEDwlEdsVoUAAggggAACyRcgeEr+MWQPEEAAAQQQQCCPAgRPecRmVQgggAACCCCQfAGCp+QfQ/YAAQQQQAABBPIoQPCUR2xWhQACCCCAAALJFyB4Sv4xZA8QQAABBBBAII8CBE95xGZVCCCAAAIIIJB8AYKn5B9D9gABBBBAAAEE8ihA8JRHbFaFAAIIIIAAAskXIHhK/jFkDxBAAAEEEEAgjwIET3nEZlUIIIAAAgggkHwBgqfkH0P2AAEEEEAAAQTyKEDwlEdsVoUAAggggAACyRcgeEr+MWQPEEAAAQQQQCCPAgRPecRmVQgggAACCCCQfAGCp+QfQ/YAAQQQQAABBPIoQPCUR2xWhQACCCCAAALJFyB4Sv4xZA8QQAABBBBAII8CBE95xGZVCCCAAAIIIJB8AYKn5B9D9gABBBBAAAEE8ihA8JRHbFaFAAIIIIAAAskXIHhK/jFkDxBAAAEEEEAgjwIET3nEZlUIIIAAAgggkHwBgqfkH0P2AAEEEEAAAQTyKEDwlEdsVoUAAggggAACyRcgeEr+MWQPEEAAAQQQQCCPAgRPecRmVQgggAACCCCQfAGCp+QfQ/YAAQQQQAABBPIoULJy5crI1S1evNgmT54cOY2RCKRZYOnSpW73lixZwjmQ5gPNvlUqoHNASecEvweVcjFDCgUUC0Wlel26dCmdNGlS1DTGIYAAAggggAACCOQIUG2XA8IgAggggAACCCBQkQDBU0U6TEMAAQQQQAABBHIECJ5yQBhEAAEEEEAAAQQqEiB4qkiHaQgggAACCCCAQI7A/wNg9u0M+B2QBAAAAABJRU5ErkJggg==</Image>' +
            '            <ScaleMode>Fill</ScaleMode>' +
            '            <BorderWidth>0</BorderWidth>' +
            '            <BorderColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Center</VerticalAlignment>' +
            '          </ImageObject>' +
            '          <Bounds X="81.6" Y="316.8005" Width="5760" Height="8640"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>License Number</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Supplier_License_Number__c + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>Suppress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="193.0063" Y="748.5106" Width="5523.073" Height="514.501"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>License Premise</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + String.escapeSingleQuotes(invPos.License_Premise__c).escapeXml() + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>Suppress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="201.5892" Y="2474.914" Width="5512.525" Height="361.3207"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Legal Business Name</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + String.escapeSingleQuotes(invPos.Supplier_Name__c ) + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>Suppress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="205.6392" Y="1612.541" Width="5512.917" Height="529.0613"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Product Name</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + String.escapeSingleQuotes(invPos.Product_Name__r.Name) + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="199.6625" Y="3330.686" Width="5512.526" Height="392.2476"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Product Description</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + String.escapeSingleQuotes(invPos.Product_Description__c).escapeXml() + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="205.0913" Y="4184.079" Width="5512.526" Height="393.5009"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Purchase Order</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Purchase_Order__c + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="205.0647" Y="5032.904" Width="2656.336" Height="366.3707"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Batch ID</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + (!String.isBlank(invPos.Harvest_Batch_Code__r.Name) ? invPos.Harvest_Batch_Code__r.Name : '') + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="204.6592" Y="5892.886" Width="2656.336" Height="380.3782"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>UID</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + (!String.isBlank(invPos.UID_New__r.Name) ? invPos.UID_New__r.Name : '') + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="3069.006" Y="5896.03" Width="2656.336" Height="390.8838"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Qty</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + (checkQtyAllocation(invPos.Qty_Allocated__c)?invPos.Qty_On_Hand__c :invPos.Qty_Allocated__c) + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="217.0651" Y="6761.478" Width="1698.485" Height="372.4529"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Qty Type</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Quantity_Type__c + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="2121.118" Y="6748.318" Width="1687.132" Height="393.7589"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>UOM</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Stocking_UOM__c + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="4025.54" Y="6748.982" Width="1707.111" Height="399.6568"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Ownership</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + String.escapeSingleQuotes(invPos.Ownership__r.Name) + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="203.6906" Y="7608.676" Width="5512.525" Height="395.4915"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Rack</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Rack__r.Name + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="198.9293" Y="8455.309" Width="1707.111" Height="399.6568"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Level</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Rack_Level__r.Name + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="2108.301" Y="8461.438" Width="1707.111" Height="399.6568"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Bin</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>True</IsVariable>' +
            '            <HorizontalAlignment>Center</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Bin_Location__r.Name + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '            <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '            <BarcodePosition>AboveAddress</BarcodePosition>' +
            '            <LineFonts/>' +
            '          </AddressObject>' +
            '          <Bounds X="4011.626" Y="8455.33" Width="1707.111" Height="399.6568"/>' +
            '        </ObjectInfo>' +
            '        <ObjectInfo>' +
            '          <AddressObject>' +
            '            <Name>Received Date</Name>' +
            '            <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '            <BackColor Alpha="0" Red="255" Green="255" Blue="255"/>' +
            '            <LinkedObjectName></LinkedObjectName>' +
            '            <Rotation>Rotation0</Rotation>' +
            '            <IsMirrored>False</IsMirrored>' +
            '            <IsVariable>False</IsVariable>' +
            '            <HorizontalAlignment>Left</HorizontalAlignment>' +
            '            <VerticalAlignment>Middle</VerticalAlignment>' +
            '            <TextFitMode>ShrinkToFit</TextFitMode>' +
            '            <UseFullFontHeight>True</UseFullFontHeight>' +
            '            <Verticalized>False</Verticalized>' +
            '            <StyledText>' +
            '              <Element>' +
            '                <String>' + invPos.Date_Received__c + '</String>' +
            '                <Attributes>' +
            '                  <Font Family="Helvetica" Size="72" Bold="True" Italic="False" Underline="False" Strikeout="False"/>' +
            '                  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '                </Attributes>' +
            '              </Element>' +
            '            </StyledText>' +
            '           <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '           <BarcodePosition>AboveAddress</BarcodePosition>' +
            '           <LineFonts />' +
            '          </AddressObject>' +
            '          <Bounds X="3083.006" Y="5030.586" Width="2634.609" Height="382.8125"/>' +
            '        </ObjectInfo>' +
            '      </DieCutLabel>';
            
        return template;        
    }
    
    /**
     * Get Dymo Label layouts
     */
    public List<SelectOption> getDymoLabelLayouts() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select Layout'));
        options.add(new SelectOption(ONEBYTHREE, ONEBYTHREE));
        options.add(new SelectOption(TWOBYFOUR, TWOBYFOUR));
        options.add(new SelectOption(FOURBYSIX, FOURBYSIX));
        
        return options; 
    }
    
    // Generate inventory info as image to print
    public void generateImageXml(){
        imageXml = '';
        List<String> inventoriesToPrint = new List<String>();
        if(invPositionWrappList != null && invPositionWrappList.size() > 0){
            for(InventoryPositionWrapper invPositionWrapper : invPositionWrappList){
                if(invPositionWrapper.isSelected){
                    if(selectedDymoLabelLayout == ONEBYTHREE){
                        imageXml = getImage1X3Xml(invPositionWrapper.invPos);
                    }else if(selectedDymoLabelLayout == TWOBYFOUR){
                        imageXml = getImage2X4Xml(invPositionWrapper.invPos);
                    }else if(selectedDymoLabelLayout == FOURBYSIX){
                        imageXml = getImage4X6Xml(invPositionWrapper.invPos);
                    }
                    isSelectedInventory = true;
                    inventoriesToPrint.add(imageXml);
                }
            }
        }
        inventoryInfo = JSON.serialize(inventoriesToPrint);
        
        if(imageXml == ''){
            isSelectedInventory = false;
        }
    }
    @AuraEnabled
    // Generate inventory info as image to print
    public static AuraResponse generateImageXml(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedInventory){
        AuraResponse r = new AuraResponse('PrintInventoryLabelsController.generateImageXml()');
        
        PrintInventoryLabelsController.inventoryDetails(recId);
        imageXml = '';
        isSelectedInventory = false;
        String inventoryInfo;
        String selectedDymoLabelLayout = layout;
        List<String> inventoriesToPrint = new List<String>();
        
        List<InventoryPositionWrapper> invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(wrpJson, List<InventoryPositionWrapper>.class);
        
        for(InventoryPositionWrapper invPositionWrapper : invPositionWrappList){
            if(invPositionWrapper.isSelected){
                if(selectedDymoLabelLayout == ONEBYTHREE){
                    imageXml = getImage1X3Xml(invPositionWrapper.invPos);
                }else if(selectedDymoLabelLayout == TWOBYFOUR){
                    imageXml = getImage2X4Xml(invPositionWrapper.invPos);
                }else if(selectedDymoLabelLayout == FOURBYSIX){
                    imageXml = getImage4X6Xml(invPositionWrapper.invPos);
                }
                isSelectedInventory = true;
                inventoriesToPrint.add(imageXml);
            }
        }
        inventoryInfo = JSON.serialize(inventoriesToPrint);
        
        if(imageXml == ''){
            isSelectedInventory = false;
        }
        
        AllProductDetails allRec = new AllProductDetails();      
        allRec.invPositionWrappList = invPositionWrappList;
        allRec.imageXml = imageXml;
        allRec.prod = productObjLight;
        allRec.inventoryInfo = inventoryInfo;
        allRec.isSelectedInventory = isSelectedInventory;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        r.data.put('records', allRec);
        return r;
    }
    public class AllProductDetails{
        @AuraEnabled public Product2 prod {get; set;} 
        @AuraEnabled public List<InventoryPositionWrapper> invPositionWrappList {get; set;}
        @AuraEnabled public List<CustomSelectOptions> dymoLabelLayouts {get; set;}
        @AuraEnabled public List<CustomSelectOptions> printers {get; set;}
        @AuraEnabled public Boolean isSelectedInventory {get; set;} 
        @AuraEnabled public String inventoryInfo {get; set;}
        @AuraEnabled public String imageXml {get; set;}
        @AuraEnabled public String selectedDymoLabelLayout {get; set;}
    }
    
    public class CustomSelectOptions{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
        
        public CustomSelectOptions() {
            this.label = '';
            this.value = '';
        }
        public CustomSelectOptions(String lab, String val) {
            this.label = lab;
            this.value = val;
        }
    }
}