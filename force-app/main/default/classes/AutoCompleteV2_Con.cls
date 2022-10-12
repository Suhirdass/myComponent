/**************************************************************************************
Apex Class Name    : AutoCompleteV2_Con 
Test Class Name    : AutocompleteV2_Con_Test
Version            : 1.0
Created Date       : July 01 2018
Function           : Used for autosearch & pagination and used in "AutoComplete" VF componenent.
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  07/01/2018              Original Version
*******************************************************************************/
public class AutoCompleteV2_Con {

    public String labelFieldVar{ get; set; }
    public String valueFieldVar{ get; set; }
    public String sObjVal{get;set;}
    public Integer randomJsIden{get;set;}
    public Object cacheField{get;private set;} 
    
    private Object targetFieldVar;
    
    public AutoCompleteV2_Con(){
        randomJsIden = getRandomNumber(1000000);
        sObjVal='Product2';
        labelFieldVar='Name';
        valueFieldVar='Id';
    }
    
    /*Dummy setter Method*/
    public void setCacheField(Object cacheField){}
    
    public void setTargetFieldVar(Object targetFieldVar){    
        if(targetFieldVar != this.targetFieldVar){
            cacheField = getCacheFieldValue(targetFieldVar);
            this.targetFieldVar = targetFieldVar;
        }
    }
    
    public Object getTargetFieldVar(){
        return targetFieldVar;
    }

    
    /*
    *This method queries data according to the passed parameters
    ***/
    @RemoteAction
    public static List<Map<String,String>> getData(String sObjVal,String labelFieldVar,String valueFieldVar,String whereClauseVar,String param){      
        List<Map<String,String>> responses = new List<Map<String,String>>();
        param = String.escapeSingleQuotes(param);
        for( Sobject sObj : Database.query('SELECT '+getFieldCSV(valueFieldVar,labelFieldVar)+' FROM '+sObjVal+' WHERE '+labelFieldVar+' LIKE \'%'+param+'%\''+(String.isNotBlank(whereClauseVar) ? ' AND '+whereClauseVar : ''))){
            responses.add(new Map<String,String>{
                'id' => String.valueOf(sObj.get(valueFieldVar)),
                'text' => String.valueOf(sObj.get(labelFieldVar))
            });
        }
        return responses;
    }  
    
    private Object getCacheFieldValue(Object targetFieldVar){
        Object retVal = targetFieldVar;
        if(targetFieldVar!=null){
            for(sObject sObj : Database.query('SELECT '+getFieldCSV(valueFieldVar,labelFieldVar)+' FROM '+sObjVal+' WHERE '+valueFieldVar+' =:targetFieldVar')){
                retVal = sObj.get(labelFieldVar);
                break;
            }
        }
        
        return retVal;
    }
    
    /*
    *Random number generator to change the js function name if multiple components us
    ***/
    private Integer getRandomNumber(Integer size){
        Double d = Math.random() * size;
        return d.intValue();
    }

    private static String getFieldCSV(String vfld,String lfld){
        Set<String> fields = new Set<String>{vfld.toLowerCase(),lfld.toLowerCase()};
        return String.join(new List<String>(fields),',');
    }
    
}