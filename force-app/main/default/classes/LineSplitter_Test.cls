@isTest
private class LineSplitter_Test {

    @isTest
    private static void nullTest() {
        runTest(null, null, null);
    }

    @isTest
    private static void noSplitTest() {
        runTest('asdf', null, 'asdf');
    }

    @isTest
    private static void simpleSplit() {
        String input = 'A sample string to split.';
        Integer lineLength = 13; // split is middle of 'string'
        String output = 'A sample' + LineSplitter.NEW_LINE +
            'string to' + LineSplitter.NEW_LINE +
            'split.';
        runTest(input, lineLength, output);
    }

    @isTest
    private static void codeSplit() {
        String input = 'BEADI-MTVAD-9SEAA';
        Integer lineLength = 7;
        String output = 'BEADI-' + LineSplitter.NEW_LINE +
            'MTVAD-' + LineSplitter.NEW_LINE +
            '9SEAA';
        runTest(input, lineLength, output);
    }

    @isTest
    private static void longWord() {
        String input = 'veryverylongword';
        Integer lineLength = 10;
        String output = 'veryveryl-' + LineSplitter.NEW_LINE +
            'ongword';
        runTest(input, lineLength, output);
    }

    private static void runTest(String input, Integer lineLength, String expected) {
        LineSplitter splitter = new LineSplitter(); 
        splitter.myInput = input;
        splitter.myLineLength = lineLength;
		System.debug('Output: '+splitter.output); 
    }
}