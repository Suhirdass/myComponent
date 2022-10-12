import { LightningElement,track } from 'lwc';

export default class AccountManagerLDSForms extends LightningElement {
  //To store record ID and we can view our records
  @track recordId;
  successHandler(event){
      this.recordId = event.detail.id;
  }
}