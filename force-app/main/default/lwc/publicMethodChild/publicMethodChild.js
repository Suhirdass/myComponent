import { LightningElement,track,api } from 'lwc';

export default class PublicMethodChild extends LightningElement {
    //default value -- private recative property
    @track value = ['red'];

    //non reactive property
    options = [
        { label: 'Red Marker', value: 'red' },
        { label: 'Blue Marker', value: 'blue' },
        { label: 'Green Marker', value: 'green' },
        { label: 'Black Marker', value: 'black' },
    ];

    // public property and passing value (checkBoxValue) from parent component
    @api
    selectCheckbox(checkboxValue){
        //Find the options property and check parent value (checkBoxValue) and current value (checkBox.value) from object/method (checkBox)
        const selectedCheckbox = this.options.find( checkbox =>{
            return checkboxValue === checkbox.value;
        })

         // To check selectedCheckBox -- value is undefined or not & store into value property and pass to child component template
         if(selectedCheckbox){
            this.value = selectedCheckbox.value;
            return "Successfully checked";
        } else {
            return "No CheckBox Found";
         }
    }
}