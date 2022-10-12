/*
GLobal exception class to capture application error into error log object.
*/
/*
    Copyright (c) 2018 Filigreen Distro
    All rights reserved.

•  Test class  Name:  ErrorLog_Test
*/

global class ErrorLogs  {

global static void log(String fileName, String errorMessage)

{
	Error_Log__c eLog = new Error_Log__c();
	eLog.File_Name__c = fileName;
	if(errorMessage.length() >255)
		eLog.Error_Message__c = errorMessage.substring(0,254);
	else
		eLog.Error_Message__c = errorMessage;
	insert eLog;
}

global static void log(String fileName, String errorMessage, Exception e)
{
	Error_Log__c eLog = new Error_Log__c();
	eLog.File_Name__c = fileName;
	if(errorMessage.length() >255)
		eLog.Error_Message__c = errorMessage.substring(0,254);
	else
		eLog.Error_Message__c = errorMessage;
	eLog.Additional_Information__c = String.valueOf(e);
	insert eLog;
}
global static void log(String fileName, String errorMessage, String additionalInfo)
{
	Error_Log__c eLog = new Error_Log__c();
	eLog.File_Name__c = fileName;
	if(errorMessage.length() >255)
		eLog.Error_Message__c = errorMessage.substring(0,254);
	else
		eLog.Error_Message__c = errorMessage;
	eLog.Additional_Information__c = additionalInfo;
	insert eLog;
}
global static Error_Log__c AutomationFailedLog(String fileName, String errorMessage, String additionalInfo)
{
	Error_Log__c eLog = new Error_Log__c();
	eLog.File_Name__c = fileName;
	if(errorMessage.length() >255)
		eLog.Error_Message__c = errorMessage.substring(0,254);
	else
		eLog.Error_Message__c = errorMessage;
	eLog.Additional_Information__c = additionalInfo;
	insert eLog;
    return eLog;
}

}