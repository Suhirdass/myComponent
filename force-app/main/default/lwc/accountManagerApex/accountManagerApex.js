import { LightningElement, wire,track } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountManager.getAccount';

//To show Toast event
import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class AccountManagerApex extends LightningElement {

   // @wire(getAllAccounts) accounts;

   @track numberOfRecords;
   @track accounts;

    
    numOfAccChangeHandler(event){
        this.numberOfRecords = event.target.value;
    }

// Imperative method to call apex with onclick
    getAccounts(){
       getAllAccounts({numOfAccounts : this.numberOfRecords}).then(response =>{
           this.accounts = response;
           const toastEvent = new ShowToastEvent({
               title : 'Account Loaded',
               message : this.numberOfRecords + 'Accounts fetched from server',
               variant : 'success',
           })
           this.dispatchEvent(toastEvent);
       }).catch(error =>{
           console.log('error');
           const toastEvent = new ShowToastEvent({
            title : 'Account Error',
            message : error.body.message,
            variant : 'error',
        })
        this.dispatchEvent(toastEvent);
       })
    }

    get responseReceived(){
        if(this.accounts){
            return true;
        }
        return false;
    }

}