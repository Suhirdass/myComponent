/**************************************************************************************
Apex Class Name    : ShipmentManifestPrintLabelctrls 
Test Class Name    :ShipmentManifestPrintLabelctrlsTest
Components Name    :ShippingManifestLinePrintLabelNavi,ShippingManifestLinePrintLabel
Created Date       : Aug 10 2020
Function           : Used to generate Labels for Shipping Manifest related Shipping ManifestLine.
Developer          :Saranya

*******************************************************************************/

public class ShipmentManifestPrintLabelctrls {
    @TestVisible private static String ONEBYTWO = '1 X 2';
    @TestVisible private static String TWOBYFOUR = '2 X 4';
    @TestVisible private static String FOURBYSIX = '4 X 6';
    public static List<CustomSelectOptions> options;
    public static List<CustomSelectOptions> optionPrinter;
    public static List<SMWrapper> SMWrapperList;
   public static List<Shipping_Manifest__c> SMList2 {get; set;}
    public static List<Shipping_Manifest_Line__c> SMWrapperList2;
    public static Shipping_Manifest__c SMObjLight {get; set;}
    public static Shipping_Manifest__c SMrecords {get; set;}
    public static List<Shipping_Manifest__c> SMList;
    public static List <String>lst = new List <String>();
    public static String finnalLabelPrint ='';
    public static String  totaltemplate;
    public static String  finalbatch; 
   //shipping manifest record ids
    @AuraEnabled
    public static AuraResponse smLineDetails(String recId){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabelctrls.smLineDetails()');
        SMWrapperList = new List<SMWrapper>();
        SMList2 = [select Name, Order_Number__c, Customer_PO_or_Quote__c,Delivery_City__c,Status__c,Picklist__c,Picklist__r.Name, Receiver_DBA__c,Box_Count__c, Order_Number__r.name,
                                              Metrc_Manifest__c, Receiver_Address__c, Receiver_City_State_Zip__c,
                                              Receiver_First_Name__c, Receiver_Contact__r.MailingPostalCode, Receiver_Contact__r.MailingState, 
                                              Receiver_Contact__r.Name, Receiver_Contact__r.MailingStreet, Receiver_Contact__r.MailingAddress,Receiver_License_Number__c, 
                                              Receiver_Contact__r.MailingCity, Receiver_Contact__r.MailingCountry, Sales_Order__c, Sales_Order__r.Name,
                                              Sales_Order__r.Total_Line_Items__c, Site__r.License_ID__r.License_Number__c, Receiver_License__r.License_City__c,Receiver_License__c,
                                              Site__r.License_ID__r.License_Address__c, Site__r.License_ID__r.License_City__c,Receiver_License__r.License_Zip__c,Receiver_License__r.License_State__c,Receiver_License__r.License_Address__c,
                                              Site__r.License_ID__r.License_State__c,Site__r.License_ID__r.License_Zip__c, id,Opportunity_Name__c,Opportunity_Name__r.Name,
                                              (SELECT name,Sales_Order_Line__c,Sales_Order_Line__r.Name,Picklist_Line__c,Picklist_Line__r.Name,SMLine_Status__c,Product_Description__c, Product_Name__r.Name, Harvest_Batch_Code__c,Product_Name__c, Shipment_Qty__c, UID__c, Batch_ID__c,UID_1__c,  
                                               id from Shipping_Manifest_Lines__r where SMLine_Status__c != 'Cancelled' and SMLine_Status__c !='Rejected' and Shipment_Qty__c!=0   ORDER BY Product_Name__c ASC  ) from 
                                              Shipping_Manifest__c where Id =: recId];
        for(Shipping_Manifest_Line__c SMLRec : SMList2[0].Shipping_Manifest_Lines__r){
            SMWrapper SMLWrapper = new SMWrapper(false, SMLRec);
            SMWrapperList.add(SMLWrapper);
        }
        options = new List<CustomSelectOptions>();
        options.add(new CustomSelectOptions('', 'Select Layout'));
      // options.add(new CustomSelectOptions(ONEBYTWO, ONEBYTWO));
     // options.add(new CustomSelectOptions(FOURBYSIX, FOURBYSIX));
         options.add(new CustomSelectOptions(TWOBYFOUR, TWOBYFOUR));
        optionPrinter = new List<CustomSelectOptions>();
        optionPrinter.add(new CustomSelectOptions('', 'Select Printer'));
        SMObjLight = SMList2[0];  
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.SMrecords = SMList2[0];  
        allRec.dymoLabelLayouts = options;
        allRec.printers = optionPrinter;
        allRec.selectedDymoLabelLayout = '';     
        allRec.smInfo = '';
        allRec.printXMLString = '';
        r.data.put('records', allRec);
        return r;
    }
    
    public class AllShipmentManifestDetails{
        @AuraEnabled public Shipping_Manifest__c SMrecords {get; set;} 
        @AuraEnabled public List<SMWrapper> SMWrapperList {get; set;}
        @AuraEnabled public List<CustomSelectOptions> dymoLabelLayouts {get; set;}
        @AuraEnabled public List<CustomSelectOptions> printers {get; set;}
        @AuraEnabled public Boolean isSelectedSM {get; set;} 
        @AuraEnabled public String smInfo {get; set;}
        @AuraEnabled public String imageXml {get; set;}
        @AuraEnabled public String printXMLString {get; set;}
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
    //genereting imagexml 
    @AuraEnabled
    public static AuraResponse generateImageXml(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedSM){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabelctrls.generateImageXml()');
        ShipmentManifestPrintLabelctrls.smLineDetails(recId);
        imageXml = '';
        isSelectedSM = false;
        String smInfo;
        String selectedDymoLabelLayout = layout;
        List<String> smToPrint = new List<String>();
        SMWrapperList = (List<SMWrapper>) System.JSON.deserialize(wrpJson, List<SMWrapper>.class);
        for(SMWrapper shipMWrapper : SMWrapperList){
            if(selectedDymoLabelLayout == ONEBYTWO){
                imageXml = getImage1X2Xml(shipMWrapper.SMPos);
            }
            else if(selectedDymoLabelLayout == FOURBYSIX)
            {
                imageXml = SinglegetImage4X6Xml(shipMWrapper.SMPos);   
            }else if(selectedDymoLabelLayout == TWOBYFOUR){
                 imageXml = getImage2X4Xml(shipMWrapper.SMPos);   
            }
            isSelectedSM = true;
        }
        
        if(imageXml == ''){
            isSelectedSM = false;
        }	
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.imageXml = imageXml;
        allRec.isSelectedSM = isSelectedSM;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        allRec.SMrecords = SMList2[0];  

        r.data.put('records', allRec);
        return r;
    }
    
    //genereting imagexml 
    @AuraEnabled
    public static AuraResponse printImageXml(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedSM){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabelctrls.generateImageXml()');
        ShipmentManifestPrintLabelctrls.smLineDetails(recId);
        imageXml = '';
        isSelectedSM = false;
        String smInfo;
        String selectedDymoLabelLayout = layout;
        List<String> smToPrint = new List<String>();
        SMWrapperList = (List<SMWrapper>) System.JSON.deserialize(wrpJson, List<SMWrapper>.class);
        for(SMWrapper shipMWrapper : SMWrapperList){
             if(selectedDymoLabelLayout == TWOBYFOUR){
                 imageXml = PrintImage2X4Xml(shipMWrapper.SMPos);   
            }
            isSelectedSM = true;
        }
        
        if(imageXml == ''){
            isSelectedSM = false;
        }	
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.imageXml = imageXml;
        allRec.isSelectedSM = isSelectedSM;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        allRec.SMrecords = SMList2[0];  

        r.data.put('records', allRec);
        return r;
    }
    
    
    
  // generate 2X4Xml  
      public static String PrintImage2X4Xml (Shipping_Manifest_Line__c smObject){
          
          string  SMboxval='';
          string  boxvalues;
          decimal boxval =  SMObjLight.Box_Count__c;
          Integer mysmbox = Integer.valueOf(SMObjLight.Box_Count__c);
          List<string> alltemdata = new List<string>();
          List<string>alltemp = new list<string>();
          string templates;    
			
          
          
          
          
          
          if(mysmbox !=null){
              
              
   for(integer i=1;i<= mysmbox ; i++){      
     templates = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
	'<PaperOrientation>Portrait</PaperOrientation>' +
	'<Id>Shipping</Id>' +
	'<PaperName>30323 Shipping</PaperName>' +
	'<DrawCommands>' +
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
	'</DrawCommands>' +
	'<ObjectInfo>' +
		'<ImageObject>' +
			'<Name>GRAPHIC</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<Image>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</Image> ' +
			'<ScaleMode>Uniform</ScaleMode>' +
			'<BorderWidth>0</BorderWidth>' +
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<HorizontalAlignment>Center</HorizontalAlignment>' +
			'<VerticalAlignment>Center</VerticalAlignment>' +
		'</ImageObject>' +
		'<Bounds X="86" Y="307" Width="2918" Height="5323" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="328" Y="855.000000000001" Width="2052" Height="288" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_1</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Sales_Order__r.name) ? SMObjLight.Sales_Order__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="304.000000000001" Y="1791" Width="2196" Height="300" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_2</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Receiver_DBA__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="227.999999999999" Y="2823" Width="2800" Height="360" />' +
	'</ObjectInfo>' +
      '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Delivery_City__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="376" Y="3807" Width="2388" Height="360" />' +
	'</ObjectInfo>'+
         '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+'Box Count '+ i +' of '+ mysmbox+'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'	<Bounds X="394" Y="4695.00045776367" Width="2325" Height="465" />' +
	'</ObjectInfo>'+
'</DieCutLabel>' ;   
         alltemp.add(templates);

   }  }else{
              
  templates = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
	'<PaperOrientation>Portrait</PaperOrientation>' +
	'<Id>Shipping</Id>' +
	'<PaperName>30323 Shipping</PaperName>' +
	'<DrawCommands>' +
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
	'</DrawCommands>' +
	'<ObjectInfo>' +
		'<ImageObject>' +
			'<Name>GRAPHIC</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<Image>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</Image> ' +
			'<ScaleMode>Uniform</ScaleMode>' +
			'<BorderWidth>0</BorderWidth>' +
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<HorizontalAlignment>Center</HorizontalAlignment>' +
			'<VerticalAlignment>Center</VerticalAlignment>' +
		'</ImageObject>' +
		'<Bounds X="86" Y="307" Width="2918" Height="5323" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="328" Y="855.000000000001" Width="2052" Height="288" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_1</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Sales_Order__r.name) ? SMObjLight.Sales_Order__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="304.000000000001" Y="1791" Width="2196" Height="300" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_2</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Receiver_DBA__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
      
		'<Bounds X="227.999999999999" Y="2823" Width="2800" Height="360" />' +
	'</ObjectInfo>' +
      '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Delivery_City__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="376" Y="3807" Width="2388" Height="360" />' +
	'</ObjectInfo>'+
         '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+'Box Count '+   +' of '+  +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'	<Bounds X="394" Y="4695.00045776367" Width="2325" Height="465" />' +
	'</ObjectInfo>'+
'</DieCutLabel>' ;   
alltemp.add(templates);              
   }
          system.debug('alltemp>>'+alltemp);
          string allstring = string.join(alltemp,',');
          return allstring;   
       
          }
         
    
    
    
        //genereting imagexml 
    @AuraEnabled
    public static AuraResponse generateImageXmlDynamicBoxCount(String recId,String wrpJson,String layout,String imageXml){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabelctrls.generateImageXml()');
        ShipmentManifestPrintLabelctrls.smLineDetails(recId);
        imageXml = '';
        String smInfo;
        String selectedDymoLabelLayout = layout;
        List<String> smToPrint = new List<String>();
        SMWrapperList = (List<SMWrapper>) System.JSON.deserialize(wrpJson, List<SMWrapper>.class);
        for(SMWrapper shipMWrapper : SMWrapperList){
             if(selectedDymoLabelLayout == TWOBYFOUR){
                 imageXml = getImage2X4XmlDynamicBoxCount(shipMWrapper.SMPos);   
            }
        }
        
       	
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.imageXml = imageXml;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        allRec.SMrecords = SMList2[0];  
        r.data.put('records', allRec);
        return r;
    }
    
    
          //genereting imagexml 
    @AuraEnabled
    public static AuraResponse printImageXmlDynamicBoxCount(String recId,String wrpJson,String layout,String imageXml,string boxCount){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabelctrls.generateImageXml()');
        ShipmentManifestPrintLabelctrls.smLineDetails(recId);
        imageXml = '';
        String smInfo;
        String selectedDymoLabelLayout = layout;
        List<String> smToPrint = new List<String>();
        SMWrapperList = (List<SMWrapper>) System.JSON.deserialize(wrpJson, List<SMWrapper>.class);
        for(SMWrapper shipMWrapper : SMWrapperList){
             if(selectedDymoLabelLayout == TWOBYFOUR){
                 imageXml = printImage2X4XmlDynamicBoxCount(shipMWrapper.SMPos,boxCount);   
            }
        }
        
       	
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.imageXml = imageXml;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        allRec.SMrecords = SMList2[0];  
        r.data.put('records', allRec);
        return r;
    }
    
      
     // generate 2X4Xml  
      public static String printImage2X4XmlDynamicBoxCount (Shipping_Manifest_Line__c smObject,string boxCount){
          string  SMboxval='';
          string  boxvalues;
          decimal boxval =  SMObjLight.Box_Count__c;
          Integer mysmbox = Integer.valueOf(SMObjLight.Box_Count__c);
          string templates;       
          
          string bxcnt=string.valueOf(SMObjLight.Box_Count__c);
          string bxcount;
          if(bxcnt !=null)
          {
              bxcount= bxcnt;
          }
          else{
              bxcount= '';
              
          }  
          
        
     templates = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
	'<PaperOrientation>Portrait</PaperOrientation>' +
	'<Id>Shipping</Id>' +
	'<PaperName>30323 Shipping</PaperName>' +
	'<DrawCommands>' +
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
	'</DrawCommands>' +
	'<ObjectInfo>' +
		'<ImageObject>' +
			'<Name>GRAPHIC</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<Image>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</Image> ' +
			'<ScaleMode>Uniform</ScaleMode>' +
			'<BorderWidth>0</BorderWidth>' +
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<HorizontalAlignment>Center</HorizontalAlignment>' +
			'<VerticalAlignment>Center</VerticalAlignment>' +
		'</ImageObject>' +
		'<Bounds X="86" Y="307" Width="2918" Height="5323" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="328" Y="855.000000000001" Width="2052" Height="288" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_1</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Sales_Order__r.name) ? SMObjLight.Sales_Order__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="304.000000000001" Y="1791" Width="2196" Height="300" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_2</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Receiver_DBA__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="327.999999999999" Y="2823" Width="2064" Height="360" />' +
	'</ObjectInfo>' +
      '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Delivery_City__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="376" Y="3807" Width="2388" Height="360" />' +
	'</ObjectInfo>'+
         '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+'Box Count '+boxCount +' of '+bxcount+'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'	<Bounds X="394" Y="4695.00045776367" Width="2325" Height="465" />' +
	'</ObjectInfo>'+
'</DieCutLabel>' ;   
 
 return templates;   
          
 
           
      }
   
      // generate 2X4Xml  
      public static String getImage2X4XmlDynamicBoxCount (Shipping_Manifest_Line__c smObject){
          string  SMboxval='';
          string  boxvalues;
          decimal boxval =  SMObjLight.Box_Count__c;
          Integer mysmbox = Integer.valueOf(SMObjLight.Box_Count__c);
          string bxcnt=string.valueOf(mysmbox);
          system.debug('bxcnt>>>'+bxcnt);
          string templates;   
          string bxcount;
          if(bxcnt !=null)
          {
              bxcount=bxcnt;
          }
          else{
              bxcount= '';
              
          }
        
           
     templates = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
	'<PaperOrientation>Portrait</PaperOrientation>' +
	'<Id>Shipping</Id>' +
	'<PaperName>30323 Shipping</PaperName>' +
	'<DrawCommands>' +
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
	'</DrawCommands>' +
	'<ObjectInfo>' +
		'<ImageObject>' +
			'<Name>GRAPHIC</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<Image>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</Image> ' +
			'<ScaleMode>Uniform</ScaleMode>' +
			'<BorderWidth>0</BorderWidth>' +
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<HorizontalAlignment>Center</HorizontalAlignment>' +
			'<VerticalAlignment>Center</VerticalAlignment>' +
		'</ImageObject>' +
		'<Bounds X="86" Y="307" Width="2918" Height="5323" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="328" Y="855.000000000001" Width="2052" Height="288" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_1</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Sales_Order__r.name) ? SMObjLight.Sales_Order__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="304.000000000001" Y="1791" Width="2196" Height="300" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_2</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Receiver_DBA__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="227.999999999999" Y="2823" Width="2800" Height="360" />' +
	'</ObjectInfo>' +
      '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Delivery_City__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="376" Y="3807" Width="2388" Height="360" />' +
	'</ObjectInfo>'+
         '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+'Box Count '+  +' of '+bxcount+'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'	<Bounds X="394" Y="4695.00045776367" Width="2325" Height="465" />' +
	'</ObjectInfo>'+
'</DieCutLabel>' ;   
 
 return templates;   
          
 
           
      }
    
   
    
   // generate 2X4Xml  
      public static String getImage2X4Xml (Shipping_Manifest_Line__c smObject){
          
          string  SMboxval='';
          string  boxvalues;
          decimal boxval =  SMObjLight.Box_Count__c;
          Integer mysmbox = Integer.valueOf(SMObjLight.Box_Count__c);
          
string bxval = string.valueOf(mysmbox);       
          
      system.debug('bxval>>'+bxval); 
          string LabelBoxValues;
          if(bxval !=null){
         LabelBoxValues = 'Box Count '+ 1 +' of '+ mysmbox;
          }
          else{
         LabelBoxValues='Box Count '+   +' of ';     
          }
          List<string>alltemp = new list<string>();
          string templates;   
     
     templates = '<?xml version="1.0" encoding="utf-8"?>' +
'<DieCutLabel Version="8.0" Units="twips">' +
	'<PaperOrientation>Portrait</PaperOrientation>' +
	'<Id>Shipping</Id>' +
	'<PaperName>30323 Shipping</PaperName>' +
	'<DrawCommands>' +
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
	'</DrawCommands>' +
	'<ObjectInfo>' +
		'<ImageObject>' +
			'<Name>GRAPHIC</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<Image>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</Image> ' +
			'<ScaleMode>Uniform</ScaleMode>' +
			'<BorderWidth>0</BorderWidth>' +
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<HorizontalAlignment>Center</HorizontalAlignment>' +
			'<VerticalAlignment>Center</VerticalAlignment>' +
		'</ImageObject>' +
		'<Bounds X="86" Y="307" Width="2918" Height="5323" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="328" Y="855.000000000001" Width="2052" Height="288" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_1</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+(!String.isBlank(SMObjLight.Sales_Order__r.name) ? SMObjLight.Sales_Order__r.name : '') +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="304.000000000001" Y="1791" Width="2196" Height="300" />' +
	'</ObjectInfo>' +
	'<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_2</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>False</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+ Utility.escapespecialchar(SMObjLight.Receiver_DBA__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="227.999999999999" Y="2823" Width="2800" Height="360" />' +
	'</ObjectInfo>' +
      '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+Utility.escapespecialchar(SMObjLight.Delivery_City__c) +'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'<Bounds X="376" Y="3807" Width="2388" Height="360" />' +
	'</ObjectInfo>'+
        '<ObjectInfo>' +
		'<TextObject>' +
			'<Name>TEXT_3</Name>' +
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
			'<LinkedObjectName></LinkedObjectName>' +
			'<Rotation>Rotation0</Rotation>' +
			'<IsMirrored>False</IsMirrored>' +
			'<IsVariable>False</IsVariable>' +
			'<HorizontalAlignment>Left</HorizontalAlignment>' +
			'<VerticalAlignment>Top</VerticalAlignment>' +
			'<TextFitMode>ShrinkToFit</TextFitMode>' +
			'<UseFullFontHeight>True</UseFullFontHeight>' +
			'<Verticalized>False</Verticalized>' +
			'<StyledText>' +
				'<Element>' +
					'<String>'+LabelBoxValues+'</String>' +
					'<Attributes>' +
						'<Font Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
					'</Attributes>' +
				'</Element>' +
			'</StyledText>' +
		'</TextObject>' +
		'	<Bounds X="394" Y="4695.00045776367" Width="2325" Height="465" />' +
	'</ObjectInfo>'+
'</DieCutLabel>' ; 
   
 return templates;   
          
  
           
      }
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     // generate 4X6Xml  
    public static String  SinglegetImage4X6Xml(Shipping_Manifest_Line__c smObject){
        
        String productDetails = '';
        String productDetails2 = '';
        Integer col1PositionActual = 4200;
        Integer col2PositionActual = 3980;
        Integer col3PositionActual = 4200;
        Integer col4PositionActual = 4470;
        Integer HorilinePositionActual = 4850;
        Integer VertlinePositionActual = 4000;
        Integer col1Position = 0;
        Integer col2Position = 0;
        Integer col3Position = 0;
        Integer col4Position = 0;
        Integer HorilinePosition = 0;
        Integer VertlinePosition = 0;
        SMWrapperList2 = new List<Shipping_Manifest_Line__c>();
        for(SMWrapper shipMWrapper : SMWrapperList){
            if(shipMWrapper.isSelected== true)
            {
                SMWrapperList2.add(shipMWrapper.SMPos);
                
            }     
        }
        Integer TotalPages=0;
        Integer pagerecord;
        List<String> printLabelList = new List<String>();  
        Integer totalRecInCurrentPage = 1;
        Integer currentRecInCurrentPage =1;
        Integer totalrecords = SMWrapperList2.size();
        Integer currentPage = 1;
        Integer currentRecord = 1;
        String secondPageString = '';
        String firstPageString = '';
        Integer modval = math.mod(totalrecords, 9);
        if(totalrecords >= 5)
        {
            if(modval < =5)
            {
                TotalPages = (totalrecords/9)+1; 
            }
            else if(modval >= 6)
            {
                TotalPages = (totalrecords/9)+2; 
            } 
        }
        else
        {
            TotalPages =1; 
            
        }         
        for( Integer i=0;i < totalrecords; i++) {
            if(currentPage == 1 && totalRecords < 5) 
            {  totalRecInCurrentPage = totalrecords;
                                                    
            }
            else if(currentPage == 1 &&  totalRecords >= 5){
                totalRecInCurrentPage = 5;
                
            } 
            else if(currentPage < totalPages && currentPage != 1 ) {
                totalRecInCurrentPage = 9; 
                
            } 
            else if(currentPage == totalPages ) {
                
                totalRecInCurrentPage= math.mod((totalRecords - 5), 9);
                if(totalRecInCurrentPage ==0)
                {
                    totalRecInCurrentPage = 9;
                }
            }
            if(currentPage == 1 ) {
                col1Position = (i*1000)+col1PositionActual;
                col2Position = (i*1000)+col2PositionActual;
                col3Position = (i*1000)+col3PositionActual;
                col4Position = (i*1000)+col4PositionActual;
                HorilinePosition = (i*1000)+HorilinePositionActual;
                VertlinePosition = (i*1000)+VertlinePositionActual;
                string smQTY;
                decimal mysmQTYval;
                decimal IQty = SMWrapperList2[i].Shipment_Qty__c;
                Integer mysmQTY = Integer.valueOf(SMWrapperList2[i].Shipment_Qty__c );
                if(mysmQTY ==IQty)
                {
                    mysmQTYval = Integer.valueOf(SMWrapperList2[i].Shipment_Qty__c );
                    smQTY =string.valueof(mysmQTY);
                }
                else
                {
                    mysmQTYval = SMWrapperList2[i].Shipment_Qty__c;
                    smQTY =String.valueof(mysmQTYval);
                    String afterDecimal = smQTY.substringAfter('.');
                    if( afterDecimal != null && afterDecimal.length()==1)
                    {
                        smQTY =String.valueof(mysmQTYval)+0;    
                    }
                    else
                    {
                        smQTY =String.valueof(mysmQTYval);   
                    }
                    
                }
                
                string product = SMWrapperList2[i].Product_Name__r.Name;
                string productval;
                if(product != null && product.containsAny('&'))
                {
                    productval = product.replace('&','&amp;');  
                    
                }
                else
                {
                    productval = product; 
                    
                }
                string Batch = SMWrapperList2[i].Harvest_Batch_Code__c;
                string Batchval;
                if(Batch != null &&  Batch.containsAny('&'))
                {
                    Batchval = Batch.replace('&','&amp;');  
                    
                }
                else
                {
                    Batchval = Batch; 
                    
                } 
               String UID_1 = '';
        if(SMWrapperList2[i].UID_1__c !=null)
        {
            UID_1 = UID_1+'<ObjectInfo>' +
                    '<BarcodeObject>' +
                    ' <Name>UID__'+(i+5)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>True</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<Text>'+(!String.isBlank(SMWrapperList2[i].UID_1__c ) ? SMWrapperList2[i].UID_1__c : '')+'</Text>' +
                    '<Type>Code128Auto</Type>' +
                    '<Size>Small</Size>' +
                    '<TextPosition>Bottom</TextPosition>' +
                    '<TextFont Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                    '<CheckSumFont Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                    '<TextEmbedding>None</TextEmbedding>' +
                    '<ECLevel>0</ECLevel>' +
                    '<HorizontalAlignment>Center</HorizontalAlignment>' +
                    '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
                    '</BarcodeObject>' +
                    '<Bounds X="1800.39371355903" Y="'+col4Position+'" Width="3700.96856779517" Height="380.021978021978" />' +
                    '</ObjectInfo>' ;
        }  
                
              
                productDetails = productDetails +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    '<Name>Qty_'+(i+1)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(smQTY) ? smQTY : '')+'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="250.703564727955"  Y="'+col1Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">Product</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col2Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(productval) ? productval : '')+'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="1800.27499329938" Y="'+col2Position+'" Width="2000.1811406771" Height="287.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>BatchID__'+(i+3)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">BatchID</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col3Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>BatchID__'+(i+3)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(Batchval ) ? Batchval : '')  +'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="1800.15753949019" Y="'+col3Position+'" Width="4000.0945128808" Height="250.018348623853" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>UID__'+(i+5)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">UID</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col4Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                   UID_1+
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>HorizontalLine</ShapeType>' +
                    '<LineWidth>15</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="170" Y="'+HorilinePosition+'" Width="5500" Height="30" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE_1</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>VerticalLine</ShapeType>' +
                    '<LineWidth>15</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="150" Y="317" Width="15" Height="500" />' +
                    '</ObjectInfo>'  +
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE_2</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>VerticalLine</ShapeType>' +
                    '<LineWidth>45</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="1000" Y="'+VertlinePosition+'" Width="30" Height="800" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+ currentPage + ' of ' + totalPages +'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="5280" Y="8645.1811406771" Width="2000.1811406771" Height="200.009380863038" />' +
                    '</ObjectInfo>';
            }  
            else if(currentPage <= totalPages && currentPage != 1 ){
                Integer col1PositionActualoff = 795;
                Integer col2PositionActualoff = 495;
                Integer col3PositionActualoff = 735;
                Integer col4PositionActualoff = 945;
                Integer HorilinePositionActualoff = 1400;
                Integer VertlinePositionActualoff = 570;
                
                col1Position = ((currentRecInCurrentPage-1)*950)+col1PositionActualoff;
                col2Position = ((currentRecInCurrentPage-1)*950)+col2PositionActualoff;
                col3Position = ((currentRecInCurrentPage-1)*950)+col3PositionActualoff;
                col4Position = ((currentRecInCurrentPage-1)*950)+col4PositionActualoff;
                HorilinePosition = ((currentRecInCurrentPage-1)*950)+HorilinePositionActualoff;
                VertlinePosition = ((currentRecInCurrentPage-1)*950)+VertlinePositionActualoff;
                string smQTY;
                decimal mysmQTYval;
                decimal IQty = SMWrapperList2[i].Shipment_Qty__c;
                Integer mysmQTY = Integer.valueOf(SMWrapperList2[i].Shipment_Qty__c );
                if(mysmQTY ==IQty)
                {
                    mysmQTYval = Integer.valueOf(SMWrapperList2[i].Shipment_Qty__c ); smQTY =string.valueof(mysmQTY);
                }
                else
                {
                 mysmQTYval = SMWrapperList2[i].Shipment_Qty__c;
                 smQTY =String.valueof(mysmQTYval);
                 String afterDecimal = smQTY.substringAfter('.');
                 if(afterDecimal.length()==1) 
                  {
                        smQTY =String.valueof(mysmQTYval)+0;    
                  }
                  else
                  {
                        smQTY =String.valueof(mysmQTYval);   
                 }
                }
                string product = SMWrapperList2[i].Product_Name__r.Name;
                string productval;
                if(product != null && product.containsAny('&'))
                {
                    productval = product.replace('&','&amp;');  
                    
                }
                else
                {
                    productval = product; 
                    
                }
                string Batch = SMWrapperList2[i].Harvest_Batch_Code__c;
                string Batchval;
                if(Batch != null &&  Batch.containsAny('&'))
                {
                    Batchval = Batch.replace('&','&amp;');  
                    
                }
                else
                {
                    Batchval = Batch; 
                    
                } 
                
               String UID_2 = '';
        if(SMWrapperList2[i].UID_1__c !=null)
        {
            UID_2 = UID_2+ '<ObjectInfo>' +
                    '<BarcodeObject>' +
                    ' <Name>UID__'+(i+5)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>True</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<Text>'+(!String.isBlank(SMWrapperList2[i].UID_1__c ) ? SMWrapperList2[i].UID_1__c : '')+'</Text>' +
                    '<Type>Code128Auto</Type>' +
                    '<Size>Small</Size>' +
                    '<TextPosition>Bottom</TextPosition>' +
                    '<TextFont Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                    '<CheckSumFont Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                    '<TextEmbedding>None</TextEmbedding>' +
                    '<ECLevel>0</ECLevel>' +
                    '<HorizontalAlignment>Center</HorizontalAlignment>' +
                    '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
                    '</BarcodeObject>' +
                    '<Bounds X="1800.39371355903" Y="'+col4Position+'" Width="3700.96856779517" Height="380.021978021978" />' +
                    '</ObjectInfo>' ;
        }  
                  
                
                
                
                
                productDetails2 = productDetails2 +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    '<Name>Qty_'+(i+1)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(smQTY) ? smQTY : '')+'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="250.703564727955"  Y="'+col1Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">Product</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col2Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(productval) ? productval : '')+'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="1800.27499329938" Y="'+col2Position+'" Width="2000.1811406771" Height="287.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>BatchID__'+(i+3)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">BatchID</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col3Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>BatchID__'+(i+3)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+(!String.isBlank(Batchval ) ? Batchval : '')  +'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="1800.15753949019" Y="'+col3Position+'" Width="4000.0945128808" Height="250.018348623853" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>UID__'+(i+5)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">UID</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Arial" Size="7" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds  X="1100.703564727955"  Y="'+col4Position+'" Width="759.635486464756" Height="387.009380863038" />' +
                    '</ObjectInfo>' +
                    UID_2+
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>HorizontalLine</ShapeType>' +
                    '<LineWidth>15</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="170" Y="'+HorilinePosition+'" Width="5605" Height="30" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE_1</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>VerticalLine</ShapeType>' +
                    '<LineWidth>15</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="150" Y="317" Width="10" Height="500" />' +
                    '</ObjectInfo>'  +
                    '<ObjectInfo>' +
                    '<ShapeObject Stroke="SolidLine">' +
                    '<Name>SHAPE_2</Name>' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<ShapeType>VerticalLine</ShapeType>' +
                    '<LineWidth>45</LineWidth>' +
                    '<LineAlignment>Center</LineAlignment>' +
                    '<FillColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '</ShapeObject>' +
                    '<Bounds X="1000" Y="'+VertlinePosition+'" Width="30" Height="800" />' +
                    '</ObjectInfo>' +
                    '<ObjectInfo>' +
                    '<TextObject>' +
                    ' <Name>Product__'+(i+2)+'</Name> ' +
                    '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                    '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                    '<LinkedObjectName />' +
                    '<Rotation>Rotation0</Rotation>' +
                    '<IsMirrored>False</IsMirrored>' +
                    '<IsVariable>False</IsVariable>' +
                    '<GroupID>-1</GroupID>' +
                    '<IsOutlined>False</IsOutlined>' +
                    '<HorizontalAlignment>Left</HorizontalAlignment>' +
                    '<VerticalAlignment>Top</VerticalAlignment>' +
                    '<TextFitMode>ShrinkToFit</TextFitMode>' +
                    '<UseFullFontHeight>True</UseFullFontHeight>' +
                    '<Verticalized>False</Verticalized>' +
                    ' <StyledText> ' +
                    ' <Element> '+
                    ' <String xml:space="preserve">'+ currentPage + ' of ' + totalPages +'</String> ' +
                    ' <Attributes> '+
                    ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                    ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
                    ' </Attributes> ' +
                    ' </Element> '+
                    ' </StyledText> ' +
                    '</TextObject>' +
                    '<Bounds X="5350.27499329938" Y="8645.1811406771" Width="2000.1811406771" Height="200.009380863038" />' +
                    '</ObjectInfo>';
            }
            if (currentRecInCurrentPage == totalRecInCurrentPage) {
                if(currentPage == 1 && productDetails != '') {
                    firstPageString = buildFirstPageXML(smObject, productDetails);
                    printLabelList.add(firstPageString);
                }
                if(currentPage > 1 && productDetails2 != '') {
                    secondPageString = buildSecondPageXMLs(productDetails2);
                    printLabelList.add(secondPageString);
                    productDetails2 = '';
                }
                currentPage++;
                currentRecInCurrentPage = 0;
                totalRecInCurrentPage = 0;
            }
            currentRecInCurrentPage++;
            currentRecord ++;	
        }
        string conCatLabel ='';
        conCatLabel =  String.join(printLabelList, '%endslabel%'); 
        string orderbySingleLable = conCatLabel.replace( '%endslabel%' , '%%%' );      
        return conCatLabel;
    } 
    //used to creating firstpagexml 
    public static String buildFirstPageXML(Shipping_Manifest_Line__c smObject, String productDetails){
        String firstPageXML = '';
        string  SMboxval='';
        decimal boxval =  SMObjLight.Box_Count__c;
        Integer mysmbox = Integer.valueOf(SMObjLight.Box_Count__c);
        SMboxval =string.valueof(mysmbox);
        string Reciver = SMObjLight.Receiver_DBA__c;
        string Reciverval;
        if(Reciver != null && Reciver.containsAny('&'))
        {
            Reciverval = Reciver.replace('&','&amp;');  
        }
        else
        {
            Reciverval = Reciver; 
        }
        string Recivercon = SMObjLight.Receiver_Contact__r.Name;
        string Reciverconval;
        if(Recivercon != null &&  Recivercon.containsAny('&'))
        {
            Reciverconval = Recivercon.replace('&','&amp;'); 
        }
        else
        {
            Reciverconval = Recivercon; 
        }
        
        string Addres = +SMObjLight.Site__r.License_ID__r.License_Number__c +
            '\n'+SMObjLight.Site__r.License_ID__r.License_Address__c +'\n'+SMObjLight.Site__r.License_ID__r.License_City__c+
            '\n'+SMObjLight.Site__r.License_ID__r.License_State__c+',' +SMObjLight.Site__r.License_ID__r.License_Zip__c;
        
        string shipAddres ='\n'+Reciverval +   
            '\n' +SMObjLight.Receiver_License__r.License_Address__c+
            '\n'+SMObjLight.Receiver_License__r.License_City__c+'\n'+SMObjLight.Receiver_License__r.License_State__c+
            ','+SMObjLight.Receiver_License__r.License_Zip__c	; 
        string Address =Addres;
        string Addressval;
        if(Address != null &&  Address.containsAny('&'))
        {
            Addressval = Address.replace('&','&amp;');  
            
        }
        else
        {
            Addressval = Address; 
        }
        
        string shipAddress =shipAddres;
        string shipAddressval;
        if(shipAddress != null && shipAddress.containsAny('&'))
        {
            shipAddressval = shipAddress.replace('&','&amp;'); 
        }
        else
        {
            shipAddressval = shipAddress; 
        }
        
           String Metrc = '';
        if(SMObjLight.Metrc_Manifest__c !=null)
        {
            Metrc = Metrc+'<ObjectInfo>' +
            '<BarcodeObject>' +
            '<Name>BARCODE_1</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>True</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Text>'+ (!String.isBlank(SMObjLight.Metrc_Manifest__c) ? SMObjLight.Metrc_Manifest__c : '') +'</Text> ' +	            
            '<Type>Code128Auto</Type>' +
            '<Size>Small</Size>' +
            '<TextPosition>Bottom</TextPosition>' +
            '<TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<TextEmbedding>None</TextEmbedding>' +
            '<ECLevel>0</ECLevel>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
            '</BarcodeObject>' +
            '<Bounds X="100" Y="3290" Width="2610" Height="410"/>' +
            '</ObjectInfo>' ;
        }
        
        
           String Order = '';
        if(SMObjLight.Order_Number__r.name !=null)
        {
            Order = Order+ '<ObjectInfo>' +
            '<BarcodeObject>' +
            '<Name>Invoice_Number</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>True</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Text>'+(!String.isBlank(SMObjLight.Order_Number__r.name) ? SMObjLight.Order_Number__r.name : '') +'</Text> ' +
            '<Type>Code128Auto</Type>' +
            '<Size>Small</Size>' +
            '<TextPosition>Bottom</TextPosition>' +
            '<TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<TextEmbedding>None</TextEmbedding>' +
            '<ECLevel>0</ECLevel>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
            '</BarcodeObject>' +
            '<Bounds X="900" Y="1900"  Width="2599" Height="400" />' +
            '</ObjectInfo>' ;
        }
        
            String ReceiverLicense = '';
        if(SMObjLight.Receiver_License_Number__c !=null)
        {
            ReceiverLicense = ReceiverLicense+ '<ObjectInfo>' +
            '<BarcodeObject>' +
            '<Name>License_Number</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>True</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
         
          '<Text>'+ (!String.isBlank(SMObjLight.Receiver_License_Number__c) ? SMObjLight.Receiver_License_Number__c : '') +'</Text> ' +
            '<Type>Code128Auto</Type>' +
            '<Size>Small</Size>' +
            '<TextPosition>Bottom</TextPosition>' +
            '<TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<CheckSumFont Family="Arial" Size="6" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<TextEmbedding>None</TextEmbedding>' +
            '<ECLevel>0</ECLevel>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
            '</BarcodeObject>' +
            '<Bounds X="900" Y="2600" Width="3360" Height="400" />' +
            '</ObjectInfo>' ;
        }
        
        
        firstPageXML = ' <DieCutLabel Version="8.0" Units="twips"> '+
            ' <PaperOrientation>Portrait</PaperOrientation> ' +
            ' <Id>Shipping4x6</Id> '+
            ' <IsOutlined>false</IsOutlined> ' +
            ' <PaperName>1744907 4 in x 6 in</PaperName> '+
            ' <DrawCommands> ' +
            ' <RoundRectangle X="0" Y="0" Width="5918.4" Height="9038.4" Rx="270" Ry="270" /> '+
            ' </DrawCommands> ' +
            '<ObjectInfo>' +
            '<ImageObject>' +
            '<Name>GRAPHIC</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Image>iVBORw0KGgoAAAANSUhEUgAAAYAAAAJACAIAAAALpSbBAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA0ppVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQ1IDc5LjE2MzQ5OSwgMjAxOC8wOC8xMy0xNjo0MDoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6ODAzNjAzNTNERkEyMTFFQjk5RENBRjRDMzJBNkI5NDMiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6ODAzNjAzNTJERkEyMTFFQjk5RENBRjRDMzJBNkI5NDMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo2ZmIwY2JhZC0wYzcxLWI2NDYtODdmYi01YWJiZDM4OTkxYjgiIHN0UmVmOmRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo2ZmIwY2JhZC0wYzcxLWI2NDYtODdmYi01YWJiZDM4OTkxYjgiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+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BAhAgAABAhAgQIAABAgQIECAHAJAgAABAlhXmupvxGIxR6QR+EI77EZAgAABbAhTsFKp5IjAWpp5Neb31/gTzybnB6xVXtdNwQABAhAgYJMJUL4tNqCls89RBdZRgEJ9Utl0rlSRSxc6Em35/ipVlwDWToDyC7NRMnNea/VW63mZZJRdmO/rbElloyibChHq7GypjYv6BpYAXn+A+pb1RlHz1Piw1fH2nlw6isoDo672mXOShY7Lw2CoeH8hOWdm3FEH1kiA4lObo6h32bijmnj7vHR5WBQGS/oDrMEpWGJaMip0L6oVKH95R2FwQjagdXYoUCpMykaOlQABeu1DoPaeYibqSFTfAytf+BkSndqF6PKNID271SEH+sVKpdKa/V2V/nfFuoa0pq+zJdE9p9jTbgQEDZWYcfOy5gM0ZpV6M/oDArQeAgQI0Mh7/SoGsN4IECBAgAABCBAgQAACBAgQgAABAgQgQIAAAQgQIEAAAgQIEIAAAQIECBCAAAECBCBAgAABCBAgQAACBAgQgAABAgQgQIAAAQgQIEAAAgQIECBAAAIECBCAAAECBCBAgAABCBAgQAACBAgQgAABAgQgQIAAAQIEIECAAAEIECBAAAIECBCAAAECBCBAgAABCBAgQAACBAgQgAABAgQIEIAAAQIEIECAAAEIECBAAAIECBCAAAECBCBAgAABCBAgQIAAAQgQIEAAAtQobrnllsWLFzsOCBDrwcqVK4855hjHgQYUK5VKsViseiMsOyLAmkzMuHkxAgJMwQABAhAgQIAABAgQIAABAgQIQIAAAQIQIECAAAQIECAAAQIECBAgAAECBAhAgAABAhAgQIAABAgQIAABAgQIQIAAAQIQIECAAAQIECBAgAAECBAgAAECBAhAgAABAhAgQIAABAgQIAABAgQIQIAAAQIECECAAAECECBAgAAECBAgAAECBAhAgAABAhAgQIAABAgQIAABAgQIECAAAQIECECAAAECECBAgAAECBAgAAECBAhAgAABAhAgQIAAAQIQIECAAAQIECAAAQIECECAAAECECBAgAAECBAgAAECBAhAgAABAgQIQIAAAQIQIECAAAQIECAAAQIECECAAAECECBAgAAECBAgQIAcAkCAAAECECBAgAAECBAgAAECBAhAgAABAhAgQIAABAgQIAABAgQIECAAAQIECECAAAECECBAgAAECBAgAAECBAhAgAABAhAgQIAABAgQIECAAAQIECAAAQIECECAAAECECBAgAAECBAgAAECBAhAgAABAgQIQIAAAQIQIECAAAQIECAAAQIECECAAAECECBAgAAECBAgAAECBAgQIAABAgQIQIAAAQIQIECAAAQIECAAAQIECECAAAECECBAgAABAhAgQIAABAgQIAABAgQIQIAAAQIQIECAAAQIECAAAQIECECAAAECBAhAgAABAhAgQIAABAgQIAABAgQIQIAAAQIQIECAAAQIECBAgAAECBAgAAECBAhAgAABAhAgQIAABAgQIAABAgQIYAxN9TdisZgjAhgBAQIEsNb8vwADAEbOVvzmZxgUAAAAAElFTkSuQmCC</Image>'+
            '<ScaleMode>Fill</ScaleMode>' +
            '<BorderWidth>0</BorderWidth>' +
            '<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Center</VerticalAlignment>' +
            '</ImageObject>' +
            '<Bounds X="117.541346976144" Y="317" Width="5686.99523838971" Height="8640" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Sender_Address</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Top</VerticalAlignment>' +
            '<TextFitMode>AlwaysFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            '<Element>' +
            '<String xml:space="preserve">' +(!String.isBlank(Addressval) ? Addressval : '')  + '</String>' +
            '<Attributes>' +
            '<Font Family="Calibri" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +            
            '</TextObject>' +
            '<Bounds X="226" Y="777" Width="2700" Height="900"/>' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>SHIPTO</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Top</VerticalAlignment>' +
            '<TextFitMode>AlwaysFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            ' <StyledText> '+
            ' <Element> ' +
            ' <String xml:space="preserve">'+shipAddressval+  ' </String> '+
            ' <Attributes> ' +
            ' <Font Family="Calibri" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" /> '+
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> ' +
            ' </Attributes> '+
            ' </Element> ' +
            ' </StyledText> '+
            '</TextObject>' +
           '<Bounds X="2890" Y="580"  Width="2750" Height="1150"/>' +

            '</ObjectInfo>' +
           Order +
            Metrc+
            ReceiverLicense +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Attention</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Top</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            ' <StyledText> ' +
            ' <Element> '+
            ' <String xml:space="preserve">'+(!String.isBlank(Reciverconval) ? Reciverconval : '') +'</String> ' +
            ' <Attributes> '+
            ' <Font Family="Calibri" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
            ' </Attributes> ' +
            ' </Element> '+
            ' </StyledText> ' +
            '</TextObject>' +
            '<Bounds X="2700" Y="3300" Width="1580" Height="390" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Attention</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Top</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            ' <StyledText> ' +
            ' <Element> '+
            ' <String xml:space="preserve">'+(!String.isBlank(SMboxval) ?SMboxval : '') +'</String> ' +
            ' <Attributes> '+
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
            ' </Attributes> ' +
            ' </Element> '+
            ' </StyledText> ' +
            '</TextObject>' +
            '<Bounds X="4700" Y="3300" Width="2055" Height="345" />' +
            '</ObjectInfo>' +
            //This place to add
            productDetails +
            ' </DieCutLabel> ' ;  
        return firstPageXML;
        
    }
    
    public static String buildSecondPageXMLs(String productDetails2) {
        string secondPageOnwards =' <DieCutLabel Version="8.0" Units="twips"> '+
            ' <PaperOrientation>Portrait</PaperOrientation> ' +
            ' <Id>Shipping4x6</Id> '+
            ' <IsOutlined>false</IsOutlined> ' +
            ' <PaperName>1744907 4 in x 6 in</PaperName> '+
            ' <DrawCommands> ' +
            ' <RoundRectangle X="0" Y="0" Width="5918.4" Height="9038.4" Rx="270" Ry="270" /> '+
            ' </DrawCommands> ' +
            '<ObjectInfo>' +
            '<ImageObject>' +
            '<Name>GRAPHIC</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Image>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</Image>' +
            '<ScaleMode>Fill</ScaleMode>' +
            '<BorderWidth>0</BorderWidth>' +
            '<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Center</VerticalAlignment>' +
            '</ImageObject>' +
            '<Bounds X="117.541346976144" Y="317" Width="5686.99523838971" Height="8640" />' +
            '</ObjectInfo>' +
            productDetails2 +
            ' </DieCutLabel> ';  
        return secondPageOnwards;
    }
    
    
    
     public static string escapespecialchar(string data){
        system.debug('data>>'+data);
         string datavalues;
              if(data != null && data.containsAny(','))
        {
            datavalues = data.replace(',','&#44;');  
        }
        else
        {
            datavalues = data; 
            
        }
              if(data != null && data.containsAny('&'))
        {
            datavalues = data.replace('&','&amp;');  
        }
        else
        {
            datavalues = data; 
            
        }
        system.debug('datavalues>>'+datavalues);
     return  datavalues;
    }
    
    // generate 1X2Xml  
    public static String  getImage1X2Xml (Shipping_Manifest_Line__c smObject){
        
        
       
        
        String template = '<?xml version="1.0" encoding="utf-8"?>' +
            '<DieCutLabel Version="8.0" Units="twips">' +
            '<PaperOrientation>Landscape</PaperOrientation>' +
            '<Id>Address</Id>' +
            '<IsOutlined>false</IsOutlined>' +
            '<PaperName>30252 Address</PaperName>' +
            '<DrawCommands>' +
            '<RoundRectangle X="0" Y="0" Width="1581" Height="5040" Rx="270" Ry="270" />' +
            '</DrawCommands>' +
            '<ObjectInfo>' +
            '<ImageObject>' +
            '<Name>GRAPHIC</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Image>iVBORw0KGgoAAAANSUhEUgAAAOkAAABxCAIAAAC/YBOaAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAFHSURBVHhe7dKxEYAwEAPBN/33bAJcACHH7CZSATcAAC+sszN77/Pgw9Y60V7PQI52qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2qdIuVdqlSrtUaZcq7VKlXaq0S5V2AQD4r5kbvZkD1sCnRk4AAAAASUVORK5CYII=</Image> ' +
            '<ScaleMode>Fill</ScaleMode>' +
            '<BorderWidth>0</BorderWidth>' +
            '<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Center</VerticalAlignment>' +
            '</ImageObject>' +
            '<Bounds X="331" Y="95.2785438499724" Width="4600.98014340872" Height="1397.72145615003" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            ' <Name>Product</Name> ' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Top</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            ' <StyledText> ' +
            ' <Element> '+
            ' <String xml:space="preserve">METRC #</String> ' +
            ' <Attributes> '+
            ' <Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
            ' </Attributes> ' +
            ' </Element> '+
            ' </StyledText> ' +
            '</TextObject>' +
            '<Bounds X="550.27499329938" Y="200" Width="3000.1811406771" Height="387.009380863038" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<BarcodeObject>' +
            '<Name>BARCODE_1</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>True</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Text>' +(!String.isBlank(SMObjLight.Metrc_Manifest__c) ? SMObjLight.Metrc_Manifest__c : '')  +'</Text> ' +	            
            '<Type>Code128Auto</Type>' +
            '<Size>Small</Size>' +
            '<TextPosition>Bottom</TextPosition>' +
            '<TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<TextEmbedding>None</TextEmbedding>' +
            '<ECLevel>0</ECLevel>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
            '</BarcodeObject>' +
            '<Bounds X="1250" Y="600.87286823552" Width="2659.60634050754" Height="457.756097560975" />' +
            '</ObjectInfo>' +
            '</DieCutLabel>';
        return template;       
    }
    
    public Class SMWrapper
    {
        @AuraEnabled public boolean isSelected {get;set;}
        @AuraEnabled public Shipping_Manifest_Line__c SMPos {get;set;}
        @AuraEnabled Public Integer qtyToAdjust{get; set;}
        
        public SMWrapper(boolean isSelected, Shipping_Manifest_Line__c SMPosObj)
        {
            this.isSelected = isSelected;
            this.SMPos = SMPosObj;
            this.qtyToAdjust= 0;
        }
    }
}