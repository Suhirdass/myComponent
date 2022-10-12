import { LightningElement, track,wire } from 'lwc';

//To import LDS uiRecordApi module to create new record (createRecord), the uiRecordApi which is there in lightning namespace
//To import LDS uiRecordApi module to view record (getRecord), the uiRecordApi which is there in lightning namespace
import {createRecord,getRecord} from "lightning/uiRecordApi";

//I need to retrive some account fields by using array
const fieldsArray = ['Account.Name','Account.Phone','Account.Website'];

export default class AccountManagerLDS extends LightningElement {
  // To Store/capture Account - Name,Phone,Website in track property
  @track accountName;
  @track accountPhone;
  @track accountWebsite;

  //To hold Account RecordID - To retrive records from account
  @track recordId;

  //wire property is used to retrive the records (getRecord) from salesforce without server side call by using uiRecordApi
  //$ - to make our wire service as private reactive property
  @wire(getRecord, {recordId : '$recordId', fields : fieldsArray})
  accountRecord;

  //Onchange Handler
  accountNameChangeHAndler(event){
      //Assign event value to accountName property
      this.accountName = event.target.value;
  }

  accountPhoneChangeHAndler(event){
      //Assign event value to accountPhone property
    this.accountPhone = event.target.value;
}

   accountWebsiteChangeHAndler(event){
       //Assign event value to accountWebsite property
    this.accountWebsite = event.target.value;
   }


   // To create Account method in the js file to create new record
   createAccount(){
    //In this method first we need to create js object to map our fields values with actual API name
    // create js object - fields, supply field API name is key and their values as value
    const fields ={'Name' : this.accountName, 'Phone' : this.accountPhone, 'Website' : this.accountWebsite};

    //To create one more JS object to map these fields with object name
    const recordInput = {apiName: 'Account', fields};

    //To make call createRecord from LDS  & recordInput is parameter to this createRecord LDS - create a new account record in backend
    //this createRecord method returns promise 
    //promise in JS - single or transcation which resolves either success respone (handled by then keyword) or error response (handled by catch keyword)
    createRecord(recordInput).then(response =>{
      console.log('Account has been created : ' + response.id);

      //To hold record id in Property
      this.recordId = response.id;
    }).catch(error =>{
        console.log('Error Message : ' + error.body.message);
    });

    }

    //To retrive Account Name,Phone,Website & get property is used to passing the value to html
    get retAccountName(){
        if(this.accountRecord.data){
           return this.accountRecord.data.fields.Name.value;
        }
        return undefined;
    }

    get retAccountPhone(){
        if(this.accountRecord.data){
           return this.accountRecord.data.fields.Phone.value;
        }
        return undefined;
    }


    get retAccountWebsite(){
        if(this.accountRecord.data){
           return this.accountRecord.data.fields.Website.value;
        }
        return undefined;
    }


}