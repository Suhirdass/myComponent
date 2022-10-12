import { LightningElement, track } from 'lwc';

export default class ConditionalRenderingExample extends LightningElement {
  //  @track displayDiv = false;

    @track cityList = ['Chennai','Bangalore','Delhi','Jaipur'];

  /*  showDivHandler(event){
        this.displayDiv = event.target.checked;
    }*/

    //This contacts is our list for this demo


    contacts = [


    { 


     Id : '1001',


     Name : 'Ajinkya Dhas',


     Website : 'www.salesforcekid.com'


    },


    {


     Id : '1002',


     Name : 'Steve Jobs',


     Website : 'www.apple.com'


    },


    {


     Id : '1003',


     Name : 'Marc Benioff',


     Website : 'www.salesforce.com'


    },


    {


    Id : '1004',


    Name : 'Bill Gates',


    Website : 'www.microsoft.com'


    }


   ];

}