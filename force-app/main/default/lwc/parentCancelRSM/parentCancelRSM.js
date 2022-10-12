import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ParentCancelRSM extends NavigationMixin(LightningElement) {
@api recordId;
handleNavigation(event){
    event.preventDefault();
    let componentDef = {
        componentDef: "c:cancelRSMController",
        attributes: {
            recordId: this.recordId,
            label: 'Navigated From Another LWC Without Using Aura'
        }
    };
    // Encode the componentDefinition JS object to Base64 format to make it url addressable
    let encodedComponentDef = btoa(JSON.stringify(componentDef));
    this[NavigationMixin.Navigate]({
        type: 'standard__webPage',
        attributes: {
            url: '/one/one.app#' + encodedComponentDef
        }
    });
}
}