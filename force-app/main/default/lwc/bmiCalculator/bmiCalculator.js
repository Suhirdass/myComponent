import { LightningElement,track} from 'lwc';

//To Import ECMAScript module from Export module (bmi.js)
import { getBMI } from 'c/bmi';

export default class BmiCalculator extends LightningElement {
/*
    //Private property -- non reactive in nature, that does not update in template (html)
    cardTitle = 'BMI Calculator';
    height;
    weight;

    //onclick function to change our private property value, but affect in html
    // handleChange(){
    //      this.cardTitle = 'Changed Value';
    //      console.log('value:', this.cardTitle);
    //  } 

    //Private property -- reactive in nature, that would be render and update in html based on input
     //@track bmi;

     //After spring 2020 release - all private property are reactive in nature
     bmi;


    onWeightHandler(event){
        //to conver string to float by using parseFloat function
        this.weight =  parseFloat(event.target.value);
    }

    onHeightHandler(event){
        this.height =  parseFloat(event.target.value);
    }

    calculateBMI(){
        try{
        this.bmi = this.weight/(this.height*this.height);
        }catch(error){
            this.bmi = undefined;
            console.log('error: ' + error);
        }
    } */

    /* 2nd Set -- @track decorator used in object then only we can see value in template*/
    cardTitle = 'BMI Calculator';

    @track bmiData = {
        weight: 0,
        height: 0,
        result: 0
    }

    onWeightHandler(event){
        //to conver string to float by using parseFloat function
        this.bmiData.weight =  parseFloat(event.target.value);
    }

    onHeightHandler(event){
        this.bmiData.height =  parseFloat(event.target.value);
    }

    calculateBMI(){
       /* try{
        this.bmiData.result = this.bmiData.weight/(this.bmiData.height*this.bmiData.height);
        console.log('data: ' + this.bmiData.result);
        }catch(error){
            this.bmiData.result = undefined;
            console.log('error: ' + error);
        } */

        //To write logic for importing the share js code here
        //To call getBMI function & it accept 2 paramters (height and weight)
        this.bmiData.result = getBMI(this.bmiData.weight,this.bmiData.height);

    }

    //Getter property - To show data in template by using getter property, if we use this property, it will rerurn some value;
    get bmiValue(){
        if(this.bmiData.result === undefined){
           return ``;
        }
        return `your BMI is : ${this.bmiData.result}`;
    }

}