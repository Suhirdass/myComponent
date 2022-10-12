/**************************************************************************************
Apex Class Name    : ShipmentManifestPrintLabel 
Test Class Name    :ShipmentManifestPrintLabelTest
Created Date       : July 20 2020
Function           : Used to generate Labels for Shipping Manifest related Shipping ManifestLine.
Developer          :Saranya

*******************************************************************************/

public class ShipmentManifestPrintLabel {
    
   @TestVisible private static String ONEBYTWO = '1 X 2';
    @TestVisible private static String FOURBYSIX = '4 X 6';
    public static List<CustomSelectOptions> options;
    public static List<CustomSelectOptions> optionPrinter;
    public static List<SMWrapper> SMWrapperList;
    public static List <String>lst = new List <String>();
    public static String finnalLabelPrint ='';
    public static String  totaltemplate;
     public static String  finalbatch;
    @AuraEnabled
    public static AuraResponse smDetails(String recId){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabel.smDetails()');
        SMWrapperList = new List<SMWrapper>();
        List<Shipping_Manifest__c> SMList = [select Name, Order_Number__c, Brand_Quote__r.Name, Receiver_DBA__c,Box_Count__c, Total_Price__c, Order_Number__r.name,Supplier_DBA__c,Supplier_Name__c,Supplier_Name__r.name,
                                             Ship_Confirmation_Date__c,  Metrc_Manifest__c, Receiver_Address__c, Receiver_City_State_Zip__c,Supplier_License__r.name,Supplier_License__c,
                                             Receiver_First_Name__c, Receiver_Contact__r.MailingPostalCode, Receiver_Contact__r.MailingState, 
                                             Receiver_Contact__r.Name, Receiver_Contact__r.MailingStreet, Receiver_Contact__r.MailingAddress,Receiver_License_Number__c, 
                                             Receiver_Contact__r.MailingCity, Receiver_Contact__r.MailingCountry, Sales_Order__c, Sales_Order__r.Name,
                                             Sales_Order__r.Total_Line_Items__c, Site__r.License_ID__r.License_Number__c, Receiver_License__r.License_City__c,Receiver_License__c,
                                             Site__r.License_ID__r.License_Address__c, Site__r.License_ID__r.License_City__c,Receiver_License__r.License_Zip__c,Receiver_License__r.License_State__c,Receiver_License__r.License_Address__c,
                                             Site__r.License_ID__r.License_State__c,Site__r.License_ID__r.License_Zip__c, id from 
                                             Shipping_Manifest__c where Id =: recId];
        
        for(Shipping_Manifest__c sm:SMList) {
            SMWrapper smWrap = new SMWrapper(false, sm);
            SMWrapperList.add(smWrap);
        }
        
        options = new List<CustomSelectOptions>();
        options.add(new CustomSelectOptions('', 'Select Layout'));
      options.add(new CustomSelectOptions(ONEBYTWO, ONEBYTWO));
        options.add(new CustomSelectOptions(FOURBYSIX, FOURBYSIX));
        optionPrinter = new List<CustomSelectOptions>();
        optionPrinter.add(new CustomSelectOptions('', 'Select Printer'));
        
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.dymoLabelLayouts = options;
        allRec.printers = optionPrinter;
        allRec.selectedDymoLabelLayout = '';     
        allRec.smInfo = '';
        allRec.printXMLString = '';
        r.data.put('records', allRec);
        
        return r;
    }
    
    public class AllShipmentManifestDetails{
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
    
        // Generate Shipment Manifest info as image to print

    @AuraEnabled
    public static AuraResponse generateImageXml(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedSM){
        AuraResponse r = new AuraResponse('ShipmentManifestPrintLabel.generateImageXml()');
        ShipmentManifestPrintLabel.smDetails(recId);
        imageXml = '';
        isSelectedSM = false;
        String smInfo;
        String selectedDymoLabelLayout = layout;
        List<String> smToPrint = new List<String>();
    
        
        SMWrapperList = (List<SMWrapper>) System.JSON.deserialize(wrpJson, List<SMWrapper>.class);
        system.debug('SMWrapperList.......'+SMWrapperList);
        for(SMWrapper shipMWrapper : SMWrapperList){
            if(selectedDymoLabelLayout == ONEBYTWO){
                imageXml = getImage1X2Xml(shipMWrapper.SMPos);
            }else if(selectedDymoLabelLayout == FOURBYSIX){
                imageXml = getImage4X6Xml(shipMWrapper.SMPos);
            }
            isSelectedSM = true;
            smToPrint.add(imageXml);
        }
        smInfo = JSON.serialize(smToPrint);
        if(imageXml == ''){
            isSelectedSM = false;
        }	
        
        AllShipmentManifestDetails allRec = new AllShipmentManifestDetails();      
        allRec.SMWrapperList = SMWrapperList;
        allRec.imageXml = imageXml;
        allRec.smInfo = smInfo;
        allRec.isSelectedSM = isSelectedSM;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        r.data.put('records', allRec);
        
        return r;
    }
 // Binding value into xml image 4X6Xml 
    public static   String  getImage4X6Xml(Shipping_Manifest__c smObject){
           
        List <Shipping_Manifest_Line__c> SMlineList = [SELECT Product_Name__r.Name, Harvest_Batch_Code__c,Product_Name__c, Shipment_Qty__c, UID__c, Batch_ID__c,UID_1__c,  
                                                       id from Shipping_Manifest_Line__c where Shipping_Manifest__c =: smObject.Id  and SMLine_Status__c != 'Cancelled' and SMLine_Status__c !='Rejected' and Shipment_Qty__c!=0   ORDER BY name];
        
       
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
        Integer TotalPages=0;
        Integer pagerecord;
        Integer Limitlst = (SMlineList.size()-5);     
        List<String> printLabelList = new List<String>();  
        Integer totalRecInCurrentPage = 1;
        Integer currentRecInCurrentPage =1;
        Integer totalrecords = SMlineList.size();
        system.debug('totalrecords>>'+totalrecords);
        Integer currentPage = 1;
        Integer currentRecord = 1;
        String secondPageString = '';
        String firstPageString = '';
         Integer modval = math.mod(totalrecords, 9);
      system.debug('modval>>'+modval);
       
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
                              
                if(currentPage == 1 && totalRecords < 5) {
                    totalRecInCurrentPage = totalrecords;
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
                                string batch = string.valueOf(SMlineList[i].Harvest_Batch_Code__c);

               		/*Integer mysmQTY = Integer.valueOf(SMlineList[i].Shipment_Qty__c);*/
   						 string smQTY;
                            
                     String mysmQTYvalue = '';

                 decimal mysmQTYval;
     decimal IQty = SMlineList[i].Shipment_Qty__c;
       Integer mysmQTY = Integer.valueOf(SMlineList[i].Shipment_Qty__c );
                smQTY =string.valueof(mysmQTY);
             system.debug('mysmQTY>>'+mysmQTY);
     if(mysmQTY ==IQty)
     {
                  system.debug('mysmQTYvalif'); 

           mysmQTYval = Integer.valueOf(SMlineList[i].Shipment_Qty__c );
                         smQTY =string.valueof(mysmQTYval);

      system.debug('mysmQTYval'+mysmQTYval);   
     }
    else
    {
         system.debug('mysmQTYvalelse'); 
          mysmQTYval = SMlineList[i].Shipment_Qty__c;
              system.debug('mysmQTYval'+mysmQTYval); 
   smQTY =string.valueof(mysmQTYval);


        
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
										' <String xml:space="preserve">' +(!String.isBlank(smQTY) ? smQTY: '') +'</String> ' +
										' <Attributes> '+
											' <Font Family="Calibri" Size="14" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
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
										' <String xml:space="preserve">'+(!String.isBlank(SMlineList[i].Product_Name__r.Name) ? SMlineList[i].Product_Name__r.Name : '')+'</String> ' +
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
								' <String xml:space="preserve">'+(!String.isBlank(SMlineList[i].Harvest_Batch_Code__c ) ? SMlineList[i].Harvest_Batch_Code__c : '')  +'</String> ' +
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
						
							  '<ObjectInfo>' +
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
								'<Text>'+(!String.isBlank(SMlineList[i].UID_1__c ) ? SMlineList[i].UID_1__c : '')+'</Text>' +
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
						'</ObjectInfo>' +
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
                       				// ' <String xml:space="preserve">1 of 3</String> ' +
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
                       
                    
                    
				//	Integer mysmQTY = Integer.valueOf(SMlineList[i].Shipment_Qty__c);
   						 string smQTY;
                            
                     String mysmQTYvalue = '';

                 decimal mysmQTYval;
     decimal IQty = SMlineList[i].Shipment_Qty__c;
       Integer mysmQTY = Integer.valueOf(SMlineList[i].Shipment_Qty__c );
                smQTY =string.valueof(mysmQTY);
             system.debug('mysmQTY>>'+mysmQTY);
     if(mysmQTY ==IQty)
     {
                  system.debug('mysmQTYvalif'); 

           mysmQTYval = Integer.valueOf(SMlineList[i].Shipment_Qty__c );
                         smQTY =string.valueof(mysmQTYval);

      system.debug('mysmQTYval'+mysmQTYval);   
     }
    else
    {
         system.debug('mysmQTYvalelse'); 
          mysmQTYval = SMlineList[i].Shipment_Qty__c;
              system.debug('mysmQTYval'+mysmQTYval); 
   smQTY =string.valueof(mysmQTYval);


        
    }
                
                
                   
					productDetails2 = productDetails2 +
                        '<ObjectInfo>' +
						'<TextObject>' +
						' <Name>Qty_'+(i+1)+'</Name> ' +
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
						' <Font Family="Arial" Size="14" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
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

						'<Bounds X="1164.27499329938" Y="'+col2Position+'" Width="3000.1811406771" Height="387.009380863038" />' +
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
						' <String xml:space="preserve">'+(!String.isBlank(SMlineList[i].Product_Name__r.Name) ? SMlineList[i].Product_Name__r.Name : '')+'</String> ' +
						' <Attributes> '+
						' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
						' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
						' </Attributes> ' +
						' </Element> '+
						' </StyledText> ' +
						'</TextObject>' +
						'<Bounds X="2000.27499329938" Y="'+col2Position+'" Width="3000.1811406771" Height="287.009380863038" />' +
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
						'<Bounds X="1164.27499329938" Y="'+col3Position+'" Width="3000.1811406771" Height="387.009380863038" />' +
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
						' <String xml:space="preserve">'+(!String.isBlank(SMlineList[i].Harvest_Batch_Code__c ) ? SMlineList[i].Harvest_Batch_Code__c : '') +'</String> ' +
						' <Attributes> '+
						' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
						' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
						' </Attributes> ' +
						' </Element> '+
						' </StyledText> ' +
						'</TextObject>' +
						'<Bounds X="2000.15753949019" Y="'+col3Position+'" Width="4000.0945128808" Height="250.018348623853" />' +
						'</ObjectInfo>' +
                          '<ObjectInfo>' +
						'<TextObject>' +
						' <Name>UID__'+(currentRecInCurrentPage+5)+'</Name> ' +
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
						'<Bounds X="1164.27499329938" Y="'+col4Position+'" Width="3000.1811406771" Height="387.009380863038" />' +
						'</ObjectInfo>' +
						'<ObjectInfo>' +
						'<BarcodeObject>' +
						' <Name>UID__'+(currentRecInCurrentPage+5)+'</Name> ' +
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
						'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
						'<LinkedObjectName />' +
						'<Rotation>Rotation0</Rotation>' +
						'<IsMirrored>False</IsMirrored>' +
						'<IsVariable>True</IsVariable>' +
						'<GroupID>-1</GroupID>' +
						'<IsOutlined>False</IsOutlined>' +
						'<Text>'+(!String.isBlank(SMlineList[i].UID_1__c ) ? SMlineList[i].UID_1__c : '')+'</Text>' +
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
						'</ObjectInfo>' +
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
						'<Bounds X="1035" Y="'+VertlinePosition+'" Width="30" Height="800" />' +
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
                       				// ' <String xml:space="preserve">1 of 3</String> ' +
									' <String xml:space="preserve">'+ currentPage + ' of ' + totalPages +'</String> ' +
										' <Attributes> '+
											' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
											' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
										' </Attributes> ' +
									' </Element> '+
								' </StyledText> ' +
							'</TextObject>' +
							//'<Bounds X="5200.27499329938" Y="8670.1811406771" Width="2000.1811406771" Height="250.009380863038" />' +
                        	'<Bounds X="5350.27499329938" Y="8690.1811406771" Width="2000.1811406771" Height="200.009380863038" />' +

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
    public static String buildFirstPageXML(Shipping_Manifest__c smObject, String productDetails){
        String firstPageXML = '';
         string  SMboxval='';
       decimal boxval =  smObject.Box_Count__c;
               Integer mysmbox = Integer.valueOf(smObject.Box_Count__c);

       SMboxval =string.valueof(mysmbox);
        system.debug('SMboxval>>'+SMboxval);
        string Addres = +smObject.Site__r.License_ID__r.License_Number__c +
            '\n'+smObject.Site__r.License_ID__r.License_Address__c +'\n'+smObject.Site__r.License_ID__r.License_City__c+
            '\n'+smObject.Site__r.License_ID__r.License_State__c+',' +smObject.Site__r.License_ID__r.License_Zip__c;
        
        string shipAddres ='\n'+smObject.Receiver_DBA__c +   
            '\n' +smObject.Receiver_License__r.License_Address__c+
            '\n'+smObject.Receiver_License__r.License_City__c+'\n'+smObject.Receiver_License__r.License_State__c+
            ','+smObject.Receiver_License__r.License_Zip__c	; 
        
       
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
'<Image>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AMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgXCRwIpFIOAgAsIYaPQAYR9ADgGki/w9JP4pq65d/HwAAAABJRU5ErkJggg==</Image>'+
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
            '<String xml:space="preserve">' + Addres + '</String>' +
            '<Attributes>' +
            '<Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" />' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +            
            '</TextObject>' +
            '<Bounds X="226.771656949076" Y="1020.47245627084" Width="2700.56696915164" Height="992.125999152206" />' +
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
            ' <String xml:space="preserve">'+shipAddres+
            ' </String> '+
            ' <Attributes> ' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> '+
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> ' +
            ' </Attributes> '+
            ' </Element> ' +
            ' </StyledText> '+
            '</TextObject>' +
            '<Bounds X="226.771656949076" Y="2140.6533560404" Width="2600.56696915164" Height="1381.25986176228" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
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
            '<Text>'+(!String.isBlank(smObject.Order_Number__r.name) ? smObject.Order_Number__r.name : '') +'</Text> ' +
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
            '<Bounds X="2950.06303742271" Y="680.314970847227" Width="2659.60634050754" Height="457.756097560975" />' +
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
            '<Text>' +(!String.isBlank(smObject.Metrc_Manifest__c) ? smObject.Metrc_Manifest__c : '')  +'</Text> ' +	            
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
            '<Bounds X="2950.72445457525" Y="1542.87286823552" Width="2659.60634050754" Height="457.756097560975" />' +
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
           //            ' <String xml:space="preserve">Attention</String> ' +

          ' <String xml:space="preserve">'+(!String.isBlank(smObject.Receiver_Contact__r.Name) ? smObject.Receiver_Contact__r.Name : '') +'</String> ' +
            ' <Attributes> '+
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0" HueScale="100" /> '+
            ' </Attributes> ' +
            ' </Element> '+
            ' </StyledText> ' +
            '</TextObject>' +
            '<Bounds X="2950.78048780488" Y="2385.7265267721" Width="2055.80487804878" Height="345.365853658536" />' +
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
            '<Bounds X="5000.78048780488" Y="2385.7265267721" Width="2055.80487804878" Height="345.365853658536" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
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
            '<Text>'+ (!String.isBlank(smObject.Receiver_License_Number__c) ? smObject.Receiver_License_Number__c : '') +'</Text> ' +
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
            '<Bounds X="2900.72445457525" Y="3266.18994140625" Width="2759.60634050754" Height="457.756097560975" />' +
            '</ObjectInfo>' +

            //Add Product Details 
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
    // generate 2X4Xml  
    public static String  getImage1X2Xml (Shipping_Manifest__c smObject){
      
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
            '<Text>' +(!String.isBlank(smObject.Metrc_Manifest__c) ? smObject.Metrc_Manifest__c : '')  +'</Text> ' +	            
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
        @AuraEnabled public Shipping_Manifest__c SMPos {get;set;}
        @AuraEnabled Public Integer qtyToAdjust{get; set;}
        
        public SMWrapper(boolean isSelected, Shipping_Manifest__c SMPosObj)
        {
            this.isSelected = isSelected;
            this.SMPos = SMPosObj;
            this.qtyToAdjust= 0;
        }
    }
    
}