/**************************************************************************************
Apex Class Name    : Metrc_Utility
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : used for utility
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
public with sharing class Metrc_Utility{
    public static boolean IS_STRAIN_TRIGGER_ENABLED = true;
    public static boolean IS_PROD_TRIGGER_ENABLED = true;
    public static boolean IS_INVENTORYLOCATION_TRIGGER_ENABLED = true;
    public static boolean IS_PICKLIST_TRIGGER_ENABLED= true;
    public static boolean IS_SHIPPINGMANIFEST_TRIGGER_ENABLED = true;
    //public static boolean IS_INVOICE_TRIGGER_ENABLED = true;
    Public static String mappingUOM='{"BBL":"Barrel","BCK":"Bucket","BG":"Bag","BT":"Bottle","BX":"Box","CS":"Case","CT":"Count","DAY":"Day","DZ":"Dozen","EA":"Each","FT":"Feet","GL":"Gallon","HR":"Hour","IN":"Inch","LB":"Pounds","LI":"Liter","LT":"Liter","MG":"Milligrams","MI":"Mile","MIN":"Minute","ML":"Milliliters","OZ":"Ounces","PT":"Pint","QT":"Quart","SEC":"Second","SF":"Square Foot","SQ":"SQ","GM":"Grams"}';
 }