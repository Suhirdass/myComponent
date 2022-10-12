import { LightningElement,wire,api,track } from 'lwc';
import search from '@salesforce/apex/DirectoryController.studentLogin'; // apex class

export default class StudentComponent extends LightningElement {

    areStudentsVisible=false;
    areStudentsVisibleScreen=false;
    areReportCardAvailable=false;
    
    studentLogin(event){
        this.areStudentsVisible = true;
    }

   
    @wire(search)studentReportCard;
    
    get optionsClass() {
        return [
            { label: '6', value: '6' },
            { label: '7', value: '7' },
            { label: '8', value: '8' },
            { label: '9', value: '9' },
            { label: '10', value: '10' },
        ];
    }
    get optionsGrade() {
        return [
            { label: 'A', value: 'A' },
            { label: 'B', value: 'B' },
            { label: 'C', value: 'C' },
            { label: 'D', value: 'D' },
            { label: 'E', value: 'E' },
            { label: 'F', value: 'F' },
        ];
    }

    
//contacts;
//error;
//valueClass='';
//areStudentsVisible = false;

/*
handleKeyChange(event) {  
    this.areStudentsVisibleScreen = true;     
    search({ studentClass : event.target.value })
            .then((result) => {
                this.contacts = result;
                console.log('data>>>' + contacts);
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                console.log('error>>>' + error);
                this.contacts = undefined;
            });
}  */


    @api className;
    @track contacts = [];
    @track error;

    handleKeyChange(event){
       // this.areStudentsVisibleScreen = true;
        const userInput = event.target.value;
        this.className= userInput;
    }

    @wire(search,{studentClass : '$className'})
    studentData({error,data}){
        if(data){
            this.areStudentsVisibleScreen = true;
            this.contacts = data;
            console.log('data>>>' + contacts);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.log('Error block' + error);
            this.contacts = undefined;

        }
    }
    
    reportCard=[];
    handleAcademics(event){
        this.reportCard=[];
        this.areReportCardAvailable= true;
        this.contacts.forEach(element=>{
            if(element.Id==event.currentTarget.dataset.id){
                this.reportCard.push(element);
                console.log(element);
            }
        })
    }

    customHideModalPopup() {
       this.areReportCardAvailable = false;
    }

  
}