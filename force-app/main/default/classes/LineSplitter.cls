public class LineSplitter {

    public static final Integer DEFAULT_LINE_LENGTH = 70;

    // pdf renderer doesn't convert new lines into breaks, so have
    // to manually use <br/>
    public static final String NEW_LINE = ' ';

    // anything in here is where we try to split words if we can
    private static String SPLIT_CHARS = ' -';

    // assignTo variable names can't match attribute names, hence the 'my' prefix
    public Integer myLineLength { get; set; }
    public String myInput { get; set; }
    public String output {
        get {
            if (output == null) {
                output = splitLines(myInput, myLineLength);
            }
            return output;
        }
        private set;
    }



    // pre-split on existing line breaks before passing to line splitter
    // since vf pdf rendering ignores line breaks
    private static String splitLines(String input, Integer lineLength) {
        if (input == null) return input;
        List<String> finalLines = new List<String>();
        for (String singleLine : input.split('\n')) {
            finalLines.add(splitLinesSingleLine(singleLine, lineLength));
        }
        return String.join(finalLines, NEW_LINE);
    }

    // splits single lines, core splitting
    // special thanks to @icr for providing something that was a huge
    // stretch to get working in Apex https://stackoverflow.com/a/17635/84130
    private static String splitLinesSingleLine(String input, Integer lineLength) {
        if (lineLength == null) { lineLength = DEFAULT_LINE_LENGTH; }
        if (input == null || input.length() <= lineLength) return input;

        String[] words = explode(input, SPLIT_CHARS);

        Integer curLineLength = 0;
        List<String> strBuilder = new List<String>();
        for(Integer i = 0; i < words.size(); i += 1)
        {
            String word = words[i];
            // If adding the new word to the current line would be too long,
            // then put it on a new line (and split it up if it's too long).
            if (curLineLength + word.length() > lineLength) {
                // Only move down to a new line if we have text on the current line.
                // Avoids situation where wrapped whitespace causes emptylines in text.
                if (curLineLength > 0) {
                    strBuilder.add(NEW_LINE);
                    curLineLength = 0;
                }

                // If the current word is too long to fit on a line even on it's own then
                // split the word up.
                while (word.length() > lineLength) {
                    strBuilder.add(word.subString(0, lineLength - 1) + '');
                    word = word.subString(lineLength - 1);
                    strBuilder.add(NEW_LINE);
                }

                // Remove leading whitespace from the word so the new line starts flush to the left.
                // ??? no trimStart() analogue in apex, trying with trim(), revisit if there are
                // issues
                // word = word.TrimStart();
                word = word.trim();
            }
            strBuilder.add(word);
            curLineLength += word.length();
        }

        String combinedLine = String.join(strBuilder, '');

        // clear out any trailing whitespace on lines
        combinedLine = combinedLine.replaceAll('\\s*<br/>', '<br/>');
        return combinedLine;
    }

    // tokenize thing into word parts based on split characters
    private static String[] explode(String str, String splitCharacters) {
        List<String> parts = new List<String>();
        if (str != null) {
            Integer startIndex = 0;
            while (true) {
                Integer preIndex = str.subString(startIndex).indexOfAny(splitCharacters);
                Integer index = startIndex + preIndex;

                if (preIndex == -1) {
                    parts.add(str.subString(startIndex));
                    break;
                }

                String word = str.subString(startIndex, index);
                String nextChar = str.subString(index, index + 1);

                // Dashes and the likes should stick to the word occuring before it. Whitespace doesn't have to.
                if (nextChar.isWhiteSpace()) {
                    parts.Add(word);
                    parts.Add(nextChar);
                } else {
                    parts.Add(word + nextChar);
                }

                startIndex = index + 1;
            }
        }
        return parts;
    }

}