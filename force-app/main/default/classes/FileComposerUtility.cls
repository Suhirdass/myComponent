public class FileComposerUtility {
    public static FiligreenFileDetails getFileData(FiligreenFileDetails details,String recordId, String templateId,String queryId, String line ){
           system.debug('First method>>');
        
  			system.debug('getFileData>>'+details);
        system.debug('recordId>>'+recordId);  
        system.debug('templateId>>'+templateId);
         system.debug('queryId>>'+queryId);
        system.debug('line>>'+line);
        
      system.debug('getFileData>>>456'+details);
        Id recId = recordId;
      details.template = [SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Id =: templateId];
      details.selectedTemplatedId = templateId;
        ContentDocumentLink[] cLinks = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId = :templateId AND ContentDocument.FileExtension= 'docx' Order By ContentDocument.CreatedDate DESC];
        if(!cLinks.isEmpty()){
            system.debug('aaa');
            ContentVersion[] cvs =  [SELECT Id, Title,VersionData FROM ContentVersion WHERE ContentDocumentId = :cLinks[0].ContentDocumentId Order By CreatedDate DESC];
            if(!cvs.isEmpty()){
                system.debug('bbb');
                details.templateBody = 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml;base64,'+EncodingUtil.Base64Encode(cvs[0].VersionData);
            }
        }
        String objName = recId.getSObjectType().getDescribe().getName();
        details.objectName = objName;
        String JSONData = '';
        objName = objName.toUpperCase();
        String query = 'SELECT ';
        Map<String,Object> fieldAndValueMap = new Map<String,Object>();
        Map<String,Map<String,Object>> invoiceFieldAndValueMap = new Map<String,Map<String,Object>>();
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();
        String comma = '';
        for(Schema.SObjectField fld :objectFields.values()){
            schema.describeFieldResult dfield = fld.getDescribe();            
            string fldType = string.valueOf(dfield.getType());
            String fName = dfield.Name.toUpperCase();
            query += comma + fName;
            comma = ',';     
               
                    
         
    
            //DISTRIBUTOR_NAME__r.Name
            fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),null);
            if (fldType == 'REFERENCE'){ // Lookup field!
                if(dfield.isCustom()){
                    String key = objName.replace('__C','_')+fName.replace('__C','__R');
                    query += comma + fName.replace('__C','__r.Name');
                    fieldAndValueMap.put(key,null);
                }else{
                    query += comma + fName.replace('ID','.Name');
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),null);
                }
            }
        }
        query += ' FROM '+objName;
        query += ' WHERE Id = :recordId';
        if(String.isNotBlank(query)){
            for(sObject obj: Database.query(query)){
                details.documentName = (String)obj.get('Name');
                details.recordId = (String)obj.get('Id');
                //Map<String,Object> fieldAndValueMapinvoice =  fieldAndValueMap.clone();
                for(Schema.SObjectField fld :objectFields.values()){
                    schema.describeFieldResult dfield = fld.getDescribe();
                    String fldType = string.valueOf(dfield.getType());
                    Integer scale;
                    if(fldType == 'DOUBLE' || fldType == 'CURRENCY'){
                        scale = dfield.getScale();
                    }
                    String fName = dfield.Name.toUpperCase();
                    system.debug('fName>>>'+fName);
                    
                    system.debug('Parent Value>>>'+getValue(fldType,obj.get(dfield.Name)));
                    
                    
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));    
                      system.debug('fName>>>'+fName);
                    if (fldType == 'REFERENCE'){ // Lookup field!
                        if(dfield.isCustom()){
                            String key = objName.replace('__C','_')+fName.replace('__C','__R');
                            sObject parent = obj.getSobject(dfield.Name.replace('__c','__r'));
                            if(parent != null)
                               // fieldAndValueMap.put(key,String.escapeSingleQuotes((String)parent.get('Name'))); 
                               fieldAndValueMap.put(key,parent.get('Name')); 
                        }else{
                            sObject parent = obj.getSobject (dfield.Name.replace('Id',''));
                            if(parent != null)
                               // fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),String.escapeSingleQuotes((String)parent.get('Name')));
                               fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),parent.get('Name'));
                        }
                    }
                }
                invoiceFieldAndValueMap.put((String)obj.get('Id'),fieldAndValueMap);
            }
        }
        FG_Queries__c fgQuery = [SELECT Id, Active__c,Query__c FROM FG_Queries__c WHERE Id = :queryId AND Active__c = true];
        String bqLinesQuery = fgQuery.Query__c != null ?fgQuery.Query__c :'';
        pattern pc = Pattern.compile('\\{[a-zA-Z0-9_\\s\\.]*\\}');
        Matcher mc = pc.matcher(bqLinesQuery);
        if(mc.find()){
            String param = bqLinesQuery.substring(mc.start()+1,mc.end()-1);                
        }
        String[] queryParts = bqLinesQuery.replace('SELECT ', '').split(' FROM');
        String bqLineFieldsStr = queryParts[0];
        String childObjName = queryParts[1].split(' WHERE')[0].trim();
        Map<String, Schema.SObjectField> childobjectFields = new Map<String, Schema.SObjectField>();
        if(String.isNotBlank(childObjName)){
            childobjectFields  = Schema.getGlobalDescribe().get(childObjName).getDescribe().fields.getMap();
        }
        String [] bqLineFields = bqLineFieldsStr.split(',');
        Set<String> finalBQLFields = new Set<String>();
        for(String field: bqLineFields){
            if(String.isNotBlank(field)){
                finalBQLFields.add(field.trim());
            }
        }
        List<Map<String,Object>> BQLFieldsMapList = new List<Map<String,Object>>();
        String childObjectName = childObjName.toUpperCase().replace('_C','');
        bqLinesQuery = bqLinesQuery.replace('{pv0}', recordId);
        for(sObject obj: Database.query(bqLinesQuery)){
            Map<String,Object> BQLFieldsMap = new Map<String,Object>();
            for(String field: finalBQLFields){
                Schema.SObjectField cField = childobjectFields.get(field);
               
                String fldType = '';
                if(cField != null){
                    schema.describeFieldResult dfield = cField.getDescribe();
                     system.debug('getNamegetNamegetName'+dfield.getName());
                    fldType = string.valueOf(dfield.getType());
                }
                
                
                  
                
                if(field.contains('.')){
                    String parentFieldName = field.replace('__r.', '_');
                    parentFieldName = parentFieldName.replace('.', '_');
                    parentFieldName = parentFieldName.toUpperCase();
                    String[] parentFields = field.split('\\.');
                    if(obj.get(parentFields[0].replace('__r','__c')) != null)
                           BQLFieldsMap.put(childObjectName+parentFieldName,obj.getSobject(parentFields[0]).get(parentFields[1]));
                       // BQLFieldsMap.put(childObjectName+parentFieldName,String.escapeSingleQuotes((String)obj.getSobject(parentFields[0]).get(parentFields[1])));
                    else
                            BQLFieldsMap.put(childObjectName+parentFieldName,null);
                }else{
                    
                    
                     if(childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_IS_SAMPLE' || childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_ISPROMO' )
                     {
                              String lineFieldName = childObjectName+field.replace('__c', '').toUpperCase();
                              BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),addCustomValue(fldType,obj.get(field),lineFieldName));
                     }else{
                         BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),getValue(fldType,obj.get(field))); 
                     }
                    
                    
                }                    
            }
            BQLFieldsMapList.add(BQLFieldsMap);
        }
        if(!BQLFieldsMapList.isEmpty()){     fieldAndValueMap.put(line,BQLFieldsMapList);
        }            
        if(!fieldAndValueMap.isEmpty()){
            JSONData = JSON.serialize(fieldAndValueMap, true);
            //JSONData = JSONData.replaceAll('null', '""');
        }        
        details.JSONData = String.escapeSingleQuotes(JSONData);
        system.debug('details.JSONData '+details.JSONData);
        return details;
    }
    
    
    public static FiligreenFileDetails getFileData(FiligreenFileDetails details,String recordId, String templateId,String queryId,String queryParams, String line ){
        
        system.debug('second method>>');
  			system.debug('getFileData>>'+details);
        system.debug('recordId>>'+recordId);
        system.debug('templateId>>'+templateId);
         system.debug('queryId>>'+queryId);
                 system.debug('queryParams>>'+queryParams);
        system.debug('line>>'+line);
        details.recordId = recordId;
        details.template = [SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Id =: templateId];
        details.selectedTemplatedId = templateId;
        ContentDocumentLink[] cLinks = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId = :templateId AND ContentDocument.FileExtension= 'docx' Order By ContentDocument.CreatedDate DESC];
        if(!cLinks.isEmpty()){
            ContentVersion[] cvs =  [SELECT Id, Title,VersionData FROM ContentVersion WHERE ContentDocumentId = :cLinks[0].ContentDocumentId Order By CreatedDate DESC];
            if(!cvs.isEmpty()){
                details.templateBody = 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml;base64,'+EncodingUtil.Base64Encode(cvs[0].VersionData);
            }
        }
        System.debug('##queryId:'+queryId);
        Id recId = recordId;
        String objName = recId.getSObjectType().getDescribe().getName();
        details.objectName = objName;
        String JSONData = '';
        objName = objName.toUpperCase();
        String query = 'SELECT ';
        Map<String,Object> fieldAndValueMap = new Map<String,Object>();
        Map<String, Schema.SObjectField> objectFields
            = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();
      
        String comma = '';
        for(Schema.SObjectField fld :objectFields.values()){
            schema.describeFieldResult dfield = fld.getDescribe();
            
            string fldType = string.valueOf(dfield.getType());
            String fName = dfield.Name.toUpperCase(); 
            system.debug('fName>>'+fName);
         if(fName=='OPPORTUNITY__C')
                {
                      query += comma;
                      comma = '';
                }else{
                   query += comma + fName;
                      comma = ',';
                }
         
            
            fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),null);
            if (fldType == 'REFERENCE'){ // Lookup field!
                if(dfield.isCustom()){
                    String key = objName.replace('__C','_')+fName.replace('__C','__R');
                    query += comma + fName.replace('__C','__r.Name');
                    
                   
                    fieldAndValueMap.put(key,null);
                }else{
                    query += comma + fName.replace('ID','.Name');
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),null);
                }
            }
        }
       query += ' FROM '+objName;
        if(String.isNotBlank(query)){
            query += ' WHERE Id = :recordId'; 
            system.debug('The query'+query);
            for(sObject obj: Database.query(query)){
                details.documentName = (String)obj.get('Name');
                for(Schema.SObjectField fld :objectFields.values()){
                    schema.describeFieldResult dfield = fld.getDescribe();
                    String fldType = string.valueOf(dfield.getType());
                    Integer scale;
                   system.debug('fldType>>>>' + fldType +'>>>>>'+obj.get(dfield.Name));
                     
                    if(fldType == 'DOUBLE' || fldType == 'CURRENCY'){
                        scale = dfield.getScale();
                    }
                    String fName = dfield.Name.toUpperCase();
                     if(fName =='DISTRIBUTOR_NAME__C')
                    {
                     // fieldAndValueMap.put(objName.DISTRIBUTOR_NAME__r.Name,null);
                    // fieldAndValueMap.put(SHIPPING_MANIFEST__C.DISTRIBUTOR_NAME__r.Name,null);

				system.debug('fieldAndValueMap===='+fieldAndValueMap);  
                    }
                    
                 system.debug('fName===='+fName);     
                    
                    
                    if(fName!='OPPORTUNITY__C')
                    {
                        fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));
                    }
                     if(fName=='ACTUAL_ARRIVAL_DATE_TIME__C')
                    {
                        fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));
                    }
                    system.debug('fieldAndValueMap>>'+fieldAndValueMap);
                    system.debug('obj.get(dfield.Name)>>'+obj.get(dfield.Name));

                    
                    if (fldType == 'REFERENCE'){ // Lookup field!
                        if(dfield.isCustom()){
                            String key = objName.replace('__C','_')+fName.replace('__C','__R');
                            sObject parent = obj.getSobject(dfield.Name.replace('__c','__r'));
                            if(parent != null)
                                fieldAndValueMap.put(key,parent.get('Name'));
                        }else{
                            sObject parent = obj.getSobject (dfield.Name.replace('Id',''));
                            if(parent != null)
                                 fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),parent.get('Name'));
                         }
                    }
                }
            }
            system.debug('queryId queryId '+queryId);
            FG_Queries__c fgQuery = [SELECT Id, Active__c,Query__c FROM FG_Queries__c WHERE Id = :queryId AND Active__c = true];
            String bqLinesQuery = fgQuery.Query__c != null ?fgQuery.Query__c :'';
            pattern pc = Pattern.compile('\\{[a-zA-Z0-9_\\s\\.]*\\}');
            Matcher mc = pc.matcher(bqLinesQuery);
            if(mc.find()){
                String param = bqLinesQuery.substring(mc.start()+1,mc.end()-1);
                System.debug('##:'+param);
                String[] queryParamsParts = queryParams.split('&');
                for(String p: queryParamsParts){
                    String[] pParts = p.split('=');
                    bqLinesQuery = bqLinesQuery.replace('{'+pParts[0]+'}',pParts[1]);
                }
                
            }
            System.debug('##'+bqLinesQuery.split('WHERE')[1]);
            String[] queryParts = bqLinesQuery.replace('SELECT ', '').split(' FROM');
            String bqLineFieldsStr = queryParts[0];
            
             System.debug('##queryParts'+queryParts); 
            String childObjName = queryParts[1].split(' WHERE')[0].trim();
            Map<String, Schema.SObjectField> childobjectFields = new Map<String, Schema.SObjectField>();
            if(String.isNotBlank(childObjName)){
                childobjectFields  = Schema.getGlobalDescribe().get(childObjName).getDescribe().fields.getMap();
            }
                System.debug('##childobjectFields'+childobjectFields); 
            String [] bqLineFields = bqLineFieldsStr.split(',');
            Set<String> finalBQLFields = new Set<String>();
            for(String field: bqLineFields){
                if(String.isNotBlank(field)){
                    finalBQLFields.add(field.trim());
                }
            }
            List<Map<String,Object>> BQLFieldsMapList = new List<Map<String,Object>>();
            String childObjectName = childObjName.toUpperCase().replace('_C','');
            system.debug('bqLinesQuery 123>>'+bqLinesQuery);
            system.debug('bqLinesQuery 123456>>'+Database.query(bqLinesQuery).Size());
            for(sObject obj: Database.query(bqLinesQuery)){ Map<String,Object> BQLFieldsMap = new Map<String,Object>();
                system.debug('finalBQLFields'+finalBQLFields);
                for(String field: finalBQLFields){ Schema.SObjectField cField = childobjectFields.get(field);
                   // system.debug('obj>>>>>>'+obj.getValues(id));
                    String fldType = '';
                    if(cField != null){ schema.describeFieldResult dfield = cField.getDescribe();
                        fldType = string.valueOf(dfield.getType());
                         system.debug('cField>'+cField);
                        system.debug('cField>'+cField);
                    }
                   String fldTypes = string.valueOf(cField);
                     system.debug('fldTypesfldTypes>'+fldTypes);  
                  
                    if(field.contains('.')){
                        String parentFieldName = field.replace('__r.', '_');
                        parentFieldName = parentFieldName.replace('.', '_');
                        parentFieldName = parentFieldName.toUpperCase();
                        String[] parentFields = field.split('\\.');
                        system.debug('childObjectName'+childObjectName);
                        system.debug('parentFieldName'+parentFieldName);
                        system.debug('obj.getSobject(parentFields[0]>>>>>missing data>>>>>>'+obj.getSobject(parentFields[0]));
                        system.debug('parentFieldName===='+obj.getSobject(parentFields[0]).get(parentFields[1]));

                        
                        if(obj.getSobject(parentFields[0]) != null){
                            BQLFieldsMap.put(childObjectName+parentFieldName,obj.getSobject(parentFields[0]).get(parentFields[1]));
                       // BQLFieldsMap.put(childObjectName+parentFieldName,(String.escapeSingleQuotes((String)obj.getSobject(parentFields[0]).get(parentFields[1]))));

                            }
                    }else{
                          system.debug('+obj.getSobject(parentFields[0]');
                         system.debug('>>>>>>>'+childObjectName+field.replace('__c', '').toUpperCase());
					 if(childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_IS_SAMPLE' || childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_ISPROMO' )
                     {
                        
                              String lineFieldName = childObjectName+field.replace('__c', '').toUpperCase();
                              BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),addCustomValue(fldType,obj.get(field),lineFieldName));
                     }else{
                       BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),getValue(fldType,obj.get(field)));

                         
                     }                            
                    }
                }
                BQLFieldsMapList.add(BQLFieldsMap);
            }
            system.debug('BQLFieldsMapList>>'+BQLFieldsMapList);
            if(!BQLFieldsMapList.isEmpty()){
                fieldAndValueMap.put(line,BQLFieldsMapList);
            }
         
            system.debug('fieldAndValueMap+++++'+fieldAndValueMap);
            if(!fieldAndValueMap.isEmpty()){
                JSONData = JSON.serialize(fieldAndValueMap, true);
                JSONData = JSONData.replaceAll('null', '""');
            }
            System.debug('##fieldAndValueMap::'+fieldAndValueMap);
        }
        details.JSONData = String.escapeSingleQuotes(JSONData);
        system.debug('JSONData>>'+JSONData);
        return details;
    }
    public static string getTemplateBody(String templateId){
        system.debug('getTemplateBody>>');
        String templateBody = '';
        ContentDocumentLink[] cLinks = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId = :templateId AND ContentDocument.FileExtension= 'docx' Order By ContentDocument.CreatedDate DESC];
        if(!cLinks.isEmpty()){
            ContentVersion[] cvs =  [SELECT Id, Title,VersionData FROM ContentVersion WHERE ContentDocumentId = :cLinks[0].ContentDocumentId Order By CreatedDate DESC];
            if(!cvs.isEmpty()){
                templateBody = 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml;base64,'+EncodingUtil.Base64Encode(cvs[0].VersionData);
            }
        }
        return templateBody;
    }
    /*private static Filigreen_Email_Template__c getTemplate(String templateId){
        if(String.isNotBlank(templateId)){
            Filigreen_Email_Template__c[] temaplates = [SELECT Id, Name, Subject__c, Description__c, Html_Body__c FROM Filigreen_Email_Template__c WHERE Id = :templateId];
            
            return temaplates.size()> 0 ?temaplates[0]:null; 
            
        }
        return null;
    }*/
    public static String mergeEmailBody(String recordId, String templateId,String line){
        String htmlBody;
        /*String lines = '';
        if(String.isNotBlank(line)){
            lines = line+'s';
        }
        Filigreen_Email_Template__c template = getTemplate(templateId);
        
        String htmlBody = template != null ? template.HTML_Body__c:'';
        String JSONData = '';//prepareFileData('Brand_Quote__c','Brand_Quote_Line__c',recordId);
        Map<String,Object> fieldAndValueMap = (Map<String,Object>) JSON.deserializeUntyped(JSONData);
        
        String[] htmlbodyTRWise = htmlBody.split('<tr>');
        String mergedHTMLBody = '';
        for(String row:htmlbodyTRWise){
            String mergedRow = '';
            pattern p = Pattern.compile('\\{\\{TableStart:'+line+'\\}\\}');
            Matcher m = p.matcher(row);
            if(m.find()){
                String lastColRemailingHTML = '';
                String[] columns = row.split('<td');
                Map<Integer,String> colsMap = new Map<Integer,String>();
                Integer i = 0;
                for(String col: columns){
                    if(String.isBlank(col)) continue;
                    col = col.replace('{{TableStart:'+line+'}}', '');
                    
                    //Check for TableEnd
                    if(col.indexOf('{{TableEnd:'+line+'}}') >= 0){
                        String[] cols = col.split('</tr>');
                        String lastCol = cols[0];
                        col = lastCol.replace('{{TableEnd:'+line+'}}', '');
                        lastColRemailingHTML = cols[1];
                    }
                    
                    colsMap.put(i++,col);
                }
                
                String linesHTML = '';
                if(String.isNotBlank(lines)){
                    List<Object> lineList = (List<Object>)fieldAndValueMap.get(lines);
                    List<List<String>> finalLineRecords = new List<List<String>>();
                    for(Object lineObj:lineList){
                        List<String> childRowMerged = new List<String>();
                        Map<String,Object> childFieldMap = (Map<String,Object>)lineObj;
                        for(Integer ind : colsMap.keySet()){
                            String col = colsMap.get(ind);
                            pattern pc = Pattern.compile('\\{\\{[a-zA-Z0-9_\\s\\.]*\\}\\}');
                            Matcher mc = pc.matcher(col);
                            if(mc.find()){
                                String childField = col.substring(mc.start()+2,mc.end()-2);
                                String childCol = '<td'+col;
                                childCol = childCol.replace('{{' +childField + '}}', (childFieldMap.get(childField) != null?String.valueOf(childFieldMap.get(childField)):'')).trim();
                                childRowMerged.add(childCol);
                            }
                        }
                        finalLineRecords.add(childRowMerged);
                    }
                    
                    for(List<String> crow: finalLineRecords){
                        linesHTML += '<tr>';
                        for(String cf: crow){
                            linesHTML += cf;
                        }
                        linesHTML += '</tr>';
                    }
                }
                linesHTML += lastColRemailingHTML;
                mergedHTMLBody += '<tr>'+linesHTML;
            }else{
                mergedHTMLBody += '<tr>'+row;
            }
        }
        htmlBody = mergedHTMLBody;
        for(String fieldName: fieldAndValueMap.keySet()){
            if(String.isNotBlank(fieldName) && fieldAndValueMap.get(fieldName) != null){
                htmlBody = htmlBody.replace('{{' +fieldName + '}}', (fieldAndValueMap.get(fieldName) != null?String.valueOf(fieldAndValueMap.get(fieldName)):'')).trim();
            }
        }*/
        return htmlBody;
    }
    public static String prepareFileData(String recordId, String queryId,String queryParams, String line){
        System.debug('##>>>>>>>>>>>line:'+line);
            System.debug('##>>>>>>>>>>>recordId:'+recordId);
            System.debug('##>>>>>>>>>>>queryId:'+queryId);
            System.debug('##>>>>>>>>>>>queryParams:'+queryParams);
        Id recId = recordId;
        String objName = recId.getSObjectType().getDescribe().getName();
        String JSONData = '';
        objName = objName.toUpperCase();
        String query = 'SELECT ';
        Map<String,Object> fieldAndValueMap = new Map<String,Object>();
        Map<String, Schema.SObjectField> objectFields
            = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();
        
        
        String comma = '';
        for(Schema.SObjectField fld :objectFields.values()){
            schema.describeFieldResult dfield = fld.getDescribe();
            
            string fldType = string.valueOf(dfield.getType());
            String fName = dfield.Name.toUpperCase();
            query += comma + fName;
            comma = ',';
            fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),null);
            if (fldType == 'REFERENCE'){ // Lookup field!
                
                if(dfield.isCustom()){
                    String key = objName.replace('__C','_')+fName.replace('__C','__R');
                    //System.debug('###Lookup =>'+key);

                    query += comma + fName.replace('__C','__r.Name');
                    fieldAndValueMap.put(key,null);
                }else{
                    query += comma + fName.replace('ID','.Name');
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),null);
                }
                
            }
        }
        query += ' FROM '+objName;
        System.debug('##query:'+query);
        if(String.isNotBlank(query)){
            query += ' WHERE Id = :recordId'; 
            for(sObject obj: Database.query(query)){
                for(Schema.SObjectField fld :objectFields.values()){
                    schema.describeFieldResult dfield = fld.getDescribe();
                    String fldType = string.valueOf(dfield.getType());
                    Integer scale;
                    if(fldType == 'DOUBLE' || fldType == 'CURRENCY'){
                        scale = dfield.getScale();
                    }
                    //System.debug('##fldType:'+fldType);
                    String fName = dfield.Name.toUpperCase();
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));
                    
                    if (fldType == 'REFERENCE'){ // Lookup field!
                        if(dfield.isCustom()){
                            String key = objName.replace('__C','_')+fName.replace('__C','__R');
                            sObject parent = obj.getSobject(dfield.Name.replace('__c','__r'));
                            if(parent != null)
                                fieldAndValueMap.put(key,parent.get('Name'));
                            	//fieldAndValueMap.put(key,(String.escapeSingleQuotes((String)parent.get('Name'))));
                        }else{
                            sObject parent = obj.getSobject (dfield.Name.replace('Id',''));
                            if(parent != null)
                                fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),parent.get('Name'));
                            	//fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),String.escapeSingleQuotes((String)parent.get('Name')));
                        }
                    }
                }
            }
            FG_Queries__c fgQuery = [SELECT Id, Active__c,Query__c FROM FG_Queries__c WHERE Id = :queryId AND Active__c = true];
            String bqLinesQuery = fgQuery.Query__c != null ?fgQuery.Query__c :'';
            pattern pc = Pattern.compile('\\{[a-zA-Z0-9_\\s\\.]*\\}');
            Matcher mc = pc.matcher(bqLinesQuery);
            if(mc.find()){
                String param = bqLinesQuery.substring(mc.start()+1,mc.end()-1);
                System.debug('##:'+param);
                String[] queryParamsParts = queryParams.split('&');
                for(String p: queryParamsParts){
                    String[] pParts = p.split('=');
                    bqLinesQuery = bqLinesQuery.replace('{'+pParts[0]+'}',pParts[1]);
                }
                
            }
            System.debug('##'+bqLinesQuery.split('WHERE')[1]);
            String[] queryParts = bqLinesQuery.replace('SELECT ', '').split(' FROM');
            String bqLineFieldsStr = queryParts[0];
            String childObjName = queryParts[1].split(' WHERE')[0].trim();
            Map<String, Schema.SObjectField> childobjectFields = new Map<String, Schema.SObjectField>();
            if(String.isNotBlank(childObjName)){
                childobjectFields  = Schema.getGlobalDescribe().get(childObjName).getDescribe().fields.getMap();
            }
            String [] bqLineFields = bqLineFieldsStr.split(',');
            Set<String> finalBQLFields = new Set<String>();
            for(String field: bqLineFields){
                if(String.isNotBlank(field)){
                    finalBQLFields.add(field.trim());
                }
            }
            //bqLinesQuery = String.format(bqLinesQuery, new List<Object>{recordId});
            //System.debug('##bqLinesQuery:'+bqLinesQuery);
            List<Map<String,Object>> BQLFieldsMapList = new List<Map<String,Object>>();
            String childObjectName = childObjName.toUpperCase().replace('_C','');//'BRAND_QUOTE_LINE_';
            for(sObject obj: Database.query(bqLinesQuery)){
                Map<String,Object> BQLFieldsMap = new Map<String,Object>();
                for(String field: finalBQLFields){
                    Schema.SObjectField cField = childobjectFields.get(field);
                    String fldType = '';
                    if(cField != null){schema.describeFieldResult dfield = cField.getDescribe();
                        fldType = string.valueOf(dfield.getType());
                    }
                    if(field.contains('.')){ String parentFieldName = field.replace('__r.', '_');
                        parentFieldName = parentFieldName.replace('.', '_');
                        parentFieldName = parentFieldName.toUpperCase();
                        String[] parentFields = field.split('\\.');
                      //   System.debug('###field:'+field +'==>Value:'+obj.get(field));
                       // BQLFieldsMap.put(childObjectName+parentFieldName,(String.escapeSingleQuotes((String)obj.getSobject(parentFields[0]).get(parentFields[1]))));
                       BQLFieldsMap.put(childObjectName+parentFieldName,obj.getSobject(parentFields[0]).get(parentFields[1]));  
                      
                    }else{
                        // System.debug('###field:'+field +'==>Value:'+obj.get(field));
                        BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),getValue(fldType,obj.get(field)));
                       
                    }

                }
                BQLFieldsMapList.add(BQLFieldsMap);
                  System.debug('##BQLFieldsMap::'+BQLFieldsMap);
            }
            
            if(!BQLFieldsMapList.isEmpty()){ fieldAndValueMap.put(line,BQLFieldsMapList);
            }
            System.debug('##fieldAndValueMap::'+fieldAndValueMap);
            if(!fieldAndValueMap.isEmpty()){
                JSONData = JSON.serialize(fieldAndValueMap, true);
              //   JSONData = JSONData.replaceAll('""', ' ');
                JSONData = JSONData.replaceAll('null', '""');
               
            }
            System.debug('##fieldAndValueMap::'+fieldAndValueMap);
        }
          System.debug('##JSONData::'+JSONData);
        
        return JSONData;
    }
    public static Map<String,Map<String,Object>> prepareFileData(List<String> invoiceIdList){
        Map<String,Map<String,Object>> invoiceFieldAndValueMap = new Map<String,Map<String,Object>>();
        system.debug('invoiceFieldAndValueMap>>'+invoiceFieldAndValueMap);
        if(invoiceIdList.size() > 0){
            Id recId = invoiceIdList[0];        
            String objName = recId.getSObjectType().getDescribe().getName();
            String JSONData = '';
            objName = objName.toUpperCase();
            String query = 'SELECT ';
            Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();        
            String comma = '';
            for(Schema.SObjectField fld :objectFields.values()){
                schema.describeFieldResult dfield = fld.getDescribe();            
                string fldType = string.valueOf(dfield.getType());
                String fName = dfield.Name.toUpperCase();
                query += comma + fName;
                comma = ',';
                //fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),null);
                if (fldType == 'REFERENCE'){ // Lookup field!                
                    if(dfield.isCustom()){ String key = objName.replace('__C','_')+fName.replace('__C','__R');
                        query += comma + fName.replace('__C','__r.Name');
                        //fieldAndValueMap.put(key,null);
                    }else{
                        query += comma + fName.replace('ID','.Name');
                        //fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),null);
                    }                
                }
            }
            query += ' FROM '+objName;
            if(String.isNotBlank(query)){  query += ' WHERE Id IN :invoiceIdList'; 
                for(sObject obj: Database.query(query)){
                    Map<String,Object> fieldAndValueMap = new Map<String,Object>();
                    for(Schema.SObjectField fld :objectFields.values()){
                        schema.describeFieldResult dfield = fld.getDescribe();
                        String fldType = string.valueOf(dfield.getType());
                        Integer scale;
                        if(fldType == 'DOUBLE' || fldType == 'CURRENCY'){ scale = dfield.getScale();
                        }
                        String fName = dfield.Name.toUpperCase();
                        fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));
                        if (fldType == 'REFERENCE'){ // Lookup field!
                            if(dfield.isCustom()){ String key = objName.replace('__C','_')+fName.replace('__C','__R');
                                sObject parent = obj.getSobject(dfield.Name.replace('__c','__r'));
                                                    if(parent != null) fieldAndValueMap.put(key,parent.get('Name'));
                               // if(parent != null) fieldAndValueMap.put(key,(String.escapeSingleQuotes((String)parent.get('Name'))));
                            }else{
                                sObject parent = obj.getSobject (dfield.Name.replace('Id',''));
                                if(parent != null) fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),parent.get('Name'));
                              //  if(parent != null) fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),String.escapeSingleQuotes((String)parent.get('Name')));
                            } 
                        }
                    }
                    invoiceFieldAndValueMap.put((String)obj.get('Id'),fieldAndValueMap);
                }                   
                if(!invoiceFieldAndValueMap.isEmpty()){  JSONData = JSON.serialize(invoiceFieldAndValueMap, true);
                    JSONData = JSONData.replaceAll('null', '""');
                }
            }
        }
        return invoiceFieldAndValueMap;
    }
    private static String getFormattedCurrency(Decimal x){
        String formattedValue = '';
        if(x == null){
            x = 0;
        }
        x = x.setScale(2);
        String y = String.valueOf(x);
        String z = '.';
        if(y.contains(',')) z = ',';
        y = y.substring(0, y.indexOf(z));
        if(x - Decimal.valueOf(y) == 0)
            formattedValue =  String.valueOf(x.format()) + z + '00';
        else formattedValue = String.valueOf(x.format());
        String[] values = formattedValue.split('\\.');
        if(values.size() == 1){ formattedValue += '.00';
        }else if(values.size() == 2){
            String last = values[1];
            if(last.length() ==1){ last += '0'; values[1] = last;
            }
            formattedValue = String.join(values,'.');
        }
        
        return formattedValue;
    }
    
    public static String addCustomValue(String datatype, Object value, String fieldName){
        
        String formattedValue = '';
        
        if(datatype.contains('BOOLEAN'))
        {
            Boolean  BooleanVal = Boolean.valueOf(value); 
            if (BooleanVal ==true && fieldName=='INVOICE_LINE_IS_SAMPLE')
            {
                formattedValue = 'Sample';  
            }else if(BooleanVal ==true && fieldName=='INVOICE_LINE_ISPROMO'){
                formattedValue = 'Promo'; 
            }
        }
        
         return formattedValue;
    }
    

    public static String getValue(String datatype, Object value){
       // string tempval='';
        System.debug('###datatype::'+datatype+'==>'+value);
         system.debug('datatype>>'+datatype);
      system.debug('value>>'+value);
        String formattedValue = '';
        if(datatype.endsWithIgnoreCase('DATETIME')){
            DateTime val = (DateTime)value;
            
           // val.addDays(-1);
        	if(value == null) return '';
            formattedValue = val.format('MMMM dd, yyyy');
        }else if(datatype.endsWithIgnoreCase('DATE')){
            DateTime val = (DateTime)value;
             //val.addDays(-1);
            if(value == null) return '';
            formattedValue = val.addDays(+1).format('MMMM dd, yyyy');
        }else if(datatype.endsWithIgnoreCase('DOUBLE')){
            formattedValue = getFormattedCurrency(Double.valueOf(value));
        }else if(datatype.endsWithIgnoreCase('CURRENCY')){
            formattedValue = '$'+getFormattedCurrency(Double.valueOf(value));
        }
        else if(datatype.endsWithIgnoreCase('PICKLIST')){
            formattedValue = string.valueOf(value);
        } else if(datatype.endsWithIgnoreCase('TEXTAREA')){
            formattedValue = string.valueOf(value);
        }else{
             string  StringVal = string.valueOf(value);
            if(StringVal !=null)
            {
             // formattedValue = String.escapeSingleQuotes(StringVal);
               StringVal.replaceAll('[^a-zA-Z0-9\\s+]', '');
            }
            //formattedValue = String.valueOf(value);
            
        }
        
        
        if(datatype.contains('STRING'))
        {
            
            string  StringVal = string.valueOf(value);
            if(StringVal !=null)
            {
               //formattedValue = String.escapeSingleQuotes(StringVal);//StringVal.replaceAll('[^a-zA-Z0-9\\s+]', '');
                 formattedValue = StringVal.replace('"','');
            }
        }
        if(datatype.contains('BOOLEAN'))
        {
            Boolean  BooleanVal = Boolean.valueOf(value); 
            if (BooleanVal ==true)
            {
              formattedValue = 'Yes';  
                  }else{
                    formattedValue = 'No';      
                  }
            system.debug('BooleanVal>>'+BooleanVal);
             system.debug('formattedValue>>'+formattedValue);
        }
        return formattedValue;
    }
    
    // New method for python Docx to Pdf conversion
    
     public static FiligreenFileDetails getJsonFileData(FiligreenFileDetails details,String recordId, String templateId,String queryId, String line ){
           system.debug('First method>>');
      system.debug('getFileData>>>456'+details);
        Id recId = recordId;
     
        String objName = recId.getSObjectType().getDescribe().getName();
        details.objectName = objName;
        String JSONData = '';
        objName = objName.toUpperCase();
        String query = 'SELECT ';
        Map<String,Object> fieldAndValueMap = new Map<String,Object>();
        Map<String,Map<String,Object>> invoiceFieldAndValueMap = new Map<String,Map<String,Object>>();
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();
        String comma = '';
        for(Schema.SObjectField fld :objectFields.values()){
            schema.describeFieldResult dfield = fld.getDescribe();            
            string fldType = string.valueOf(dfield.getType());
            String fName = dfield.Name.toUpperCase();
            query += comma + fName;
            comma = ',';     
               
                    
         
    
            //DISTRIBUTOR_NAME__r.Name
            fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),null);
            if (fldType == 'REFERENCE'){ // Lookup field!
                if(dfield.isCustom()){
                    String key = objName.replace('__C','_')+fName.replace('__C','__R');
                    query += comma + fName.replace('__C','__r.Name');
                    fieldAndValueMap.put(key,null);
                }else{
                    query += comma + fName.replace('ID','.Name');
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),null);
                }
            }
        }
        query += ' FROM '+objName;
        query += ' WHERE Id = :recordId';
        if(String.isNotBlank(query)){
            for(sObject obj: Database.query(query)){
                details.documentName = (String)obj.get('Name');
                details.recordId = (String)obj.get('Id');
                //Map<String,Object> fieldAndValueMapinvoice =  fieldAndValueMap.clone();
                for(Schema.SObjectField fld :objectFields.values()){
                    schema.describeFieldResult dfield = fld.getDescribe();
                    String fldType = string.valueOf(dfield.getType());
                    Integer scale;
                    if(fldType == 'DOUBLE' || fldType == 'CURRENCY'){
                        scale = dfield.getScale();
                    }
                    String fName = dfield.Name.toUpperCase();
                    system.debug('fName>>>'+fName);
                    
                    system.debug('Parent Value>>>'+getValue(fldType,obj.get(dfield.Name)));
                    
                    
                    fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('__C',''),getValue(fldType,obj.get(dfield.Name)));    
                      system.debug('fName>>>'+fName);
                    if (fldType == 'REFERENCE'){ // Lookup field!
                        if(dfield.isCustom()){
                            String key = objName.replace('__C','_')+fName.replace('__C','__R');
                            sObject parent = obj.getSobject(dfield.Name.replace('__c','__r'));
                            if(parent != null)
                               // fieldAndValueMap.put(key,String.escapeSingleQuotes((String)parent.get('Name'))); 
                               fieldAndValueMap.put(key,parent.get('Name')); 
                        }else{
                            sObject parent = obj.getSobject (dfield.Name.replace('Id',''));
                            if(parent != null)
                               // fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),String.escapeSingleQuotes((String)parent.get('Name')));
                               fieldAndValueMap.put(objName.replace('__C','_')+fName.replace('ID','__R'),parent.get('Name'));
                        }
                    }
                }
                invoiceFieldAndValueMap.put((String)obj.get('Id'),fieldAndValueMap);
            }
        }
        FG_Queries__c fgQuery = [SELECT Id, Active__c,Query__c FROM FG_Queries__c WHERE Id = :queryId AND Active__c = true];
        String bqLinesQuery = fgQuery.Query__c != null ?fgQuery.Query__c :'';
        pattern pc = Pattern.compile('\\{[a-zA-Z0-9_\\s\\.]*\\}');
        Matcher mc = pc.matcher(bqLinesQuery);
        if(mc.find()){
            String param = bqLinesQuery.substring(mc.start()+1,mc.end()-1);                
        }
        String[] queryParts = bqLinesQuery.replace('SELECT ', '').split(' FROM');
        String bqLineFieldsStr = queryParts[0];
        String childObjName = queryParts[1].split(' WHERE')[0].trim();
        Map<String, Schema.SObjectField> childobjectFields = new Map<String, Schema.SObjectField>();
        if(String.isNotBlank(childObjName)){
            childobjectFields  = Schema.getGlobalDescribe().get(childObjName).getDescribe().fields.getMap();
        }
        String [] bqLineFields = bqLineFieldsStr.split(',');
        Set<String> finalBQLFields = new Set<String>();
        for(String field: bqLineFields){
            if(String.isNotBlank(field)){
                finalBQLFields.add(field.trim());
            }
        }
        List<Map<String,Object>> BQLFieldsMapList = new List<Map<String,Object>>();
        String childObjectName = childObjName.toUpperCase().replace('_C','');
        bqLinesQuery = bqLinesQuery.replace('{pv0}', recordId);
        for(sObject obj: Database.query(bqLinesQuery)){
            Map<String,Object> BQLFieldsMap = new Map<String,Object>();
            for(String field: finalBQLFields){
                Schema.SObjectField cField = childobjectFields.get(field);
               
                String fldType = '';
                if(cField != null){
                    schema.describeFieldResult dfield = cField.getDescribe();
                     system.debug('getNamegetNamegetName'+dfield.getName());
                    fldType = string.valueOf(dfield.getType());
                }
                
                
                  
                
                if(field.contains('.')){
                    String parentFieldName = field.replace('__r.', '_');
                    parentFieldName = parentFieldName.replace('.', '_');
                    parentFieldName = parentFieldName.toUpperCase();
                    String[] parentFields = field.split('\\.');
                    if(obj.get(parentFields[0].replace('__r','__c')) != null)
                           BQLFieldsMap.put(childObjectName+parentFieldName,obj.getSobject(parentFields[0]).get(parentFields[1]));
                       // BQLFieldsMap.put(childObjectName+parentFieldName,String.escapeSingleQuotes((String)obj.getSobject(parentFields[0]).get(parentFields[1])));
                    else
                            BQLFieldsMap.put(childObjectName+parentFieldName,null);
                }else{
                    
                    
                     if(childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_IS_SAMPLE' || childObjectName+field.replace('__c', '').toUpperCase() == 'INVOICE_LINE_ISPROMO' )
                     {
                              String lineFieldName = childObjectName+field.replace('__c', '').toUpperCase();
                              BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),addCustomValue(fldType,obj.get(field),lineFieldName));
                     }else{
                         BQLFieldsMap.put(childObjectName+field.replace('__c', '').toUpperCase(),getValue(fldType,obj.get(field))); 
                     }
                    
                    
                }                    
            }
            BQLFieldsMapList.add(BQLFieldsMap);
        }
        if(!BQLFieldsMapList.isEmpty()){     fieldAndValueMap.put(line,BQLFieldsMapList);
        }            
        if(!fieldAndValueMap.isEmpty()){
            JSONData = JSON.serialize(fieldAndValueMap, true);
            //JSONData = JSONData.replaceAll('null', '""');
        }        
        details.JSONData = String.escapeSingleQuotes(JSONData);
        system.debug('details.JSONData '+details.JSONData);
        return details;
    }
    
    
  @Future(callout=true)
   public static void saveFile(Id attachmentId,String invoiceId,String Name){
   

Map<ID, FG_Template__c> templateMap = new Map<ID, FG_Template__c>([SELECT Id, Name, Name__c  FROM FG_Template__c 
WHERE Template_Group__c ='InvoiceFinal' AND Active__c = true Limit 1]);
String encodedValue;
String encodedJsonValue;

List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocumentId FROM  ContentDocumentLink WHERE LinkedEntityId =: templateMap.keySet() AND ContentDocument.FileExtension= 'docx' Limit 1];   //pass caseId

if (contentDocumentLinks.size() > 0)
{
List<Id> contentDocumentLinkIds = new List<Id>();
for (ContentDocumentLink contentDocumentLink : contentDocumentLinks )
	contentDocumentLinkIds.add(contentDocumentLink .ContentDocumentId);

List<ContentVersion> contentVersions = [SELECT Id,ContentDocumentId,Title,VersionData,isLatest FROM ContentVersion WHERE ContentDocumentId in :contentDocumentLinkIds and FileType!='SNOTE' and IsLatest = true];

if (contentVersions.size() > 0)
{
	for (ContentVersion contentVersion : contentVersions )
	{
		system.debug(contentVersion.Title);
	   //contentVersion.Title
	   encodedValue=EncodingUtil.base64Encode(contentVersion.VersionData);     //this get the attachment body
	}
}

}

//00P6s000002EoEQEA0
ContentVersion jsonconv = [Select id,FileType, Title,FileExtension, Versiondata from ContentVersion where islatest=true AND ContentDocumentId=:attachmentId];

encodedJsonValue  =EncodingUtil.base64Encode(jsonconv.VersionData);  

	
String boundary = '-------314159265358979323846';
String filename ='PO';

String delimiter = '\r\n--' + boundary +'\r\n';
	String close_delim = '\r\n--' + boundary + '--';
//String body =encodedValue; //encodes the blob into a base64 encoded String
String filetype = 'multipart/form-data';
String body;
body +=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+' "mimeType" : "application/vnd.google-apps.document" }'+
delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+encodedValue+close_delim;

		
		body +=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+' "mimeType" : "application/vnd.google-apps.document" }'+
delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+encodedJsonValue+close_delim;


system.debug('body>>'+body);


Http http = new Http();
HttpRequest req = new HttpRequest();
// string endpointUrl=googleDrive.File_Upload_Url__c;
req.setEndpoint('https://wovn-docx2pdf.herokuapp.com/upload-file');
// req.setHeader('Authorization', 'Bearer ' +accessToken);
req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
req.setHeader('Content-length', String.valueOf(body.length()));
req.setBody(body);
req.setMethod('POST');
req.setTimeout(120000);
HttpResponse res = http.send(req);
String response = res.getBody();
//system.debug('>>'+req.getBody());
system.debug('response'+response); 

//String base64Content = ( String ) JSON.deserialize( res.getBody(), String.class );
//Blob body = ;



// file atttachemen


Blob base64Response = res.getBodyAsBlob();
ContentVersion conVer = new ContentVersion();
conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
conVer.PathOnClient = Name+'.pdf'; // The files name, extension is very important here which will help the file in preview.
conVer.Title = Name; // Display name of the files
conVer.VersionData = base64Response; // converting your binary string to Blob
insert conVer;


// First get the content document Id from ContentVersion
Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;

//Create ContentDocumentLink
ContentDocumentLink cDe = new ContentDocumentLink();
cDe.ContentDocumentId = conDoc;
cDe.LinkedEntityId = invoiceId; // you can use objectId,GroupId etc
cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
cDe.Visibility = 'InternalUsers';
insert cDe;
       
       
   
   }
    
    
}