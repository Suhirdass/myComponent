public class XMLParser {
   // To find the root element so that we can enclose it in the curly braces 
    public static String rootElementName; 
     public static String accids; 
    /* Method which is parsing the XML content into JSON 
     * @param xml : XML String 
     * return     : JSON String
    */
    
    public static String xmlToJson(String xml,string recordId) {
        
        accids = recordId;
         system.debug('accids'+accids);
        // Load the xml in the document
        Dom.Document doc = new Dom.Document();
        doc.load(xml);
        Dom.XMLNode root = doc.getRootElement();
        
        // Pass the root element and false as the second parameter
        String jsonContent = XMLParser.parse(root, false);
        
        return jsonContent;
}	
     /* Method which makes the recursive calls and creates the JSON for
     * each element, it processes each node and finds the attributes and text content of a node
     * @param node      : Dom.XMLNode instance - XML node which will be processed
     * @param isChild   : Boolean - To control the structure of JSON, should be true for child element
     * return           : JSON string 
    */ 
    public static String parse(Dom.XMLNode node, Boolean isChild){
        
        String json = '';
        Boolean isArray = false;
        if ( rootElementName == null ) {
            rootElementName = node.getName();
        }
        
        if ( node.getNodeType() == Dom.XmlNodeType.ELEMENT ){
            
            Map<String, List<String>> mapChildrenJSON = new Map<String, List<String>>();
            List<String> lstJSONForChildren = new List<String>();
            
            // Check whether node has any child
            List<Dom.XMLNode> children = node.getChildElements();
            
            if ( children.size() > 0 ){
            
                // Process all the children in a row
                for ( Dom.XMLNode child : children ){
                    
                    String tmp = parse( child, true);
                    
                    if( tmp != '' ) {
                    
                        if ( !mapChildrenJSON.containsKey( child.getName() ) ){
                        
                            mapChildrenJSON.put( child.getName(), new List<String>() );     
                        
                        }
                        
                        // Add into a map to make a collection for the repeatative child nodes
                        mapChildrenJSON.get( child.getName() ).add( tmp );  
                    
                    }
                    
                } 
                
                // Strcuture the JSON based on the repeation 
                // Should be treated as an array if there are multiple elements with the same node name
                for ( String key : mapChildrenJSON.keySet() ){
                    
                    if ( mapChildrenJSON.get(key).size() > 1 ){
                        if(isChild) {
                        
                            lstJSONForChildren.add( '[' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                        
                        }
                        else {
                        
                            lstJSONForChildren.add( '"' + key + '": [' + String.join(mapChildrenJSON.get(key), ', ') + ']' );
                                
                        }
                        isArray = true;
                    }
                    else {
                    
                        lstJSONForChildren.add( '"' + key + '": ' + mapChildrenJSON.get(key)[0] );
                    
                    }
                }
            }
            
            // Construc the JSON for all the node attributes 
            List<String> lstAttributes = new List<String>( lstJSONForChildren );
            
            for ( Integer i=0; i<node.getAttributeCount(); i++){
                
                String key = node.getAttributeKeyAt( i );
                String value = node.getAttribute( key, '' );
                lstAttributes.add( '"' + key + '": "' + value + '"' );    
            
            }  
            
            // Look for the text content 
            String textContent = node.getText();
            if ( textContent != null && textContent.trim() != '' ) {
            
                textContent = textContent.replace( '"', '\\"' );
                lstAttributes.add( '"ele_text": "' + textContent + '"' );  // Text which is part of the element
                  
            }
            if ( !isChild ){
            
                if(!isArray) {
                
                    json = '"' + node.getName() + '": {' + String.join(lstAttributes,  ', ') + '}'; 
                    
                }
                else {
                
                    json = '[ {' + String.join(lstAttributes,  ', ') + '} ]'; 
                    
                }
            }
            else {
                if ( lstAttributes.size() == 1 && textContent != null && textContent.trim() != '' ){
                    
                    json = '"' + textContent + '"';
                    
                } 
                else {
                    if(!isArray) {
                    
                        if( lstAttributes.size() > 0 ){
                        
                            json = '{' + String.join(lstAttributes,  ', ') + '}'; 
                            
                        }
                        
                    }
                    else {
                    
                        json = String.join(lstAttributes,  ', '); 
                        
                    }
                }   
            }
        }
        if ( rootElementName == node.getName() ) {
        
            if(!isArray) {
            
                json = '{' + json + '}';
            
            }
            else {
                
                json = '{"' + node.getName() + '" : ' + json + '}';
                
            }
            
          
        }
    
accountQBIds(json);
        return json;
    }
    
    public static void accountQBIds(string json)
    {
       system.debug('json'+json);
           
    }
 public class AccountWrapper
 {
      public List<String> Customer {get;set;}
     
  public String Name {get;set;}
  public String Id {get;set;}
  public String Phone {get;set;}
  public AccountWrapper(List<String> lst)
  {
    this.Customer =lst;
     // this.Id =
   // this.Id =id;
   // this.Phone =phone;
  }
 }
    /*   public class channel {
        public String title {get;set;}
        public String link {get;set;}
        public String description {get;set;}
        public String pubDate {get;set;}
        public String source {get;set;}
        public list<LHC_HomePageController.item> items {get;set;}
        public channel() {
            items = new list<LHC_HomePageController.item>();
        }
    }  
    
   public class item {
        public String title {get;set;}
        public String link {get;set;}
        public String description {get;set;}
        public String pubDate {get;set;}
        public String source {get;set;}
        public String mediaURL {get;set;}
        public Date getPublishedDate() {  Date result = (pubDate != null) ? Date.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;return result;
        }
        public DateTime getPublishedDateTime() {  DateTime result = (pubDate != null) ? DateTime.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;return result;            
        }
    } 
    
   public static LHC_HomePageController.channel getRSSData(string feedURL) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(feedURL);
        req.setMethod('GET');        
        Dom.Document doc = new Dom.Document();
        String xmlDom = '';
        Http h = new Http();
        HttpResponse res; 
        if (!Test.isRunningTest()){ 
            try{ res = h.send(req);
            }catch(Exception ex){ return null;
            }
            // Generate the HTTP response as an XML stream          
            if(res.getBody() != null){
                doc.load(res.getBody().replace('&', EncodingUtil.urlEncode('&','UTF-8')).replace('<![CDATA[','').replace(']]>',''));//res.getBody());
            }            
            
        } 
        Dom.XMLNode rss = doc.getRootElement();
            LHC_HomePageController.channel result = new LHC_HomePageController.channel();
                list<LHC_HomePageController.item> rssItems = new list<LHC_HomePageController.item>();
//
        if(rss != null)
            {
        Dom.XMLNode channel = rss.getChildElements()[0];
        for(Dom.XMLNode elements : channel.getChildElements()) {
            if('title' == elements.getName()) { result.title = elements.getText();} 
            if('link' == elements.getName()) {result.link = elements.getText();}
            if('description' == elements.getName()) { result.description = elements.getText();}
            if('item' == elements.getName()) { 
LHC_HomePageController.item rssItem = new LHC_HomePageController.item();
                for(Dom.XMLNode xmlItem : elements.getChildElements()) {                    
                    if('title' == xmlItem.getName()) {rssItem.title = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8'); }
                    if('link' == xmlItem.getName()) { rssItem.link = xmlItem.getText();}
                    if('description' == xmlItem.getName()) {  rssItem.description = xmlItem.getText();}
                    if('pubDate' == xmlItem.getName()) { rssItem.pubDate = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8');}
                    if('content' == xmlItem.getName()) { rssItem.mediaURL = EncodingUtil.urlDecode(xmlItem.getAttribute('url', null),'UTF-8');}
                     if('creator' == xmlItem.getName()) {rssItem.source = xmlItem.getText();}
                    
                }
                //for each item, add to rssItem list
                rssItems.add(rssItem); 
                system.debug('rssItems'+rssItems);
                break;
            }
           
        }
        result.items = rssItems;    
                }
        return result;
                
    }*/
}