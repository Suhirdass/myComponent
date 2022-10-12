import { LightningElement,wire,api,track } from 'lwc';
import searchClassTeacher from '@salesforce/apex/DirectoryController.selectClassTeacher';
import updatedDetails from '@salesforce/apex/DirectoryController.getValue';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from "@salesforce/apex";


import NAME_FIELD from '@salesforce/schema/School_Student__c.Student_Name__c';
import CONTACTNO_FIELD from '@salesforce/schema/School_Student__c.Contact_Number__c';
import CLASSES_FIELD from '@salesforce/schema/School_Student__c.Class__c';
import CLASS_TEACHER_FIELD from '@salesforce/schema/School_Student__c.Teacher__c';

export default class TeacherComponent extends LightningElement {

    marks;
    error;
    areTeachersVisible=false;
    areTeachersVisibleScreen=false;
    dontShowTeachersScreen=true;
    areStudentListVisibileScreen=false;
    areReportCardAvailable=false;
    showOne=false;
    showReportcard=false;
    studentRecordForm=false;
    enterMarksScreen=false;

    @api getReportCard(event){
        this.showReportcard=true;
        this.areTeachersVisibleScreen=false;
        this.areStudentListVisibileScreen=false;
        this.dontShowTeachersScreen=true;
        searchClassTeacher({studentClass : event.target.value})
                .then((result) => {
                    this.marks = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.marks = undefined;
                });
    }

    showReportcard=false;
    giveMarks(event) {
        this.showReportcard=true;
        this.areStudentListVisibileScreen=false;
        console.log('give marks'+this.contacts);
    }

    teacherLogin(event){
        this.areTeachersVisible = true;
    }

    createNewRecord(event){
        this.studentRecordForm=true;
    }

    inputMarks(event){
        this.enterMarksScreen=true;
    }
    
    

    @wire(searchClassTeacher)teacherReportCard;
    handleClass(event){
        this.areReportCardAvailable= true;
    }

    get optionsClass() {
        return [
            { label: '6', value: '6' },
            { label: '7', value: '7' },
            { label: '8', value: '8' },
            { label: '9', value: '9' },
            { label: '10', value: '10' },
        ];
    }
    
//contacts;
//error;
valueClass='';
areTeachersVisible = false;

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

    @track contacts;

    @track error;

    handleKeyChange(event){
        this.areTeachersVisibleScreen = false;
        const userInput = event.target.value;
        this.className= userInput;

    }

    @wire(searchClassTeacher,{studentClass : '$className'})
    teacherData({error,data}){
        if(data){
            this.areTeachersVisibleScreen = true;
            this.contacts = data;
            console.log('data>>>' + data);
            this.error = undefined;
        } else if (error) {

            //console.log('Error block');

            this.error = error;
            console.log('Error block' + error);
            this.contacts = undefined;

        }
    }

    handleKeyChangeSubmit(event) {
        this.areStudentListVisibileScreen=true;  
         this.showOne=true;
         console.log('HI'+JSON.stringify(this.contacts));
     }

    @track isModalOpen = false;

     submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
        this.areReportCardAvailable=false;
        this.areStudentListVisibileScreen=false;
    }

    //Update Stdudent marks
record=[];
marksUpdate(event){
    console.log(JSON.stringify(this.contacts));
        this.contacts.forEach(element =>{
            if(element.Students__r){
            element.Students__r.forEach(elementTwo =>{


                if(elementTwo.Id==event.currentTarget.dataset.id){
                    let   a={...elementTwo};

                    this.record.forEach(elementThree =>{
                        console.log('asssssdsd');
                        if(elementThree.Id==event.currentTarget.dataset.id){
                               a={...elementThree};
                               this.record.pop(elementThree);     
                        }
                    });

                    console.log('assss'+JSON.stringify(a));

                    if(event.target.label=='English'){
                        console.log('label english'+event.target.label);
                        a.English__c = event.target.value;                     
                    }
                    else if(event.target.label=='Tamil'){
                        a.Tamil__c = event.target.value;                     
                    }
                    else if(event.target.label=='Maths'){
                        a.Mathematics__c = event.target.value;
                        
                    }
                    else if(event.target.label=='Science'){
                        a.Science__c = event.target.value; 
                        
                    }
                    else if(event.target.label=='Social'){
                        a.Social_Science__c = event.target.value; 
                        
                    }
                    this.record.push(a);
                    
                    console.log('final'+this.record);
                    console.log(JSON.stringify(this.record));
                }    

            }); 
        }}); 
        
    }

    
    handleSubmitMarks(event) {       
        console.log(JSON.stringify(this.record));
        //refreshApex(this.record);
        console.log('submit'+this.record);
        this.enterMarksScreen=false;
        updatedDetails({ updatedSchoolStudents:this.record})
                .then((result) => {                    
                        const evt = new ShowToastEvent({
                            title: 'Success',
                            message: 'Updated Successfully',
                            variant: 'success',
                            mode: 'dismissable'
                        });
                        this.dispatchEvent(evt);
                })
                .catch((error) => {
                    const evt = new ShowToastEvent({
                        title: 'Error',
                        message: 'Update Failed',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                });
                refreshApex(updatedDetails);
    }

    enterMarksScreen=true;
    cancelScreenMarks(event){
        this.enterMarksScreen=false;
    }

    fields = [NAME_FIELD, CONTACTNO_FIELD, CLASSES_FIELD, CLASS_TEACHER_FIELD];

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Student Created',
            message: 'Student Record Created Successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.studentRecordForm=false;
    }
    onCancel(event){
        this.studentRecordForm=false;
    }
}