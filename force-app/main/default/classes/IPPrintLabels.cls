/**************************************************************************************
Apex Class Name    : IPPrintLabels 
Test Class Name    :InventoryDetailsTest
Created Date       : July 20 2020
Function           : Used to generate Labels for Inventory Postion.
Developer          :Saranya

*******************************************************************************/

public class IPPrintLabels {
    public static String  finalbatch;
   // dymo label for 4 by 6 
public static String getImage4X6Xml(Inventory_Position__c invPos){
        
    Inventory_Position__c IPList = [SELECT id , Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_City_State_Zip__c,
                                        Rack__r.Name,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c,
                                        Rack__c,Rack_Level__c,Rack_Level__r.Name,Bin_Location__r.Name,Bin_Location__c, Product_Name__r.Name,
                                        COA_Expiration_Date__c,Supplier_License_Number__c,Product_Name__c,License_Premise__c,Inventory_Qty__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c,
                                        Product_Description__c,Producer_Name__c,Stocking_UOM__c,Purchase_Order__c,COA_Number_New__c
                                        from Inventory_Position__c where id =: invPos.Id];
        
        string LicensePremise =+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c+
            '\n'+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c    
            +'\n'+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c+
            ','+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c;  
        string LicensePremises = LicensePremise;
        string LicensePremisesval;
        if(LicensePremises != null &&  LicensePremises.containsAny('&'))
        {
            LicensePremisesval = LicensePremises.replace('&','&amp;');  
            
        }
        else
        {
            LicensePremisesval = LicensePremises; 
            
        }
        
        string Product = IPList.Product_Name__r.Name ;
        string Productval;
        if(Product != null && Product.containsAny('&'))
        {
            Productval = Product.replace('&','&amp;');  
        }
        else
        {
            Productval = Product; 
            
        }
        string Productdes = IPList.Product_Description__c;
        string Productdesval;
        if( Productdes != null && Productdes.containsAny('&'))
        {
            Productdesval = Productdes.replace('&','&amp;');  
            
        }
        else
        {
            Productdesval = Productdes; 
            
        }
        string UOM = IPList.Stocking_UOM__c ;
        string UOMval;
        if(UOM != null && UOM != null &&  UOM.containsAny('&'))
        {
            UOMval = UOM.replace('&','&amp;');  
            
        }
        else
        {
            UOMval = UOM; 
            
        }
        string COANumber =IPList.COA_Number_New__c ;
        string COAval;
        if(COANumber != null && COANumber != null && COANumber.containsAny('&'))
        {
            COAval = COANumber.replace('&','&amp;');  
            
        }
        else
        {
            COAval = COANumber; 
            
        }      
        
        string producer = IPList.Producer_Name__c;
        string replacedProducerval;
        if(producer != null &&  producer.containsAny('&'))
        {
            replacedProducerval = producer.replace('&','&amp;');  
            
        }
        else
        {
            replacedProducerval = producer; 
            
        }
        string HarvestBatch = invPos.Harvest_Batch_Code__r.Name;
        string HarvestBatchval;
        if(HarvestBatch != null && HarvestBatch != null && HarvestBatch.containsAny('&'))
        {
            HarvestBatchval = HarvestBatch.replace('&','&amp;');  
            
        }
        else
        {
            HarvestBatchval = HarvestBatch; 
            
        }   
        string Licensenum =  IPList.Supplier_License_Number__c;
        string Licensenumval;
        if(Licensenum != null &&  Licensenum != null && Licensenum.containsAny('&'))
        {
            Licensenumval = Licensenum.replace('&','&amp;');  
            
        }
        else
        {
            Licensenumval = Licensenum; 
            
        }    
        
        string rack= IPList.Rack__r.Name;
        string Level= IPList.Rack_Level__r.Name;
        string Bin= IPList.Bin_Location__r.Name;
        string RLB = rack + '-' + Level + '-' + Bin;
        string RLBs = RLB;
    system.debug('RLBsRLBsRLBs>>'+RLBs);
        string RLBsval;
    integer RLBcharLength;
    if(RLBs !=null)
    {
        RLBcharLength = RLB.length();
system.debug('RLBcharLength>>>>>>>>>>>>>>>>>>'+RLBcharLength);    
    }
 
        if(RLBs != null && RLBs.containsAny('&'))
        {
            RLBsval = RLBs.replace('&','&amp;');  
        }
        else
        {
            RLBsval = RLBs; 
        } 
    
        Datetime   Expdate = invPos.Date_Received__c;
        date RecDate ;
        if(Expdate!=null)
        {
            Date myDate = date.newinstance(Expdate.year(), Expdate.month(), Expdate.day());
            RecDate = myDate;
        }
        string Expiration ='';
        
        if(RecDate!=null)
        {
            Expiration =RecDate.format();
        }
        string Expdateval ='';
        if(Expdate!=null)
        {
            Expdateval =Expdate.format();
        }
        date COA = IPList.COA_Expiration_Date__c;
        string ExpirationDate ='';
        if(COA!=null)
        {
            ExpirationDate =COA.format();
        }
        String IPRLB = '';
        if(invPos.Rack__c != null && invPos.Rack_Level__c != null && invPos.Bin_Location__c != null && RLBcharLength < 12  )
        {
            system.debug('inside < 9');
            IPRLB = IPRLB+'<ObjectInfo>' +
                '<BarcodeObject>' +
                '<Name>RLB</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>True</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<Text>'+(!String.isBlank(RLBsval)?RLBsval : '')+'</Text>' +
                '<Type>Code128Auto</Type>' +
                '<Size>Medium</Size>' +
                '<TextPosition>Bottom</TextPosition>' +
                '<TextFont Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<TextEmbedding>None</TextEmbedding>' +
                '<ECLevel>0</ECLevel>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
                '</BarcodeObject>' +
                '<Bounds X="745" Y="8250.40087890625" Width="5350" Height="450" />' +
                '</ObjectInfo>';
        }
    else if(invPos.Rack__c != null && invPos.Rack_Level__c != null && invPos.Bin_Location__c != null && RLBcharLength > 12  )
    {
        system.debug('iside else if');
      
      IPRLB = IPRLB+'<ObjectInfo>' +
                '<BarcodeObject>' +
                '<Name>RLB</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>True</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<Text>'+(!String.isBlank(RLBsval)?RLBsval : '')+'</Text>' +
                '<Type>Code128Auto</Type>' +
                '<Size>Small</Size>' +
                '<TextPosition>Bottom</TextPosition>' +
                '<TextFont Family="Arial" Size="10" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<TextEmbedding>None</TextEmbedding>' +
                '<ECLevel>0</ECLevel>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />' +
                '</BarcodeObject>' +
                '<Bounds X="750" Y="8250.40087890625" Width="5250" Height="450" />' +
                '</ObjectInfo>';   
    }
    
    
        decimal mysmQTYval;
        decimal IQty = IPList.Inventory_Qty__c;
        Integer mysmQTY = Integer.valueOf(IPList.Inventory_Qty__c );
        
        if(mysmQTY ==IQty)
        {
            mysmQTYval = Integer.valueOf(IPList.Inventory_Qty__c );
        }
        else
        {
            mysmQTYval = IPList.Inventory_Qty__c;
           
        }
        String IPQty = '';
        if(IPList.Inventory_Qty__c != null)
        {
            IPQty = IPQty+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>Quantity</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>False</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<VerticalAlignment>Middle</VerticalAlignment>' +
                '<TextFitMode>ShrinkToFit</TextFitMode>' +
                '<UseFullFontHeight>True</UseFullFontHeight>' +
                '<Verticalized>False</Verticalized>' +
                '<StyledText>' +
                ' <Element>' +
                '  <String>' + mysmQTYval + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="22" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                ' </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '</TextObject>' +
                '<Bounds X="4000" Y="7100" Width="1800" Height="775" />' +
                '</ObjectInfo>'; 
        }
        
        String LicenseAdd = '';
        if(IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c != null)
        {
          LicenseAdd = LicenseAdd+'<ObjectInfo>' +
                '<AddressObject>' +
                '<Name>License Premise Address</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>True</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<HorizontalAlignment>Left</HorizontalAlignment>' +
                '<VerticalAlignment>Top</VerticalAlignment>' +
                '<TextFitMode>ShrinkToFit</TextFitMode>' +
                '<UseFullFontHeight>True</UseFullFontHeight>' +
                '<Verticalized>False</Verticalized>' +
                ' <StyledText>' +
                '   <Element>' +
                '<String>' + (!String.isBlank(LicensePremisesval) ? LicensePremisesval : '') + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                ' <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                '  </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '<ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
                '<BarcodePosition>AboveAddress</BarcodePosition>' +
                '<LineFonts>' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '<Font Family="Arial" Size="12" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
                '</LineFonts>' +
                '</AddressObject>' +
                '<Bounds X="3112" Y="550" Width="2610" Height="1125" />' +
                '</ObjectInfo>'; 
        }
        
        String IPUID = '';
        if(invPos.UID_New__r.Name !=null)
        {
            IPUID = IPUID+'<ObjectInfo>' +
                '<BarcodeObject>' +
                '<Name>UID</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>True</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<Text>'+ invPos.UID_New__r.Name +'</Text>' +
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
                '<Bounds X="175" Y="5332.16818659856" Width="5810" Height="420" />' +
                '</ObjectInfo>' ;
        }
        String IPDate = '';
        if(invPos.Date_Received__c !=null)
        {
            IPDate = IPDate+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>Received Date</Name>' +
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
                '<StyledText>' +
                ' <Element>' +
                '  <String>' + Expiration  + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                ' </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '</TextObject>' +
                '<Bounds X="4400" Y="6250" Width="1305" Height="360" />' +
                '</ObjectInfo>';  
        }
        
        String template ='<DieCutLabel Version="8.0" Units="twips">' +
            '<PaperOrientation>Portrait</PaperOrientation>' +
            '<Id>Shipping4x6</Id>' +
            '<IsOutlined>false</IsOutlined>' +
            '<PaperName>1744907 4 in x 6 in</PaperName>' +
            '<DrawCommands>' +
            '<RoundRectangle X="0" Y="0" Width="5918.4" Height="9038.4" Rx="270" Ry="270" />' +
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
            '<Image>iVBORw0KGgoAAAANSUhEUgAAAXoAAAI3CAYAAACVjpC/AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAACKYSURBVHhe7d27duLK1rfxqe9awIGHr0AkbwpOHDntTISQOOuQrBMIraxTR04M6U7QvgEPBy1uZEf6ZpVKUJxs+dSNp5/fGqwFhU64ir+mCpuVVEoAAGb9P/evJEnWNwCALb6iJ+ABwC5f0QMA7CLoAcC4vakbPpuFVYxzfCfxeKeiBwDjCHoAMO7FqRsucV+H32A6XUzd4DuJxztz9Pg2GOf4TuLx/vLUzWLoV1jfhovwxEdZyFC3e2izi2G9zw/fJfCslcx6mzH/oeNvNZNe0pPZSu/791a4/1p+OzvH9p7tfYRwTOus6M30J/nB/vVr/KJaztFnMtcKqJpnIvnkL/2QF3Kfp5JlqeT3/zLpj5+IYNNq9kPGRRjzervthyc+Wv9Wt7+UUSc8fq+P3t6bpDIt9edWTiUtxvLjo8PiJF7j1/P2D2PdmbU3lKGrfPTMvZj1NmfyZKjxuLPM1hk+qph6E3n0bTsW95Kn13Jzcy3pzsmlqfTdrQngl9rW+/YVQTi+OMQPHqs7zoHk+nQ+0LY47Q9VVDAkl8n2oGs3bo6N/fW6kbi6V1vjdTOIN9t5qUJ+ZnubzW3aDu7DtTf7iSr0XtjowfUP6VzKdSpSPJUHX0Pb45itlws/v/g1vvb4wvLPHbZZbo7e/ae57ZlnW89LOq3KqD3TsmfbvNK6v26PlymnlfZ71J7pkjvLrJXVNJUq1dKg2V593z2M1m0caCunadQWbWNr2RbHGi8T21oGX4Efv+H2Er14DcumVT0MW4yb0L4ZZwfa/bgJ24zvt9p+5ND4O7q9oM0+ou3691C8g2PrN/Ze24HtO88eR3z8oT3eVrSPtx3fTpth7ufX3F43dVPNJdu6HEvlvBvuurOxP5PWFfDjn2aZTK7cpW/nTC7qBln90Ro+PRe/av9Kl9ixepC7QquBcXe9veLuwVcCW+sGh9rKJ93Auq0r59rDL9s/1qM6I1l+5mU9/qn+rRvvpUzTQsa/XioBw7jZG2fH2vf5MawjfXDwPRS9z1o6+j45uo/9sd+5dFfTA/++dlXw8+s39OfV1ee7YymyefT+2LyG57dzIWduWqZ7rmuEdY68H199fN/4Pfthv0e/uNcfq3asPxmEtmcVT6IXdW5F3yGx1cOdFOlU9KTtSq/6s4HiTh60zzpn2uXNunopNtMOPtTWde+spk3/7XL/wo8g51F8/x/Yd2vf+TLQuMXw2Id9x8ZNLvXHSPU42zjWvs+PYX3n1AVVfVu+YyL66PvkNfsIwaiVs+STmUir9cMcvXv+SKJ+2Gt97fF94/dsy6CPzpIawL8PdEr/SsPYn10n8vhC9dIZ/dZKKWxzol2ztfxKHlw5f3Em6734qr+QO5f0/ZvNut0nOXNj6UDb1j7ccTfVhV82VB17+z6kL/VL0+VJ9W+hf3Mtd258JN36Q1k3cJ4dN6k8TsI423p/HGs/oH8r86wZr+7W7jdL/Lh0y++OzYPvk9fto5nv7o4LyX6OpPPGY9zzQdv5tOMziN+jx7fxKePcTVkORKvIWy0JIsfagb8kHu8fNnUDADhNVPT4Nhjn+E6o6AHgGyHoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcA4gh4AjCPoAcCYJEnCvRpBDwDGEfQAYBxBDwDGVFUV7tUIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwLqlUkiThIQDAGip6ADCOoAcA4/ambvRhuAcA+KriXKeiBwDjCHoAMI6gBwDjWgT9Sma9xM/3uNtwEZo/wmomvaQns5XeXwx1++H+a/nt7Bzbe7b3QVaznvTcAbjj6830JwkAf9+LQb+a/ZBxkcm8qvwHtbf98MRH69/q9pcy6oTH7/XR23uD8qmQizM9gPJJiosz+YeHAuAbazl1k8skLo19tTyUuoBeyLCppl17byjD9RVAWOZYeyyu7tVi2Cyrt6ZUj7fzUoX8zPY2m9u0HdyHa2/2E64aXJuv0v2iYZl4/cBV84Ncf3IDfa6+s7niOHQFAgCf5MWg74yWMs9EinFXA63FVEihofbTVf9zyeITxLH2QzRsB3lzFaHLxyHZbGc5al8hb20vXJW02Uc5lbQYyy9tXz3cSZHN/fpLd5nw3PqqM/ot0zSVaVlJOU0lnZafdzUEAM9oVdH3b12YlRpchYxd6j0rkysfaF05T31DcKx93+rPo/47l4Gvlgd6T+TxT3NiSOW8G+625LeXnuueN57fRzjWzplc1A3SubyWVMPcVe8u0J9f332u0ZVxoT+vbiLdcaEnyh+bk2RnJMvmhAMAn+zFoF8Mj1Xxj+JzbXHvQ24jl3t/LijlqfANwbH2fZ0zF6+bCnxdRb+R317xpHtWq5nM9DhevY8Qzq46zyczkWfX78jot14NpFMp/QnSVfbR5wVM3QD4i14M+v7NtdxpVZokrkLVYHNlaP+mru5d+0TjbqtCT+VxEqpcDbrf63Q71n5A/1bmWVMtu1u7357x8+Fu+d0E9ccbttd9kjNXSb9yH818vKvOs58j6by0vvsAtr7z4okNAD7Tx34FgvsgcyBa5d7K1qzEsXYAwKeIc73lb90AAL4qvtQMAAyiogeAb4SgBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjkkolSRIeAgCsoaIHAOMIegAwbm/qRh+GewCAryrOdSp6ADCOoAcA4wh6ADCOoAcA4wh6ADCOoAcA49oH/WomvSTxv7Ljb72ZrMJTr7eQoW5juAgP32sx3DmmD94+AHxhr6zoU5mWlVTlVNJiLD9mb4/6t3kuwFP9504e/vYhAcCJe9vUTedSrlOR4qmsq+neUIa9TUW9GB6q/Fcyc8v4tok8+jblq/GhRrh/sBXk8XaGC7f+QHJtzwfatpf2F3J9LTL+td2+mvXW21jvJz5m167HOFvvqzmWndexu79whcNVA4BT97agXz3IXSGSXfXrx4XG70+t9Jcj0TSWQZ7JvNLH1VyypvJf/JJxEdp/Xoiu/jwN4812Krntd2S01O3pU9lc227DviNno5+S5ROJLzQ6o6Vf3x+Lnibum2AuHuX8t7bPdYt6jE9Xet9dqTTLbO1f180HhDqAL+mVQV/IuKvVbXcsRTbX8A3NGo/n3fpe+aQRnp5L/bAr51r5O6s/WsM37f0rH9jP2Vq+tb7cTEXuHv6Ex8pfMbiqvL4aePzTnAUu5Kyj/+me+0kff/ydM22t+f3rGoOD66rOSJb+BBQeA8CJetscvatyjyRc1yV78SSlf1SKy/0Ln6iqaV/c++DceBSfoVF750wjt1l+NZNZy2q6o1X9xd3dempoca9b1JNSXdG35/evazRXFO62HIXX4TB1A+CLeNvUzTM6o98yTaNKOFT+W+0TjdBQ6Uv/RtvDlcJee1i++yRn/rzSlytN68Nz9A1d5qJYTw316xX0WCby2Gy7jf6tzLPmdbhbb2tKCAC+Cr69EgAMinP9wyt6AMBpIegBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMSyqVJEl4CACwhooeAIwj6AHAuL2pG30Y7gEAvqo416noAcA4gh4AjCPoAcA4gh4AjCPoAcC49kG/mkkvSfwnufWtJ7NVeO4jLYav3/Zb1gGAb+KVFX0q07Lyv4JZTkXG3U8I1/6tbn8po054fNBChnqyGS7Cw1brAMD39Oapm87op2RSyN1DnfSLYVTtNwkcXQX0whkhXs4v5qrx3lCGPW3rzWTl1wknkPg5v85QI34ls95Acn06H2ib20i8jl+tWV5vbpt14/a2mvZGONb1yQMAjHjHHH1XzlOR4qn0ITrIM5lrpV9Vc8nygQ/M1cOdFNncXwEsXbm9tVwlt/2wqUJj+6e2LUeyV5Q3z7ntarxPZiKjpbsvks21fb2R2mrW2z6WYiw/mjNAsy29HEm1/RehDuAbeEfQl/JUiKTnXVn9edTHuQx8FV1X249/VtK5vJZUQ7+p3v1y6bmeInalops5IpMrn+X1ieUlZX1QYR+764Rtdc7kom7Y6IxkGZ98AMCINwf9ajbRQE/l+rKjuelic1Opryv4EJ7lNJXcleJuueJJTxF+AzJrVVHncu+Xq08sL+nWlxn1PsI6F2ctJu+ZugFg1CuDvpBxt57j7o5FpmX4ALR/K/OsqejdrZ4vb+bKu+NCsp8j6fRvZJqG5bpPctaqek7lceK2o1cK6VR+1zuUqyyao490Rr83+3DrZHOqdADf2ml/qZn7AHUgeqVwq9EOAGgrzvV3zNEDAL4CvqYYAAyiogeAb4SgBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHoAMI6gBwDjCHrghPEHjPgIBD0AGEfQAycs/jN24K0IegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwjqAHAOMIegAwLqlUkiThIQDAGip6ADCOoAcA4/ambvRhuAcA+KriXKeiBwDjCHoAMI6gBwDj2gf9YujnfNa34SI88UZ+e0M5upXVTHpJT2ar5n6076YdAPCiV1b0mcyrSqp5JpJPngnbhQw1kN97LtiWyrTUfev+y6nIuEvYA0Ab7566Wc16UaXtKvSVzHoDyfW5fKBtIe0Xw2aZ+ATwKJNeaO/NdM12OqOfesop5O4hWiNU/R97cgGAr++VQZ/LwIXyQGM8vZbLjgvdpa+yq2qu4ZvL/aIjo6W7r/X/XNtv+36aZpCHqwG9uaZaIRc/tU1L9LQYy6/WId2V81TXfirDYwDAMW+bunGhrsH8w82drOfu6yr+8c9+Xb7686gnhnON512ZXLnQ75zJRd3QUilPhdtktMXOSJZbJxEAgPPuqZvFvcZ7Ng8V/WGdM43x4knjWa1mMnvn9MpqNtGTSirX7pKiwdQNABz0tqkbV72nU/k96kj/yn0wO9C2iTymYTHpS92sy7rk7d/INA3rdp/k7E1VdyHjrtt3It2xyLRciu4eAPACvgIBAAyKc/3dUzcAgNNG0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABhH0AOAcQQ9ABiXVCpJkvAQAGANFT0AGEfQA4Bxe1M3+jDcAwB8VXGuU9EDgHEEPeS///2v/Oc//wmPAFhD0EP+97//yf/93/+FRwCsaR/0i6EkSU9mq/B4NZNekshw0dwPz4V2Nz9U36J1cJIIecC2T6roU5mWlf9gt5yKjLuEPQD8K58+ddMZ/ZRMCrl7iJI+vhoAAHyqvzBH35XzVKR4KsNjAMDf9BeCvpSnQiQ974bHqjOSZVXJbT88BgB8mvZB3z2XNJqCWT3c6aNMrl4I69VsIrmueX3ZCS2KqRsA+GvaB72rwueZFOOu/22a7lhjfn4rh3O+kHG3/q2b7lhkWi5lFOU8AODv4SsQAMCgONf/whw9AOBfIugBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMI+gBwDiCHgCMSyqVJEl4CACwhooeAIwj6AHAuL2pG30Y7sES+hgxxoN9cR9T0QOAcQQ9ABhH0AOAcScZ9L0k8fNLm1tPZqvw5JutZNbbbHO4CM2wYTXbHje9mfZ4sBhu2vXWOzCYVrNe3e62E6+Lv2unr7b6sbWFDA9mhmvfee/vjpsPyZrTc5JBv6wqqcqppPrPtNT71VJGnfDkiw50plrNfsi4yGTutq23275rPbzstjbL4DSE8eLGTjGWH01wD3LJ5nW/V/NMinF3rz/Lp0IuznSQlU9SXJxJ6+GGT7Ddj78+/b3X5EwluksZd58L+6+ZB19q6mYxjM68zU86OiP3Zgut2geSa3M+iJZZy2Wy7kFX4W8v66q6zZl9qF26v0xdcbjnnKjTt47DYEnwlXQu5ToVKZ5KWT3cSSGZXPkTu+pf6SORxz+bPnL9rueCuo/rO5zYT9DB97+K2zfNF+LO2/X7PDzfm8ijf+64zuinjo9C7h5W7fJAHTuuk6JnMfe7VevbySinlVb0lZ5pa/NMjy+rtCJ3Dyp9s1ZapeliaeXKtY3Nc7u0mAuvs9nusWXj9p1lWh/HaTnJPv5I8Xjx9+t+8X2eTqtmGOmT1TTVtq2+cm31uq4f0/Wgs+tkx4N/f22Obd0XR9532+0HxM+HbW93/U7OHBwfr8+DUxD/HL9MRb/6487FuQz8mbM+q7qqrHN5LalWYO5s+tLJtH/rLs9KmaaFjA9dD67nBzfbb+s1x4HPov3a1f7rjqXI5n56rnvuS3spwxKi954KPdWfd8NjV6V1ZVzU63bHhRTjHybnab+OeipFT9JS3D1oDx1///v29Fya3ty19Xy4mnteND5a5MGx4zo1XyboO2cX+u/NHLu7Ld3EfWfk5/S1EpN8cvyDm8Xw5Q9ZFvfaTRoQemZ+YUA8iu/Lxb3vWK/lceAzbeZaq/pDmDBucrlvTr6+z1K5vmxm4Tsy+j2VNJ1K6YsAt43XfCaEz9K/2czRH3v/+/bmRL6ayexQkdU8H79fj1jNJuvx0SYPjubSqdED2yrxT8beJZW7Stocp76p/XNxW3PJtG6Lr6HC5Xy97OZSb2vZcGnntq3v9/Vl4/b2wqWde5xmVab361VDm97i3Z6K5tjczaQD46Xhp9Wi17/XP67f/fSOu/Q+vA1r4p/HSfHvwaYPtqdR4vfY3jK+7dAUzuH369pWLrhb1P+t8uDYcf17m2OSiq9A+CboY8QYD/bFffylfusGAPB6BD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGEfQA4BxBD0AGJdUKkmS8BAAYA0VPQAYR9ADgHF7Uzf6MNyDJfQxYowH++I+pqIHAOMIegAw7usH/WomPb1EcZcpSTKURWiWxTC01bfebBWeqC2GdftwvcK21axXr+O235vJ9tp4v5XMepv+OdYPrfn+jvrf8W092en69nbXD2NtfazHxlg0Jrde17r9HccEvMEXD/qFDLtjKbK5n2esynOZuHeWe0MNcsnm2uba55kU4270plvIfZ5KlqWS329Fw1r5VMjFWcfdkeLiTPQePtBq9kPGRSZz1z96u+27Vu3P3XB8j/6tbnspo8/ovBfHWCppKlvja/VwJ4U2ajM+TT2GNidgTqqeDlL3Scz69pWU01SPOas0LLbst8+rTF9bOi3Dw6ySdFqV5bTSt13VNDfq9Tc/E3fTN/SXFr+WU9D8jNd9UpXVNI1+5uEHrvm5aXN95lu32/2irk99n9d97deP+9f3eVbpuX17W36Zzba2xo3fZjQ+wrL1pp8ZY81+p80xbZ7PpofH3N+2eb1f6z3/vKjvg3qc7PTB5mnT4j42OUfvqnFJz6UbHoveO9d3aPFU6v2VzCa5pNeX0umcyYUUcvewfcrvjH7LVCsvfTOKvqE1E8pQceKjdEZL0Tehr4Lrqqsjo+VctKmukvUH7qbPBnlT9etzxVh+uPJsMYzam6uB2v1wIHk6lfJQhxW5yE9dp5xKqtv6pcW2r7LDFaE7nnR6I226+vkxFlze6DjKZeKP+d4f181leA4fz/2M9XpperPpwf6N9rW23i/cVKGODW3LB1rpD2d+6rCZbnNjLTE8RWsy6Lv1O042b7lS6velvi1XD3Kn9+uAqTu+uHuIOtgNiK6Mi0LG3US640KX/cHl3yfo37qgLjUM9WftUnfHdpjWQeqs/jzuhGwjl9x16NGptkyuXAb4E3ytc3ktaT7wl/nu5PGz5TzPs2NsrSOX16mOr18ybIqL8Aw+nh8X2rNuxnXfbiExqvtm/Mt/ruPGmuX++dJB79+k+ub2FZPj5k2HC30fu7exO4vXzc2Z/vqyE+ZJteIL1aC7ttN3omyKeh0Qv7UK8Mu4EHKV/SfN835ji+HLc6fbYVoHqfvcxPdv0659PlufI7TKd/2ZT1qfmBe/xqIdXI+F6na7mu+e66jZXPH5sRNOFs+NsZgfo3olkRf7z+Fj1X3yKH9a9n1n9FN70/Vh/Zmd6f7RAb41l/Pl+HnU5vg3c6a78+z1vFyYB96apIvmVhvNHL5/7t/Pp36E+GdxErbmxjf9Vs+p6s330eF5++32sO56jj48t/sZzPp5v/BmrnZr/OyMA2fn+XjoHB5j/oloHj46nr3n/p34uM0IYyruQz+e1p/t7M/Rr8dbNAatiPv46wc9WqGPD6lDuAmG/Q9Y7TI7HrYKiHBbB30U7E3aNyfyOP2NiH8GfAXCN0EfH+Y+hHOfwzT0/f4tPnj/TuPB/c1M/eH9ztSc46Z7u3dybXB6Nu5jgv6boI8RYzzU/EngcSrlcmTug1iC/huijxFjPNgX97HJX68EAGwQ9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYR9ABgHEEPAMYllUqSJDwE8N1oBIR7sCTOdSp6ADCOoAcA4/ambriMs4k+RozxYB9TNwDwjRD0AGAcQQ8AxhH0AGAcQQ8AxhH0AGDcvwv61Ux6SeJ/BShJhrIIzbIYhrb61putwhO1xbBuH65XiOysm/Rmsr32C/z6PdnZZTtbr8fd3rgdAPhg/yjoFzLsjqXI5v53eKvyXCYuuV1YDnLJ5trm2ueZFONuFOoLuc9TybJU8vtDSe+kMi3D+suRdEJrK/1bXW8po1etFNvsu5yKjLvPhb3+DPSEcPCEBQAf6J8E/Wo2EY1zmd/264bOSJZ6f/VwJ4W2X4Vm6V/pI5HHPyEtF/eSp9dyc3MtaT5pVTHXVwD1FYO/75LVVe69oQx7TfUdrih8VR7COV4mXBk0VxP+9kJCd0Y/9dgLuXtY6WZ7m/X8vlYy6w30ZyCSDzbbes32AaCtk5qjL58KLYrPpRsei947T0WKp1LvazhOckmvL6XTOZOLEKL7Cq2k67B00z7927kGbq5XDEOZ5NHJpdCY/emq7/D8obNGs4y7MtDgH7j13ZWCWycfvFCNb469M1rWVxhhX/eLjoyW7r7UVy/umF69fQBo56SCvlsno7hYr5VSZ79G/+pB7vS+m8pJkroaLu4eDszBb6ZPln4Opi8301QzO5ciu9JHjebKoQ7kw1Jxu3ZWfx7137kMfMVd7399pXFQdOx+7v/59V6/fQBo558EfefyWiM0qqLdlImWr52zC33gKt662U/V6JLXl516WiedSukrXr3NtR4u7uRgUb9lIb/GhWSZLr813dPspw7kl9TH1lTc8YnksHp6qj72xb3Gtv88oq7iD3nt9gGgNQ0U941G69tfM8+i/WaVBpxXTtOoXarMP1FWWpRXbp5jY15paFaplu9rW9vUWzqtplmzXrQNv1xape5xWM5vpZxWqbb7TYZltjcflve37efqdY88vz6uep/NMa+3F17Xs9t/p812/2If42QxHuyL+/h7fnulm0oZiFbPt9FUjm3fro/xLMaDfXEfn9QcPQDg4/F99N8EfYwY48E+KnoA+EYIegAwjqDHcevf/w+3b/EXXPVXU7jXyx+swQqCHi8Iv9vv/m6h5ddOfGnhbzemZSXNH1EDXx1BjzfZ+l6ere8C2vleoRO29xrCl+qJ/xoNvn0UhrjfunH/aW6w6U19fOAP0NzfcNV/1Nb8kVv8h2vhfpZVafRHcKfo6Gs48IdyFsX9CpviPqaixwuiL1orxvJDy9ztL5+Lvyvo2PcKnZ7jrwGwh6DHq21/+Vz9XUEXZ+57eY59r9DpOf4aAIN2S3zY9KY+PjJ1s/7eoKY9/q6e3e8VOlmHXwNTN7Ai7mP+MvaboI8RYzzYF/cxUzcAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYNze/2EKAGALFT0AGEfQA4Bx/M/BAcAg/ufgAPCNEPQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGEfQAYBxBDwDGPR/0i6H//w6ub72ZrMJTR61m0tNlh4vw+CW7+2i9IgCgjRYVfSrTspKqnEpajOXXp+RwJvNK9zHPRPKJzF48mwAA2mLqBgCMaxH0hYy7iSTdsWhpL7f90Pyhchm4aZtBrhcQ13LZCc0AgHdrPXXjZlWKu4etOfrFsJlbH0qbGZ3jy4epm2ouWTGWH8zdAMCHaT1107/Zn6Pv37pwdrdbaVPov3Z5AMD7tZ+j71zKdSqS37f7NDYfhOq91W/RhKmbZCB5OpXfI+ZuAOCjJFphVy6QG67iBgB8bXGu81s3AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8AxhH0AGAcQQ8Axu39j0cAALZQ0QOAcQQ9AJgm8v8BhCcVnUAeFBkAAAAASUVORK5CYII=</Image>' +
            '<ScaleMode>Fill</ScaleMode>' +
            '<BorderWidth>0</BorderWidth>' +
            '<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Center</VerticalAlignment>' +
            '</ImageObject>' +
            '<Bounds X="150" Y="200" Width="5692" Height="8617.89940828402" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Brand Account</Name>' +
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
            '<StyledText>' +
            '<Element>' +
            '<String>' + (!String.isBlank(replacedProducerval) ? replacedProducerval : '') + '</String>' +
            '<Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +
            '</TextObject>' +
            '<Bounds X="300" Y="550" Width="5000" Height="500" />' +
            '</ObjectInfo>' +      
            '<ObjectInfo>' +
            '<BarcodeObject>' +
            '<Name>Supplier License</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>True</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<Text>'+ (!String.isBlank(Licensenumval) ? Licensenumval : '') +  '</Text>' +
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
            '<Bounds X="350" Y="2100" Width="5265" Height="400" />' +
            '</ObjectInfo>' +      
            LicenseAdd+  
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Product Name</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>'  + (!String.isBlank(Productval) ?Productval : '') +'</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="350" Y="2900" Width="5340" Height="300" />' +
            '</ObjectInfo>' +  
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Product Description</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(Productdesval) ? Productdesval : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="350" Y="3740" Width="5340" Height="375" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Batch ID</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '<String>' + (!String.isBlank(HarvestBatchval) ? HarvestBatchval : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="300" Y="4610" Width="5340" Height="330" />' +
            '</ObjectInfo>' +
            IPUID+  
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Test Status</Name>' +
            '	<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '  <String>' + (!String.isBlank(invPos.Lab_Test_Status__c) ? invPos.Lab_Test_Status__c : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="380" Y="6200" Width="1350" Height="360" />' +
            '</ObjectInfo>' +      
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>PO Number</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(IPList.Purchase_Order__c) ? IPList.Purchase_Order__c : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="2250" Y="6250" Width="1650" Height="360" />' +
            '</ObjectInfo>' +     
            IPDate+   
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>COA Number</Name>' +
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
            '<StyledText>' +
            '<Element>' +
            '<String>' +(!String.isBlank( COAval) ?  COAval : '') + '</String>' +
            '<Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +
            '</TextObject>' +
            '<Bounds X="490" Y="6950" Width="1815" Height="360" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Stock UOM</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(UOMval) ?UOMval : '')  + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="2560" Y="6900" Width="780" Height="390" />' +
            '</ObjectInfo>' +     
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Exp Date</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '  <String>' + ExpirationDate+ '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="11" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="380" Y="7600" Width="1305" Height="360" />' +
            '</ObjectInfo>' +
            IPRLB+
            IPQty+ 
            ' </DieCutLabel>';
        return template;        
    }
       // dymo label for 2 by 4
    public static String getImage2X4Xml(Inventory_Position__c invPos){
        Inventory_Position__c IPList = [SELECT  Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_City_State_Zip__c,
                                        Rack__r.Name,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c,
                                        Rack__c,Rack_Level__c,Rack_Level__r.Name,Bin_Location__r.Name,Bin_Location__c, Product_Name__r.Name,
                                        COA_Expiration_Date__c,Supplier_License_Number__c,Product_Name__c,License_Premise__c,Inventory_Qty__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c,
                                        Product_Description__c,Producer_Name__c,Stocking_UOM__c,Purchase_Order__c,COA_Number_New__c,Ownership__c,Ownership__r.name,		
                                        id , Supplier_Name__c
                                        from Inventory_Position__c where id =: invPos.Id];
        
        string LicensePremise =+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c+
            '\n'+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c    
            +'\n'+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c+
            ','+IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c;  
        
        string producer = IPList.Producer_Name__c;
        string replacedProducerval;
        if(producer != null && producer.containsAny('&'))
        {
            replacedProducerval = producer.replace('&','&amp;');  
        }
        else
        {
            replacedProducerval = producer; 
        }
        string LicensePremises = LicensePremise;
        string LicensePremisesval;
        if(LicensePremises != null && LicensePremises.containsAny('&'))
        {
            LicensePremisesval = LicensePremises.replace('&','&amp;');  
        }
        else
        {
            LicensePremisesval = LicensePremises; 
        }
        string Product = IPList.Product_Name__r.Name ;
        string Productval;
        if(Product != null &&  Product.containsAny('&'))
        {
            Productval = Product.replace('&','&amp;');  
        }
        else
        {
            Productval = Product; 
        }
        string UOM = IPList.Stocking_UOM__c ;
        string UOMval;
        if ( UOM != null && UOM.containsAny('&'))
        {
            UOMval = UOM.replace('&','&amp;');  
        }
        else
        {
            UOMval = UOM; 
        }
        string HarvestBatch = invPos.Harvest_Batch_Code__r.Name; 
        string HarvestBatchval;
        if(HarvestBatch != null && HarvestBatch != null &&  HarvestBatch.containsAny('&') )
        {
            HarvestBatchval = HarvestBatch.replace('&','&amp;');  
        }
        else
        {
            HarvestBatchval = HarvestBatch; 
        }   
        string Licensenum =  IPList.Supplier_License_Number__c;
        string Licensenumval;
        if(Licensenum != null && Licensenum.containsAny('&'))
        {
            Licensenumval = Licensenum.replace('&','&amp;');  
        }
        else
        {
            Licensenumval = Licensenum; 
        }     
        
        
        string rack= IPList.Rack__r.Name;
        string Level= IPList.Rack_Level__r.Name;
        string Bin= IPList.Bin_Location__r.Name;
        
        String ProductDes = string.valueOf(IPList.Product_Description__c);
        
        if(ProductDes != null && ProductDes.countMatches(',') >=3)	
        {
            integer inof = ProductDes.indexOf(',', 1 + ProductDes.indexOf(',', 1+ ProductDes.indexOf(',')));
            String firstPart = ProductDes.substring(0, inof);
            String secondPart = ProductDes.substring(inof+1);  
            finalbatch= firstPart+ '\n'+secondPart ;  
            
        }
        else if(ProductDes != null && ProductDes.countMatches(',') >=2)
        {
            integer inof = ProductDes.indexOf(',', 1 + ProductDes.indexOf(','));
            String firstPart = ProductDes.substring(0, inof);
            String secondPart = ProductDes.substring(inof+1);  
            finalbatch= firstPart+ '\n'+secondPart ;  
        }
        else 
        {
            finalbatch = ProductDes ; 
            
        }  
        string ProductDescription = finalbatch;
        string Productdesval2;
        if(ProductDescription != null && ProductDescription.containsAny('&'))
        {
            Productdesval2 = ProductDescription.replace('&','&amp;');  
        }
        else
        {
            Productdesval2 = ProductDescription; 
            
        }
        string RLB = rack + '-' + Level + '-' + Bin;
        Datetime   Expdate = invPos.Date_Received__c;
        date RecDate ;
        if(Expdate!=null)
        {
            Date myDate = date.newinstance(Expdate.year(), Expdate.month(), Expdate.day());
            RecDate = myDate;
        }
        string Expiration ='';
        
        if(RecDate!=null)
        {
            Expiration =RecDate.format();
        }
        string Expdateval ='';
        if(Expdate!=null)
        {
            Expdateval =Expdate.format();
        }
        date COA = IPList.COA_Expiration_Date__c;
        string ExpirationDate ='';
        if(COA!=null)
        {
            ExpirationDate =COA.format();
        }
        decimal mysmQTYval;
        decimal IQty = IPList.Inventory_Qty__c;
        Integer mysmQTY = Integer.valueOf(IPList.Inventory_Qty__c );
        
        if(mysmQTY ==IQty)
        {
            mysmQTYval = Integer.valueOf(IPList.Inventory_Qty__c );
        }
        else
        {
            mysmQTYval = IPList.Inventory_Qty__c;
        }
        String IPRLB = '';
        if(invPos.Rack__c != null && invPos.Rack_Level__c != null && invPos.Bin_Location__c != null )
        {
            IPRLB = IPRLB+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>Stock UOM</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>False</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<VerticalAlignment>Middle</VerticalAlignment>' +
                '<TextFitMode>ShrinkToFit</TextFitMode>' +
                '<UseFullFontHeight>True</UseFullFontHeight>' +
                '<Verticalized>False</Verticalized>' +
                '<StyledText>' +
                ' <Element>' +
                '<String>' + (!String.isBlank(RLB) ? RLB : '') + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                ' </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '</TextObject>' +
                '<Bounds X="370" Y="4720" Width="2050" Height="250" />' +
                '</ObjectInfo>';
        } 
        String IPQty = '';
        if(IPList.Inventory_Qty__c != null)
        {
            IPQty = IPQty+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>Quantity</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>False</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<VerticalAlignment>Middle</VerticalAlignment>' +
                '<TextFitMode>ShrinkToFit</TextFitMode>' +
                '<UseFullFontHeight>True</UseFullFontHeight>' +
                '<Verticalized>False</Verticalized>' +
                '<StyledText>' +
                ' <Element>' +
                '  <String>' + mysmQTYval + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" /> ' +
                '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                ' </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '</TextObject>' +
                '<Bounds X="200" Y="5100" Width="700" Height="360" />' +
                '</ObjectInfo>'; 
        } 
        
        String LicenseAdd = '';
        if(IPList.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c != null)
        {
            LicenseAdd = LicenseAdd+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>LicensePremise</Name>' +
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
                '<StyledText>' +
                '<Element>' +
                '<String>' + (!String.isBlank(LicensePremisesval) ? LicensePremisesval : '') + '</String>' +
                '<Attributes>' +
                ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                '</Attributes>' +
                '</Element>' +
                '</StyledText>' +
                '</TextObject>' + 
                '<Bounds X="300" Y="1450" Width="5000" Height="350" />' +
                '</ObjectInfo>';   
        }
        String IPDate = '';
        if(invPos.Date_Received__c !=null)
        {
            IPDate = IPDate+'<ObjectInfo>' +
                '<TextObject>' +
                '<Name>Received Date</Name>' +
                '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
                '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
                '<LinkedObjectName />' +
                '<Rotation>Rotation0</Rotation>' +
                '<IsMirrored>False</IsMirrored>' +
                '<IsVariable>False</IsVariable>' +
                '<GroupID>-1</GroupID>' +
                '<IsOutlined>False</IsOutlined>' +
                '<HorizontalAlignment>Center</HorizontalAlignment>' +
                '<VerticalAlignment>Top</VerticalAlignment>' +
                '<TextFitMode>ShrinkToFit</TextFitMode>' +
                '<UseFullFontHeight>True</UseFullFontHeight>' +
                '<Verticalized>False</Verticalized>' +
                '<StyledText>' +
                ' <Element>' +
                '  <String>' + Expiration  + '</String>' +
                '  <Attributes>' +
                ' <Font Family="Calibri" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
                '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
                ' </Attributes>' +
                '  </Element>' +
                '  </StyledText>' +
                '</TextObject>' +
                '<Bounds X="1600" Y="3300" Width="1305" Height="250" />' +
                '</ObjectInfo>';  
            
        }
        
        String template ='<DieCutLabel Version="8.0" Units="twips">' +
            '<PaperOrientation>Portrait</PaperOrientation>' +
            '<Id>Shipping</Id>' +
            '<IsOutlined>false</IsOutlined>' +
            '<PaperName>30323 Shipping</PaperName>' +
            '<DrawCommands>' +
            '<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" />' +
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
            '<Image>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</Image>' +
            '<ScaleMode>Uniform</ScaleMode>' +
            '<BorderWidth>0</BorderWidth>' +
            '<BorderColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Center</VerticalAlignment>' +
            '</ImageObject>' +
            '<Bounds X="144.775510204084" Y="157" Width="2805.02040816327" Height="5423" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>LicensePremise</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Left</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            '<Element>' +	
            '<String>' + (!String.isBlank(Licensenumval) ? Licensenumval : '') + '</String>' +
            '<Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +
            '</TextObject>' + 
            '<Bounds X="300" Y="490" Width="2000" Height="250" />' +
            '</ObjectInfo>' +   
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Legal Business Name</Name>' +
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
            '<StyledText>' +
            '<Element>' +
            '<String>' + (!String.isBlank(replacedProducerval) ? replacedProducerval: '') + '</String>' +
            '<Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +
            '</TextObject>' +
            '<Bounds X="300" Y="1000" Width="2000" Height="250" />' +
            '</ObjectInfo>' +   
            LicenseAdd +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Product Name</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>'  + (!String.isBlank(Productval) ?Productval : '') +'</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="350" Y="2200" Width="4600" Height="250" />' +
            '</ObjectInfo>' +  
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Product Description</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(Productdesval2) ? Productdesval2: '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="200" Y="2700" Width="2850" Height="250" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>PO Number</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(IPList.Purchase_Order__c) ? IPList.Purchase_Order__c : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="300" Y="3300" Width="1650" Height="250" />' +
            '</ObjectInfo>' + 
            IPDate+   
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Batch ID</Name>' +
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
            '<StyledText>' +
            ' <Element>' +
            '<String>' + (!String.isBlank( HarvestBatchval) ?  HarvestBatchval  : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="200" Y="3850" Width="1400" Height="250" />' +
            '</ObjectInfo>' +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Stock UOM</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '<String>' + (!String.isBlank(IPList.Ownership__r.Name) ? IPList.Ownership__r.Name : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="1560" Y="3800" Width="1305" Height="250" />' +
            '</ObjectInfo>' +  
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Stock UOM</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '<String>' + (!String.isBlank(invPos.UID_New__r.Name) ? invPos.UID_New__r.Name : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="400" Y="4270" Width="2050" Height="375" />' +
            '</ObjectInfo>' +
            IPRLB+    
            IPQty +
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Test Status</Name>' +
            '	<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '  <String>' + (!String.isBlank(invPos.Lab_Test_Status__c) ? invPos.Lab_Test_Status__c : '') + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +	
            '</TextObject>' +
            '<Bounds X="820" Y="5140" Width="1350" Height="240" />' +
            '</ObjectInfo>' +    
            '<ObjectInfo>' +
            '<TextObject>' +
            '<Name>Stock UOM</Name>' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '<BackColor Alpha="0" Red="255" Green="255" Blue="255" />' +
            '<LinkedObjectName />' +
            '<Rotation>Rotation0</Rotation>' +
            '<IsMirrored>False</IsMirrored>' +
            '<IsVariable>False</IsVariable>' +
            '<GroupID>-1</GroupID>' +
            '<IsOutlined>False</IsOutlined>' +
            '<HorizontalAlignment>Center</HorizontalAlignment>' +
            '<VerticalAlignment>Middle</VerticalAlignment>' +
            '<TextFitMode>ShrinkToFit</TextFitMode>' +
            '<UseFullFontHeight>True</UseFullFontHeight>' +
            '<Verticalized>False</Verticalized>' +
            '<StyledText>' +
            ' <Element>' +
            '  <String>' +(!String.isBlank(UOMval ) ?UOMval  : '')  + '</String>' +
            '  <Attributes>' +
            ' <Font Family="Calibri" Size="7" Bold="False" Italic="False" Underline="False" Strikeout="False" /> ' +
            '  <ForeColor Alpha="255" Red="0" Green="0" Blue="0"/>' +
            ' </Attributes>' +
            '  </Element>' +
            '  </StyledText>' +
            '</TextObject>' +
            '<Bounds X="2000" Y="5140" Width="780" Height="250" />' +
            '</ObjectInfo>' +  
            '</DieCutLabel>' ;
        return template;        
    }
    // dymo label for 1 by 3 
    public static String getImage1X3Xml(Inventory_Position__c invPos){
        Inventory_Position__c IPList = [SELECT  Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_City_State_Zip__c,
                                        Rack__r.Name,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c,
                                        Rack__c,Rack_Level__c,Rack_Level__r.Name,Bin_Location__r.Name,Bin_Location__c, Product_Name__r.Name,
                                        COA_Expiration_Date__c,Supplier_License_Number__c,Product_Name__c,License_Premise__c,Inventory_Qty__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c,
                                        Product_Description__c,Producer_Name__c,Stocking_UOM__c,Purchase_Order__c,COA_Number_New__c,Ownership__c,Ownership__r.name,		
                                        id , Supplier_Name__c
                                        from Inventory_Position__c where id =: invPos.Id];
        
        string producer = IPList.Producer_Name__c;
        string replacedProducerval;
        if(producer != null && producer.containsAny('&'))
        {
            replacedProducerval = producer.replace('&','&amp;');  
        }
        else
        {
            replacedProducerval = producer; 
        }
        string LicensePremises = IPList.License_Premise__c ;
        string LicensePremisesval;
        if(LicensePremises != null && LicensePremises.containsAny('&'))
        {
            LicensePremisesval = LicensePremises.replace('&','&amp;');  
        }
        else
        {
            LicensePremisesval = LicensePremises; 
        }
        
        string Product = IPList.Product_Name__r.Name ;
        string Productval;
        if(Product != null && Product.containsAny('&'))
        {
            Productval = Product.replace('&','&amp;');  
        }
        else
        {
            Productval = Product; 
        }
        
        string UOM = IPList.Stocking_UOM__c ;
        string UOMval;
        if( UOM != null && UOM.containsAny('&'))
        {
            UOMval = UOM.replace('&','&amp;');  
            
        }
        else
        {
            UOMval = UOM; 
        }
        string HarvestBatch = invPos.Harvest_Batch_Code__r.Name; 
        string HarvestBatchval;
        if( HarvestBatch != null &&  HarvestBatch.containsAny('&'))
        {
            HarvestBatchval = HarvestBatch.replace('&','&amp;');  
        }
        else
        {
            HarvestBatchval = HarvestBatch; 
        }   
        string Licensenum =  IPList.Supplier_License_Number__c;
        string Licensenumval;
        if(Licensenum != null &&  Licensenum.containsAny('&'))
        {
            Licensenumval = Licensenum.replace('&','&amp;');  
        }
        else
        {
            Licensenumval = Licensenum; 
        }     
        string Productdes = IPList.Product_Description__c;
        string Productdesval;
        if( Productdes != null && Productdes.containsAny('&'))
        {
            Productdesval = Productdes.replace('&','&amp;');  
            
        }
        else
        {
            Productdesval = Productdes; 
            
        }
        decimal mysmQTYval;
        decimal IQty = IPList.Inventory_Qty__c;
        Integer mysmQTY = Integer.valueOf(IPList.Inventory_Qty__c );
        
        if(mysmQTY ==IQty)
        {
            mysmQTYval = Integer.valueOf(IPList.Inventory_Qty__c );
        }
        else
        {
            mysmQTYval = IPList.Inventory_Qty__c;
        }
        
        String IPQty = '';
        if(IPList.Inventory_Qty__c != null)
        {
            IPQty = IPQty+ '<ObjectInfo>' +
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
                '  <String>' + mysmQTYval + '</String>' +
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
                '</ObjectInfo>' ;
        }     
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
            '<String>' + (!String.isBlank(Licensenumval) ? Licensenumval : '') + '</String>' +
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
            '<String>' + (!String.isBlank(replacedProducerval) ? replacedProducerval : '') + '</String>' +
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
            '<String>' + (!String.isBlank(LicensePremisesval) ? LicensePremisesval : '') + '</String>' +
            '<Attributes>' +
            '<Font Family="Calibri" Size="14" Bold="False" Italic="False" Underline="False" Strikeout="False" />' +
            '<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />' +
            '</Attributes>' +
            '</Element>' +
            '</StyledText>' +
            '       <ShowBarcodeFor9DigitZipOnly>False</ShowBarcodeFor9DigitZipOnly>' +
            '       <BarcodePosition>Suppress</BarcodePosition>' +
            '       <LineFonts />' +
            '   </AddressObject>' +
            '   <Bounds X="410.8696" Y="1233.913" Width="1408.696" Height="170.7391" />' +
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
            '  <String>'  + (!String.isBlank(Productval) ? Productval : '') +'</String>' +
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
            '<String>' + (!String.isBlank(Productdesval) ? Productdesval : '') + '</String>' +
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
            '  <String>' +(!String.isBlank(IPList.Purchase_Order__c) ? IPList.Purchase_Order__c : '') + '</String>' +
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
            '<String>' + (!String.isBlank(HarvestBatchval) ? HarvestBatchval: '') + '</String>' +
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
            IPQty +
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
            '  <String>' +(!String.isBlank( UOMval ) ?  UOMval  : '')  + '</String>' +
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
    
    
     public static String getImage2X4XmlQR(Inventory_Position__c invPos){
        Inventory_Position__c IPList = [SELECT  Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_City_State_Zip__c,Inventory_Location__r.Name,
                                        Rack__r.Name,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Address__c,Site__r.Name,Site__r.Warehouse_Name__c,	
                                        Rack__c,Rack_Level__c,Rack_Level__r.Name,Bin_Location__r.Name,Bin_Location__c, Product_Name__r.Name,Harvest_Batch_Code__r.Name,
                                        COA_Expiration_Date__c,Supplier_License_Number__c,Product_Name__c,License_Premise__c,Inventory_Qty__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_City__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_State__c,
                                        Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_License__r.License_Zip__c,
                                        Product_Description__c,Producer_Name__c,Stocking_UOM__c,Purchase_Order__c,COA_Number_New__c,Ownership__c,
                                        Ownership__r.name, id , Supplier_Name__c  from Inventory_Position__c where id =: invPos.Id];		
                                        
           system.debug('invPos.Site__r.Warehouse_Name__c'+IPList.Site__r.Warehouse_Name__c);
                String SiteWarehouse = IPList.Site__r.Warehouse_Name__c ;
         string SiteWarehouseval;
        if(SiteWarehouse !=null && SiteWarehouse.containsAny('&'))
       {
            SiteWarehouseval = SiteWarehouse.replace('&','&amp;');  
        }
        else
        {
            SiteWarehouseval = SiteWarehouse; 
        } 
         
         String HarvestBatchCode = invPos.Harvest_Batch_Code__r.Name ;
         string HarvestBatchCodeval;
        if(HarvestBatchCode !=null && HarvestBatchCode.containsAny('&'))
       {
            HarvestBatchCodeval = HarvestBatchCode.replace('&','&amp;');  
        }
        else
        {
            HarvestBatchCodeval = HarvestBatchCode; 
        }  
         
          String Site =invPos.Site__r.Name ;
         string Siteval;
        if(Site !=null && Site.containsAny('&'))
       {
            Siteval = Site.replace('&','&amp;');  
        }
        else
        {
            Siteval = Site; 
        }
         
         string SiteWarehouseConcat = Siteval + ' {' +SiteWarehouseval +'}';

          String IPUID = invPos.UID_New__r.Name;
         string IPUIDval;
        if(IPUID !=null && IPUID.containsAny('&'))
       {
            IPUIDval = IPUID.replace('&','&amp;');  
        }
        else
        {
            IPUIDval = IPUID; 
        }
          String InvLoc = invPos.Inventory_Location__r.Name;
         string InvLocval;
        if(InvLoc !=null && InvLoc.containsAny('&'))
       {
            InvLocval = InvLoc.replace('&','&amp;');  
        }
        else
        {
            InvLocval = InvLoc; 
        }
           string Product = IPList.Product_Name__r.Name ;
        string Productval;
        if(Product != null && Product.containsAny('&'))
        {
            Productval = Product.replace('&','&amp;');  
        }
        else
        {
            Productval = Product; 
        }
        
         
           string rack= IPList.Rack__r.Name;
        string Level= IPList.Rack_Level__r.Name;
        string Bin= IPList.Bin_Location__r.Name;
        string RLB = rack + '-' + Level + '-' + Bin;
        string RLBs = RLB;
    system.debug('RLBsRLBsRLBs>>'+RLBs);
       //  string QRData ='12345';
         string QRData = Productval  + ' - ' + HarvestBatchCode + ' - '+ Siteval + ' - ' + InvLocval + ' - ' + rack + ' - ' + Level + ' - ' + Bin;
        string QRDatas = QRData;
    system.debug('QRDatas>>'+QRDatas);
        string RLBsval;
    integer RLBcharLength;
    if(RLBs !=null)
    {
        RLBcharLength = RLB.length();
system.debug('RLBcharLength>>>>>>>>>>>>>>>>>>'+RLBcharLength);    
    }
 
        if(RLBs != null && RLBs.containsAny('&'))
        {
            RLBsval = RLBs.replace('&','&amp;');  
        }
        else
        {
            RLBsval = RLBs; 
        } 
      
         
        
          string secondPageOnwards =
              '<DieCutLabel Version="8.0" Units="twips"> '+
	'<PaperOrientation>Portrait</PaperOrientation> '+
	'<Id>Shipping</Id> '+
	'<PaperName>30323 Shipping</PaperName> '+
	'<DrawCommands> '+
		'<RoundRectangle X="0" Y="0" Width="3060" Height="5715" Rx="270" Ry="270" /> '+
	'</DrawCommands> '+
	'<ObjectInfo> '+
		'<TextObject> '+
			'<Name>Text</Name> '+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /> '+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" /> '+
			'<LinkedObjectName></LinkedObjectName> '+
			'<Rotation>Rotation0</Rotation> '+
			'<IsMirrored>False</IsMirrored> '+
			'<IsVariable>True</IsVariable> '+
			'<HorizontalAlignment>Center</HorizontalAlignment> '+
			'<VerticalAlignment>Middle</VerticalAlignment> '+
			'<TextFitMode>ShrinkToFit</TextFitMode> '+
			'<UseFullFontHeight>True</UseFullFontHeight> '+
			'<Verticalized>False</Verticalized> '+
			'<StyledText> '+
				'<Element> '+
					'<String>Click here to enter text</String> '+
					'<Attributes> '+
						'<Font Family="Arial" Size="24" Bold="False" Italic="False" Underline="False" Strikeout="False" /> '+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /> '+
					'</Attributes> '+
				'</Element> '+
			'</StyledText> '+
		'</TextObject> '+
		'<Bounds X="310" Y="322" Width="2540" Height="5070" /> '+
	'</ObjectInfo> '+
	'<ObjectInfo> '+
		'<ImageObject> '+
			'<Name>GRAPHIC</Name> '+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" /> '+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" /> '+
			'<LinkedObjectName></LinkedObjectName> '+
			'<Rotation>Rotation0</Rotation> '+
			'<IsMirrored>False</IsMirrored> '+
			'<IsVariable>False</IsVariable> '+
			'<Image>iVBORw0KGgoAAAANSUhEUgAAAcAAAAKkCAYAAACXqO+iAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAAtESURBVHhe7d1BSptdGIDRm0RBpBQctzhzA4ID6SoKrsIddNLlOAvUBQjO3IJjJzqRIDhoR20N4aeBP0OL6XPOJO+9WcDDvd9HMvn52wCAmOnqEwBSBBCAJAEEIGntGeDz8/P48ePHct7d3R3v379fzgDwr1kL4Pn5+bi8vByTyWScnp6Oi4uLMZvNVt8CwPaZTv//snMtgJ8/fx7fvn1bzu/evRsnJyfLGALAtrq6ulpN69YCeHZ2Nubz+WoFANvvj8yt8RIMAEkbT4AHBweuQAHYKi/N+v79+7i5ufnvpc5NJ8CNAfz06dO4vr4eOzs7yzUAbIP7+/txfHw8Hh4elutNAXQFCkCSAAKQJIAAJAkgAEkCCECSAAKQJIAAJAkgAEkCCECSAAKQJIAAJAkgAEkCCEDSXw/gpl/lBoC/6a8H0P8LAvAWuAIFIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAEEIEkAAUgSQACSBBCAJAHkVT0+Po7b29txd3e32gF4GwSQV/USwMViMWaz2WoH4G0QQF7V/v7+ODw8HB8+fFjtALwNAsir+vjxo/gBb5IAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkCSAASQIIQJIAApAkgAAkbQzgdDodOzs7qxUAbIe9vb0xmUxWq80mP39bzePs7GzM5/PlfHR0NL58+bIMIQBsg5dmLRaL8fXr1/H09LTc+yNzazYGEAD+BZsC6HgHQJIAApC0dgUKABVOgAAkCSAASQIIQJIAApAkgAAkCSAAQWP8At3RikTNvukYAAAAAElFTkSuQmCC</Image> '+
			'<ScaleMode>Fill</ScaleMode> '+
			'<BorderWidth>0</BorderWidth> '+
			'<BorderColor Alpha="255" Red="0" Green="0" Blue="0" /> '+
			'<HorizontalAlignment>Left</HorizontalAlignment> '+
			'<VerticalAlignment>Top</VerticalAlignment> '+
		'</ImageObject> '+
		'<Bounds X="86" Y="307" Width="2854" Height="5323" /> '+
	'</ObjectInfo> '+
              '<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Product</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="199" Y="500" Width="810" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_1</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					  '<String>'+(!String.isBlank(Productval)?Productval : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="199" Y="750" Width="2625" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_2</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>UID</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="184" Y="1050" Width="540" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_3</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                  '<String>'+(!String.isBlank(IPUIDval)?IPUIDval : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="169" Y="1300" Width="2580" Height="330" />'+
	'</ObjectInfo>'+
      '<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_batch</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Batch ID</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="184" Y="1600" Width="800" Height="240" />'+
	'</ObjectInfo>'+   
              '<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_3</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                  '<String>'+(!String.isBlank(HarvestBatchCodeval)?HarvestBatchCodeval : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="169" Y="1900" Width="2580" Height="330" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_4</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Site:</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="180" Y="2200" Width="570" Height="255" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_5</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                  '<String>'+(!String.isBlank(SiteWarehouseConcat)?SiteWarehouseConcat : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="610" Y="2200" Width="2000" Height="210" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_6</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Inventory Location:</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="10" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="180" Y="2400" Width="1900" Height="250" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_7</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                  '<String>'+(!String.isBlank(InvLocval)?InvLocval : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="1890" Y="2400" Width="900" Height="225" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_8</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Rack :</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="176" Y="2650" Width="630" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_9</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                  '<String>'+(!String.isBlank(rack)?rack : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="850" Y="2650" Width="690" Height="225" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_10</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Rack Level : </String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="184" Y="2890" Width="1275" Height="255" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_11</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
                 '<String>'+(!String.isBlank(Level)?Level : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="1350" Y="2890" Width="1080" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_12</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
					'<String>Bin :</String>'+
					'<Attributes>'+
						'<Font Family="Arial" Size="9" Bold="True" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
			'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="176" Y="3200" Width="465" Height="240" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<TextObject>'+
			'<Name>TEXT_13</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<HorizontalAlignment>Left</HorizontalAlignment>'+
			'<VerticalAlignment>Top</VerticalAlignment>'+
			'<TextFitMode>ShrinkToFit</TextFitMode>'+
			'<UseFullFontHeight>True</UseFullFontHeight>'+
			'<Verticalized>False</Verticalized>'+
			'<StyledText>'+
				'<Element>'+
              	'<String>'+(!String.isBlank(Bin)?Bin : '')+'</String>' +
					'<Attributes>'+
						'<Font Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
						'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
					'</Attributes>'+
				'</Element>'+
			'</StyledText>'+
		'</TextObject>'+
		'<Bounds X="650" Y="3200" Width="1485" Height="225" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<ShapeObject>'+
			'<Name>SHAPE_2</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<ShapeType>HorizontalLine</ShapeType>'+
			'<LineWidth>15</LineWidth>'+
			'<LineAlignment>Center</LineAlignment>'+
			'<FillColor Alpha="0" Red="255" Green="255" Blue="255" />'+
		'</ShapeObject>'+
		'<Bounds X="124" Y="1480" Width="2720" Height="15" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<ShapeObject>'+
			'<Name>SHAPE_3</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<ShapeType>HorizontalLine</ShapeType>'+
			'<LineWidth>15</LineWidth>'+
			'<LineAlignment>Center</LineAlignment>'+
			'<FillColor Alpha="0" Red="255" Green="255" Blue="255" />'+
		'</ShapeObject>'+
		'<Bounds X="124" Y="1000" Width="2700" Height="15" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<ShapeObject>'+
			'<Name>SHAPE</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<ShapeType>HorizontalLine</ShapeType>'+
			'<LineWidth>15</LineWidth>'+
			'<LineAlignment>Center</LineAlignment>'+
			'<FillColor Alpha="0" Red="255" Green="255" Blue="255" />'+
		'</ShapeObject>'+
		'<Bounds X="109" Y="3500" Width="2820" Height="15" />'+
	'</ObjectInfo>'+
              '<ObjectInfo>'+
		'<ShapeObject>'+
			'<Name>SHAPE_4</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<ShapeType>HorizontalLine</ShapeType>'+
			'<LineWidth>15</LineWidth>'+
			'<LineAlignment>Center</LineAlignment>'+
			'<FillColor Alpha="0" Red="255" Green="255" Blue="255" />'+
		'</ShapeObject>'+
		'<Bounds X="109" Y="2150" Width="2820" Height="15" />'+
	'</ObjectInfo>'+
	'<ObjectInfo>'+
		'<BarcodeObject>'+
			'<Name>BARCODE</Name>'+
			'<ForeColor Alpha="255" Red="0" Green="0" Blue="0" />'+
			'<BackColor Alpha="0" Red="255" Green="255" Blue="255" />'+
			'<LinkedObjectName></LinkedObjectName>'+
			'<Rotation>Rotation0</Rotation>'+
			'<IsMirrored>False</IsMirrored>'+
			'<IsVariable>False</IsVariable>'+
			'<Text>'+(!String.isBlank(QRDatas)?QRDatas : '')+'</Text> '+	
			'<Type>QRCode</Type>'+
			'<Size>Large</Size>'+
			'<TextPosition>None</TextPosition>'+
			'<TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
			'<CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />'+
			'<TextEmbedding>None</TextEmbedding>'+
			'<ECLevel>0</ECLevel>'+
			'<HorizontalAlignment>Center</HorizontalAlignment>'+
			'<QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />'+
		'</BarcodeObject>'+
		'<Bounds X="259" Y="3500" Width="2505" Height="1575" />'+
	'</ObjectInfo>'+
'</DieCutLabel> ';
                return secondPageOnwards;
          
    }
    
}