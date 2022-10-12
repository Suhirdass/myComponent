import { LightningElement, wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountController.fetchAccounts';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PARENT_FIELD from '@salesforce/schema/Account.ParentId';

export default class SampleLWC extends LightningElement {

    records;
    wiredRecords;
    error;
    fields = [ NAME_FIELD, INDUSTRY_FIELD, PARENT_FIELD ];

    @wire( fetchAccounts )  
    wiredAccount( value ) {

        this.wiredRecords = value;
        const { data, error } = value;

        if ( data ) {
                            
            this.records = data;
            this.error = undefined;

        } else if ( error ) {

            this.error = error;
            this.records = undefined;

        }

    }  
}