import { LightningElement,track } from 'lwc';

export default class NewCalculator extends LightningElement {
   @track currentResult;

   firstNumber;
   secondNumber;

   //to store previuos result
   @track previousResults = [];

   //to show previous result
   @track showPreviousResult = false;

   numberChangeHandler(event){
       const inputBoxValue = event.target.name;

       if(inputBoxValue == 'firstNumber'){
           this.firstNumber = event.target.value;
       } else if(inputBoxValue == 'secondNumber'){
        this.secondNumber = event.target.value;
    }
   }


   addHandler(){
       //convert string to Int
       const firstN = parseInt(this.firstNumber);
       const secondN = parseInt(this.secondNumber);
       this.currentResult = `Result of ${firstN} + ${secondN} is ${ firstN + secondN }`;

       //push method to store the value in array
       this.previousResults.push(this.currentResult);
   }

   subHandler(){
    //convert string to Int
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);
    this.currentResult = `Result of ${firstN} - ${secondN} is ${ firstN - secondN }`;

    //push method to store the value in array
    this.previousResults.push(this.currentResult);
 }
 
 mulHandler(){
    //convert string to Int
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);
    this.currentResult = `Result of ${firstN} * ${secondN} is ${ firstN * secondN }`;

    //push method to store the value in array
    this.previousResults.push(this.currentResult);
  }

 divHandler(){
    //convert string to Int
    const firstN = parseInt(this.firstNumber);
    const secondN = parseInt(this.secondNumber);
    this.currentResult = `Result of ${firstN} / ${secondN} is ${ firstN / secondN }`;

    //push method to store the value in array
    this.previousResults.push(this.currentResult);
  }

  showPreviuosResultToggle(event){
      this.showPreviousResult = event.target.checked;
  }

}