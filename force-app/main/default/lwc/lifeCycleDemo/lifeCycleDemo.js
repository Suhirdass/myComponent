import { LightningElement } from 'lwc';

export default class LifeCycleDemo extends LightningElement {

    constructor(){
        super();
        console.log("Lifecycle Demo:Inside Constructor");
    }
    
    connectedCallback(){
        console.log('Component Connected Callback is called');
        //cannot access input, button-controls
        //apex call
        //load the data
    }

    renderedCallback(){
        console.log('Component Rendered Callback is called');
    }
    
    disconnectedCallback(){
        console.log('Component DisConnected Callback is called');
    }
}