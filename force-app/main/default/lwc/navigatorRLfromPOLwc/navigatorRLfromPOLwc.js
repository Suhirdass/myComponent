import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class NavigatorRLfromPOLwc extends NavigationMixin(LightningElement) {
    @api recordId;

    connectedcallback() {
        console.log('recordId----->'+this.recordId);
    }
    @api invoke() {

       var compDefinition = {
            componentDef: "c:createRLfromPOLwc",
            attributes: {
                recordId : this.recordId != "" ? this.recordId : " "
            }
        };
        // Base64 encode the compDefinition JS object
        var encodedCompDef = btoa(JSON.stringify(compDefinition));
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: "/one/one.app#" + encodedCompDef
            }
        });
    }
}