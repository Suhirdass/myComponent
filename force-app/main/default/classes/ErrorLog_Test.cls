@isTest 
private class ErrorLog_Test {

	@isTest
	private static void testName() {
	ErrorLogs.log('test file', 'test msg');
	ErrorLogs.log('test file','test', 'test');
	Exception e;
	ErrorLogs.log('test file','test', e);
        ErrorLogs.AutomationFailedLog('test file','test', 'test');
	}
}