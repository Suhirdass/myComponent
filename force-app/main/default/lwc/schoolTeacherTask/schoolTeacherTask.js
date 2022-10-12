
import { LightningElement, wire,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import metaData from '@salesforce/apex/DirectoryController.metaData';

export default class SchoolTeacherTask extends NavigationMixin(LightningElement) {

    @track time = "8:22 AM";
    @track greeting = "Good Morning"; 
    @track currentDate;
    //@track monthValue;
    //@track yearValue;


    connectedCallback() {
        //get current time
        this.getTime();
        
        /*get time periodically after every minute -- setInterval accept function method, 
        Here we are using arrow function, -- duration = 1000*60 (everytime this method will call )*/
    
        setInterval(() => {
            this.getTime();
          }, 1000 * 60);
     }

     getTime() {
        const date = new Date(); /* creating object of Date class */
        const hour = date.getHours();
        const min = date.getMinutes();
        const date1 = date.getDate();
        const month1 = date.getMonth() + 1;
        const year1 = date.getFullYear();
         
         // set time for time property
         this.time = `${this.getHour(hour)}:${this.getDoubleDigit(
            min
          )} ${this.getMidDay(hour)}`;
         this.setGreeting(hour);
        
        this.currentDate = `${this.setDate(date1)} - ${this.setMonth(month1)} - ${this.setYear(year1)}`;
     }

     //Convert 24 hours format to 12 hours format
 getHour(hour) {
    return hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;
  }

 //return AM or PM based on current hour
 getMidDay(hour) {
    return hour >= 12 ? "PM" : "AM";
  }

 //convert single digit to double digit
 getDoubleDigit(digit) {
    return digit < 10 ? "0" + digit : digit;
  }

//return greeting based on current hour
setGreeting(hour) {
    if (hour < 12) {
      this.greeting = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      this.greeting = "Good Afternoon";
    } else {
      this.greeting = "Good Evening";
    }
  }

  setDate(date1){
     return date1;
  }

  setMonth(month1){
     return month1;
 }

 setYear(year1){
    return year1;
 }


    navigateToManage() {
        
        //navigate to show the details of management
        let cmpDef={
            componentDef:"c:managementComponent"
        };
        let encodedDef=btoa(JSON.stringify(cmpDef));
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                url:"/one/one.app#"+encodedDef
            }
        });
    }

    navigateToStudent(){

      //navigate to show the details of student
      let cmpDef1={
        componentDef:"c:studentComponent"
    };
    let encodedDef1=btoa(JSON.stringify(cmpDef1));
    this[NavigationMixin.Navigate]({
        "type": "standard__webPage",
        "attributes": {
            url:"/one/one.app#"+encodedDef1
        }
    });

 }

    navigateToTeacher(){
    //navigate to show the details of management
    let cmpDef2={
        componentDef:"c:teacherComponent"
    };
    let encodedDef2=btoa(JSON.stringify(cmpDef2));
    this[NavigationMixin.Navigate]({
        "type": "standard__webPage",
        "attributes": {
            url:"/one/one.app#"+encodedDef2
        }
    });
  }

  @track data;
  @track error;
 @wire(metaData)
 customMetaData({error,data}){
   if(data){
       this.data = data;
       this.error = undefined;
   } else if(error){
       this.error = error;
       this.data = undefined;
   }
 }

}