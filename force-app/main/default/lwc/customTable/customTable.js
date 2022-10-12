import { LightningElement,api,wire,track } from 'lwc';
import getAllAccounts from '@salesforce/apex/customTable.getAllAccounts';
 
export default class CustomTable extends LightningElement {
    @api records;
    @api errors;

    @wire(getAllAccounts,{
     }
    )
    wiredCases({
        data,error
    }){
    if(data){
        this.records = data;
        this.errors = undefined;
    }
    if(error){
        this.errors = error;
        this.records = undefined;
        }
    }
}