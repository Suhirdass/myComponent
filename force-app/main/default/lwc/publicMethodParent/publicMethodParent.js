import { LightningElement,track } from 'lwc';

export default class PublicMethodParent extends LightningElement {
    @track value;

    checkboxSelectHandler(){
        //To Call Public Method of our Child Component in Parent JS Controller -- by using QuerySelectorAll
        const childComponent = this.template.querySelector('c-public-method-child');
       //selectCheckBox -- public method in CC
       const returnedMessage = childComponent.selectCheckbox(this.value);
        console.log('Returned Message: ', returnedMessage);
    }

    onInputChangeHandler(event){
        this.value = event.target.value;
    }
}