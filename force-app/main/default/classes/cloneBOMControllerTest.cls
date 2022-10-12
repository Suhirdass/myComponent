@isTest(SeeAllData=false)
public class cloneBOMControllerTest {

    static testmethod void runBOMClone(){
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;

        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        Bill_of_Materials__c objBillofMat = new Bill_of_Materials__c();
        objBillofMat.Name = 'test BOM';
        objBillofMat.BOM_Levels__c = 1;
        objBillofMat.Product__c = objProduct1.Id;
        objBillofMat.Status__c = 'Draft';
        insert objBillofMat;
        
        BOM_Lines__c objbomline1 = new BOM_Lines__c();
        objbomline1.Bill_of_Material__c = objBillofMat.id;
        objbomline1.Product__c = objProduct1.id;
        objbomline1.Sequence__c = 10;
        objbomline1.Qty_Per__c = 20;
        
        BOM_Lines__c objbomline2 = new BOM_Lines__c();
        objbomline2.Bill_of_Material__c = objBillofMat.id;
        objbomline2.Product__c = objProduct1.id;
        objbomline2.Sequence__c = 10;
        objbomline2.Qty_Per__c = 20;
        
        BOM_Lines__c objbomline3 = new BOM_Lines__c();
        objbomline3.Bill_of_Material__c = objBillofMat.id;
        objbomline3.Product__c = objProduct1.id;
        objbomline3.Sequence__c = 10;
        objbomline3.Qty_Per__c = 20;
        
        list<BOM_Lines__c> lstBOMLine = new list<BOM_Lines__c> ();
        lstBOMLine.add(objbomline1);
        lstBOMLine.add(objbomline2);
        lstBOMLine.add(objbomline3);
        insert lstBOMLine;

        List<cloneBOMController.BOMLineWrapper> bomliWrapprList = new List<cloneBOMController.BOMLineWrapper>();    
       
        cloneBOMController.BOMLineWrapper bomliWrappr1  = new  cloneBOMController.BOMLineWrapper();
        cloneBOMController.BOMLineWrapper bomliWrappr2  = new  cloneBOMController.BOMLineWrapper();
        cloneBOMController.BOMLineWrapper bomliWrappr3  = new  cloneBOMController.BOMLineWrapper();

        bomliWrappr1.isSelected = true;
        bomliWrappr1.billofMaterialsLineBOM = objbomline1;
        bomliWrapprList.add(bomliWrappr1);
        
        bomliWrappr2.isSelected = true;
        bomliWrappr2.billofMaterialsLineBOM = objbomline2;
        bomliWrapprList.add(bomliWrappr2);
        
        bomliWrappr3.isSelected = true;
        bomliWrappr3.billofMaterialsLineBOM = objbomline3;
        bomliWrapprList.add(bomliWrappr3);
        
        cloneBOMController.cloneBOM(objBillofMat.Id);
        cloneBOMController.getBOM(objBillofMat.Id);
        cloneBOMController.getBOMLines(objBillofMat.Id);
        cloneBOMController.cloneBOMLight(objBillofMat, bomliWrapprList);
    }
}