/**************************************************************************************
Apex Class Name    : PicklistController 
Test Class Name    :PicklistControllerTest
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for PicklistPdf VF page
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/
/**************************************************************************************
Apex Class Name    : PicklistController 
Test Class Name    :PicklistControllerTest
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for PicklistPdf VF page
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/

public class PicklistController {


Public Picklist__c picklist {get; set;}
Public List<PicklistLineWrapper> picklistLineList {get; set;}
Public String recordID {get; set;}

    
    @AuraEnabled
    public static AuraResponse updateSorting(String recordId){ 
        AuraResponse r = new AuraResponse('PicklistController.updateSorting()'); 
        
        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();  List<Picklist_Line__c> printPickListLine = new List<Picklist_Line__c>();
        printPickListLine =[SELECT id,Name,Product_Name__c,Product_Name__r.name,Harvest_Batch_or_Lot_Code__c, Product_Description__c,Producer_Name__c,Inventory_Location__c,Rack__c,Rack_Level__c,  Bin_Location__c,Purchase_Order__c,UID__c,Qty_to_Pick__c,Sales_Order_Line__r.Is_Sample__c,Is_Sample__c,IsPromo__c,Sorting__c FROM Picklist_Line__c WHERE Picklist__c = :recordID  ORDER BY Sorting__c ASC];
        
        for(Picklist_Line__c var:printPickListLine){  Picklist_Line__c pkSorting = new Picklist_Line__c();
                                                    String str = var.Inventory_Location__c+''+var.Rack__c+''+var.Rack_Level__c+''+var.Bin_Location__c;
                                                    str = str.replaceAll('\\D', '');
                                                    if(str!='')   {
                                                        pkSorting.sorting__c =   Decimal.valueOf(str); 
                                                    }  else{
                                                        pkSorting.sorting__c =1;
                                                    }                                  
                                                    
                                                    pkSorting.id= var.id; picklistLines.add(pkSorting);
                                                   }
        
        if(picklistLines.size() > 0){ UPDATE picklistLines;
                                    }
        
        return r;
        
    }
   
    
public PicklistController() {
    Map<ID,String> PicklistLineKeyMap = new Map<ID,String>();
    Map<String,Decimal> PicklistLineQtyMap = new Map<String,Decimal>();
    picklist =new Picklist__c();
    picklistLineList = new List<PicklistLineWrapper>();
    List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
    List<Picklist_Line__c> subPicklistLine = new List<Picklist_Line__c>();
    string status;
    recordID =ApexPages.currentPage().getParameters().get('Id');
    if(recordID!=null){
        picklist =[select id,Sales_Order__c,Sales_Order__r.Name,Status__c,Name,Assigned_To_Name__c,Scheduled_Pick_Date__c,
        Picklist_Lines__c,Receiver_DBA__c,Delivery_City__c,Planned_Ship_Date__c from Picklist__c where id = :recordID];
        
        picklistLines =[SELECT id,Name,Product_Name__c,Product_Name__r.name,Harvest_Batch_or_Lot_Code__c,
                        Product_Description__c,Producer_Name__c,Inventory_Location__c,Rack__c,Rack_Level__c,
                        Bin_Location__c,Purchase_Order__c,UID__c,Qty_to_Pick__c,Sales_Order_Line__r.Is_Sample__c,Is_Sample__c,IsPromo__c,sorting__c
                          FROM Picklist_Line__c WHERE Picklist__c = :recordID  ORDER BY Inventory_Location__c,sorting__c ASC];
        
      
        

        for(Picklist_Line__c var:picklistLines){

            String mapKey = var.Product_Name__c+'-'+var.Producer_Name__c+'-'+var.Inventory_Location__c+'-'+var.Rack__c+'-'+var.Rack_Level__c+'-'+var.Bin_Location__c+'-'+var.UID__c+'-'+var.Harvest_Batch_or_Lot_Code__c+'-'+var.sorting__c;
            mapKey += var.Is_Sample__c;

            if(PicklistLineQtyMap.containskey(mapKey)){ Decimal qty=PicklistLineQtyMap.get(mapKey);
                PicklistLineQtyMap.put(mapKey,qty+var.Qty_to_Pick__c);
            }else {
                PicklistLineKeyMap.put(var.ID,mapKey);
                PicklistLineQtyMap.put(mapKey,var.Qty_to_Pick__c);
            }
            
        }


        for(Picklist_Line__c var:picklistLines){

            String mapKey = var.Product_Name__c+'-'+var.Producer_Name__c+'-'+var.Inventory_Location__c+'-'+var.Rack__c+'-'+var.Rack_Level__c+'-'+var.Bin_Location__c+'-'+var.UID__c+'-'+var.Harvest_Batch_or_Lot_Code__c+'-'+var.sorting__c;
            mapKey += var.Is_Sample__c;
            if(PicklistLineKeyMap.containskey(var.ID) && PicklistLineQtyMap.containskey(mapKey)){
                PicklistLineWrapper wrap= new PicklistLineWrapper(var,PicklistLineQtyMap.get(mapKey));
                picklistLineList.add(wrap);
            }
        }
    }
    }
    
    
    
}