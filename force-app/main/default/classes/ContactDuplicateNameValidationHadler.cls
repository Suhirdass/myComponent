public class ContactDuplicateNameValidationHadler {
    public static void beforeInsert(List<contact> lstInvoice,Map<Id, contact> oldProductMap){
        system.debug('lstInvoice>>'+lstInvoice);
                system.debug('oldProductMap>>'+oldProductMap);

     set <string> conname = new set<string>();
    set <string> conlstname = new set<string>();
    set <id> accid = new set<id>();
        string status;
    set <string> conEmails= new set<string>();
   // Set<String> uniqueSet = new Set<String>();
        string uniqueSet;
  List<String> lstname = new List<String>();
    for(contact con : lstInvoice){
        system.debug('con>>'+con.AccountId);
        system.debug('con>>'+con.FirstName);
        system.debug('con>>'+con.LastName);
        conname.add(con.FirstName);
        conlstname.add(con.LastName);
        conEmails.add(con.Email);
        accid.add(con.AccountId);
     //   uniqueSet.add(con.FirstName+ ' '+con.LastName);
       uniqueSet = con.FirstName+ ' '+con.LastName;
    }
      
        
        system.debug('uniqueSetuniqueSet>>>'+uniqueSet);
                system.debug('conEmails>>>'+conEmails);

       List<contact> lstcon=[select id,name,email,AccountId,FirstName,LastName from contact where AccountId=:accid AND (Name=:uniqueSet OR email=:conEmails)];
                           system.debug('lstcon>>>'+lstcon.size());
        system.debug('lstcon>>>'+lstcon);
               Set<string > duplicateaccIds= new Set<string >();
 Set<string > duplicateaccIdsemails= new Set<string >();
      
            
        
           for(contact dup: lstcon ) {duplicateaccIds.add(dup.name);duplicateaccIdsemails.add(dup.email);   
       }
 system.debug('duplicateaccIds>>>'+duplicateaccIds);
         system.debug('duplicateaccIdsemails>>>'+duplicateaccIdsemails);
       for(contact a : lstInvoice)
       {
           system.debug('a'+a.Name);
            system.debug('a'+a.email);
           
               if(duplicateaccIds.contains(uniqueSet))    {  a.addError('Record already exist with same Name');
               }if(duplicateaccIdsemails.contains(a.email)) { a.addError('email already exist');
               }
            
            
       
        
}        
        
        
 system.debug('lstcon>>>'+lstcon);
      /*  if(lstcon.size() > 1 ){for(contact cn : lstInvoice){ 
                for(contact cons : lstcon) {  
                    if(uniqueSet.contains(cons.Name)) {    cn.addError('Contact names alredy Exist In Account'); 
                    }
                    if(conEmails.contains(cons.Email)) {   cn.addError('Contact Email alredy Exist In Account');   
                    
                }
               }   
                
            }


        
        }*/
    

        
        }         
      public static void beforeupdate(List<contact> lstInvoice,Map<Id, contact> oldcontactMap){
        system.debug('lstInvoice>>'+lstInvoice);
         system.debug('oldProductMap>>'+oldcontactMap);

     set <string> conname = new set<string>();
    set <string> conlstname = new set<string>();
    set <id> accid = new set<id>();
        string status;
    set <string> conEmails= new set<string>();
   // Set<String> uniqueSet = new Set<String>();
        string uniqueSet;
  List<String> lstname = new List<String>();
          Set<string > duplicateaccIds= new Set<string >();
 Set<string > duplicateaccIdsemails= new Set<string >();
            
        
    for(contact con : lstInvoice){
  
       
        if(con.FirstName != oldcontactMap.get(con.Id).FirstName || con.LastName != oldcontactMap.get(con.Id).LastName ){
       
            conname.add(con.FirstName);  conlstname.add(con.LastName); 
            accid.add(con.AccountId);  uniqueSet = con.FirstName+ ' '+con.LastName;

        }        if(con.Email != oldcontactMap.get(con.Id).Email ){  conEmails.add(con.Email);   accid.add(con.AccountId);
        }


        }

   
       List<contact> lstcon=[select id,name,email,AccountId,FirstName,LastName from contact where AccountId=:accid AND (Name=:uniqueSet OR email=:conEmails)];
                         
               
           for(contact dup: lstcon ){
         duplicateaccIds.add(dup.name); duplicateaccIdsemails.add(dup.email);   
       }
 
       for(contact a : lstInvoice)
       {
           system.debug('a'+a.Name);
               if(duplicateaccIds.contains(uniqueSet)) {  a.addError('Contact names alredy Exist In Account');
               }if(duplicateaccIdsemails.contains(a.email)){a.addError('Contact Email alredy Exist In Account');
               }
            
            
       }
               
        
        
     

        
        }         
        
        
        
        
        
        
        

   
    

 

}