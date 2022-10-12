public class printServiceTicketController {
    public Integer totalCompleted{set;get;}
    public ServiceTicketsCtlr.ServiceTicket serviceTicket{set;get;}
    public List<ServiceTicketsCtlr.ServiceTicketLine> serviceTicketLines{set;get;}
    public Account branddetails{set;get;}
    public printServiceTicketController(){
        totalCompleted = 0;
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        AuraResponse r = ServiceTicketsCtlr.getServiceTicket(recordId);
        serviceTicket = (ServiceTicketsCtlr.ServiceTicket)r.data.get('serviceTicket');
        if(serviceTicket.transferMethod == 'Drop-off'){
            //serviceTicket.licenseNumber = serviceTicket.licenseNumber + ' - '+ serviceTicket.licenseType;
        } else {
            //serviceTicket.licenseNumber = serviceTicket.licenseNumber + ' - '+ serviceTicket.licensePremiseAddress;
        }
        serviceTicketLines = (List<ServiceTicketsCtlr.ServiceTicketLine>)r.data.get('serviceTicketLines');
        for(ServiceTicketsCtlr.ServiceTicketLine stl: serviceTicketLines){
            if(stl.PWOStatus == 'Completed'){
                totalCompleted++;
            }
        }
        branddetails = (Account)r.data.get('branddetails');
    }
}