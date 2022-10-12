public class publishOrderRevisionToSlack {
    public Static String CRM_Redirect_URL{
        get{
            return String.isNotBlank(CRM_Redirect_URL) ? CRM_Redirect_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','CRM_Redirect_URL');
        }set;
    } 
 @InvocableMethod 
    public static void publishOrderrevisionToSlack(List<Id> OrderRevisionids) {
     
}
}