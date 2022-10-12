public class HeatMapGeneratorCtlr {
    public String jsonData{get;set;}
    public List<SelectOption> sites{get; set;}
    public List<SelectOption> locations{get; set;}
    public String iLocation{get;set;}
    public String siteId{get;set;}
    
    public HeatMapGeneratorCtlr(){
        jsonData = '';
        sites = allSites();
        allLocations();
    }
    
    @AuraEnabled
    public static AuraResponse heatMapGenerator(){
        AuraResponse r = new AuraResponse('HeatMapGeneratorCtlr.heatMapGenerator()');
        List<String> AssignedWarehouseIds = new List<String>();
        List<CustomSelectOptions> options = new List<CustomSelectOptions>();
        String siteId = null;
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
            for(Site__c siteObj : [SELECT Name,Id FROM Site__c WHERE Id IN: AssignedWarehouseIds]){
                options.add(new CustomSelectOptions(siteObj.Id,siteObj.Name)); 
                if(siteId == null){
                    siteId = siteObj.Id;
                }
            }
        }
        r.data.put('sites',options);  
        
        List<CustomSelectOptions> lOptions = new List<CustomSelectOptions>();
        String iLocation = null;
        for(Inventory_Location__c loc : [SELECT Id, Name
                                         FROM Inventory_Location__c 
                                         WHERE Site_Name__c = :siteId 
                                         AND Include_in_Heat_Map__c = true]){
                                             lOptions.add(new CustomSelectOptions(loc.Id,loc.Name)); 
                                             if(iLocation == null){
                                                 iLocation = loc.Id; 
                                             }
                                             
                                         }
        r.data.put('locations',lOptions); 
        HeatMapGeneratorCtlr heatMap = new HeatMapGeneratorCtlr();
        heatMap.iLocation = iLocation;
        heatMap.processRackData();
        r.data.put('jsonData',heatMap.jsonData);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getAllLocations(String siteId){
        AuraResponse r = new AuraResponse('HeatMapGeneratorCtlr.getAllLocations()');
    	List<CustomSelectOptions> lOptions = new List<CustomSelectOptions>();
        String iLocation = null;
        for(Inventory_Location__c loc : [SELECT Id, Name FROM Inventory_Location__c 
                                         WHERE Site_Name__c = :siteId AND Include_in_Heat_Map__c = true]){
                                             lOptions.add(new CustomSelectOptions(loc.Id,loc.Name)); 
                                             if(iLocation == null){
                                                 iLocation = loc.Id; 
                                             }
                                             
                                         }
        r.data.put('locations',lOptions); 
        HeatMapGeneratorCtlr heatMap = new HeatMapGeneratorCtlr();
        heatMap.iLocation = iLocation;
        heatMap.processRackData();
        r.data.put('jsonData',heatMap.jsonData); 
        return r;    
    }
    
    @AuraEnabled
    public static AuraResponse getProcessRackData(String locId){
        AuraResponse r = new AuraResponse('HeatMapGeneratorCtlr.getProcessRackData()');
    	HeatMapGeneratorCtlr heatMap = new HeatMapGeneratorCtlr();
        heatMap.iLocation = locId;
        heatMap.processRackData();
        r.data.put('jsonData',heatMap.jsonData);
        return r;
    }
    
    public List<SelectOption> allSites() {
        
        List<SelectOption> options = new List<SelectOption>();
        siteId = null;
        for(Site__c siteObj : [SELECT Name,Id FROM Site__c ]){
            options.add(new SelectOption(siteObj.Id,siteObj.Name)); 
            if(siteId == null){
                siteId = siteObj.Id;
            }
        }
        System.debug('allSites - ');
        System.debug(options);
        return options;
    }
    
    public void allLocations() {
        
        List<SelectOption> options = new List<SelectOption>();
        iLocation = null;
        //options.add(new SelectOption('', '- None -'));
        for(Inventory_Location__c loc : [SELECT Id, Name
                                         FROM Inventory_Location__c 
                                         WHERE Site_Name__c = :siteId 
                                         AND Include_in_Heat_Map__c = true]){
                                             options.add(new SelectOption(loc.Id,loc.Name)); 
                                             if(iLocation == null){
                                                 iLocation = loc.Id; 
                                             }
                                             
                                         }
        System.debug(iLocation+' :iLocation options: '+options);
        locations = options;
        System.debug('allLocations - ');
        System.debug(locations);
        processRackData();
    }
    
    public Set<String> getInventoryPositions(){
        Set<String> positions = new Set<String>();
        List<Rack_Level__c> level = [SELECT Name FROM Rack_Level__c WHERE Rack__c IN(SELECT Id FROM Rack__c WHERE Inventory_Location__c = :iLocation)];
        System.debug('getInventoryPositions level' + level);
        for(Inventory_Position__c obj : [SELECT Bin_Location__r.Name,Bin_Location__r.Rack__c,
                                         Bin_Location__r.Rack_Level__r.Name
                                         FROM Inventory_Position__c
                                         WHERE Inventory_Location__c =:iLocation AND  Bin_Location__c IN (SELECT Id FROM Bin_Location__c )]){
                                             positions.add(obj.Bin_Location__r.Rack__c+obj.Bin_Location__r.Rack_Level__r.Name+obj.Bin_Location__r.Name);
                                         }
        System.debug('getInventoryPositions positions'+positions);
        return positions;
    }
    
    public void processRackData(){
        System.debug('In Method');
        Set<String> positions = getInventoryPositions();
        Map<String,Map<String,Set<String>>> data = new Map<String,Map<String,Set<String>>>();
        Map<String,List<Map<String,String>>> rows = new Map<String,List<Map<String,String>>>();
        
        Map<String,Boolean> isIPAvailable = new Map<String,Boolean>();
        List<Rack_Level__c> level = [SELECT Name FROM Rack_Level__c WHERE Rack__c IN(SELECT Id FROM Rack__c WHERE Inventory_Location__c = :iLocation)];
        String query = 'SELECT Id, Rack__c,Rack_Level__r.Name,';
        query += 'Name, Inventory_Location__c,Site__c FROM Bin_Location__c';
        query += ' WHERE Rack_Level__r.Rack__r.Inventory_Location__r.Include_in_Heat_Map__c = TRUE';
        query += ' AND Rack_Level__r.Rack__r.Inventory_Location__c = :iLocation';
        query += ' ORDER BY Rack_Level__r.Name ASC, Name Asc,Rack__c ASC';
        Set<String> openAdded = new Set<String>();
        for(Bin_Location__c bin : Database.query(query)){
            System.debug('data' + data);
            if(data.containsKey(bin.Rack__c)){
                Map<String,Set<String>> bins = data.get(bin.Rack__c);
                if(bins.containsKey(bin.Name)){
                    if(!positions.contains(bin.Rack__c+bin.Rack_Level__r.Name+bin.Name)){
                        bins.get(bin.Name).add(bin.Rack_Level__r.Name +'-Open');
                    }
                    else
                        bins.get(bin.Name).add(bin.Rack_Level__r.Name);
                }else{
                    Set<String> ls = new Set<String>();
                    if(!positions.contains(bin.Rack__c+bin.Rack_Level__r.Name+bin.Name))
                         ls.add(bin.Rack_Level__r.Name + '-Open');
                    else
                        ls.add(bin.Rack_Level__r.Name);
                    bins.put(bin.Name,ls);
                }
            }else{
                Map<String,Set<String>> mp  = new Map<String,Set<String>>();
                Set<String> ls = new Set<String>();
                if(!positions.contains(bin.Rack__c+bin.Rack_Level__r.Name+bin.Name))
                    ls.add(bin.Rack_Level__r.Name + '-Open');
                else
                    ls.add(bin.Rack_Level__r.Name);
                mp.put(bin.Name,ls);
                data.put(bin.Rack__c,mp);
            }
        }
        System.debug('data: '+data);
        Set<String> levelsArr = new Set<String>();
        
        for(Rack_level__c obj : level){
            levelsArr.add(obj.Name);
        }
        System.debug('levelsArr::'+levelsArr);
        //Object levels = level[0].get('total');
        Map<String,String> finalData = new Map<String,String>();
        finalData.put('level',String.join(new List<String>(levelsArr),','));
        finalData.put('tableData',JSON.serialize(data));
        jsonData = JSON.serialize(finalData);
        System.debug('jsonData::'+jsonData);
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