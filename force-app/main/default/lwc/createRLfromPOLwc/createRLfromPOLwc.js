import { LightningElement,api,track,wire } from 'lwc';

import purchaseOrderValue from '@salesforce/apex/CreateRLfromPOline.purchaseOrderDeatils';

export default class CreateRLfromPOLwc extends LightningElement {

    @track columns = [{
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
        sortable: true
    }
  
];

   @api recordId;
   poRecord;
   @track error;

   connectedCallback(){
        console.log('In connected call back function....'+this.recordId);
        this.apexCallOut();
   }

   apexCallOut() {
        purchaseOrderValue({poId:this.recordId})
        .then((result) =>{
            console.log('data====>' + JSON.stringify(result.data.poData));
            this.poRecord = result;
            console.log('Record Data ' + JSON.stringify(this.poRecord));
        })
        .catch((error) =>{
            console.log('In connected call back error....');
            this.error = error;
            // This way you are not to going to see [object Object]
            console.log('Error is', this.error);
        });
   }

}