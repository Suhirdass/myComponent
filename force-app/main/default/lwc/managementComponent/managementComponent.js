import { LightningElement,wire,track } from 'lwc';
import teacherlist from '@salesforce/apex/DirectoryController.listOfTeacher';
//import getTeacherList from '@salesforce/apex/DirectoryController.getTeacherList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { NavigationMixin } from 'lightning/navigation';

import CONTACT_FIELD from '@salesforce/schema/Teacher__c.Contact_Number__c';
import EMAIL_FIELD from '@salesforce/schema/Teacher__c.Email__c';
import SUBJECT_HANDLING_FIELD from '@salesforce/schema/Teacher__c.Subject_Handling__c';
import NAME_FIELD from '@salesforce/schema/Teacher__c.Teacher_Name__c';
import CLASS_FIELD from '@salesforce/schema/Teacher__c.Class__c';

let i=0;

const columns = [
    { label: 'ID', fieldName: 'Name' },
    { label: 'Teacher Name', fieldName: 'Teacher_Name__c', type: 'text' },
    { label: 'Contact No', fieldName: 'Contact_Number__c', type: 'phone' },
    { label: 'Email', fieldName: 'Email__c', type: 'Email' },
    { label: 'Subject Handling', fieldName: 'Subject_Handling__c', type: 'text' },
    { label: 'Class handling', fieldName: 'Faculty_of_Class__c', type: 'Formula' },
];

export default class ManagementComponent extends LightningElement {

    fields = [NAME_FIELD, CLASS_FIELD, SUBJECT_HANDLING_FIELD, CONTACT_FIELD, EMAIL_FIELD ];

    @track page = 1; //this will initialize 1st page
    @track items = [];  //data to be displayed in the table  
    @track teacherData = []; //it contains all the records.
    @track columns; //holds column info.
    @track startingRecord = 1; //start record position per page
    @track endingRecord = 0; //end record position per page
    @track pageSize = 5; //default value we are assigning
    @track totalRecountCount = 0; //total record count received from all retrieved records
    @track totalPage = 0; //total number of page is needed to display all records

    @track error;

    @wire(teacherlist)
    wiredTeacher({error,data}) {
        if (data) {
            this.teacherData = data;
            this.totalRecountCount = data.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); //here it is 5
            //initial data to be displayed ----------->
            //slice will take 0th element and ends with 5, but it doesn't include 5th element
            //so 0 to 4th rows will be displayed in the table
            this.items = this.teacherData.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.items = undefined;
        }
    }

    //clicking on previous button this method will be called
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1; //decrease page by 1
            this.displayRecordPerPage(this.page);
        }
    }
    //clicking on next button this method will be called
    nextHandler() {
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);            
        }             
    }

    //this method displays records page by page
    displayRecordPerPage(page){

        /*let's say for 2nd page, it will be => "Displaying 6 to 10 of 23 records. Page 2 of 5"
        page = 2; pageSize = 5; startingRecord = 5, endingRecord = 10
        so, slice(5,10) will give 5th to 9th records.
        */
        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        this.items = this.teacherData.slice(this.startingRecord, this.endingRecord);

        //increment by 1 to display the startingRecord count, 
        //so for 2nd page, it will show "Displaying 6 to 10 of 23 records. Page 2 of 5"
        this.startingRecord = this.startingRecord + 1;
    }    

    teacherRecordForm=false;
    createNewRecord(event){
        this.teacherRecordForm=true;
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Teacher Created',
            message: 'Teacher Record Created Successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.teacherRecordForm=false;
    }
    onCancel(event){
        this.teacherRecordForm=false;
    }
}

    




    /*
    @track recordEnd = 0;
    @track recordStart = 0;
    @track pageNumber = 1;
    @track totalRecords = 0;
    @track totalPages = 0;
    @track pageSize = 3;    
    @track isPrev = true;
    @track isNext = true;
    @track loaderSpinner = false;
    @track teacherdataList=[];

    //on load
    connectedCallback(){
        this.getRecords();
    }


    handlePagePrevAction(){
        this.pageNumber = this.pageNumber-1;
        this.getRecords();
    }

    handlePageNextAction(){
        this.pageNumber = this.pageNumber+1;
        this.getRecords();
    }

    getRecords(){
        this.loaderSpinner = true;
        getTeacherList({pageSize: this.pageSize, pageNumber : this.pageNumber})
        .then(result => {
            this.loaderSpinner = false;
            console.log('result>>' + result);
            if(result){
                var resultData = JSON.parse(result);
                this.recordEnd = resultData.recordEnd;
                this.totalRecords = resultData.totalRecords;
                this.recordStart = resultData.recordStart;
                this.teacherdataList = resultData.teacherList;
                this.pageNumber = resultData.pageNumber;                
                this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
                this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
                this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);
            }
        })
        .catch(error => {
            this.loaderSpinner = false;
            this.error = error;
            console.log('error>>' + this.error);
        });
    }


    //display no records
    get isDisplayNoRecords() {
        var isDisplay = true;
        if(this.teacherdataList){
            if(this.teacherdataList.length == 0){
                isDisplay = true;
            }else{
                isDisplay = false;
            }
        }
        return isDisplay;
    }*/

//}

/*
    areTeachersVisible=false;
    areTeachersVisibleScreen=false;

    @track contacts;
    @track error; */


   // @wire(teacherlist) teacherData;
   /* (error,data){
        if(data){
            this.areTeachersVisibleScreen = true;
            this.contacts = data;
            console.log('data>>>' + data);
            this.error = undefined;
        } else if(error){
            this.error = error;
            console.log('Error block' + error);
            this.contacts = undefined;
        }
    }*/