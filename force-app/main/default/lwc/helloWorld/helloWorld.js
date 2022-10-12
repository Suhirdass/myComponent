import { LightningElement, track } from 'lwc';

export default class HelloWorld extends LightningElement {
    //Data binding from JS to HTML , we can use @track property 
  @track dynamicGreeting = 'World';

  //Method & event should hold the values from input 
  //Data binding from HTML to JS , we can use event handler 
  greetingChangeHandler(event){
      //this - to call current property of the class
    this.dynamicGreeting = event.target.value;
  }

}