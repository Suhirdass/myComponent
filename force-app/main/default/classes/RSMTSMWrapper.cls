/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMTSMWrapper
 */
public class RSMTSMWrapper{
    public String id {get; set;}
    public String name {get; set;}
    public String accountName {get; set;}
    public String accountId {get; set;}
    public String deliveryAddress {get; set;}
    public String deliveryCity {get; set;}
    public String receiverPhone {get; set;}
    public String receiverEmail {get; set;}
    public Date plannedShipTransferDate {get; set;}
    public String driverName {get; set;}
    public String driverId {get; set;}
    public String vehicleName {get; set;}
    public String vehicleId {get; set;}
    public Integer totalLineItems {get; set;}
    public String receiverContactName {get; set;}
    public String receiverContactId {get; set;}
    public String poNumber {get; set;}
    public DateTime actualDepartureDateTime {get; set;}
    public DateTime actualArrivalDateTime {get; set;}
    public DateTime receiverAcceptanceDate {get; set;}
    public Boolean isRSM {get; set;}
    public Boolean departConfirmSelection {get; set;}
    public Integer pendingInvoices {get; set;}
    public String paymentTerms{get; set;}
    public String soid {get; set;}
    public String soname {get; set;}
    public String orderid {get; set;}
    public String ordername {get; set;}
    public String priority {get; set;}
    public String windowStartEnd {get; set;}
    public String manifest {get; set;}
    public Boolean cannotShipConfirm {get; set;}
    public Decimal boxCount {get; set;}
    public RSMTSMWrapper(){
        isRSM = false;
        departConfirmSelection = false;
        pendingInvoices = 0;
        cannotShipConfirm = false;
    }
}