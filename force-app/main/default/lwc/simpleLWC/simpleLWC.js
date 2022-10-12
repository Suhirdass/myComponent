import { LightningElement,track,wire,api } from 'lwc';
import search from '@salesforce/apex/loginPage.studentLogin'; // apex class
import searchTwo from '@salesforce/apex/loginPage.teacherLogin'; //apex class
import searchThree from '@salesforce/apex/loginPage.classLogin'; //apex class
import searchFunction from '@salesforce/apex/loginPage.searchTeacher'; // apex class
import classHandle from '@salesforce/apex/loginPage.listOfClassStudents'; // apex class
import searchClassTeach from '@salesforce/apex/loginPage.selectClassTeacher'; //apex class
import updatedDetails from '@salesforce/apex/loginPage.getValue'; // apex class
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import NAME_FIELD from '@salesforce/schema/School_Student__c.Student_Name__c';
import CONTACTNO_FIELD from '@salesforce/schema/School_Student__c.Contact_No__c';
import CLASSES_FIELD from '@salesforce/schema/School_Student__c.Classes__c';
import CLASS_TEACHER_FIELD from '@salesforce/schema/School_Student__c.Class_Teacher__c';

export default class SchoolProjectTeacher extends NavigationMixin(LightningElement) {
   
   
    fields = [NAME_FIELD, CONTACTNO_FIELD, CLASSES_FIELD, CLASS_TEACHER_FIELD];

    sudentRecordForm=false;
    createNewRecord(event){
        this.sudentRecordForm=true;
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Student Created',
            message: 'Student Record Created Successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.sudentRecordForm=false;
    }
    onCancel(event){
        this.sudentRecordForm=false;
    }
    enterMarksScreen=true;
    cancelScreenMarks(event){
        this.enterMarksScreen=false;
    }

    marks;
    error;
    areTeachersVisibleScreen=false;
    areStudentListVisibileScreen=false;
    showOne=false;
    showReportcard=false;
    dontShowTeachersScreen=true;
    @api getReportCard(event){
        this.showReportcard=true;
        this.areTeachersVisibleScreen=false;
        this.areStudentListVisibileScreen=false;
        this.dontShowTeachersScreen=true;
        console.log('hiiiiiiiiiii-studentclass'+studentClass);
        searchClassTeach({ studentClass: event.target.value })
                .then((result) => {
                    this.marks = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.marks = undefined;
                });
    }


    areTeachersVisible=false;

    teacherLogin(event){
        this.areTeachersVisible = true;
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
    
/*Teacher screen-Class Handling

    classContacts;
    classError;
    areStudentListVisibileScreen=false;
    classHandling(event) {
        this.areStudentListVisibileScreen=true; 
        classHandle({ classTeacher: event.target.value })
                .then((result) => {
                    this.classContacts = result;
                    this.classError = undefined;
                })
                .catch((error) => {
                    this.classError = error;
                    this.classContacts = undefined;
                });
    }  */

    contacts;
    error;
    valueClass='';
    areTeachersVisibleScreen=false;
    areStudentListVisibileScreen=false;
    showOne=false;
    handleKeyChange(event) {
        this.areTeachersVisibleScreen=true;
        
        searchClassTeach({ studentClass: event.target.value })
                .then((result) => {
                    this.contacts = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.contacts = undefined;
                });
    }

    handleKeyChangeSubmit(event) {
       // this.areTeachersVisibleScreen=false;
       this.areStudentListVisibileScreen=true;  
        this.showOne=true;
        console.log('HI'+JSON.stringify(this.contacts));
       /* searchClassTeach({ studentClass: event.target.value })
                .then((result) => {
                    this.contacts = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.contacts = undefined;
                });*/
    }
    
    showReportcard=false;
    giveMarks(event) {{
        this.showReportcard=true;
        this.areStudentListVisibileScreen=false;
        console.log('give marks'+this.contacts);
       
        /*searchClassTeach({ studentClass: event.target.value })
                .then((result) => {
                    this.contacts = result;
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                    this.contacts = undefined;
                });
                this.getReportCard();
    }
        let cmpDef={
            componentDef:"c:schoolProjectMarks"
        };
        let encodedDef=btoa(JSON.stringify(cmpDef));
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                url:"/one/one.app#"+encodedDef
            }
        });*/
    }
    }    
    
    @track isModalOpen = false;
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.areStudentListVisibileScreen=false;
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
        this.areReportCardAvailable=false;
        this.areStudentListVisibileScreen=false;
    }
    
    @track contactsRecord;
    searchValue = '';
    searchKeyword(event) {
        this.searchValue = event.target.value;
    }
 
    handleSearchKeyword() {        
        if (this.searchValue !== '') {
            searchFunction({
                    searchKey: this.searchValue
                })
                .then(result => {
                    this.contactsRecord = result;
                })
                .catch(error => {                   
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);
                    this.contactsRecord = null;
                });
        } else {
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
        }
    }
    @wire(searchTwo)teacherApex;



//Update Stdudent marks
record=[];
marksUpdate(event){
    console.log(JSON.stringify(this.contacts));
        this.contacts.forEach(element =>{
            if(element.School_Students__r){
            element.School_Students__r.forEach(elementTwo =>{


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
    enterMarksScreen=false;
    inputMarks(event){
        this.enterMarksScreen=true;
    }
    
    success;
    fail;
    handleSubmitMarks(event) {       
        console.log(JSON.stringify(this.record));
        console.log('submit'+this.record);
        this.enterMarksScreen=false;
        updatedDetails({ updatedSchoolStudents:this.record})
        //updatedDetails({ updatedSchoolStudents:this.studentRecord})
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
    }
    

   /*
    @track columnsOne = [
        { label: 'Roll No', fieldName: 'School_Students__r.Classes__r.Name' },
        { label: 'Student Name', fieldName: 'School_Students__r.Student_Name__c', type: 'text' },
        { label: 'Class', fieldName: 'Class__c', type: 'phone' },
        { label: 'Class Teacher', fieldName: 'Class_Teacher__r.Name', type: 'Email' },
        { label: 'Minimum  Marks', fieldName: '40', type: 'Number' },
        { label: 'Maximum Marks', fieldName: '100', type: 'Number' },
        { label: 'Minimum Grade', fieldName: 'F' , type: 'Formula'},
        { label: 'Maximum Grade', fieldName: 'A+', type: 'Formula' },
    ];
    @track columnsTwo = [
        { label: 'English', fieldName: 'School_Students__r.English__c', type: 'phone' , editable: true},
        { label: 'Tamil', fieldName: 'School_Students__r.Tamil__c', type: 'Email', editable: true },
        { label: 'Mathematics', fieldName: 'School_Students__r.Mathematics__c', type: 'Formula' , editable: true},
        { label: 'Science', fieldName: 'School_Students__r.Science__c', type: 'text' , editable: true},
        { label: 'Social Science', fieldName: 'School_Students__r.Social_Science__c', type: 'Email' , editable: true},
        { label: 'Total Marks', fieldName: 'School_Students__r.Total_Marks__c', type: 'Formula' },
        { label: 'Percentage', fieldName: 'School_Students__r.Percentage__c', type: 'text' },
        { label: 'Grade', fieldName: 'School_Students__r.Grade__c', type: 'text' },
        
    ];
    @track accList;
    @track error;
    @wire(searchTwo)wiredAccounts({error,data}) {
        
        if (data) {
            console.log('hwllo'+JSON.stringify(data));
            this.contacts = data;
            console.log(JSON.Stringify(this.accList));
        } else if (error) {
            this.error = error;
        }
    }*/
}