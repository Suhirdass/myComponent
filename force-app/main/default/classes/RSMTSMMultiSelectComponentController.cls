/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMTSMMultiSelectComponentController
 */
public with sharing class RSMTSMMultiSelectComponentController {
    public List<RSMTSMWrapper> initialList {get; set;}
    public List<RSMTSMWrapper> selectedList {get; set;}
    
    public List<String> availableRSMTSMOptions {get; set;}
    public List<String> selectedRSMTSMOptions {get; set;}
    Map<String, RSMTSMWrapper> availableOptionMap;
    Map<String, RSMTSMWrapper> selectedOptionMap;
  
    //  Default constructor
    public RSMTSMMultiSelectComponentController() {
        availableRSMTSMOptions = new List<String>();
        selectedRSMTSMOptions = new List<String>();
        availableOptionMap = new Map<String, RSMTSMWrapper>();
        selectedOptionMap = new Map<String, RSMTSMWrapper>();
    }
  
    /**
     * Action method of right arrow to move items from available RSM/TSM list to selected TSM list
     */
    public PageReference clickRight(){
        selectedRSMTSMOptions.clear();
        for(String rsmtsmId : availableRSMTSMOptions){
            if (availableOptionMap.containsKey(rsmtsmId)) {
                selectedOptionMap.put(rsmtsmId, availableOptionMap.get(rsmtsmId));        
            }
            availableOptionMap.remove(rsmtsmId);
        }
        return null;
    }

    /**
     * Action method of left arrow to move items from selected RSM/TSM list to available TSM list
     */     
    public PageReference clickLeft(){
        availableRSMTSMOptions.clear();
        for(String rsmtsmId : selectedRSMTSMOptions){
            if (selectedOptionMap.containsKey(rsmtsmId)) {
                availableOptionMap.put(rsmtsmId, selectedOptionMap.get(rsmtsmId));        
            }
            selectedOptionMap.remove(rsmtsmId);
        }
        return null;
    }

    /**
     * Retrieve RSM/TSM in available list
     */      
    public List<SelectOption> getAvailableOptionList(){
        List<SelectOption> tempOptionList = new List<SelectOption>();
        List<RSMTSMWrapper> tempValueList; 
        
        // load initially selected records into the available RSM/TSM list 
        if (initialList != null && initialList.size() > 0) {
            for (RSMTSMWrapper rsmtsmObj : initialList) {
                availableOptionMap.put(rsmtsmObj.Id, rsmtsmObj);
            }
            initialList.clear();
        }
        
        tempValueList = availableOptionMap.values();
        for (RSMTSMWrapper rsmtsmObj : tempValueList) { 
            tempOptionList.add(new SelectOption(rsmtsmObj.Id, rsmtsmObj.Name + ' - ' + rsmtsmObj.deliveryCity));
        }
        tempOptionList = doSortOption(tempOptionList);
        return tempOptionList;
    }

    /**
     * Retrieve RSM/TSM in selected option list
     */
    public List<SelectOption> getSelectedOptionList(){
        List<SelectOption> tempOptionList = new List<SelectOption>();
        List<RSMTSMWrapper> tempValueList;
        
        if(selectedList != null && (selectedList.size() > 0 || (selectedList.size() == 0 && selectedOptionMap.size() > 0))){
            selectedList.clear();  
            tempValueList = selectedOptionMap.values();
            for (RSMTSMWrapper rsmtsmObj : tempValueList) { 
                tempOptionList.add(new SelectOption(rsmtsmObj.Id, rsmtsmObj.Name));
                selectedList.add(rsmtsmObj);
            }
        }
        return tempOptionList;
    }
    
    /**
     * Sort selectoptions based on labels
     *
     * @param opts The selectoptions
     *
     * @return  The sorted selectoptions
     */
    private List<Selectoption> doSortOption(List<Selectoption> opts) {
        
        Map<String, Selectoption> mapping = new Map<String, Selectoption>();
        // Suffix to avoid duplicate values like same labels or values are in inbound list 
        Integer suffix = 1;
        for (Selectoption opt : opts) {
            mapping.put((opt.getLabel() + suffix++), opt);   
        }
        
        List<String> sortKeys = new List<String>();
        sortKeys.addAll(mapping.keySet());
        sortKeys.sort();
        opts.clear();
        
        for (String key : sortKeys) {
            opts.add(mapping.get(key));
        }
        return opts;
    }
}