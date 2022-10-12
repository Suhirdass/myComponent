import { LightningElement , track, wire} from 'lwc';
import { registerListener,unregisterAllListeners } from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class SelectedMeetingRoom extends LightningElement {

    @track selectedMeetingRoom = {};

    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    onMeetingRoomSelectHandler(payload){
        this.selectedMeetingRoom = payload;
    }

    connectedCallback(){
        registerListener('pubsubtileclick', this.onMeetingRoomSelectHandler,this);
    }

    @wire(CurrentPageReference) pageRef;
}