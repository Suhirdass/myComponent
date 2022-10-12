import { LightningElement, track, wire, api } from 'lwc';
import retriveShippingManifestData from '@salesforce/apex/RSMController.getShippingDetails';
import getRsmLinesData from '@salesforce/apex/RSMController.getRsmLines';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
//import fetchShippingManifestLineRecord from '@salesforce/apex/RSMController.deleteMultipleRecords';

export default class CancelRSMController extends NavigationMixin(LightningElement) {

    @track shipment = [];
    @api recordId;

    @track records = [];
    @track rsmLinesItems = [];
    @track dataNotFound;

    value = 'None';


    @track recordId;
    @track rec;

    currentPage =1;
    totalRecords;
    @api recordSize = 5;
    totalPage = 0;

    @wire(retriveShippingManifestData, { recordId: '$recordId' })
    wireRecord({ data, error }) {
        if (data) {
            this.records = data;
            console.log('@@@Data:' + JSON.stringify(this.records));
            this.error = undefined;
            this.dataNotFound = '';
            if (this.records == '') {
                this.dataNotFound = 'There is no Contact found related to Account name';
            }

        } else {
            this.error = error;
            this.data = undefined;
        }
    }

    @wire(getRsmLinesData, { recordId: '$recordId' })
    wireRecordLine({ data, error }) {
        if (data) {
            this.rsmLinesItems = data;
            console.log('@@@Data2:' + JSON.stringify(this.rsmLinesItems));
            this.error = undefined;
            this.dataNotFound = '';
            if (this.rsmLinesItems == '') {
                this.dataNotFound = 'There is no Contact found related to Account name';
            }

        } else {
            this.error = error;
            this.data = undefined;
        }
    }

    get options() {
        return [
            { label: 'None', value: 'None' },
            { label: 'Damaged Products', value: 'Damaged Products' },
            { label: 'Denied Product', value: 'Denied Product' },
            { label: 'Expiration Date', value: 'Expiration Date' },
            { label: 'Incorrect License', value: 'Incorrect License' },
            { label: 'Incorrect Pricing', value: 'Incorrect Pricing' },
            { label: 'Incorrect Product', value: 'Incorrect Product' },
            { label: 'Incorrect Qty Shipped', value: 'Incorrect Qty Shipped' },
            { label: 'Labeling Issue', value: 'Labeling Issue' },
            { label: 'Non-Complient', value: 'Non-Complient' },
            { label: 'Not-Ordered', value: 'Not-Ordered' },
        ];
    }

    handleChange(event) {

        getRsmLinesData({ id: event.currentTarget.dataset.id, picklist: event.detail.value })
            .then((result) => {
                console.log(JSON.stringify(result));
                alert('Updated Succesfully');
                refreshApex(this.options);

            })
            .catch((error) => {
                alert('Failed to update');
                console.log(JSON.stringify(error));

            });

    }

    renderedCallback() {
        console.log('Current Record Id:' + this.recordId);
    }

  /*  handleChangeRadio(event) {
        this.rec = event.target.value;
    }*/


   /* handleRecordDelete() {


        this.recordId = this.rec;
        deleteRecord(this.recordId)
            .then(() => {
                const toastEvent = new ShowToastEvent({
                    title: 'Record Deleted',
                    message: 'Record deleted successfully',
                    variant: 'success',
                })
                this.dispatchEvent(toastEvent);
                return refreshApex(this.wireduserList);
            })
            .catch(error => {
                console.log('unable to delete record' + error.body.message);
            })
        this.rec = '';
    } */

        
       /* if(checkboxoption=true){
            records.Status='Canceled';
        } else {
            records.Status='In-Transit';
        }
    }*/

    handlePrevious() {

        if(this.currentPage>1){
            this.currentPage = this.currentPage-1;
           // this.updateRecords();
        }
        
    }

    handleRecordDelete() {
        this.value= 'Cancelled';

    }
}