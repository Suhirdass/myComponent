import { LightningElement,api } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import WEB_FIELD from '@salesforce/schema/Account.Website';


export default class AccountRecordForm extends LightningElement {
   // @track recordId;

    //fieldsArray = ['Name','Phone','Website']; 
    // Above property (fieldsArray) SF don't aware of these fields are used or not - while deleting or modify fields in object manager , ith will thorew error, somewhere it is used like that
    // it is over come by using hard-reference (above import method - @salesforce/schema/Account) -- SF aware of these fields are used, we can delete or modify those fields
    //fieldsArray = [NAME_FIELD, PHONE_FIELD, WEB_FIELD]; if i am giving layout-type attribute in html, no need these field property
  /*  successHandler(event){
        this.recordId = event.detail.id;
    } */

    // Get RecordId & Object Name from framework --> using public property
    //this conmponent only work on record page and fetch the objcet and recordId of that particular record
    @api objectApiName;
    @api recordId;
}