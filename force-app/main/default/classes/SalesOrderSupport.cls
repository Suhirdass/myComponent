/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SalesOrderSupport
 */
public with sharing class SalesOrderSupport {
    
    // SO Status
    public static final String SO_STATUS_APPROVED = 'Approved'; 
    public static final String SO_STATUS_CANCELLED = 'Cancelled';   
    public static final String SO_STATUS_DRAFT = 'Draft'; 
    public static final String SO_STATUS_SHIPPED = 'Shipped'; 
    public static final String SO_STATUS_CLOSED = 'Closed';
    // SO Line Status
    public static final String SO_LINE_STATUS_OPEN = 'Open'; 
    public static final String SO_LINE_STATUS_ALLOCATED = 'Allocated'; 
    public static final String SO_LINE_STATUS_PARTIALLY_ALLOCATED = 'Partially Allocated';
    public static final String SO_LINE_STATUS_CANCELLED = 'Cancelled';
    public static final String SO_LINE_STATUS_REJECTED = 'Rejected';
    public static final String SO_LINE_STATUS_BACK_ORDERED = 'Back Ordered';
    
    public static final String PO_LINE_STATUS_PARTIALLY_RECEIVED = 'Partially Received';
}