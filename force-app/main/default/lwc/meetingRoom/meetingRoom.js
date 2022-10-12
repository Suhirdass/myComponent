import { LightningElement,api, wire } from 'lwc';
import {fireEvent} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class MeetingRoom extends LightningElement {
    //for using slot no need property we can access data by using slot
    @api meetingRoomInfo;
    //{roomName:'A-01',roomCapacity:'12'};


    @wire(CurrentPageReference) pageReference;


    //Public boolean property, the default value is false
    @api showRoomInfo = false;

    tileClickHandler(){
        // when click on div tag - To create event & that should fire by using custom events -- This is handled by PC
        //dispatch event is the part of the standard JS method
        //1st Parameter - tileClick - Event name -- Based on this event name,the PC will communicate by using on + event name
        //2nd Parameter - Detail - it's property, all payload need to passed via detail property of your event & this property should be used by PC to communicate with CC
        //3rd Parameter - bubbles - need to add bubble = true, while doing our event in programmatically
        const tileClicked = new CustomEvent ('tileclick', {detail:this.meetingRoomInfo, bubbles : true});

        // after creation of event, the event should dispatch to PC (tileClicked - event variable)
        this.dispatchEvent(tileClicked);
        fireEvent(this.pageReference, 'pubsubtileclick', this.meetingRoomInfo);

    }
}