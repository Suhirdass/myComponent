import { LightningElement, wire } from 'lwc';
import retriveShippingManifestLine from '@salesforce/apex/CancelRSMController.retriveShippingManifestLine';
const columns = [
    { label: 'SM Line', fieldName: 'Name', type: 'auto number' },
    { label: 'Product Name', fieldName: 'Product_Name__c', type: 'text' },
    // { label: 'Producer Name', fieldName: '', type: 'text' },
    { label: 'Product Description', fieldName: 'Product_Description__c', type: 'text' },
    { label: 'Shipment Qty', fieldName: 'Shipment_Qty__c', type: 'number' },
    { label: 'Retail Wholesale Price', fieldName: 'Retail_Wholesale_Price__c', type: 'currency' },
    { label: 'Qty Received', fieldName: 'Qty_Received__c', type: 'number' },
    { label: 'Line Total Price', fieldName: 'Line_Total_Price__c', type: 'currency' },
    { label: 'Picklist Line', fieldName: 'Picklist_Line__c', type: 'picklist line' },
    //{ label: 'SO Line', fieldName: '', type: 'text' },
    { label: 'Rejection Reason', fieldName: 'Rejection_Reason__c', type: 'picklist' },


    /* { label: 'Label', fieldName: 'name' },
    { label: 'Website', fieldName: 'website', type: 'url' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Balance', fieldName: 'amount', type: 'currency' },
    { label: 'CloseAt', fieldName: 'closeAt', type: 'date' },*/
];
export default class Table extends LightningElement {
    columns = columns;
    // @track showTable = true;
    @wire(retriveShippingManifestLine)
    shipment;
    wiredshipment({ error, data }) {
        if (data) {
            this.shipment = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.shipment = undefined;
        }
    }
}